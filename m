From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Nov 2011 16:39:32 +0800
Subject: [PATCH 4/4] arm/imx: fix imx6q mmc error when mounting rootfs
In-Reply-To: <1320914372-4416-1-git-send-email-shawn.guo@linaro.org>
References: <1320914372-4416-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1320914372-4416-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following error is seen in some case when mounting rootfs from
SD/MMC cards.

  Waiting for root device /dev/mmcblk0p1...
  mmc1: host does not support reading read-only switch. assuming write-enable.
  mmc1: new high speed SDHC card at address b368
  mmcblk0: mmc1:b368 SDC   3.74 GiB
   mmcblk0: p1
  mmc1: Timeout waiting for hardware interrupt.
  mmcblk0: error -110 transferring data, sector 3678224, nr 40, cmd response 0x900, card status 0xc00
  end_request: I/O error, dev mmcblk0, sector 3678225
  Buffer I/O error on device mmcblk0p1, logical block 458754
  lost page write due to I/O error on mmcblk0p1

This patch fixes the problem by lowering the usdhc clock and correcting
watermark configuration.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clock-imx6q.c    |   17 ++++++++++++++++-
 drivers/mmc/host/sdhci-esdhc-imx.c |    8 ++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index e0b926d..613a1b9 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -1139,7 +1139,7 @@ static int _clk_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	max_div = ((d->bm_pred >> d->bp_pred) + 1) *
-		  ((d->bm_pred >> d->bp_pred) + 1);
+		  ((d->bm_podf >> d->bp_podf) + 1);
 
 	div = parent_rate / rate;
 	if (div == 0)
@@ -2002,6 +2002,21 @@ int __init mx6q_clocks_init(void)
 	clk_set_rate(&asrc_serial_clk, 1500000);
 	clk_set_rate(&enfc_clk, 11000000);
 
+	/*
+	 * Before pinctrl API is available, we have to rely on the pad
+	 * configuration set up by bootloader.  For usdhc example here,
+	 * u-boot sets up the pads for 49.5 MHz case, and we have to lower
+	 * the usdhc clock from 198 to 49.5 MHz to match the pad configuration.
+	 *
+	 * FIXME: This is should be removed after pinctrl API is available.
+	 * At that time, usdhc driver can call pinctrl API to change pad
+	 * configuration dynamically per different usdhc clock settings.
+	 */
+	clk_set_rate(&usdhc1_clk, 49500000);
+	clk_set_rate(&usdhc2_clk, 49500000);
+	clk_set_rate(&usdhc3_clk, 49500000);
+	clk_set_rate(&usdhc4_clk, 49500000);
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpt");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ae57769..4b976f0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -32,6 +32,7 @@
 /* VENDOR SPEC register */
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
+#define SDHCI_WTMK_LVL			0x44
 #define SDHCI_MIX_CTRL			0x48
 
 /*
@@ -476,6 +477,13 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (is_imx53_esdhc(imx_data))
 		imx_data->flags |= ESDHC_FLAG_MULTIBLK_NO_INT;
 
+	/*
+	 * The imx6q ROM code will change the default watermark level setting
+	 * to something insane.  Change it back here.
+	 */
+	if (is_imx6q_usdhc(imx_data))
+		writel(0x08100810, host->ioaddr + SDHCI_WTMK_LVL);
+
 	boarddata = &imx_data->boarddata;
 	if (sdhci_esdhc_imx_probe_dt(pdev, boarddata) < 0) {
 		if (!host->mmc->parent->platform_data) {
-- 
1.7.4.1
