From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2012 09:16:49 +0900
Subject: [PATCH 2/7] mmc: sdhi: enchance OF support for flags and cd-gpios
In-Reply-To: <1353889014-17142-1-git-send-email-horms@verge.net.au>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
Message-ID: <1353889014-17142-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enhance the OF support for SDHI by adding the following bindings:

* renesas,shmobile-sdhi-has-idle-wait:
  Equivalent to setting TMIO_MMC_HAS_IDLE_WAIT in
  the flags of platform data

* renesas,shmobile-sdhi-use-gpio-cd:
  Equivalent to setting TMIO_MMC_USE_GPIO_CD in
  the flags of platform data

* renesas,shmobile-sdhi-wrprotect-disable:
  Equivalent to setting TMIO_MMC_WRPROTECT_DISABLE in
  the flags of platform data

* cd-gpios:
  Equivalent to setting cd_gpio in platform data

This patch also requests the clock based on the device tree
node name if the platform data is absent.

The motivation for this is to allow registration of the SDHI
device of the KZM-A9-GT board through device tree.

The following device tree snippet illustrates the use of the bindings
described above.

	sdhi0 at 0xee100000 {
		compatible = "renesas,shmobile-sdhi";
		reg = <0xee100000 0x100>;
		interrupt-parent = <&gic>;
		interrupts = <0 83 0x4
			      0 84 0x4
			      0 85 0x4>;
		interrupt-names = "card_detect", "sdcard", "sdio";
		reg-io-width = <2>;
		vmmc-supply = <&fixedregulator2v8>;
		vqmmc-supply = <&fixedregulator2v8>;
		renesas,shmobile-sdhi-has-idle-wait;
	};

	sdhi2 at 0xee140000 {
		compatible = "renesas,shmobile-sdhi";
		reg = <0xee140000 0x100>;
		interrupt-parent = <&gic>;
		interrupts = <0 103 0x4
			      0 104 0x4
			      0 105 0x4>;
		interrupt-names = "card_detect", "sdcard", "sdio";
		reg-io-width = <2>;
		vmmc-supply = <&fixedregulator2v8>;
		vqmmc-supply = <&fixedregulator2v8>;
		renesas,shmobile-sdhi-has-idle-wait;
		renesas,shmobile-sdhi-use-gpio-cd;
		renesas,shmobile-sdhi-wrprotect-disable;
		cd-gpios = <&gpio 13 1>;
	};

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   76 +++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 0bdc146..8c7e658 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -29,6 +29,7 @@
 #include <linux/mfd/tmio.h>
 #include <linux/sh_dma.h>
 #include <linux/delay.h>
+#include <linux/of_gpio.h>
 
 #include "tmio_mmc.h"
 
@@ -117,13 +118,64 @@ static const struct sh_mobile_sdhi_ops sdhi_ops = {
 	.cd_wakeup = sh_mobile_sdhi_cd_wakeup,
 };
 
+static int __devinit
+sh_mobile_sdhi_probe_clk(struct platform_device *pdev,
+			 struct sh_mobile_sdhi *priv,
+			 const char *clk_name)
+{
+	priv->clk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		return PTR_ERR(priv->clk);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static int __devinit
+sh_mobile_sdhi_probe_config_dt(struct platform_device *pdev,
+			       struct sh_mobile_sdhi *priv)
+{
+	struct tmio_mmc_data *mmc_data = &priv->mmc_data;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	BUG_ON(!np);
+
+	ret = sh_mobile_sdhi_probe_clk(pdev, priv, np->name);
+	if (ret)
+		return ret;
+
+	ret = of_get_named_gpio(np, "cd-gpios", 0);
+	if (gpio_is_valid(ret))
+		mmc_data->cd_gpio = ret;
+
+	if (of_get_property(np, "renesas,shmobile-sdhi-has-idle-wait", NULL))
+		mmc_data->flags |= TMIO_MMC_HAS_IDLE_WAIT;
+	if (of_get_property(np, "renesas,shmobile-sdhi-use-gpio-cd", NULL))
+		mmc_data->flags |= TMIO_MMC_USE_GPIO_CD;
+	if (of_get_property(np, "renesas,shmobile-sdhi-wrprotect-disable",
+			    NULL))
+		mmc_data->flags |= TMIO_MMC_WRPROTECT_DISABLE;
+
+	return 0;
+}
+#else
+static int __devinit
+sh_mobile_sdhi_probe_config_dt(struct platform_device *pdev,
+			       struct sh_mobile_sdhi *priv)
+{
+	return 0;
+}
+#endif
+
 static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
-	char clk_name[8];
 	int irq, ret, i = 0;
 	bool multiplexed_isr = true;
 
@@ -144,21 +196,17 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		}
 	}
 
-	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
-	priv->clk = clk_get(&pdev->dev, clk_name);
-	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
-		ret = PTR_ERR(priv->clk);
-		goto eclkget;
-	}
-
 	mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
 	mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
 	if (p) {
+		char clk_name[8];
+		snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
+		ret = sh_mobile_sdhi_probe_clk(pdev, priv, clk_name);
+		if (ret)
+			goto eclkget;
+
 		mmc_data->flags = p->tmio_flags;
-		if (mmc_data->flags & TMIO_MMC_HAS_IDLE_WAIT)
-			mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
 		mmc_data->ocr_mask = p->tmio_ocr_mask;
 		mmc_data->capabilities |= p->tmio_caps;
 		mmc_data->capabilities2 |= p->tmio_caps2;
@@ -176,7 +224,13 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 			priv->dma_priv.alignment_shift = 1; /* 2-byte alignment */
 			mmc_data->dma = &priv->dma_priv;
 		}
+	} else {
+		ret = sh_mobile_sdhi_probe_config_dt(pdev, priv);
+		if (ret)
+			goto eclkget;
 	}
+	if (mmc_data->flags & TMIO_MMC_HAS_IDLE_WAIT)
+		mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
 
 	/*
 	 * All SDHI blocks support 2-byte and larger block sizes in 4-bit
-- 
1.7.10.4
