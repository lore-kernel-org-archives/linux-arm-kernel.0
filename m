From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Mon, 22 Aug 2016 13:32:47 -0400
Subject: [RFC] arm64: Enforce gettimeofday vdso structure read ordering
In-Reply-To: <20160822113739.GA30850@leverpostej>
References: <20160812114111.GA21484@leverpostej>
 <1471636928-11177-1-git-send-email-bdegraaf@codeaurora.org>
 <20160822113739.GA30850@leverpostej>
Message-ID: <862b0e4fbc652bb4a0ef8d129bbc0cdb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-08-22 07:37, Mark Rutland wrote:
> Hi,
> 
> On Fri, Aug 19, 2016 at 04:02:08PM -0400, Brent DeGraaf wrote:
>> Introduce explicit control-flow logic immediately prior to virtual
>> counter register read in all cases so that the mrs read will
>> always be accessed after all vdso data elements are read and
>> sequence count is verified. Ensure data elements under the
>> protection provided by the sequence counter are read only within
>> the protection logic loop.  Read the virtual counter as soon as
>> possible after the data elements are confirmed correctly read,
>> rather than after several other operations which can affect time.
>> Reduce full barriers required in register read code in favor of
>> the lighter-weight one-way barrier supplied by a load-acquire
>> wherever possible.
> 
> As I commented previously, can you please explain *why* these chagnes
> should be made?
> 
> * What problem does this patch address?

Initially, I set out to fix a control-flow problem, as I originally
wrote this against the code prior to the refactoring of commit
b33f491f5a9aaf171b7de0f905362eb0314af478, back when there was still a
do_get_tspec subroutine.  That one used a dmb to order the
data accesses prior to the isb/mrs sequence that read the virtual
counter.  Our Senior Director, who has done extensive work with the ARM
cpu and is intimately familiar with the instruction set, indicated that
the dmb which was used in that code was not enough to ensure ordering
between the loads from the structure and the read of the virtual 
counter.
Since that code had no control-flow (e.g., some conditional governing 
the
code's progress) prior to the isb, he suggested that some form of dsb
would be required to ensure proper order of access between the loads
from the vdso structure and the mrs read of the the virtual counter.

I went to the latest armv8 ARM at that time and found a concrete example
of how the code should be structured to ensure an ordered read of the
virtual counter.  In the most recent copy to which I have access
(ARM DDI 0487A.j), that code is given on page D6-1871, under section
D6.2.2.  I moved the sequence count check immediately prior to the
isb to satisfy the particular ordering requirements in that code.

When the refactored code went in recently, however, the seqcnt_read
prior to the isb changed to a seqcnt_check, which addressed that 
ordering
requirement.

In the process of merging the prior code, however, I had noticed
several other things that were wrong or not ideal and I describe the
details of those problems below.

> 
> * Is this a bug fix? If so, what problem can be seen currently?

The most obvious problem with the existing code is where the timezone 
data
gets loaded: after sequence counts have been checked and rechecked,
completely outside the area of the code protected by the sequence 
counter.
While I realize that timezone code does not change frequently, this is
still a problem as the routine explicitly reads data that could be in 
the
process of being updated.

To make the demarkation clear with the refactored version, and keep code
that reads the vdso_data cleanly contained within the protection of the
sequence count, I elected to combine the two macros that check and 
recheck
the sequence counter.  This allowed the recheck to avoid looping on the
barrier requirements of a two reads of the sequence count, as branching
from one macro to a label created inside another macro (e.g. label 8888
in this case) is ugly at best.  This, I figured, would also help prevent
future mistakes that involved access vdso_data in an unprotected 
fashion:
Only the block of code passed to the routine would be allowed to 
directly
access the vdso data.

The second problem is that the timing between the reading of the vdso 
data
and the virtual counter is treated as secondary in the code, as a few
register manipulations using the structure data are performed prior
to reading the virtual counter.  While the cpu itself is free to reorder
these shifts and loads somewhat, depending on the implementation, the
read of the virtual counter should be performed as close as possible to
the time the vdso data itself is read to minimize variability.  As these
manipulations and loads are not dependent on the result of the mrs read,
putting them after the virtual counter isb/mrs sequence allows these
independent register manipulations to issue while the mrs is still in
process.

Finally, the nomenclature ("acquire_seqcnt") used by the existing code
pointed toward use of the load-acquire semantic, and using those allowed
me to reduce the number of explicit barriers needed in the reader code.

> 
> * Is this an optimisation? If so, how much of an improvement can be
>   seen?

Optimization was not the main goal of this patch, yet performance did
improve on my target, with the average time improving marginally
(350 nsec after vs 360 nsec before the change), compared to the
refactored code.  In fact, performance is now slightly better (around
a miniscule 2 nsec) than the original code, before the refactor, which
hurt performance.

> 
> In the absence of answers to the above, this patch is impossible to
> review, and will not get applied. It makes invasive changes, ans we 
> need
> a rationale for those.
> 
> I've made some comments below, but the above is key.
> 
> [...]
> 
>> +	.macro	seqdata_acquire fallback, tzonly=NO_TZ, skipvcnt=0, getdata
>> +9999:	ldar	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
>> +8888:	tbnz	seqcnt, #0, 9999b
>>  	ldr	w_tmp, [vdso_data, #VDSO_USE_SYSCALL]
>> -	cbnz	w_tmp, \fail
>> +	cbnz	w_tmp, \fallback
>> +	\getdata
>> +	dmb	ishld	/* No loads from vdso_data after this point */
> 
> What ordering guarantee is the DMB attempting to provide? Given we have
> the acquire, I assume some prior load, but I couldn't figure out what
> specifically.

That barrier specifically ensures that loads performed by the "getdata" 
sequence
do not get accessed after the subsequent ldar check of the sequence 
counter,
since, as you know, ldar may allow loads that come before it in program 
order
to be accessed after it in much the same way as stlr may allow stores 
that come
after it to accessed before it.

> 
>> +	mov	w9, seqcnt
>> +	ldar	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
> 
> Usually, acquire operations pair with a release operation elsewhere. 
> What
> does this pair with?
> 

It was for that reason that I introduced stlr's into the writer code, 
but the
barrier provided by stlr was insufficient for my purposes, as Will 
pointed out.
There is no requirement or even suggestion in the ARM that every use of 
ldar
needs to be paired with stlr's.  If there were, LSE instructions such as 
ldadda
(which does a load-acquire followed by a regular str) and ldaddl (which 
pairs an
ordinary load with an stlr) would not exist.

>> +	cmp	w9, seqcnt
>> +	bne	8888b	/* Do not needlessly repeat ldar and its implicit barrier 
>> */
>> +	.if (\tzonly) != NO_TZ
>> +		cbz	x0, \tzonly
>> +	.endif
>> +	.if (\skipvcnt) == 0
>> +		isb
>> +		mrs	x_tmp, cntvct_el0
>> +	.endif
>>  	.endm
> 
> All this conitional code makes the callers somehwat painful to read.
> 
> It might be nicer to have this explicit in the calelrs that require it
> rather than conditional in the macro.
> 

The general use-case of the acquire sequence made this the cleanest safe
implementation I could come up.  If this isb/mrs sequence is split out
into each clock handler, it would serve to obscure the relationship
between the control-flow dependency (in this case, the "bne 8888b") and
the isb.  Keeping this acquire sequence intact helps to ensure that
future modifications adhere to the correct sequence.  Note that if the
caller specifies neither option, the default is to leave these items
in place.

>> 
>>  	.macro get_nsec_per_sec res
>> @@ -64,9 +70,6 @@ x_tmp		.req	x8
>>  	 * shift.
>>  	 */
>>  	.macro	get_clock_shifted_nsec res, cycle_last, mult
>> -	/* Read the virtual counter. */
>> -	isb
>> -	mrs	x_tmp, cntvct_el0
>>  	/* Calculate cycle delta and convert to ns. */
>>  	sub	\res, x_tmp, \cycle_last
>>  	/* We can only guarantee 56 bits of precision. */
>> @@ -137,17 +140,12 @@ x_tmp		.req	x8
>>  ENTRY(__kernel_gettimeofday)
>>  	.cfi_startproc
>>  	adr	vdso_data, _vdso_data
>> -	/* If tv is NULL, skip to the timezone code. */
>> -	cbz	x0, 2f
>> -
>> -	/* Compute the time of day. */
>> -1:	seqcnt_acquire
>> -	syscall_check fail=4f
>> -	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
>> -	/* w11 = cs_mono_mult, w12 = cs_shift */
>> -	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
>> -	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
>> -	seqcnt_check fail=1b
>> +	seqdata_acquire fallback=4f tzonly=2f getdata=__stringify(\
>> +		ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST];\
>> +		/* w11 = cs_mono_mult, w12 = cs_shift */;\
>> +		ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT];\
>> +		ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC];\
>> +		ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST])
> 
> Why do we need the stringify? Is that just so we can pass the code as a
> macro parameter? If so, it really doesn't look like the way to go...
> 
> This is unfortunately painful to read.
> 

I implemented it this way to remain as similar as possible with the
refactored code that was recently merged, while at the same time 
ensuring
that, as I explained above, the reads of the vdso_data performed by each
clock type are completely contained within a set of proper sequence 
count
checks.  That they were not contained led to problems such as the 
improper
handling of the timezone data before, and it ensures that the isb 
follows
the sequence check closely.  This use is not entirely dissimilar to 
other
code which uses stringify currently present in the arm64 kernel code 
which
passes code as a parameter. See, for example, 
arch/arm64/lib/copy_*_user.S.
All this said, however, I was never thrilled about going the stringify
route, but it was the most readable of any other variants I could
come up with (and far better than adding the extra ".if's" in the 
macro).
Do you happen to have a better suggestion?


> Thanks,
> Mark.

Thanks for your comments.
Brent
