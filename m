From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 22 Mar 2010 13:39:00 -0500
Subject: [PATCH 2/3] ep93xx: add /proc/cpuinfo extension
Message-ID: <0D753D10438DA54287A00B02708426976368DDCD38@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a callback to mach-ep93xx for the /proc/cpuinfo extension.

This cpuinfo extension dumps the processor unique ID and Maverick
Key as well as the processor silicon revision and a number of
boot configuration options.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

This patch depends on ep93xx: added chip revision reading function

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 90fb591..fe1eb7a 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -26,6 +26,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
+#include <linux/seq_file.h>
 #include <linux/termios.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
@@ -618,6 +619,81 @@ void ep93xx_keypad_release_gpio(struct platform_device *pdev)
 EXPORT_SYMBOL(ep93xx_keypad_release_gpio);
 
 
+/*************************************************************************
+ * EP93xx proc/cpuinfo extension
+ *************************************************************************/
+#define EP93XX_SECURITY_REG(x)			(EP93XX_SECURITY_BASE + (x))
+#define EP93XX_SECURITY_SECFLG			EP93XX_SECURITY_REG(0x2400)
+#define EP93XX_SECURITY_FUSEFLG			EP93XX_SECURITY_REG(0x2410)
+#define EP93XX_SECURITY_UNIQID			EP93XX_SECURITY_REG(0x2440)
+#define EP93XX_SECURITY_UNIQCHK			EP93XX_SECURITY_REG(0x2450)
+#define EP93XX_SECURITY_UNIQVAL			EP93XX_SECURITY_REG(0x2460)
+#define EP93XX_SECURITY_SECID1			EP93XX_SECURITY_REG(0x2500)
+#define EP93XX_SECURITY_SECID2			EP93XX_SECURITY_REG(0x2504)
+#define EP93XX_SECURITY_SECCHK1			EP93XX_SECURITY_REG(0x2520)
+#define EP93XX_SECURITY_SECCHK2			EP93XX_SECURITY_REG(0x2524)
+#define EP93XX_SECURITY_UNIQID2			EP93XX_SECURITY_REG(0x2700)
+#define EP93XX_SECURITY_UNIQID3			EP93XX_SECURITY_REG(0x2704)
+#define EP93XX_SECURITY_UNIQID4			EP93XX_SECURITY_REG(0x2708)
+#define EP93XX_SECURITY_UNIQID5			EP93XX_SECURITY_REG(0x270c)
+
+static const char *ep93xx_rev[] = {
+	"A", "B", "C", "D0", "D1", "E0", "E1", "E2", "??"
+};
+
+void ep93xx_cpuinfo(struct seq_file *m, void *v)
+{
+	u32 val;
+
+	seq_puts(m, "\n");
+
+	/*
+	 * Fuse0 [63:40]	EP93XX_SECURITY_SECID1  [23: 0]
+	 * Fuse0 [39:32]	EP93XX_SECURITY_UNIQCHK [ 7: 0]
+	 * Fuse0 [31: 0]	EP93XX_SECURITY_UNIQID  [31: 0]
+	 *
+	 * Fuse1 [63:56]	EP93XX_SECURITY_FUSEFLG [ 7: 0]
+	 * Fuse1 [55:48]	EP93XX_SECURITY_SECCHK2 [ 7: 0]
+	 * Fuse1 [47:16]	EP93XX_SECURITY_SECID2  [31: 0]
+	 * Fuse1 [15: 8]	EP93XX_SECURITY_SECCHK1 [ 7: 0]
+	 * Fuse1 [ 7: 0]	EP93XX_SECURITY_SECID1  [31:24]
+	 *
+	 * Fuse2 [63:32]	EP93XX_SECURITY_UNIQID3 [31: 0]
+	 * Fuse2 [31: 0]	EP93XX_SECURITY_UNIQID2 [31: 0]
+	 *
+	 * Fuse3 [63:32]	EP93XX_SECURITY_UNIQID5 [31: 0]
+	 * Fuse3 [31: 0]	EP93XX_SECURITY_UNIQID4 [31: 0]
+	 *
+	 * See http://arm.cirrus.com/forum/viewtopic.php?p=1767
+	 */
+	seq_printf(m, "Unique ID\t: %8.8x\n",
+		__raw_readl(EP93XX_SECURITY_UNIQID));
+	seq_printf(m, "Maverick Key\t: %8.8x%8.8x%8.8x%6.6x %s\n",
+		__raw_readl(EP93XX_SECURITY_UNIQID2),
+		__raw_readl(EP93XX_SECURITY_UNIQID3),
+		__raw_readl(EP93XX_SECURITY_UNIQID4),
+		__raw_readl(EP93XX_SECURITY_UNIQID5) & 0x00ffffff,
+		__raw_readl(EP93XX_SECURITY_UNIQVAL) == 1 ? "OK" : "BAD");
+
+	/* See http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf */
+	val = ep93xx_chip_revision();
+	if (val > ARRAY_SIZE(ep93xx_rev))
+		val = ARRAY_SIZE(ep93xx_rev) - 1;
+	seq_printf(m, "Silicon Rev\t: %s\n", ep93xx_rev[val]);
+
+	val = __raw_readl(EP93XX_SYSCON_SYSCFG);
+	seq_printf(m, "Watchdog\t: %s\n",
+		(val & EP93XX_SYSCON_SYSCFG_LCSN1) ? "disabled" : "active");
+	seq_printf(m, "Reset duration\t: %s\n",
+		(val & EP93XX_SYSCON_SYSCFG_LCSN2) ? "disabled" : "active");
+	seq_printf(m, "Boot mode\t: %s %ssync %sternal %d-bit\n",
+		(val & EP93XX_SYSCON_SYSCFG_SBOOT) ? "serial" : "normal",
+		(val & EP93XX_SYSCON_SYSCFG_LASDO) ? "" : "a",
+		(val & EP93XX_SYSCON_SYSCFG_LEECLK) ? "in" : "ex",
+		ep93xx_boot_width());
+}
+
+
 extern void ep93xx_gpio_init(void);
 
 void __init ep93xx_init_devices(void)
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index c6dc14d..576676f 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -9,6 +9,7 @@ struct i2c_board_info;
 struct platform_device;
 struct ep93xxfb_mach_info;
 struct ep93xx_keypad_platform_data;
+struct seq_file;
 
 struct ep93xx_eth_data
 {
@@ -44,6 +45,9 @@ void ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data);
 int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
 void ep93xx_keypad_release_gpio(struct platform_device *pdev);
 
+/* EP93xx /proc/cpuinfo extension */
+void ep93xx_cpuinfo(struct seq_file *m, void *v);
+
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
 
