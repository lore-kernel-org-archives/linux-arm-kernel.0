From: henryc.chen@mediatek.com (Henry Chen)
Date: Mon, 23 May 2016 17:15:24 +0800
Subject: [PATCH] soc: mtk-pmic-wrap: avoid integer overflow warning
In-Reply-To: <1463086904-2493288-1-git-send-email-arnd@arndb.de>
References: <1463086904-2493288-1-git-send-email-arnd@arndb.de>
Message-ID: <1463994924.18442.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks to the patch.

On Thu, 2016-05-12 at 23:01 +0200, Arnd Bergmann wrote:
> On ARM64, the mtk-pmic-wrap driver causes a harmless warning:
> 
> mtk-pmic-wrap.c:1062:16: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> mtk-pmic-wrap.c:1074:16: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> mtk-pmic-wrap.c:1086:16: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>   .int_en_all = ~(BIT(31) | BIT(1)),
> 
> The problem is that the result of the BIT() macro is an 'unsigned long',
> so taking the bitwise NOT operation of that results in an integer
> with the upper 32 bits all set and that cannot be assigned to a
> 'u32' variable without loss of information.
> 
> This is harmless because we were never interested in the upper bits
> here anyway, so we can shut up the warning by adding a simple cast
> to 'u32'.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Henry Chen <henryc.chen@mediatek.com>

> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 3c3e56df526e..a003ba26ca6e 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1059,7 +1059,7 @@ static const struct pmic_wrapper_type pwrap_mt2701 = {
>  	.regs = mt2701_regs,
>  	.type = PWRAP_MT2701,
>  	.arb_en_all = 0x3f,
> -	.int_en_all = ~(BIT(31) | BIT(2)),
> +	.int_en_all = ~(u32)(BIT(31) | BIT(2)),
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE_NEW,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 0,
> @@ -1071,7 +1071,7 @@ static struct pmic_wrapper_type pwrap_mt8135 = {
>  	.regs = mt8135_regs,
>  	.type = PWRAP_MT8135,
>  	.arb_en_all = 0x1ff,
> -	.int_en_all = ~(BIT(31) | BIT(1)),
> +	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 1,
> @@ -1083,7 +1083,7 @@ static struct pmic_wrapper_type pwrap_mt8173 = {
>  	.regs = mt8173_regs,
>  	.type = PWRAP_MT8173,
>  	.arb_en_all = 0x3f,
> -	.int_en_all = ~(BIT(31) | BIT(1)),
> +	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_NO_STAUPD,
>  	.has_bridge = 0,
