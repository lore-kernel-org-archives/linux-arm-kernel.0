From: kwangwoo.lee@sk.com (kwangwoo.lee at sk.com)
Date: Sun, 31 Jul 2016 23:45:46 +0000
Subject: [PATCH v2] arm64: mm: convert __dma_* routines to use start, size
In-Reply-To: <c4ee86f4-e7c4-aeee-f3eb-cb4477a95bf6@arm.com>
References: <1469518496-8177-1-git-send-email-kwangwoo.lee@sk.com>
 <b978e732-f5c3-4b77-01d9-dd5f7e2303e3@arm.com>
 <15c12f9900fd4b31a875250c478023c6@nmail01.hynixad.com>
 <c355debc-0238-ff51-ca90-6e0c8085366b@arm.com>
 <b0d9ef6b59364c4587f8d7c2493160ed@nmail01.hynixad.com>
 <c4ee86f4-e7c4-aeee-f3eb-cb4477a95bf6@arm.com>
Message-ID: <1c4ec01bd3594485b6a4b386994dc6ca@nmail01.hynixad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Saturday, July 30, 2016 2:06 AM
> To: ???(LEE KWANGWOO) MS SW; Russell King - ARM Linux; Catalin Marinas; Will Deacon; Mark Rutland;
> linux-arm-kernel at lists.infradead.org
> Cc: ???(KIM HYUNCHUL) MS SW; linux-kernel at vger.kernel.org; ???(CHUNG WOO SUK) MS SW
> Subject: Re: [PATCH v2] arm64: mm: convert __dma_* routines to use start, size
> 
> On 28/07/16 01:08, kwangwoo.lee at sk.com wrote:
> >> -----Original Message-----
> >> From: Robin Murphy [mailto:robin.murphy at arm.com]
> >> Sent: Wednesday, July 27, 2016 6:56 PM
> >> To: ???(LEE KWANGWOO) MS SW; Russell King - ARM Linux; Catalin Marinas; Will Deacon; Mark Rutland;
> >> linux-arm-kernel at lists.infradead.org
> >> Cc: ???(KIM HYUNCHUL) MS SW; linux-kernel at vger.kernel.org; ???(CHUNG WOO SUK) MS SW
> >> Subject: Re: [PATCH v2] arm64: mm: convert __dma_* routines to use start, size
> >>
> >> On 27/07/16 02:55, kwangwoo.lee at sk.com wrote:
> >> [...]
> >>>>>  /*
> >>>>> - *	__dma_clean_range(start, end)
> >>>>> + *	__dma_clean_area(start, size)
> >>>>>   *	- start   - virtual start address of region
> >>>>> - *	- end     - virtual end address of region
> >>>>> + *	- size    - size in question
> >>>>>   */
> >>>>> -__dma_clean_range:
> >>>>> -	dcache_line_size x2, x3
> >>>>> -	sub	x3, x2, #1
> >>>>> -	bic	x0, x0, x3
> >>>>> -1:
> >>>>> +__dma_clean_area:
> >>>>>  alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> >>>>> -	dc	cvac, x0
> >>>>> +	dcache_by_line_op cvac, sy, x0, x1, x2, x3
> >>>>>  alternative_else
> >>>>> -	dc	civac, x0
> >>>>> +	dcache_by_line_op civac, sy, x0, x1, x2, x3
> >>>>
> >>>> dcache_by_line_op is a relatively large macro - is there any way we can
> >>>> still apply the alternative to just the one instruction which needs it,
> >>>> as opposed to having to patch the entire mostly-identical routine?
> >>>
> >>> I agree with your opinion. Then, how do you think about using CONFIG_* options
> >>> like below? I think that alternative_* macros seems to keep the space for
> >>> unused instruction. Is it necessary? Please, share your thought about the
> >>> space. Thanks!
> >>>
> >>> +__dma_clean_area:
> >>> +#if    defined(CONFIG_ARM64_ERRATUM_826319) || \
> >>> +       defined(CONFIG_ARM64_ERRATUM_827319) || \
> >>> +       defined(CONFIG_ARM64_ERRATUM_824069) || \
> >>> +       defined(CONFIG_ARM64_ERRATUM_819472)
> >>> +       dcache_by_line_op civac, sy, x0, x1, x2, x3
> >>> +#else
> >>> +       dcache_by_line_op cvac, sy, x0, x1, x2, x3
> >>> +#endif
> >>
> >> That's not ideal, because we still only really want to use the
> >> workaround if we detect a CPU which needs it, rather than baking it in
> >> at compile time. I was thinking more along the lines of pushing the
> >> alternative down into dcache_by_line_op, something like the idea below
> >> (compile-tested only, may not actually be viable).
> >
> > OK. Using the capability of CPU features seems to be preferred.
> >
> >> Robin.
> >>
> >> -----8<-----
> >> diff --git a/arch/arm64/include/asm/assembler.h
> >> b/arch/arm64/include/asm/assembler.h
> >> index 10b017c4bdd8..1c005c90387e 100644
> >> --- a/arch/arm64/include/asm/assembler.h
> >> +++ b/arch/arm64/include/asm/assembler.h
> >> @@ -261,7 +261,16 @@ lr	.req	x30		// link register
> >>  	add	\size, \kaddr, \size
> >>  	sub	\tmp2, \tmp1, #1
> >>  	bic	\kaddr, \kaddr, \tmp2
> >> -9998:	dc	\op, \kaddr
> >> +9998:
> >> +	.ifeqs "\op", "cvac"
> >> +alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> >> +	dc	cvac, \kaddr
> >> +alternative_else
> >> +	dc	civac, \kaddr
> >> +alternative_endif
> >> +	.else
> >> +	dc	\op, \kaddr
> >> +	.endif
> >>  	add	\kaddr, \kaddr, \tmp1
> >>  	cmp	\kaddr, \size
> >>  	b.lo	9998b
> >
> > I agree that it looks not viable because it makes the macro bigger and
> > conditional specifically with CVAC op.
> 
> Actually, having had a poke around in the resulting disassembly, it
> looks like this does work correctly. I can't think of a viable reason
> for the whole dcache_by_line_op to ever be wrapped in yet another
> alternative (which almost certainly would go horribly wrong), and it
> would mean that any other future users are automatically covered for
> free. It's just horrible to look at at the source level.

Then, Are you going to send a patch for this? Or should I include this change?

> Robin.
> 
> >
> > Then.. if the number of the usage of alternative_* macros for erratum is
> > few (just one in this case for cache clean), I think only small change like
> > below seems to be optimal and there is no need to create a variant macro of
> > dcache_cache_by_line_op. How do you think about it?
[...]

Regards,
Kwangwoo
