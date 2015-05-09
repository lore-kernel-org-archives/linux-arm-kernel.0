From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 May 2015 14:48:18 +0100
Subject: Memory size unaligned to section boundary
In-Reply-To: <554E0DC8.4060401@redhat.com>
References: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
 <20150506101104.GD2067@n2100.arm.linux.org.uk>
 <20150506105102.GB5382@e104818-lin.cambridge.arm.com>
 <20150506113503.GT2067@n2100.arm.linux.org.uk>
 <554E0DC8.4060401@redhat.com>
Message-ID: <20150509134818.GP2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 03:38:16PM +0200, Hans de Goede wrote:
> Ok, so does that mean that Mark's original patch:
> 
> ---->8----
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4e6ef89..2ea13f0 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1125,9 +1125,9 @@ void __init sanity_check_meminfo(void)
>                          * occurs before any free memory is mapped.
>                          */
>                         if (!memblock_limit) {
> -                               if (!IS_ALIGNED(block_start, SECTION_SIZE))
> +                               if (!IS_ALIGNED(block_start, PMD_SIZE))
>                                         memblock_limit = block_start;
> -                               else if (!IS_ALIGNED(block_end, SECTION_SIZE))
> +                               else if (!IS_ALIGNED(block_end, PMD_SIZE))
>                                         memblock_limit = arm_lowmem_limit;
>                         }
> 
> @@ -1142,7 +1142,7 @@ void __init sanity_check_meminfo(void)
>          * last full section, which should be mapped.
>          */
>         if (memblock_limit)
> -               memblock_limit = round_down(memblock_limit, SECTION_SIZE);
> +               memblock_limit = round_down(memblock_limit, PMD_SIZE);
>         if (!memblock_limit)
>                 memblock_limit = arm_lowmem_limit;
> 
> 
> Is good, or do we only need to have the last chunk of this patch ?

That should do it, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
