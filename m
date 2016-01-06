From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Jan 2016 16:31:34 +0000
Subject: [PATCH] ARM64: Improve copy_page for 128 cache line sizes.
In-Reply-To: <CA+=Sn1ku1CQUM8whiMmv_sZY175kt6b1wg_818fyu++N6Sybgg@mail.gmail.com>
References: <CA+=Sn1ku1CQUM8whiMmv_sZY175kt6b1wg_818fyu++N6Sybgg@mail.gmail.com>
Message-ID: <20160106163133.GG16580@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, Dec 22, 2015 at 03:32:19PM -0800, Andrew Pinski wrote:
> On Tue, Dec 21, 2015 at 5:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 21 December 2015, Will Deacon wrote:
> >> On Sat, Dec 19, 2015 at 04:11:18PM -0800, Andrew Pinski wrote:
> I think it is the prefetching.  ThunderX T88 pass 1 and pass 2 does
> not have a hardware prefetcher so prefetching a half of a cacheline
> ahead does not help at all.
> 
> >>
> >> Also, how are you measuring the improvement? If you can share your
> >> test somewhere, I can see how it affects the other systems I have
> >> access to.
> 
> You can find my benchmark at
> https://github.com/apinski-cavium/copy_page_benchmark .
> copy_page is my previous patch.
> copy_page128 is just the unrolled and only 128 byte prefetching
> copy_page64 is the original code
> copy_page64unroll is the new patch which I will be sending out soon.

Thanks, this was really helpful to evaluate the different versions on
the Cortex-A* cores I've got on my desk. Doing so showed that, in fact,
having explicit prfm instructions tends to be *harmful* for us -- the
hardware prefetcher is actually doing a much better job on its own.

Now, I still maintain that we don't want lots of different copy_page
implementations, but I'm not averse to patching a nop with a prfm on
cores that benefit from software-driven prefetching. We could hang it
off the alternatives framework that we have already.

> > Are there any possible downsides to using the ThunderX version on other
> > microarchitectures too and skip the check?
> 
> Yes that is a good idea.  I will send out a new patch in a little bit
> which just unrolls the loop with keeping of the two prefetch
> instructions in there.

copy_page64unroll didn't perform well on all of my systems. The code
below was the best all-rounder I could come up with. Do you reckon you
could try taking it and adding prefetches to see if you can make it fly
on ThunderX?

Cheers,

Will

--->8

ENTRY(copy_page)
	ldp	x2, x3, [x1]
	ldp	x4, x5, [x1, #16]
	ldp	x6, x7, [x1, #32]
	ldp	x8, x9, [x1, #48]
	ldp	x10, x11, [x1, #64]
	ldp	x12, x13, [x1, #80]
	ldp	x14, x15, [x1, #96]
	ldp	x16, x17, [x1, #112]

	mov	x18, #(PAGE_SIZE - 128)
	add	x1, x1, #128
1:
	subs	x18, x18, #128

	stnp	x2, x3, [x0]
	ldp	x2, x3, [x1]
	stnp	x4, x5, [x0, #16]
	ldp	x4, x5, [x1, #16]
	stnp	x6, x7, [x0, #32]
	ldp	x6, x7, [x1, #32]
	stnp	x8, x9, [x0, #48]
	ldp	x8, x9, [x1, #48]
	stnp	x10, x11, [x0, #64]
	ldp	x10, x11, [x1, #64]
	stnp	x12, x13, [x0, #80]
	ldp	x12, x13, [x1, #80]
	stnp	x14, x15, [x0, #96]
	ldp	x14, x15, [x1, #96]
	stnp	x16, x17, [x0, #112]
	ldp	x16, x17, [x1, #112]

	add	x0, x0, #128
	add	x1, x1, #128

	b.gt	1b

	stnp	x2, x3, [x0]
	stnp	x4, x5, [x0, #16]
	stnp	x6, x7, [x0, #32]
	stnp	x8, x9, [x0, #48]
	stnp	x10, x11, [x0, #64]
	stnp	x12, x13, [x0, #80]
	stnp	x14, x15, [x0, #96]
	stnp	x16, x17, [x0, #112]

	ret
ENDPROC(copy_page)
