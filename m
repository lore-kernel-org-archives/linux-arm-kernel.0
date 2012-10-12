From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 12 Oct 2012 11:37:30 +0200
Subject: [PATCH] ARM: nomadik: fixup some FSMC merge problems
In-Reply-To: <1349994182-26116-1-git-send-email-linus.walleij@linaro.org>
References: <1349994182-26116-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121012093730.GA12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 00:23 Fri 12 Oct     , Linus Walleij wrote:
> 
> Due to a clash between refactoring and due to loss of a header
> file that remained in my working tree the Nomadik stopped
> compiling after switching to the FSMC driver. This patch fixes
> it up.
> 
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> ---
>  arch/arm/mach-nomadik/board-nhk8815.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
> index a105d1b..3f97ef4 100644
> --- a/arch/arm/mach-nomadik/board-nhk8815.c
> +++ b/arch/arm/mach-nomadik/board-nhk8815.c
> @@ -37,14 +37,15 @@
>  #include <plat/mtu.h>
>  #include <plat/pincfg.h>
>  
> -#include <mach/fsmc.h>
> -
>  #include "cpu-8815.h"
>  
>  /* Initial value for SRC control register: all timers use MXTAL/8 source */
>  #define SRC_CR_INIT_MASK	0x00007fff
>  #define SRC_CR_INIT_VAL		0x2aaa8000
>  
> +#define ALE_OFF 0x1000000
> +#define CLE_OFF 0x800000
> +
>  /* These addresses span 16MB, so use three individual pages */
>  static struct resource nhk8815_nand_resources[] = {
>  	{
> @@ -53,6 +54,16 @@ static struct resource nhk8815_nand_resources[] = {
>  		.end = 0x40000000 + SZ_16K - 1,
>  		.flags = IORESOURCE_MEM,
>  	}, {
> +		.name = "nand_addr",
> +		.start = 0x40000000 + ALE_OFF,
> +		.end = 0x40000000 +ALE_OFF + SZ_16K - 1,
> +		.flags = IORESOURCE_MEM,
> +	}, {
> +		.name = "nand_cmd",
> +		.start = 0x40000000 + CLE_OFF,
> +		.end = 0x40000000 + CLE_OFF + SZ_16K - 1,
> +		.flags = IORESOURCE_MEM,
> +	}, {
>  		.name  = "fsmc_regs",
>  		.start = NOMADIK_FSMC_BASE,
>  		.end   = NOMADIK_FSMC_BASE + SZ_4K - 1,
> @@ -105,8 +116,6 @@ static struct fsmc_nand_platform_data nhk8815_nand_platform_data = {
>  	.partitions = nhk8815_partitions,
>  	.nr_partitions = ARRAY_SIZE(nhk8815_partitions),
>  	.width = FSMC_NAND_BW8,
> -	.ale_off = 0x1000000,
> -	.cle_off = 0x800000,
>  };
>  
>  static struct platform_device nhk8815_nand_device = {
> @@ -171,6 +180,10 @@ static struct platform_device nhk8815_onenand_device = {
>  	.num_resources	= ARRAY_SIZE(nhk8815_onenand_resource),
>  };
>  
> +/* bus control reg. and bus timing reg. for CS0..CS3 */
> +#define FSMC_BCR(x)	(NOMADIK_FSMC_VA + (x << 3))
> +#define FSMC_BTR(x)	(NOMADIK_FSMC_VA + (x << 3) + 0x04)
> +
>  static void __init nhk8815_onenand_init(void)
>  {
>  #ifdef CONFIG_MTD_ONENAND
> -- 
> 1.7.11.4
> 
