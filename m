From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 11 Jan 2015 21:56:41 +0800
Subject: [PATCH] pinctrl: sirf: drop marco support
Message-ID: <1420984601-3773-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

marco chip has been dropped, clear its support.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/Kconfig             |  2 +-
 drivers/pinctrl/sirf/pinctrl-sirf.c | 51 ++++++++++---------------------------
 drivers/pinctrl/sirf/pinctrl-sirf.h |  1 -
 3 files changed, 14 insertions(+), 40 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index d014f22..44cc5f7 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -113,7 +113,7 @@ config PINCTRL_SINGLE
 	  This selects the device tree based generic pinctrl driver.
 
 config PINCTRL_SIRF
-	bool "CSR SiRFprimaII/SiRFmarco pin controller driver"
+	bool "CSR SiRFprimaII pin controller driver"
 	depends on ARCH_SIRF
 	select PINMUX
 	select GPIOLIB_IRQCHIP
diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 4871647..2a1f072 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -38,7 +38,6 @@ struct sirfsoc_gpio_bank {
 
 struct sirfsoc_gpio_chip {
 	struct of_mm_gpio_chip chip;
-	bool is_marco; /* for marco, some registers are different with prima2 */
 	struct sirfsoc_gpio_bank sgpio_bank[SIRFSOC_GPIO_NO_OF_BANKS];
 };
 
@@ -149,23 +148,14 @@ static void sirfsoc_pinmux_endisable(struct sirfsoc_pmx *spmx,
 
 	for (i = 0; i < mux->muxmask_counts; i++) {
 		u32 muxval;
-		if (!spmx->is_marco) {
-			muxval = readl(spmx->gpio_virtbase +
-				SIRFSOC_GPIO_PAD_EN(mask[i].group));
-			if (enable)
-				muxval = muxval & ~mask[i].mask;
-			else
-				muxval = muxval | mask[i].mask;
-			writel(muxval, spmx->gpio_virtbase +
-				SIRFSOC_GPIO_PAD_EN(mask[i].group));
-		} else {
-			if (enable)
-				writel(mask[i].mask, spmx->gpio_virtbase +
-					SIRFSOC_GPIO_PAD_EN_CLR(mask[i].group));
-			else
-				writel(mask[i].mask, spmx->gpio_virtbase +
-					SIRFSOC_GPIO_PAD_EN(mask[i].group));
-		}
+		muxval = readl(spmx->gpio_virtbase +
+			SIRFSOC_GPIO_PAD_EN(mask[i].group));
+		if (enable)
+			muxval = muxval & ~mask[i].mask;
+		else
+			muxval = muxval | mask[i].mask;
+		writel(muxval, spmx->gpio_virtbase +
+			SIRFSOC_GPIO_PAD_EN(mask[i].group));
 	}
 
 	if (mux->funcmask && enable) {
@@ -223,16 +213,11 @@ static int sirfsoc_pinmux_request_gpio(struct pinctrl_dev *pmxdev,
 
 	spmx = pinctrl_dev_get_drvdata(pmxdev);
 
-	if (!spmx->is_marco) {
-		muxval = readl(spmx->gpio_virtbase +
-			SIRFSOC_GPIO_PAD_EN(group));
-		muxval = muxval | (1 << (offset - range->pin_base));
-		writel(muxval, spmx->gpio_virtbase +
-			SIRFSOC_GPIO_PAD_EN(group));
-	} else {
-		writel(1 << (offset - range->pin_base), spmx->gpio_virtbase +
-			SIRFSOC_GPIO_PAD_EN(group));
-	}
+	muxval = readl(spmx->gpio_virtbase +
+		SIRFSOC_GPIO_PAD_EN(group));
+	muxval = muxval | (1 << (offset - range->pin_base));
+	writel(muxval, spmx->gpio_virtbase +
+		SIRFSOC_GPIO_PAD_EN(group));
 
 	return 0;
 }
@@ -256,7 +241,6 @@ static void __iomem *sirfsoc_rsc_of_iomap(void)
 {
 	const struct of_device_id rsc_ids[]  = {
 		{ .compatible = "sirf,prima2-rsc" },
-		{ .compatible = "sirf,marco-rsc" },
 		{}
 	};
 	struct device_node *np;
@@ -284,7 +268,6 @@ static int sirfsoc_gpio_of_xlate(struct gpio_chip *gc,
 static const struct of_device_id pinmux_ids[] = {
 	{ .compatible = "sirf,prima2-pinctrl", .data = &prima2_pinctrl_data, },
 	{ .compatible = "sirf,atlas6-pinctrl", .data = &atlas6_pinctrl_data, },
-	{ .compatible = "sirf,marco-pinctrl", .data = &prima2_pinctrl_data, },
 	{}
 };
 
@@ -317,9 +300,6 @@ static int sirfsoc_pinmux_probe(struct platform_device *pdev)
 		goto out_no_rsc_remap;
 	}
 
-	if (of_device_is_compatible(np, "sirf,marco-pinctrl"))
-		spmx->is_marco = 1;
-
 	pdata = of_match_node(pinmux_ids, np)->data;
 	sirfsoc_pin_groups = pdata->grps;
 	sirfsoc_pingrp_cnt = pdata->grps_cnt;
@@ -803,7 +783,6 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 	struct sirfsoc_gpio_bank *bank;
 	void __iomem *regs;
 	struct platform_device *pdev;
-	bool is_marco = false;
 
 	u32 pullups[SIRFSOC_GPIO_NO_OF_BANKS], pulldowns[SIRFSOC_GPIO_NO_OF_BANKS];
 
@@ -819,9 +798,6 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 	if (!regs)
 		return -ENOMEM;
 
-	if (of_device_is_compatible(np, "sirf,marco-pinctrl"))
-		is_marco = 1;
-
 	sgpio->chip.gc.request = sirfsoc_gpio_request;
 	sgpio->chip.gc.free = sirfsoc_gpio_free;
 	sgpio->chip.gc.direction_input = sirfsoc_gpio_direction_input;
@@ -836,7 +812,6 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 	sgpio->chip.gc.of_gpio_n_cells = 2;
 	sgpio->chip.gc.dev = &pdev->dev;
 	sgpio->chip.regs = regs;
-	sgpio->is_marco = is_marco;
 
 	err = gpiochip_add(&sgpio->chip.gc);
 	if (err) {
diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.h b/drivers/pinctrl/sirf/pinctrl-sirf.h
index d7f16b4..9550335 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.h
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.h
@@ -49,7 +49,6 @@ struct sirfsoc_pmx {
 	u32 paden_regs[SIRFSOC_GPIO_NO_OF_BANKS];
 	u32 dspen_regs;
 	u32 rsc_regs[3];
-	bool is_marco;
 };
 
 /* SIRFSOC_GPIO_PAD_EN set */
-- 
2.2.1
