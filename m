From: triad@df.lth.se (Linus Walleij)
Date: Wed,  7 Jul 2010 14:05:39 +0200
Subject: [PATCH] ARM: expose PB1176 ROM in debugfs
Message-ID: <1278504339-26992-1-git-send-email-triad@df.lth.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This exposes the PB1176 ROM as a simple 16KiB file in debugfs so
that it can be copied out and disassembled with some
objcopy+objdump massage for example. I used this to find out how
the ROM handled the CharLCD.

Signed-off-by: Linus Walleij <triad@df.lth.se>
---
 arch/arm/mach-realview/include/mach/board-pb1176.h |    1 +
 arch/arm/mach-realview/realview_pb1176.c           |   31 ++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-realview/include/mach/board-pb1176.h b/arch/arm/mach-realview/include/mach/board-pb1176.h
index 2f5ccb2..9f627d4 100644
--- a/arch/arm/mach-realview/include/mach/board-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/board-pb1176.h
@@ -69,6 +69,7 @@
 
 #define REALVIEW_DC1176_GIC_CPU_BASE		0x10120000 /* GIC CPU interface, on devchip */
 #define REALVIEW_DC1176_GIC_DIST_BASE		0x10121000 /* GIC distributor, on devchip */
+#define REALVIEW_DC1176_ROM_BASE		0x10200000 /* 16KiB NRAM preudo-ROM, on devchip */
 #define REALVIEW_PB1176_GIC_CPU_BASE		0x10040000 /* GIC CPU interface, on FPGA */
 #define REALVIEW_PB1176_GIC_DIST_BASE		0x10041000 /* GIC distributor, on FPGA */
 #define REALVIEW_PB1176_L220_BASE		0x10110000 /* L220 registers */
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 099a1f1..cfdfd75 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -26,6 +26,7 @@
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
+#include <linux/debugfs.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -323,6 +324,36 @@ static void realview_pb1176_fixup(struct machine_desc *mdesc,
 	meminfo->nr_banks = 1;
 }
 
+#ifdef CONFIG_DEBUG_FS
+/*
+ * This exposes the PB1176 DevChip ROM as a simple file in debugfs
+ * The reference manual states that this is actually a pseudo-ROM
+ * programmed in NVRAM.
+ */
+static struct debugfs_blob_wrapper devchip_rom_blob;
+
+static int __init pb1176_export_rom(void)
+{
+	void __iomem *virtbase;
+	struct dentry *d;
+
+	virtbase = ioremap(REALVIEW_DC1176_ROM_BASE, SZ_16K);
+	if (!virtbase)
+		return -EIO;
+	devchip_rom_blob.data = virtbase;
+	devchip_rom_blob.size = SZ_16K;
+	d = debugfs_create_blob("pb1176-DevChip-ROM",
+				S_IFREG | S_IRUSR,
+				NULL, &devchip_rom_blob);
+	if (!d)
+		return -EIO;
+
+	return 0;
+}
+
+device_initcall(pb1176_export_rom);
+#endif
+
 static void __init realview_pb1176_init(void)
 {
 	int i;
-- 
1.7.1
