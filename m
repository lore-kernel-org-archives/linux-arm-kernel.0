From: prakity@marvell.com (Philip Rakity)
Date: Tue, 21 Dec 2010 23:16:18 -0800
Subject: Fwd: [PATCH 3/23]  Alternative mmc structure to support pxa168,
	pxa910, mmp2 family SD
References: <B8EC55D2-F154-492D-AF7C-39A779B4E740@marvell.com>
Message-ID: <ABB3BF96-C852-4B81-8B27-12352F460703@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


resend -- correct list


Begin forwarded message:

> From: Philip Rakity <prakity@marvell.com>
> Date: December 21, 2010 11:07:46 PM PST
> To: "linux-mtd at lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel at lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
> Cc: Mark Brown <markb@marvell.com>
> Subject: [PATCH 3/23] Alternative mmc structure to support pxa168, pxa910, mmp2 family SD
> 
> 
> From 53c28d8058538f0b731982aa6f0b4ee38bf52e44 Mon Sep 17 00:00:00 2001
> From: Philip Rakity <prakity@marvell.com>
> Date: Sun, 19 Dec 2010 19:08:31 -0800
> Subject: [PATCH] sdhci: delete clk gating code since not correct
> 
> clock gating is using wrong registers for mmp2.
> remove code -- future patch will add back support
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Mark F. Brown <markb@marvell.com>
> ---
> arch/arm/plat-pxa/include/plat/sdhci.h |    1 -
> drivers/mmc/host/sdhci-pxa.c           |    9 ---------
> 2 files changed, 0 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
> index 1ab332e..270fb2b 100644
> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -15,7 +15,6 @@
> 
> /* pxa specific flag */
> /* Require clock free running */
> -#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
> 
> /* Board design supports 8-bit data on SD/SDIO BUS */
> #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
> index 5a61208..4713238 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -29,9 +29,6 @@
> 
> #define DRIVER_NAME	"sdhci-pxa"
> 
> -#define SD_FIFO_PARAM		0x104
> -#define DIS_PAD_SD_CLK_GATE	0x400
> -
> struct sdhci_pxa {
> 	struct sdhci_host		*host;
> 	struct sdhci_pxa_platdata	*pdata;
> @@ -49,7 +46,6 @@ struct sdhci_pxa {
> static void set_clock(struct sdhci_host *host, unsigned int clock)
> {
> 	struct sdhci_pxa *pxa = sdhci_priv(host);
> -	u32 tmp = 0;
> 
> 	if (clock == 0) {
> 		if (pxa->clk_enable) {
> @@ -58,11 +54,6 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
> 		}
> 	} else {
> 		if (0 == pxa->clk_enable) {
> -			if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
> -				tmp = readl(host->ioaddr + SD_FIFO_PARAM);
> -				tmp |= DIS_PAD_SD_CLK_GATE;
> -				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
> -			}
> 			clk_enable(pxa->clk);
> 			pxa->clk_enable = 1;
> 		}
> -- 
> 1.6.0.4
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-sdhci-delete-clk-gating-code-since-not-correct.patch
Type: application/octet-stream
Size: 2012 bytes
Desc: 0003-sdhci-delete-clk-gating-code-since-not-correct.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101221/53b71d5a/attachment.obj>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ATT00001..txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101221/53b71d5a/attachment.txt>
