From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 27 Jan 2014 17:21:16 +0000
Subject: [PATCH v2] ARM: mm: Fix stage-2 device memory attributes
In-Reply-To: <52E69121.8050500@arm.com>
References: <1388816085-21417-1-git-send-email-christoffer.dall@linaro.org>
 <1388852843-30986-1-git-send-email-christoffer.dall@linaro.org>
 <20140124233703.GA889@cbox> <52E64029.6000201@arm.com>
 <20140127165730.GC8358@arm.com> <52E69121.8050500@arm.com>
Message-ID: <20140127172116.GD8358@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 05:02:25PM +0000, Marc Zyngier wrote:
> On 27/01/14 16:57, Catalin Marinas wrote:
> > On Mon, Jan 27, 2014 at 11:16:57AM +0000, Marc Zyngier wrote:
> >> On 24/01/14 23:37, Christoffer Dall wrote:
> >>> On Sat, Jan 04, 2014 at 08:27:23AM -0800, Christoffer Dall wrote:
> >>>> --- a/arch/arm/include/asm/pgtable-3level.h
> >>>> +++ b/arch/arm/include/asm/pgtable-3level.h
> >>>> @@ -120,13 +120,19 @@
> >>>>  /*
> >>>>   * 2nd stage PTE definitions for LPAE.
> >>>>   */
> >>>> -#define L_PTE_S2_MT_UNCACHED	 (_AT(pteval_t, 0x5) << 2) /* MemAttr[3:0] */
> >>>> -#define L_PTE_S2_MT_WRITETHROUGH (_AT(pteval_t, 0xa) << 2) /* MemAttr[3:0] */
> >>>> -#define L_PTE_S2_MT_WRITEBACK	 (_AT(pteval_t, 0xf) << 2) /* MemAttr[3:0] */
> >>>> -#define L_PTE_S2_RDONLY		 (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
> >>>> -#define L_PTE_S2_RDWR		 (_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
> >>>> -
> >>>> -#define L_PMD_S2_RDWR		 (_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
> >>>> +#define L_PTE_S2_MT_UNCACHED		(_AT(pteval_t, 0x0) << 2) /* strongly ordered */
> >>>> +#define L_PTE_S2_MT_WRITETHROUGH	(_AT(pteval_t, 0xa) << 2) /* normal inner write-through */
> >>>> +#define L_PTE_S2_MT_WRITEBACK		(_AT(pteval_t, 0xf) << 2) /* normal inner write-back */
> >>>> +#define L_PTE_S2_MT_DEV_SHARED		(_AT(pteval_t, 0x1) << 2) /* device */
> >>>> +#define L_PTE_S2_MT_DEV_NONSHARED	(_AT(pteval_t, 0x1) << 2) /* device */
> >>>> +#define L_PTE_S2_MT_DEV_WC		(_AT(pteval_t, 0x5) << 2) /* normal non-cacheable */
> >>>> +#define L_PTE_S2_MT_DEV_CACHED		(_AT(pteval_t, 0xf) << 2) /* normal inner write-back */
> >>>> +#define L_PTE_S2_MT_MASK		(_AT(pteval_t, 0xf) << 2)
> >>>> +
> >>>> +#define L_PTE_S2_RDONLY			(_AT(pteval_t, 1) << 6)   /* HAP[1]   */
> >>>> +#define L_PTE_S2_RDWR			(_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
> >>>> +
> >>>> +#define L_PMD_S2_RDWR			(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
> >>>>  
> >>>>  /*
> >>>>   * Hyp-mode PL2 PTE definitions for LPAE.
> >>
> >> The change makes sense to me. arm64 uses a slightly different approach,
> >> by using a PTE_S2_MEMATTR macro, but I'm not sure that would work for ARM.
> >>
> >> Russell, Catalin: could you please have a look at this?
> > 
> > Do we actually need more than Normal Cacheable and Device for stage 2?
> 
> Not so far. As long as these two memory types are enforced as a minimum,
> we're quite happy to let the guest use whatever it decides.
> 
> I suppose Christoffer introduces them all here as a matter of
> completeness, but I don't see them as being useful anytime soon.

That would be useful on arm if you want cachepolicy= argument to force
the cacheability of guest Normal memory type.

On arm64, the stage 1 memory type is decided via MAIR and that's how we
handle cachepolicy for Normal memory. But for stage 2 this won't work,
the type is explicitly set in the MemAttr encoding. But I don't think we
need host cachepolicy enforced onto guest.

-- 
Catalin
