From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Aug 2015 18:53:13 +0100
Subject: [PATCH v4] ARM: early fixmap support for earlycon
In-Reply-To: <00498073e34373292dd053cdb700ff25@agner.ch>
References: <1434491507-6208-1-git-send-email-stefan@agner.ch>
 <00498073e34373292dd053cdb700ff25@agner.ch>
Message-ID: <20150808175313.GO7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 11:02:38PM +0200, Stefan Agner wrote:
> On 2015-06-16 23:51, Stefan Agner wrote:
> >  static void __init devicemaps_init(const struct machine_desc *mdesc)
> >  {
> > @@ -1231,7 +1272,10 @@ static void __init devicemaps_init(const struct
> > machine_desc *mdesc)
> >  
> >  	early_trap_init(vectors);
> >  
> > -	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
> > +	/*
> > +	 * Clear page table except top pmd used by early fixmaps
> > +	 */
> > +	for (addr = VMALLOC_START; addr < (FIXADDR_TOP & PMD_MASK); addr += PMD_SIZE)
> >  		pmd_clear(pmd_off_k(addr));
> >  
> 
> Hi Russel,
> 
> Checked this again, v4 does the right thing:
> FIXADDR_TOP (0xffeff000) & PMD_MASK (0xffe00000) gives us the address of
> the top PMD (0xFFE00000). We don't clear that since that is taken care
> of by early fixmap support (early_fixmap_shutdown). v3 used
> FIXADDR_START, which also left out the second to top PMD. The 3MiB of
> fixmap spawns two PMD's however only the top PMD is handled by early
> fixmap. Hence this was wrong in v3, but is fixed in v4.
> 
> Can you reconsider this patch?

I applied the patch which was in the patch system, and Olof's builder
reported failures:

        arm.allnoconfig:
:(.init.text+0x7a0): undefined reference to `early_fixmap_init'

        arm.efm32_defconfig:
arch/arm/kernel/setup.c:958: undefined reference to `early_fixmap_init'

        arm.lpc18xx_defconfig:
arch/arm/include/asm/fixmap.h:25:29: error: 'L_PTE_YOUNG' undeclared (first use in this function)
arch/arm/include/asm/fixmap.h:25:43: error: 'L_PTE_PRESENT' undeclared (first use in this function)
arch/arm/include/asm/fixmap.h:25:59: error: 'L_PTE_XN' undeclared (first use in this function)
arch/arm/include/asm/fixmap.h:25:70: error: 'L_PTE_DIRTY' undeclared (first use in this function)
arch/arm/include/asm/fixmap.h:30:47: error: 'L_PTE_MT_DEV_SHARED' undeclared (first use in this function)
arch/arm/include/asm/fixmap.h:30:69: error: 'L_PTE_SHARED' undeclared (first use in this function)

So I'm going to drop it from my tree.  Please resubmit a fixed version,
thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
