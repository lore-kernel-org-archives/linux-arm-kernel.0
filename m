From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 11 Aug 2010 10:23:14 +0200
Subject: [PATCH] ARM: ux500 cpu/SoC version macros
Message-ID: <1281514994-29850-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for checking if the digital baseband (DB)
System-on-Chip (aka "cpu) ASIC hardware version is 1.0, 1.1 or
2.0. We print the result in the bootlog, the functions are then
used for runtime decisions based on hardware version.

Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/cpu-db8500.c               |   83 ++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    2 -
 arch/arm/mach-ux500/include/mach/hardware.h    |   10 +++
 3 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index f21c444..f7056a9 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -16,6 +16,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
@@ -38,10 +39,13 @@ static struct platform_device *platform_devs[] __initdata = {
 /* minimum static i/o mapping required to boot U8500 platforms */
 static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO1_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO2_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO3_BASE, SZ_4K),
+	/* Map the ROM as a device, we only use it to read values */
+	__IO_DEV_DESC(U8500_BOOT_ROM_BASE, SZ_128K),
 };
 
 static struct map_desc u8500ed_io_desc[] __initdata = {
@@ -53,6 +57,68 @@ static struct map_desc u8500v1_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
 };
 
+/*
+ * Functions to differentiate between later ASICs
+ * We look into the end of the ROM to locate the hardcoded ASIC ID.
+ * This is only needed to differentiate between minor revisions and
+ * process variants of an ASIC, the major revisions are encoded in
+ * the cpuid.
+ */
+#define U8500_ASIC_ID_LOC_ED_V1	(U8500_BOOT_ROM_BASE + 0x1FFF4)
+#define U8500_ASIC_ID_LOC_V2	(U8500_BOOT_ROM_BASE + 0x1DBF4)
+#define U8500_ASIC_REV_ED	0x01
+#define U8500_ASIC_REV_V10	0xA0
+#define U8500_ASIC_REV_V11	0xA1
+#define U8500_ASIC_REV_V20	0xB0
+
+/**
+ * struct db8500_asic_id - fields of the ASIC ID
+ * @process: the manufacturing process, 0x40 is 40 nm
+ *  0x00 is "standard"
+ * @partnumber: hithereto 0x8500 for DB8500
+ * @revision: version code in the series
+ * This field definion is not formally defined but makes
+ * sense.
+ */
+struct db8500_asic_id {
+	u8 process;
+	u16 partnumber;
+	u8 revision;
+};
+
+/* This isn't going to change at runtime */
+static struct db8500_asic_id db8500_id;
+
+static void __init get_db8500_asic_id(void)
+{
+	u32 asicid;
+
+	if (cpu_is_u8500v1() || cpu_is_u8500ed())
+		asicid = readl(__io_address(U8500_ASIC_ID_LOC_ED_V1));
+	else
+		/* Else assume we're dealing with V2 for the time being */
+		asicid = readl(__io_address(U8500_ASIC_ID_LOC_V2));
+
+	db8500_id.process = (asicid >> 24);
+	db8500_id.partnumber = (asicid >> 16) & 0xFFFFU;
+	db8500_id.revision = asicid & 0xFFU;
+}
+
+bool cpu_is_u8500v10(void)
+{
+	return (db8500_id.revision == U8500_ASIC_REV_V10);
+}
+
+bool cpu_is_u8500v11(void)
+{
+	return (db8500_id.revision == U8500_ASIC_REV_V11);
+}
+
+bool cpu_is_u8500v20(void)
+{
+	return (db8500_id.revision == U8500_ASIC_REV_V20);
+}
+
 void __init u8500_map_io(void)
 {
 	ux500_map_io();
@@ -63,6 +129,9 @@ void __init u8500_map_io(void)
 		iotable_init(u8500ed_io_desc, ARRAY_SIZE(u8500ed_io_desc));
 	else
 		iotable_init(u8500v1_io_desc, ARRAY_SIZE(u8500v1_io_desc));
+
+	/* Read out the ASIC ID as early as we can */
+	get_db8500_asic_id();
 }
 
 /*
@@ -70,6 +139,20 @@ void __init u8500_map_io(void)
  */
 void __init u8500_init_devices(void)
 {
+	/* Display some ASIC boilerplate */
+	pr_info("DB8500: process: %02x, revision ID: 0x%02x\n",
+		db8500_id.process, db8500_id.revision);
+	if (cpu_is_u8500ed())
+		pr_info("DB8500: Early Drop (ED)\n");
+	else if (cpu_is_u8500v10())
+		pr_info("DB8500: version 1.0\n");
+	else if (cpu_is_u8500v11())
+		pr_info("DB8500: version 1.1\n");
+	else if (cpu_is_u8500v20())
+		pr_info("DB8500: version 2.0\n");
+	else
+		pr_warning("ASIC: UNKNOWN SILICON VERSION!\n");
+
 	ux500_init_devices();
 
 	if (cpu_is_u8500ed())
diff --git a/arch/arm/mach-ux500/include/mach/db8500-regs.h b/arch/arm/mach-ux500/include/mach/db8500-regs.h
index f000218..f07d098 100644
--- a/arch/arm/mach-ux500/include/mach/db8500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db8500-regs.h
@@ -30,8 +30,6 @@
 #define U8500_ICN_BASE		0x81000000
 
 #define U8500_BOOT_ROM_BASE	0x90000000
-/* ASIC ID is at 0xff4 offset within this region */
-#define U8500_ASIC_ID_BASE	0x9001F000
 
 #define U8500_PER6_BASE		0xa03c0000
 #define U8500_PER5_BASE		0xa03e0000
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 8656379..de42f65 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -114,6 +114,16 @@ static inline bool cpu_is_u8500v1(void)
 	return cpu_is_u8500() && (read_cpuid_id() & 15) == 1;
 }
 
+#ifdef CONFIG_UX500_SOC_DB8500
+bool cpu_is_u8500v10(void);
+bool cpu_is_u8500v11(void);
+bool cpu_is_u8500v20(void);
+#else
+static inline bool cpu_is_u8500v10(void) { return false; }
+static inline bool cpu_is_u8500v11(void) { return false; }
+static inline bool cpu_is_u8500v20(void) { return false; }
+#endif
+
 static inline bool cpu_is_u5500(void)
 {
 #ifdef CONFIG_UX500_SOC_DB5500
-- 
1.6.3.3
