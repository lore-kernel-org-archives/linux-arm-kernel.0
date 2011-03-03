From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Mar 2011 22:12:27 -0300
Subject: [PATCH] ARM: mx51: Print silicon revision on boot
Message-ID: <1299114747-14091-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c   |    1 +
 arch/arm/mach-mx5/cpu.c               |   21 +++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mx51.h |    1 +
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 652ace4..1282a60 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1510,6 +1510,7 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 
 	clk_enable(&iim_clk);
 	mx51_revision();
+	mx51_display_revision();
 	clk_disable(&iim_clk);
 
 	/* move usb_phy_clk to 24MHz */
diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index df46b5e..565ed4d 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -51,6 +51,27 @@ int mx51_revision(void)
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
+		srev = "2.0";
+		break;
+	case IMX_CHIP_REVISION_3_0:
+		srev = "3.0";
+		break;
+	default:
+		return IMX_CHIP_REVISION_UNKNOWN;
+		srev = "unknown";
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
-- 
1.6.0.4
