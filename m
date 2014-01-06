From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 06 Jan 2014 19:38:38 +0100
Subject: [PATCH 2/5] ARM: S3C24XX: add generic handler for swrst resets
In-Reply-To: <3105326.uFdOVLyXH8@phil>
References: <3105326.uFdOVLyXH8@phil>
Message-ID: <1569032.VYgrksRbsn@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously the s3c24xx socs using the swrst machnism simply wrote
the needed value to a statically mapped register.

To generalize and make it usable in the dt case create a reset handler
similar to the already existing watchdog-reset used by different samsung
architectures.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig       |    5 ++
 arch/arm/mach-s3c24xx/Makefile      |    1 +
 arch/arm/mach-s3c24xx/common.h      |   16 ++++
 arch/arm/mach-s3c24xx/swrst-reset.c |  160 +++++++++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 arch/arm/mach-s3c24xx/swrst-reset.c

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index e19e314..bb0f653 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -30,6 +30,11 @@ config S3C2410_COMMON_DCLK
 	  Temporary symbol to build the dclk driver based on the common clock
 	  framework.
 
+config S3C24XX_SWRST
+	bool
+	help
+	  Handle resets using the swrst register available on some s3c24xx SoCs.
+
 menu "SAMSUNG S3C24XX SoCs Support"
 
 comment "S3C24XX SoCs"
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 2235d0d..9cc1d58 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o
 # PM
 
 obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
+obj-$(CONFIG_S3C24XX_SWRST)	+= swrst-reset.o
 
 # common code
 
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 0f548c5..caf1534 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -131,4 +131,20 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 				    void __iomem *reg_base);
 #endif
 
+#ifdef CONFIG_S3C24XX_SWRST
+void s3c24xx_swrst_reset(void);
+bool s3c24xx_swrst_reset_available(void);
+void s3c24xx_swrst_reset_of_init(void);
+void s3c24xx_swrst_reset_init(void __iomem *base, bool is_s3c2412);
+#else
+static inline void s3c24xx_swrst_reset(void) {}
+static inline bool s3c24xx_swrst_reset_available(void)
+{
+	return false;
+}
+static inline void s3c24xx_swrst_reset_of_init(void) {}
+static inline void s3c24xx_swrst_reset_init(void __iomem *base,
+					     bool is_s3c2412) {}
+#endif
+
 #endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
diff --git a/arch/arm/mach-s3c24xx/swrst-reset.c b/arch/arm/mach-s3c24xx/swrst-reset.c
new file mode 100644
index 0000000..d027c4a
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/swrst-reset.c
@@ -0,0 +1,160 @@
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+/*
+ * Although the manuals state that the string to write to the register
+ * is soc-specific, at least the s3c2416 and s3c2450 do not seem to care
+ * what gets written to the register and have been using the s3c2443
+ * string all along.
+ */
+#define S3C2412_SWRST_RESET		(0x533C2412)
+#define S3C2443_SWRST_RESET		(0x533C2443)
+
+enum s3c_cpu_type {
+	TYPE_S3C2412,
+	TYPE_S3C2443,
+};
+
+struct s3c24xx_swrst_drv_data {
+	int cpu_type;
+};
+
+struct s3c2412_rst_clocks {
+	const char *clk;
+	const char *new_parent;
+};
+
+/* S3C2412 errata "Watch-dog/Software Reset Problem" specifies
+ * that this reset must be done with the SYSCLK sourced from
+ * EXTCLK instead of FOUT to avoid a glitch in the reset
+ * mechanism.
+ *
+ * See the watchdog section of the S3C2412 manual for more
+ * information on this fix.
+ *
+ * The proposed fix is to write "0" to the clksrc register,
+ * to reset the sysclk "which generates the ARMCLK, HCLK, PCLK".
+ * Translated to the clock implementation, this looks like:
+ */
+struct s3c2412_rst_clocks s3c2412_clocks[] = {
+	{ "mdivclk", "xti" },
+	{ "msysclk", "mdivclk" },
+};
+
+static void __iomem *swrst_base;
+static int swrst_type;
+
+void s3c24xx_swrst_reset(void)
+{
+	int i;
+	bool has_faults = true;
+
+	if (!swrst_base) {
+		pr_err("%s: swrst reset not initialized\n", __func__);
+		/* delay to allow the serial port to show the message */
+		mdelay(50);
+		return;
+	}
+
+	switch (swrst_type) {
+	case TYPE_S3C2412:
+		/* handle the needed clock changes */
+		for (i = 0; i < ARRAY_SIZE(s3c2412_clocks); i++) {
+			struct s3c2412_rst_clocks *entry = &s3c2412_clocks[i];
+			struct clk *clk, *new_parent;
+			int ret;
+
+			clk = clk_get(NULL, entry->clk);
+			if (IS_ERR(clk)) {
+				pr_err("s3c24xx-swrst: could not get clock %s, err %ld\n",
+				       entry->clk, PTR_ERR(clk));
+				has_faults = true;
+				continue;
+			}
+
+			new_parent = clk_get(NULL, entry->new_parent);
+			if (IS_ERR(new_parent)) {
+				pr_err("s3c24xx-swrst: could not get clock %s, err %ld\n",
+				       entry->new_parent, PTR_ERR(new_parent));
+				has_faults = true;
+				clk_put(clk);
+				continue;
+			}
+
+			ret = clk_set_parent(clk, new_parent);
+			if (ret) {
+				pr_err("s3c24xx-swrst: could not set the parent clock of %s to %s, err %d\n",
+				       entry->clk, entry->new_parent, ret);
+				has_faults = true;
+			}
+
+			clk_put(new_parent);
+			clk_put(clk);
+		}
+
+		if (has_faults) {
+			pr_warn("s3c24xx-swrst: some clocks could not be set to the needed parent.\n");
+			pr_warn("s3c24xx-swrst: this can trigger a glitch in the s3c2412 soc\n");
+		}
+
+		writel(S3C2412_SWRST_RESET, swrst_base);
+		break;
+	case TYPE_S3C2443:
+		writel(S3C2443_SWRST_RESET, swrst_base);
+		break;
+	}
+}
+
+bool s3c24xx_swrst_reset_available(void)
+{
+	return !!swrst_base;
+}
+
+#ifdef CONFIG_OF
+static struct s3c24xx_swrst_drv_data s3c24xx_swrst_drv_data_array[] = {
+	[TYPE_S3C2412] = { TYPE_S3C2412 },
+	[TYPE_S3C2443] = { TYPE_S3C2443 },
+};
+
+static const struct of_device_id s3c24xx_swrst_match[] = {
+	{
+		.compatible = "samsung,s3c2412-swrst",
+		.data = &s3c24xx_swrst_drv_data_array[TYPE_S3C2412],
+	}, {
+		.compatible = "samsung,s3c2443-swrst",
+		.data = &s3c24xx_swrst_drv_data_array[TYPE_S3C2443],
+	},
+	{},
+};
+
+void __init s3c24xx_swrst_reset_of_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	struct s3c24xx_swrst_drv_data *data;
+
+	np = of_find_matching_node_and_match(NULL, s3c24xx_swrst_match, &match);
+	if (!np)
+		return;
+
+	data = (struct s3c24xx_swrst_drv_data *)match->data;
+	swrst_type = data->cpu_type;
+
+	swrst_base = of_iomap(np, 0);
+	if (!swrst_base) {
+		pr_err("%s: failed to map swrst register\n", __func__);
+		return;
+	}
+
+}
+#endif
+
+void __init s3c24xx_swrst_reset_init(void __iomem *base, bool is_s3c2412)
+{
+	swrst_base = base;
+	swrst_type = (is_s3c2412) ? TYPE_S3C2412 : TYPE_S3C2443;
+}
-- 
1.7.10.4
