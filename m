From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 5 Oct 2009 13:50:50 -0400
Subject: [PATCH 2/2] arm: add /proc/cpuinfo extension for ep93xx
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901BE991A@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901BE991A@mi8nycmail19.Mi8.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB76AF@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a callback to mach-ep93xx for /proc/cpuinfo extension and
hook up all the edb93xx platforms.

This cpuinfo extension dumps the processor unique Maverick Key
and the processor silicon revision.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

V2 - Rebased to 2.6.32-rc3


diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index f7ebed9..35121e4 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -714,6 +714,56 @@ void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
 	platform_device_register(&ep93xx_fb_device);
 }
 
+
+/*************************************************************************
+ * EP93xx proc/cpuinfo extension
+ *************************************************************************/
+static const char *ep93xx_rev[] = {
+	"A", "B", "C", "D0", "D1", "E0", "E1", "E2", "??"
+};
+
+void ep93xx_cpuinfo(struct seq_file *m, void *v)
+{
+	u32 val;
+
+	/*
+	 * EP93xx Security Fuses
+	 * See http://arm.cirrus.com/forum/viewtopic.php?p=1767
+	 *
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
+	val = __raw_readl(EP93XX_SYSCON_CHIP_ID);
+	val = (val >> 28) & 0xf;
+	if (val >= ARRAY_SIZE(ep93xx_rev))
+		val = ARRAY_SIZE(ep93xx_rev) - 1;
+	seq_printf(m, "Silicon Rev\t: %s\n", ep93xx_rev[val]);
+}
+
+
 extern void ep93xx_gpio_init(void);
 
 void __init ep93xx_init_devices(void)
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 73145ae..117768b 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -120,6 +120,7 @@ MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -133,6 +134,7 @@ MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -146,6 +148,7 @@ MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -159,6 +162,7 @@ MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -172,6 +176,7 @@ MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -185,6 +190,7 @@ MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -198,6 +204,7 @@ MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -211,5 +218,6 @@ MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 0fbf87b..d22360e 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -109,6 +109,20 @@
 #define EP93XX_I2S_BASE			EP93XX_APB_IOMEM(0x00020000)
 
 #define EP93XX_SECURITY_BASE		EP93XX_APB_IOMEM(0x00030000)
+#define EP93XX_SECURITY_REG(x)		(EP93XX_SECURITY_BASE + (x))
+#define EP93XX_SECURITY_SECFLG		EP93XX_SECURITY_REG(0x2400)
+#define EP93XX_SECURITY_FUSEFLG		EP93XX_SECURITY_REG(0x2410)
+#define EP93XX_SECURITY_UNIQID		EP93XX_SECURITY_REG(0x2440)
+#define EP93XX_SECURITY_UNIQCHK		EP93XX_SECURITY_REG(0x2450)
+#define EP93XX_SECURITY_UNIQVAL		EP93XX_SECURITY_REG(0x2460)
+#define EP93XX_SECURITY_SECID1		EP93XX_SECURITY_REG(0x2500)
+#define EP93XX_SECURITY_SECID2		EP93XX_SECURITY_REG(0x2504)
+#define EP93XX_SECURITY_SECCHK1		EP93XX_SECURITY_REG(0x2520)
+#define EP93XX_SECURITY_SECCHK2		EP93XX_SECURITY_REG(0x2524)
+#define EP93XX_SECURITY_UNIQID2		EP93XX_SECURITY_REG(0x2700)
+#define EP93XX_SECURITY_UNIQID3		EP93XX_SECURITY_REG(0x2704)
+#define EP93XX_SECURITY_UNIQID4		EP93XX_SECURITY_REG(0x2708)
+#define EP93XX_SECURITY_UNIQID5		EP93XX_SECURITY_REG(0x270c)
 
 #define EP93XX_GPIO_BASE		EP93XX_APB_IOMEM(0x00040000)
 #define EP93XX_GPIO_REG(x)		(EP93XX_GPIO_BASE + (x))
@@ -218,6 +232,7 @@
 #define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1<<16)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	(1<<15)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	(1<<0)
+#define EP93XX_SYSCON_CHIP_ID		EP93XX_SYSCON_REG(0x94)
 #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
 
 #define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 01a0f08..2f8acc2 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -7,6 +7,7 @@
 struct i2c_board_info;
 struct platform_device;
 struct ep93xxfb_mach_info;
+struct seq_file;
 
 struct ep93xx_eth_data
 {
@@ -39,6 +40,9 @@ void ep93xx_register_pwm(int pwm0, int pwm1);
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev);
 
+/* EP93xx /proc/cpuinfo extension */
+void ep93xx_cpuinfo(struct seq_file *m, void *v);
+
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
