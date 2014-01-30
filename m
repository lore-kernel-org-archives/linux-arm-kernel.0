From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 30 Jan 2014 13:03:40 +0200
Subject: [PATCH v5] ARM: davinci: aemif: get rid of davinci-nand driver
 dependency on aemif
Message-ID: <1391079820-13018-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The problem that the set timings code contains the call of Davinci
platform function davinci_aemif_setup_timing() which is not
accessible if kernel is built for another platform like Keystone.

The Keysone platform is going to use TI AEMIF driver.
If TI AEMIF is used we don't need to set timings and bus width.
It is done by AEMIF driver.

To get rid of davinci-nand driver dependency on aemif platform code
we moved aemif code to davinci platform.

The platform AEMIF code (aemif.c) has to be removed once Davinci
will be converted to DT and use ti-aemif.c driver.

Acked-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
[nsekhar at ti.com: fixed checkpatch error and a build breakage due to
		 missing include, rebased onto l2-mtd/master]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Applies to latest of l2-mtd/master

v5:
- fixed coccinelle warning

 arch/arm/mach-davinci/aemif.c                   | 107 +++++++++++++++++++++---
 arch/arm/mach-davinci/board-da830-evm.c         |   3 +
 arch/arm/mach-davinci/board-da850-evm.c         |   3 +
 arch/arm/mach-davinci/board-dm644x-evm.c        |   5 ++
 arch/arm/mach-davinci/board-dm646x-evm.c        |   3 +
 arch/arm/mach-davinci/board-mityomapl138.c      |   4 +
 drivers/mtd/nand/davinci_nand.c                 |  22 -----
 include/linux/platform_data/mtd-davinci-aemif.h |   5 +-
 8 files changed, 117 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-davinci/aemif.c b/arch/arm/mach-davinci/aemif.c
index f091a90..ff8b7e7 100644
--- a/arch/arm/mach-davinci/aemif.c
+++ b/arch/arm/mach-davinci/aemif.c
@@ -16,6 +16,7 @@
 #include <linux/time.h>
 
 #include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/platform_data/mtd-davinci.h>
 
 /* Timing value configuration */
 
@@ -43,6 +44,17 @@
 				WSTROBE(WSTROBE_MAX) | \
 				WSETUP(WSETUP_MAX))
 
+static inline unsigned int davinci_aemif_readl(void __iomem *base, int offset)
+{
+	return readl_relaxed(base + offset);
+}
+
+static inline void davinci_aemif_writel(void __iomem *base,
+					int offset, unsigned long value)
+{
+	writel_relaxed(value, base + offset);
+}
+
 /*
  * aemif_calc_rate - calculate timing data.
  * @wanted: The cycle time needed in nanoseconds.
@@ -76,6 +88,7 @@ static int aemif_calc_rate(int wanted, unsigned long clk, int max)
  * @t: timing values to be progammed
  * @base: The virtual base address of the AEMIF interface
  * @cs: chip-select to program the timing values for
+ * @clkrate: the AEMIF clkrate
  *
  * This function programs the given timing values (in real clock) into the
  * AEMIF registers taking the AEMIF clock into account.
@@ -86,24 +99,17 @@ static int aemif_calc_rate(int wanted, unsigned long clk, int max)
  *
  * Returns 0 on success, else negative errno.
  */
-int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
-					void __iomem *base, unsigned cs)
+static int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
+					void __iomem *base, unsigned cs,
+					unsigned long clkrate)
 {
 	unsigned set, val;
 	int ta, rhold, rstrobe, rsetup, whold, wstrobe, wsetup;
 	unsigned offset = A1CR_OFFSET + cs * 4;
-	struct clk *aemif_clk;
-	unsigned long clkrate;
 
 	if (!t)
 		return 0;	/* Nothing to do */
 
-	aemif_clk = clk_get(NULL, "aemif");
-	if (IS_ERR(aemif_clk))
-		return PTR_ERR(aemif_clk);
-
-	clkrate = clk_get_rate(aemif_clk);
-
 	clkrate /= 1000;	/* turn clock into kHz for ease of use */
 
 	ta	= aemif_calc_rate(t->ta, clkrate, TA_MAX);
@@ -130,4 +136,83 @@ int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
 
 	return 0;
 }
-EXPORT_SYMBOL(davinci_aemif_setup_timing);
+
+/**
+ * davinci_aemif_setup - setup AEMIF interface by davinci_nand_pdata
+ * @pdev - link to platform device to setup settings for
+ *
+ * This function does not use any locking while programming the AEMIF
+ * because it is expected that there is only one user of a given
+ * chip-select.
+ *
+ * Returns 0 on success, else negative errno.
+ */
+int davinci_aemif_setup(struct platform_device *pdev)
+{
+	struct davinci_nand_pdata *pdata = dev_get_platdata(&pdev->dev);
+	uint32_t val;
+	unsigned long clkrate;
+	struct resource	*res;
+	void __iomem *base;
+	struct clk *clk;
+	int ret = 0;
+
+	clk = clk_get(&pdev->dev, "aemif");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		dev_dbg(&pdev->dev, "unable to get AEMIF clock, err %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev, "unable to enable AEMIF clock, err %d\n",
+			ret);
+		goto err_put;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "cannot get IORESOURCE_MEM\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	base = ioremap(res->start, resource_size(res));
+	if (!base) {
+		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res);
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/*
+	 * Setup Async configuration register in case we did not boot
+	 * from NAND and so bootloader did not bother to set it up.
+	 */
+	val = davinci_aemif_readl(base, A1CR_OFFSET + pdev->id * 4);
+	/*
+	 * Extended Wait is not valid and Select Strobe mode is not
+	 * used
+	 */
+	val &= ~(ACR_ASIZE_MASK | ACR_EW_MASK | ACR_SS_MASK);
+	if (pdata->options & NAND_BUSWIDTH_16)
+		val |= 0x1;
+
+	davinci_aemif_writel(base, A1CR_OFFSET + pdev->id * 4, val);
+
+	clkrate = clk_get_rate(clk);
+
+	if (pdata->timing)
+		ret = davinci_aemif_setup_timing(pdata->timing, base, pdev->id,
+						 clkrate);
+
+	if (ret < 0)
+		dev_dbg(&pdev->dev, "NAND timing values setup fail\n");
+
+	iounmap(base);
+err:
+	clk_disable_unprepare(clk);
+err_put:
+	clk_put(clk);
+	return ret;
+}
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index d1f45af..5623131 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -419,6 +419,9 @@ static inline void da830_evm_init_nand(int mux_mode)
 	if (ret)
 		pr_warning("da830_evm_init: NAND device not registered.\n");
 
+	if (davinci_aemif_setup(&da830_evm_nand_device))
+		pr_warn("%s: Cannot configure AEMIF.\n", __func__);
+
 	gpio_direction_output(mux_mode, 1);
 }
 #else
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index e0af0ec..234c5bb 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -358,6 +358,9 @@ static inline void da850_evm_setup_nor_nand(void)
 
 		platform_add_devices(da850_evm_devices,
 					ARRAY_SIZE(da850_evm_devices));
+
+		if (davinci_aemif_setup(&da850_evm_nandflash_device))
+			pr_warn("%s: Cannot configure AEMIF.\n", __func__);
 	}
 }
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 987605b7..5602957 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -778,6 +778,11 @@ static __init void davinci_evm_init(void)
 		/* only one device will be jumpered and detected */
 		if (HAS_NAND) {
 			platform_device_register(&davinci_evm_nandflash_device);
+
+			if (davinci_aemif_setup(&davinci_evm_nandflash_device))
+				pr_warn("%s: Cannot configure AEMIF.\n",
+					__func__);
+
 			evm_leds[7].default_trigger = "nand-disk";
 			if (HAS_NOR)
 				pr_warning("WARNING: both NAND and NOR flash "
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 13d0801..ae129bc 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -805,6 +805,9 @@ static __init void evm_init(void)
 
 	platform_device_register(&davinci_nand_device);
 
+	if (davinci_aemif_setup(&davinci_nand_device))
+		pr_warn("%s: Cannot configure AEMIF.\n", __func__);
+
 	dm646x_init_edma(dm646x_edma_rsv);
 
 	if (HAS_ATA)
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 7aa105b..96fc00a 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -27,6 +27,7 @@
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
 #include <linux/platform_data/mtd-davinci.h>
+#include <linux/platform_data/mtd-davinci-aemif.h>
 #include <mach/mux.h>
 #include <linux/platform_data/spi-davinci.h>
 
@@ -432,6 +433,9 @@ static void __init mityomapl138_setup_nand(void)
 {
 	platform_add_devices(mityomapl138_devices,
 				 ARRAY_SIZE(mityomapl138_devices));
+
+	if (davinci_aemif_setup(&mityomapl138_nandflash_device))
+		pr_warn("%s: Cannot configure AEMIF.\n", __func__);
 }
 
 static const short mityomap_mii_pins[] = {
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index a4989ec..8eb6a36 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -746,28 +746,6 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		goto err_clk_enable;
 	}
 
-	/*
-	 * Setup Async configuration register in case we did not boot from
-	 * NAND and so bootloader did not bother to set it up.
-	 */
-	val = davinci_nand_readl(info, A1CR_OFFSET + info->core_chipsel * 4);
-
-	/* Extended Wait is not valid and Select Strobe mode is not used */
-	val &= ~(ACR_ASIZE_MASK | ACR_EW_MASK | ACR_SS_MASK);
-	if (info->chip.options & NAND_BUSWIDTH_16)
-		val |= 0x1;
-
-	davinci_nand_writel(info, A1CR_OFFSET + info->core_chipsel * 4, val);
-
-	ret = 0;
-	if (info->timing)
-		ret = davinci_aemif_setup_timing(info->timing, info->base,
-							info->core_chipsel);
-	if (ret < 0) {
-		dev_dbg(&pdev->dev, "NAND timing values setup fail\n");
-		goto err;
-	}
-
 	spin_lock_irq(&davinci_nand_lock);
 
 	/* put CSxNAND into NAND mode */
diff --git a/include/linux/platform_data/mtd-davinci-aemif.h b/include/linux/platform_data/mtd-davinci-aemif.h
index 05b2934..97948ac 100644
--- a/include/linux/platform_data/mtd-davinci-aemif.h
+++ b/include/linux/platform_data/mtd-davinci-aemif.h
@@ -10,6 +10,8 @@
 #ifndef _MACH_DAVINCI_AEMIF_H
 #define _MACH_DAVINCI_AEMIF_H
 
+#include <linux/platform_device.h>
+
 #define NRCSR_OFFSET		0x00
 #define AWCCR_OFFSET		0x04
 #define A1CR_OFFSET		0x10
@@ -31,6 +33,5 @@ struct davinci_aemif_timing {
 	u8	ta;
 };
 
-int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
-					void __iomem *base, unsigned cs);
+int davinci_aemif_setup(struct platform_device *pdev);
 #endif
-- 
1.8.3.2
