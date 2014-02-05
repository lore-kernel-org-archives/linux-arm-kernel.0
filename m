From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 4 Feb 2014 23:52:48 -0600
Subject: [PATCH 1/2] arm64: vdso: fix coarse clock handling
In-Reply-To: <20140204182631.GI664@mudshark.cambridge.arm.com>
References: <1391456932-17815-1-git-send-email-nathan_lynch@mentor.com>
 <1391456932-17815-2-git-send-email-nathan_lynch@mentor.com>
 <20140204182631.GI664@mudshark.cambridge.arm.com>
Message-ID: <52F1D1B0.6080401@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 02/04/2014 12:26 PM, Will Deacon wrote:
> 
> On Mon, Feb 03, 2014 at 07:48:51PM +0000, Nathan Lynch wrote:
>> When __kernel_clock_gettime is called with a CLOCK_MONOTONIC_COARSE or
>> CLOCK_REALTIME_COARSE clock id, it returns incorrectly to whatever the
>> caller has placed in x2.  Fix this by saving x30/LR to x2
>> unconditionally.
>>
>> Also: the tv_nsec field in the result is shifted by the value in x12.
>> In the high-precision case x12 is cs_shift from the data page, but
>> for coarse clocks x12 is uninitialized.  Fix this by setting x12 to 0
>> once we know we are dealing with a coarse clock.
> 
> How are you managing to see these failures? It's clear that our LTP testing
> isn't hitting this path...

I'm using a custom test program that I wrote to check the vdso
implementation I've been working on for 32-bit ARM.  Briefly looking
through LTP sources it's not apparent to me that it tests
clock_gettime() with the coarse ids.


> 
>> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
>> ---
>>  arch/arm64/kernel/vdso/gettimeofday.S | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
>> index f0a6d10b5211..6c37ae4a70c0 100644
>> --- a/arch/arm64/kernel/vdso/gettimeofday.S
>> +++ b/arch/arm64/kernel/vdso/gettimeofday.S
>> @@ -88,13 +88,13 @@ ENDPROC(__kernel_gettimeofday)
>>  /* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
>>  ENTRY(__kernel_clock_gettime)
>>  	.cfi_startproc
>> +	mov	x2, x30
>> +	.cfi_register x30, x2
>> +
>>  	cmp	w0, #CLOCK_REALTIME
>>  	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
>>  	b.ne	2f
>>  
>> -	mov	x2, x30
>> -	.cfi_register x30, x2
>> -
> 
> Could we avoid the redundant moves by instead doing this around the bl
> __do_get_tspec?

In v2 I've restored x30 upon returning from __do_get_tspec and adjusted
the return from __kernel_clock_gettime accordingly.  Let me know if you
were suggesting something different here.


> 
>>  	/* Get kernel timespec. */
>>  	adr	vdso_data, _vdso_data
>>  1:	seqcnt_acquire
>> @@ -118,6 +118,9 @@ ENTRY(__kernel_clock_gettime)
>>  	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
>>  	b.ne	8f
>>  
>> +	/* Set shift to 0 for coarse clocks */
>> +	mov	x12, #0
> 
> Worth mentioning that xtime_coarse_nsec is pre-shifted for us, rather than
> shifting not actually being required.

Agreed.


> Also, rather than shift by #0, can we move the lsl instruction immediately
> before the b 4f earlier on?

There are two more shift operations later in the routine which would
also need accounting for, so it's not quite that simple.  Okay to leave
this alone for the purpose of this patch?
