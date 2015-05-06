From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 May 2015 11:43:44 +0100
Subject: Memory size unaligned to section boundary
In-Reply-To: <20150506101104.GD2067@n2100.arm.linux.org.uk>
References: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
 <20150506101104.GD2067@n2100.arm.linux.org.uk>
Message-ID: <20150506104344.GB707@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, May 06, 2015 at 11:11:05AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 23, 2015 at 03:19:45PM +0200, Stefan Agner wrote:
> > Hi,
> > 
> > It seems to me that I hit an issue in low memory mapping (map_lowmem).
> > I'm using a custom memory size, which leads to an freeze on Linux 4.0
> > and also with Linus master on two tested ARMv7-A SoC's (Freescale Vybrid
> > and NVIDIA Tegra 3):
> > 
> > With mem=259744K
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 4.0.0-00189-ga4d2a4c3-dirty
> > (ags at trochilidae) (gcc version 4.8.3 20140401 (prerelease) (Linaro GCC
> > 4.8-2014.04) ) #506 Thu Apr 23 14:13:21 CEST 2015
> > [    0.000000] CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7),
> > cr=10c5387d
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> > instruction cache
> > [    0.000000] Machine model: Toradex Colibri VF61 on Colibri Evaluation
> > Board
> > [    0.000000] bootconsole [earlycon0] enabled
> > [    0.000000] cma: Reserved 16 MiB at 0x8e400000
> > [    0.000000] Memory policy: Data cache writeback
> > <freeze>
> > 
> > I dug a bit more into that, and it unveiled that when creating the
> > mapping for the non-kernel_x part (if (kernel_x_end < end) in
> > map_lowmem), the unaligned section at the end leads to the freeze. In
> > alloc_init_pmd, if the memory end is section unaligned, alloc_init_pte
> > gets called which allocates a PTE outside of the initialized region (in
> > early_alloc_aligned). The system freezes at the call of memset in
> > early_alloc_aligned function.
> > 
> > With some debug print, this can be better illustrated:
> > [    0.000000] pgd 800063f0, addr 8fc00000, end 8fda8000, next 8fda8000
> > [    0.000000] pud 800063f0, addr 8fc00000, end 8fda8000, next 8fda8000
> > [    0.000000] pmd 800063f0, addr 8fc00000, next 8fda8000
> >                          => actual end of memory ^^^^^^^^
> > [    0.000000] alloc_init_pte
> > [    0.000000] set_pte_ext, pte 00000000, addr 8fc00000, end 8fda8000
> > [    0.000000] early_pte_alloc
> > [    0.000000] early_alloc_aligned, 00001000, ptr 8fcff000, align
> > 00001000
> >      => PTE allocated outside of initialized area ^^^^^^^^
> 
> Right, and the question is why does that happen - and the answer is
> this:
> 
>         /*
>          * Round the memblock limit down to a section size.  This
>          * helps to ensure that we will allocate memory from the
>          * last full section, which should be mapped.
>          */
>         if (memblock_limit)
>                 memblock_limit = round_down(memblock_limit, SECTION_SIZE);
> 
> That should round down by 2x SECTION_SIZE to ensure that we don't start
> allocating the L2 page table in a section which isn't mapped.  Please
> try this patch:
> 
>  arch/arm/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4e6ef896c619..387becac5c86 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1142,7 +1142,7 @@ void __init sanity_check_meminfo(void)
>  	 * last full section, which should be mapped.
>  	 */
>  	if (memblock_limit)
> -		memblock_limit = round_down(memblock_limit, SECTION_SIZE);
> +		memblock_limit = round_down(memblock_limit, 2 * SECTION_SIZE);
>  	if (!memblock_limit)
>  		memblock_limit = arm_lowmem_limit;

For LPAE, where SECTION_SIZE == PMD_SIZE, this will set the memblock
limit a section lower than necessary.

In another subthread thread [1] I suggested roudning down to PMD_SIZE
instead, which should do the right thing regardless of LPAE.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/340925.html
