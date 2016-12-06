From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 6 Dec 2016 22:43:40 +0000
Subject: [PATCH 1/3] ARM: Define KERNEL_START and KERNEL_END
In-Reply-To: <20161206195312.22354-2-f.fainelli@gmail.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <20161206195312.22354-1-f.fainelli@gmail.com>
 <20161206195312.22354-2-f.fainelli@gmail.com>
Message-ID: <SG2PR06MB116569D2A9756BE11131CB4B8A820@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/6/2016, Florian Fainelli wrote:
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4001dd15818d..18ef688a796e 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1437,12 +1437,8 @@ static void __init kmap_init(void)
>  static void __init map_lowmem(void)
>  {
>  	struct memblock_region *reg;
> -#ifdef CONFIG_XIP_KERNEL
> -	phys_addr_t kernel_x_start = round_down(__pa(_sdata), SECTION_SIZE);
> -#else
> -	phys_addr_t kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
> -#endif
> -	phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
> +	phys_addr_t kernel_x_start = round_down(__pa(KERNEL_START),
> SECTION_SIZE);
> +	phys_addr_t kernel_x_end = round_down(__pa(_end), SECTION_SIZE);

Why are you changing the end of executable kernel (hence the 'x' in
kernel_x_end) from __init_end to _end which basically maps the entire
kernel image including text and data?

Doing so would then change data from MT_MEMORY_RW into MT_MEMORY_RWX.

I would think it would create some type of security risk to allow
data to be executable.
