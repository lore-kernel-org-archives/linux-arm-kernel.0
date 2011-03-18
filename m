From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Mar 2011 23:32:11 -0300
Subject: [PATCH v4] ARM: mx51: Print silicon revision on boot
Message-ID: <1300415531-25358-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having the silicon revision to appear on the boot log is a useful information.

MX31 and MX35 already show the silicon revision on boot. 

Add support for displaying such information for MX51 as well.

Tested on a MX51EVK, where it shows:

CPU identified as i.MX51, silicon rev 3.0

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v3:
- Change the location of mx51_display_revision
- Use defines to represent the chip revision strings
Changes since v2:
- Remove unneeded return inside mx51_display_revision 
Changes since v1:
- Added patch description
 arch/arm/mach-mx5/clock-mx51-mx53.c   |    1 +
 arch/arm/mach-mx5/cpu.c               |   20 ++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mx51.h |    1 +
 arch/arm/plat-mxc/include/mach/mxc.h  |   14 ++++++++++++++
 4 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 652ace4..cc6ad1c 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1511,6 +1511,7 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 	clk_enable(&iim_clk);
 	mx51_revision();
 	clk_disable(&iim_clk);
+	mx51_display_revision();
 
 	/* move usb_phy_clk to 24MHz */
 	clk_set_parent(&usb_phy1_clk, &osc_clk);
diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index df46b5e..3b4c307 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -51,6 +51,26 @@ int mx51_revision(void)
 }
 EXPORT_SYMBOL(mx51_revision);
 
+void mx51_display_revision(void)
+{
+	int rev;
+	char *srev;
+	rev = mx51_revision();
+
+	switch (rev) {
+	case IMX_CHIP_REVISION_2_0:
+		srev = IMX_CHIP_REVISION_2_0_STRING;
+		break;
+	case IMX_CHIP_REVISION_3_0:
+		srev = IMX_CHIP_REVISION_3_0_STRING;
+		break;
+	default:
+		srev = IMX_CHIP_REVISION_UNKNOWN_STRING;
+	}
+	printk(KERN_INFO "CPU identified as i.MX51, silicon rev %s\n", srev);
+}
+EXPORT_SYMBOL(mx51_display_revision);
+
 #ifdef CONFIG_NEON
 
 /*
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 1eb339e..dede19a 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -347,6 +347,7 @@
 
 #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
 extern int mx51_revision(void);
+extern void mx51_display_revision(void);
 #endif
 
 /* tape-out 1 defines */
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 7e07263..3322c7a 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -51,6 +51,20 @@
 #define IMX_CHIP_REVISION_3_3		0x33
 #define IMX_CHIP_REVISION_UNKNOWN	0xff
 
+#define IMX_CHIP_REVISION_1_0_STRING		"1.0"
+#define IMX_CHIP_REVISION_1_1_STRING		"1.1"
+#define IMX_CHIP_REVISION_1_2_STRING		"1.2"
+#define IMX_CHIP_REVISION_1_3_STRING		"1.3"
+#define IMX_CHIP_REVISION_2_0_STRING		"2.0"
+#define IMX_CHIP_REVISION_2_1_STRING		"2.1"
+#define IMX_CHIP_REVISION_2_2_STRING		"2.2"
+#define IMX_CHIP_REVISION_2_3_STRING		"2.3"
+#define IMX_CHIP_REVISION_3_0_STRING		"3.0"
+#define IMX_CHIP_REVISION_3_1_STRING		"3.1"
+#define IMX_CHIP_REVISION_3_2_STRING		"3.2"
+#define IMX_CHIP_REVISION_3_3_STRING		"3.3"
+#define IMX_CHIP_REVISION_UNKNOWN_STRING	"unknown"
+
 #ifndef __ASSEMBLY__
 extern unsigned int __mxc_cpu_type;
 #endif
-- 
1.6.0.4
