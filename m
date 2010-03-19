From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Mar 2010 11:28:44 +0100
Subject: [PATCH 4/5] i.MX51: determine silicon revision dynamically
In-Reply-To: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
References: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1268994525-32495-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale redboot passes the silicon revision via
ATAG_REVISION. Remove this bootloader dependency by
doing the same as redboot does in the Kernel.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/cpu.c               |   53 +++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mx51.h |   13 ++++----
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index 41c769f..2d37785 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -14,9 +14,62 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <mach/hardware.h>
 #include <asm/io.h>
 
+static int cpu_silicon_rev = -1;
+
+#define SI_REV 0x48
+
+static void query_silicon_parameter(void)
+{
+	void __iomem *rom = ioremap(MX51_IROM_BASE_ADDR, MX51_IROM_SIZE);
+	u32 rev;
+
+	if (!rom) {
+		cpu_silicon_rev = -EINVAL;
+		return;
+	}
+
+	rev = readl(rom + SI_REV);
+	switch (rev) {
+	case 0x1:
+		cpu_silicon_rev = MX51_CHIP_REV_1_0;
+		break;
+	case 0x2:
+		cpu_silicon_rev = MX51_CHIP_REV_1_1;
+		break;
+	case 0x10:
+		cpu_silicon_rev = MX51_CHIP_REV_2_0;
+		break;
+	case 0x20:
+		cpu_silicon_rev = MX51_CHIP_REV_3_0;
+		break;
+	default:
+		cpu_silicon_rev = 0;
+	}
+
+	iounmap(rom);
+}
+
+/*
+ * Returns:
+ *	the silicon revision of the cpu
+ *	-EINVAL - not a mx51
+ */
+int mx51_revision(void)
+{
+	if (!cpu_is_mx51())
+		return -EINVAL;
+
+	if (cpu_silicon_rev == -1)
+		query_silicon_parameter();
+
+	return cpu_silicon_rev;
+}
+EXPORT_SYMBOL(mx51_revision);
+
 static int __init post_cpu_init(void)
 {
 	unsigned int reg;
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index f1396bd..fd255a9 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -28,6 +28,12 @@
  */
 
 /*
+ * IROM
+ */
+#define MX51_IROM_BASE_ADDR		0x0
+#define MX51_IROM_SIZE			SZ_64K
+
+/*
  * IRAM
  */
 #define MX51_IRAM_BASE_ADDR		0x1FFE0000	/* internal ram */
@@ -438,12 +444,7 @@
 
 #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
 
-extern unsigned int system_rev;
-
-static inline unsigned int mx51_revision(void)
-{
-	return system_rev;
-}
+extern int mx51_revision(void);
 #endif
 
 #endif	/*  __ASM_ARCH_MXC_MX51_H__ */
-- 
1.7.0
