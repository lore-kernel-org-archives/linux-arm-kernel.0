From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2017 22:13:15 +0000
Subject: [PATCH 3/4] ARM: nommu: display vectors base
In-Reply-To: <20170118203837.6536-1-afzal.mohd.ma@gmail.com>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
 <20170118203837.6536-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170118221315.GP27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 02:08:37AM +0530, afzal mohammed wrote:
> The exception base address is now dynamically estimated for no-MMU
> case, display it.
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
>  arch/arm/mm/init.c | 5 +++++
>  arch/arm/mm/mm.h   | 5 +++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index cf47f86f79ed..9e11f255c3bf 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -522,7 +522,12 @@ void __init mem_init(void)
>  			"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
>  			"       .bss : 0x%p" " - 0x%p" "   (%4td kB)\n",
>  
> +#ifdef CONFIG_MMU
>  			MLK(UL(VECTORS_BASE), UL(VECTORS_BASE) + (PAGE_SIZE)),
> +#else
> +			MLK_ROUNDUP(vectors_base, vectors_base + PAGE_SIZE),

I think MLK() will do here - no need to use the rounding-up version
as PAGE_SIZE is a multiple of 1k.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
