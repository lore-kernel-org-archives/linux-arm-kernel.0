From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 29 Jul 2010 05:16:28 +0200
Subject: [PATCH 12/13] [ARM] pxa/balloon3: Add NAND driver
In-Reply-To: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1280373389-32475-12-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND support is implemented through the gen_nand driver.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c              |  198 +++++++++++++++++++++++++++++
 arch/arm/mach-pxa/include/mach/balloon3.h |    3 +
 2 files changed, 201 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 6f594bd..781dab7 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -27,6 +27,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/types.h>
 #include <linux/i2c/pcf857x.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -530,6 +532,201 @@ static inline void balloon3_i2c_init(void) {}
 #endif
 
 /******************************************************************************
+ * NAND
+ ******************************************************************************/
+#if defined(CONFIG_MTD_NAND_PLATFORM)||defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
+
+#define	BALLOON3_NAND_BASE		(0x10e00000)
+#define	BALLOON3_NAND_IO_REG		(0x10e00000)
+#define	BALLOON3_NAND_CONTROL2_REG	(0x10e00010)
+#define	BALLOON3_NAND_STAT_REG		(0x10e00010)
+#define	BALLOON3_NAND_CONTROL_REG	(0x10e00014)
+#define BALLOON3_FPGA_VER		(0x10e0001c)
+
+#define	BALLOON3_NAND_CONTROL_FLWP	(1 << 7)
+#define	BALLOON3_NAND_CONTROL_FLSE	(1 << 6)
+#define	BALLOON3_NAND_CONTROL_FLCE3	(1 << 5)
+#define	BALLOON3_NAND_CONTROL_FLCE2	(1 << 4)
+#define	BALLOON3_NAND_CONTROL_FLCE1	(1 << 3)
+#define	BALLOON3_NAND_CONTROL_FLCE0	(1 << 2)
+#define	BALLOON3_NAND_CONTROL_FLALE	(1 << 1)
+#define	BALLOON3_NAND_CONTROL_FLCLE	(1 << 0)
+
+#define	BALLOON3_NAND_STAT_RNB		(1 << 0)
+
+#define	BALLOON3_NAND_CONTROL2_16BIT	(1 << 0)
+
+static void __iomem *nand_control_reg;
+
+static uint16_t balloon3_ctl =
+	BALLOON3_NAND_CONTROL_FLCE0 | BALLOON3_NAND_CONTROL_FLCE1 |
+	BALLOON3_NAND_CONTROL_FLCE2 | BALLOON3_NAND_CONTROL_FLCE3 |
+	BALLOON3_NAND_CONTROL_FLWP;
+
+static void balloon3_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+
+	if (ctrl & NAND_CTRL_CHANGE) {
+		if (ctrl & NAND_CLE)
+			balloon3_ctl |= BALLOON3_NAND_CONTROL_FLCLE;
+		else
+			balloon3_ctl &= ~BALLOON3_NAND_CONTROL_FLCLE;
+
+		if (ctrl & NAND_ALE)
+			balloon3_ctl |= BALLOON3_NAND_CONTROL_FLALE;
+		else
+			balloon3_ctl &= ~BALLOON3_NAND_CONTROL_FLALE;
+
+		writel(balloon3_ctl, nand_control_reg);
+	}
+
+	if (cmd != NAND_CMD_NONE)
+		writeb(cmd, this->IO_ADDR_W);
+}
+
+static void balloon3_nand_select_chip(struct mtd_info *mtd, int chip)
+{
+	if (chip < 0 || chip > 3)
+		return;
+
+	balloon3_ctl |= BALLOON3_NAND_CONTROL_FLCE0 |
+			BALLOON3_NAND_CONTROL_FLCE1 |
+			BALLOON3_NAND_CONTROL_FLCE2 |
+			BALLOON3_NAND_CONTROL_FLCE3;
+
+	/* Deassert correct nCE line */
+	balloon3_ctl &= ~(BALLOON3_NAND_CONTROL_FLCE0 << chip);
+
+	writew(balloon3_ctl, nand_control_reg);
+}
+
+static int balloon3_nand_probe(struct platform_device *pdev)
+{
+	void __iomem *temp_map;
+	uint16_t ver;
+	int ret;
+
+	/* Configure the FPGA to use 8bit NAND */
+	temp_map = ioremap(BALLOON3_NAND_CONTROL2_REG, 0x4);
+	if (!temp_map) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+	writew(BALLOON3_NAND_CONTROL2_16BIT, temp_map);
+	iounmap(temp_map);
+
+	/* Configure the FPGA to use 8bit NAND */
+	temp_map = ioremap(BALLOON3_FPGA_VER, 0x4);
+	if (!temp_map) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+	ver = readw(temp_map);
+	if (ver > 0x0201)
+		pr_warn("The FPGA code, version 0x%04x, is newer than rel-0.3. "
+			"NAND support might be broken in this version!", ver);
+	iounmap(temp_map);
+
+	/* Remap control register */
+	nand_control_reg = ioremap(BALLOON3_NAND_CONTROL_REG, 0x4);
+	if (!nand_control_reg) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	/* Power up the NAND chips */
+	ret = gpio_request(BALLOON3_GPIO_RUN_NAND, "NAND");
+	if (ret)
+		goto err2;
+
+	ret = gpio_direction_output(BALLOON3_GPIO_RUN_NAND, 1);
+	if (ret)
+		goto err3;
+
+	gpio_set_value(BALLOON3_GPIO_RUN_NAND, 1);
+
+	/* Deassert all nCE lines and write protect line */
+	writel(balloon3_ctl, nand_control_reg);
+	return 0;
+
+err3:
+	gpio_free(BALLOON3_GPIO_RUN_NAND);
+err2:
+	iounmap(nand_control_reg);
+err1:
+	return ret;
+}
+
+static void balloon3_nand_remove(struct platform_device *pdev)
+{
+	/* Power down the NAND chips */
+	gpio_set_value(BALLOON3_GPIO_RUN_NAND, 0);
+	gpio_free(BALLOON3_GPIO_RUN_NAND);
+	iounmap(nand_control_reg);
+}
+
+static struct mtd_partition balloon3_partition_info[] = {
+	[0] = {
+		.name	= "Boot",
+		.offset	= 0,
+		.size	= SZ_4M,
+	},
+	[1] = {
+		.name	= "RootFS",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= MTDPART_SIZ_FULL
+	},
+};
+
+static const char *balloon3_part_probes[] = { "cmdlinepart", NULL };
+
+struct platform_nand_data balloon3_nand_pdata = {
+	.chip = {
+		.nr_chips	= 4,
+		.chip_offset	= 0,
+		.nr_partitions	= ARRAY_SIZE(balloon3_partition_info),
+		.partitions	= balloon3_partition_info,
+		.chip_delay	= 50,
+		.part_probe_types = balloon3_part_probes,
+	},
+	.ctrl = {
+		.hwcontrol	= 0,
+		.dev_ready	= 0,
+		.select_chip	= balloon3_nand_select_chip,
+		.cmd_ctrl	= balloon3_nand_cmd_ctl,
+		.probe		= balloon3_nand_probe,
+		.remove		= balloon3_nand_remove,
+	},
+};
+
+static struct resource balloon3_nand_resource[] = {
+	[0] = {
+		.start = BALLOON3_NAND_BASE,
+		.end   = BALLOON3_NAND_BASE + 0x4,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device balloon3_nand = {
+	.name		= "gen_nand",
+	.num_resources	= ARRAY_SIZE(balloon3_nand_resource),
+	.resource	= balloon3_nand_resource,
+	.id		= -1,
+	.dev		= {
+		.platform_data = &balloon3_nand_pdata,
+	}
+};
+
+static void __init balloon3_nand_init(void)
+{
+	platform_device_register(&balloon3_nand);
+}
+#else
+static inline void balloon3_nand_init(void) {}
+#endif
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void __init balloon3_init(void)
@@ -547,6 +744,7 @@ static void __init balloon3_init(void)
 	balloon3_lcd_init();
 	balloon3_leds_init();
 	balloon3_mmc_init();
+	balloon3_nand_init();
 	balloon3_nor_init();
 	balloon3_ts_init();
 	balloon3_udc_init();
diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index 8886c23..555c5ba 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -50,6 +50,9 @@ enum balloon3_features {
 
 #define BALLOON3_GPIO_S0_CD		(105)
 
+/* NAND */
+#define BALLOON3_GPIO_RUN_NAND		(102)
+
 /* PCF8574A Leds */
 #define	BALLOON3_PCF_GPIO_BASE		160
 #define	BALLOON3_PCF_GPIO_LED0		(BALLOON3_PCF_GPIO_BASE + 0)
-- 
1.7.1
