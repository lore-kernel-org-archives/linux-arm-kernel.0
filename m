From: sergeimir@emcraft.com (Sergei Miroshnichenko)
Date: Wed, 14 Oct 2015 12:17:08 +0300
Subject: [PATCH 1/1] mmc: sdhci-esdhc-imx: enable Auto CMD12 for Vybrid
Message-ID: <1444814228-20863-1-git-send-email-sergeimir@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a compatible string to support Vybrid version of controller.

Enable Auto CMD12 for multi block read/write, as described in
Vybrid Reference Manual Chapter 50.6.3 "Card access".

This patch fixes support for SDIO devices, such as WiFi kits.

Tested on a VF610-based board.

Signed-off-by: Sergei Miroshnichenko <sergeimir@emcraft.com>
---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt          |  1 +
 arch/arm/boot/dts/vfxxx.dtsi                           |  4 ++--
 drivers/mmc/host/sdhci-esdhc-imx.c                     | 18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index dca56d6..694541f 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -12,6 +12,7 @@ Required properties:
 	       "fsl,imx35-esdhc"
 	       "fsl,imx51-esdhc"
 	       "fsl,imx53-esdhc"
+	       "fsl,vf610-esdhc"
 	       "fsl,imx6q-usdhc"
 	       "fsl,imx6sl-usdhc"
 	       "fsl,imx6sx-usdhc"
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 6865137..fd5975e 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -464,7 +464,7 @@
 			};
 
 			esdhc0: esdhc at 400b1000 {
-				compatible = "fsl,imx53-esdhc";
+				compatible = "fsl,vf610-esdhc";
 				reg = <0x400b1000 0x1000>;
 				interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_IPG_BUS>,
@@ -477,7 +477,7 @@
 			};
 
 			esdhc1: esdhc at 400b2000 {
-				compatible = "fsl,imx53-esdhc";
+				compatible = "fsl,vf610-esdhc";
 				reg = <0x400b2000 0x1000>;
 				interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_IPG_BUS>,
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 886d230..b125735 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -135,6 +135,8 @@
 #define ESDHC_FLAG_HS200		BIT(8)
 /* The IP supports HS400 mode */
 #define ESDHC_FLAG_HS400		BIT(9)
+/* Fix multiblock reads on Vybrid */
+#define ESDHC_FLAG_MULTIBLOCK_ACMD12	BIT(10)
 
 /* A higher clock ferquency than this rate requires strobell dll control */
 #define ESDHC_STROBE_DLL_CLK_FREQ	100000000
@@ -180,6 +182,10 @@ static struct esdhc_soc_data usdhc_imx7d_data = {
 			| ESDHC_FLAG_HS400,
 };
 
+static struct esdhc_soc_data esdhc_vf610_data = {
+	.flags = ESDHC_FLAG_MULTIBLK_NO_INT | ESDHC_FLAG_MULTIBLOCK_ACMD12,
+};
+
 struct pltfm_imx_data {
 	u32 scratchpad;
 	struct pinctrl *pinctrl;
@@ -224,6 +230,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
 	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
 	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
+	{ .compatible = "fsl,vf610-esdhc", .data = &esdhc_vf610_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
@@ -248,6 +255,11 @@ static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
 	return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
 }
 
+static inline int is_vf610_esdhc(struct pltfm_imx_data *data)
+{
+	return data->socdata == &esdhc_vf610_data;
+}
+
 static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
 {
 	void __iomem *base = host->ioaddr + (reg & ~0x3);
@@ -887,7 +899,8 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 			v = boarddata->delay_line <<
 				ESDHC_DLL_OVERRIDE_VAL_SHIFT |
 				(1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
-			if (is_imx53_esdhc(imx_data))
+			if (is_imx53_esdhc(imx_data) ||
+			    is_vf610_esdhc(imx_data))
 				v <<= 1;
 			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
 		}
@@ -1206,6 +1219,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 		host->quirks2 |= SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
 
+	if (imx_data->socdata->flags & ESDHC_FLAG_MULTIBLOCK_ACMD12)
+		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+
 	if (of_id)
 		err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
 	else
-- 
1.9.3
