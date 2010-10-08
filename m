From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Oct 2010 16:00:10 +0200
Subject: [PATCH v2 2/3] ARM: mx35: Add mx35_revision function to query the
	silicon revision
In-Reply-To: <20101008135733.GK29673@pengutronix.de>
References: <20101008135733.GK29673@pengutronix.de>
Message-ID: <1286546411-6578-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric B?nard <eric@eukrea.com>

Based on work done earlier by Sascha Hauer

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Eric B?nard <eric@eukrea.com>
[ukl: actually squash the two approaches together]
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c       |    3 +++
 arch/arm/mach-mx3/cpu.c               |   27 +++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mx35.h |   18 ++++--------------
 arch/arm/plat-mxc/include/mach/mx3x.h |   10 +++++++++-
 4 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 708c2b3..0911d7c 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -535,6 +535,9 @@ int __init mx35_clocks_init()
 	__raw_writel(cgr2, CCM_BASE + CCM_CGR2);
 	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);
 
+	clk_enable(&iim_clk);
+	mx35_read_cpu_rev();
+
 #ifdef CONFIG_MXC_USE_EPIT
 	epit_timer_init(&epit1_clk,
 			MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR), MX35_INT_EPIT1);
diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-mx3/cpu.c
index 47b0573..d00a754 100644
--- a/arch/arm/mach-mx3/cpu.c
+++ b/arch/arm/mach-mx3/cpu.c
@@ -55,3 +55,30 @@ void __init mx31_read_cpu_rev(void)
 
 	printk(KERN_WARNING "Unknown CPU identifier. srev = %02x\n", srev);
 }
+
+unsigned int mx35_cpu_rev;
+EXPORT_SYMBOL(mx35_cpu_rev);
+
+void __init mx35_read_cpu_rev(void)
+{
+	u32 rev;
+	char *srev = "unknown";
+
+	rev = __raw_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));
+	switch (rev) {
+	case 0x00:
+		mx35_cpu_rev = MX3x_CHIP_REV_1_0;
+		srev = "1.0";
+		break;
+	case 0x10:
+		mx35_cpu_rev = MX3x_CHIP_REV_2_0;
+		srev = "2.0";
+		break;
+	case 0x11:
+		mx35_cpu_rev = MX3x_CHIP_REV_2_1;
+		srev = "2.1";
+		break;
+	}
+
+	printk(KERN_INFO "CPU identified as i.MX35, silicon rev %s\n", srev);
+}
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index 9f0a1ee..220a656 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -1,5 +1,6 @@
 #ifndef __MACH_MX35_H__
 #define __MACH_MX35_H__
+
 /*
  * IRAM
  */
@@ -63,6 +64,8 @@
 #define MX35_CAN1_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xe4000)
 #define MX35_CAN2_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xe8000)
 #define MX35_RTIC_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xec000)
+#define MX35_IIM_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xf0000)
+
 #define MX35_OTG_BASE_ADDR		0x53ff4000
 
 #define MX35_ROMP_BASE_ADDR		0x60000000
@@ -184,20 +187,7 @@
 
 #define MX35_PROD_SIGNATURE		0x1	/* For MX31 */
 
-/* silicon revisions specific to i.MX31 */
-#define MX35_CHIP_REV_1_0		0x10
-#define MX35_CHIP_REV_1_1		0x11
-#define MX35_CHIP_REV_1_2		0x12
-#define MX35_CHIP_REV_1_3		0x13
-#define MX35_CHIP_REV_2_0		0x20
-#define MX35_CHIP_REV_2_1		0x21
-#define MX35_CHIP_REV_2_2		0x22
-#define MX35_CHIP_REV_2_3		0x23
-#define MX35_CHIP_REV_3_0		0x30
-#define MX35_CHIP_REV_3_1		0x31
-#define MX35_CHIP_REV_3_2		0x32
-
-#define MX35_SYSTEM_REV_MIN		MX35_CHIP_REV_1_0
+#define MX35_SYSTEM_REV_MIN		MX3x_CHIP_REV_1_0
 #define MX35_SYSTEM_REV_NUM		3
 
 #ifdef IMX_NEEDS_DEPRECATED_SYMBOLS
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index d41ad68..d1bd26d 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -240,7 +240,7 @@
 
 #define MX3x_PROD_SIGNATURE		0x1	/* For MX31 */
 
-/* silicon revisions specific to i.MX31 */
+/* silicon revisions specific to i.MX31 and i.MX35 */
 #define MX3x_CHIP_REV_1_0		0x10
 #define MX3x_CHIP_REV_1_1		0x11
 #define MX3x_CHIP_REV_1_2		0x12
@@ -267,6 +267,14 @@ static inline int mx31_revision(void)
 {
 	return mx31_cpu_rev;
 }
+
+extern unsigned int mx35_cpu_rev;
+extern void mx35_read_cpu_rev(void);
+
+static inline int mx35_revision(void)
+{
+	return mx35_cpu_rev;
+}
 #endif
 
 #ifdef IMX_NEEDS_DEPRECATED_SYMBOLS
-- 
1.7.2.3
