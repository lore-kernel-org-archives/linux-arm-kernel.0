From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri,  8 Oct 2010 10:02:37 +0200
Subject: [PATCH] i.MX35: use the correct IIM register to get CPU revision
In-Reply-To: <1286523290-25321-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1286523290-25321-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1286524957-30218-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

instead of using ROM_SI_REV use IIM's Silicon Revision register
as described in :
- Reference Manual 29.3.3.10
- RM Errata 29.3.3.9.13

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx3/clock-imx35.c       |    1 +
 arch/arm/mach-mx3/cpu.c               |   23 +++++++++--------------
 arch/arm/plat-mxc/include/mach/mx35.h |    8 +++-----
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 85884c7..f7cec59 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -535,6 +535,7 @@ int __init mx35_clocks_init()
 	__raw_writel(cgr2, CCM_BASE + CCM_CGR2);
 	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);
 
+	clk_enable(&iim_clk);
 	mx35_read_cpu_rev();
 
 	mxc_timer_init(&gpt_clk,
diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-mx3/cpu.c
index db7af50..d00a754 100644
--- a/arch/arm/mach-mx3/cpu.c
+++ b/arch/arm/mach-mx3/cpu.c
@@ -59,31 +59,26 @@ void __init mx31_read_cpu_rev(void)
 unsigned int mx35_cpu_rev;
 EXPORT_SYMBOL(mx35_cpu_rev);
 
-#define MX35_ROM_SI_REV		0x40
-
 void __init mx35_read_cpu_rev(void)
 {
-	void __iomem *rom = ioremap(MX35_IROM_BASE_ADDR, MX35_IROM_SIZE);
 	u32 rev;
 	char *srev = "unknown";
 
-	if (!rom)
-		return;
-
-	rev = readl(rom + MX35_ROM_SI_REV);
+	rev = __raw_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));
 	switch (rev) {
-	case 0x1:
-		mx35_cpu_rev = MX35_CHIP_REV_1_0;
+	case 0x00:
+		mx35_cpu_rev = MX3x_CHIP_REV_1_0;
 		srev = "1.0";
 		break;
-	case 0x2:
-		mx35_cpu_rev = MX35_CHIP_REV_2_0;
+	case 0x10:
+		mx35_cpu_rev = MX3x_CHIP_REV_2_0;
 		srev = "2.0";
 		break;
+	case 0x11:
+		mx35_cpu_rev = MX3x_CHIP_REV_2_1;
+		srev = "2.1";
+		break;
 	}
 
 	printk(KERN_INFO "CPU identified as i.MX35, silicon rev %s\n", srev);
-
-	iounmap(rom);
 }
-
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index d1675ae..92794be 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -70,6 +70,8 @@
 #define MX35_CAN1_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xe4000)
 #define MX35_CAN2_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xe8000)
 #define MX35_RTIC_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xec000)
+#define MX35_IIM_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xf0000)
+
 #define MX35_OTG_BASE_ADDR		0x53ff4000
 
 #define MX35_ROMP_BASE_ADDR		0x60000000
@@ -182,11 +184,7 @@
 
 #define MX35_PROD_SIGNATURE		0x1	/* For MX31 */
 
-/* silicon revisions specific to i.MX35 */
-#define MX35_CHIP_REV_1_0		0x1
-#define MX35_CHIP_REV_2_0		0x2
-
-#define MX35_SYSTEM_REV_MIN		MX35_CHIP_REV_1_0
+#define MX35_SYSTEM_REV_MIN		MX3x_CHIP_REV_1_0
 #define MX35_SYSTEM_REV_NUM		3
 
 #ifdef IMX_NEEDS_DEPRECATED_SYMBOLS
-- 
1.7.0.4
