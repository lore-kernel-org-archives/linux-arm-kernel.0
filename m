From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 8 Dec 2010 11:07:59 +0530
Subject: [PATCH 7/9] ux500: dynamic SOC detection
In-Reply-To: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
References: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1291786681-8664-7-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dynamically detect the DBx500 SOC an revision based on the ASIC ID.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Makefile                |    3 +-
 arch/arm/mach-ux500/cpu-db5500.c            |   12 +++-
 arch/arm/mach-ux500/cpu-db8500.c            |   91 +++--------------------
 arch/arm/mach-ux500/cpu.c                   |    4 -
 arch/arm/mach-ux500/id.c                    |  107 +++++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/hardware.h |   50 +------------
 arch/arm/mach-ux500/include/mach/id.h       |   80 ++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/setup.h    |    1 +
 8 files changed, 212 insertions(+), 136 deletions(-)
 create mode 100644 arch/arm/mach-ux500/id.c
 create mode 100644 arch/arm/mach-ux500/include/mach/id.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 9d7f8d3..f577ecf 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -2,7 +2,8 @@
 # Makefile for the linux kernel, U8500 machine.
 #
 
-obj-y				:= clock.o cpu.o devices.o devices-common.o
+obj-y				:= clock.o cpu.o devices.o devices-common.o \
+				   id.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o
 obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index 7b0ab833..af04e08 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -21,9 +21,12 @@
 
 #include "devices-db5500.h"
 
-static struct map_desc u5500_io_desc[] __initdata = {
+static struct map_desc u5500_uart_io_desc[] __initdata = {
 	__IO_DEV_DESC(U5500_UART0_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_UART2_BASE, SZ_4K),
+};
+
+static struct map_desc u5500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U5500_GIC_CPU_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_GIC_DIST_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_L2CC_BASE, SZ_4K),
@@ -153,6 +156,13 @@ static void __init db5500_add_gpios(void)
 
 void __init u5500_map_io(void)
 {
+	/*
+	 * Map the UARTs early so that the DEBUG_LL stuff continues to work.
+	 */
+	iotable_init(u5500_uart_io_desc, ARRAY_SIZE(u5500_uart_io_desc));
+
+	ux500_map_io();
+
 	iotable_init(u5500_io_desc, ARRAY_SIZE(u5500_io_desc));
 }
 
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 304b20a..44a322c 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -29,9 +29,12 @@ static struct platform_device *platform_devs[] __initdata = {
 };
 
 /* minimum static i/o mapping required to boot U8500 platforms */
-static struct map_desc u8500_io_desc[] __initdata = {
+static struct map_desc u8500_uart_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_UART0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_UART2_BASE, SZ_4K),
+};
+
+static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_GIC_CPU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
@@ -51,7 +54,6 @@ static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_GPIO1_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO2_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO3_BASE, SZ_4K),
-	__MEM_DEV_DESC(U8500_BOOT_ROM_BASE, SZ_1M),
 };
 
 static struct map_desc u8500_ed_io_desc[] __initdata = {
@@ -68,71 +70,15 @@ static struct map_desc u8500_v2_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K),
 };
 
-/*
- * Functions to differentiate between later ASICs
- * We look into the end of the ROM to locate the hardcoded ASIC ID.
- * This is only needed to differentiate between minor revisions and
- * process variants of an ASIC, the major revisions are encoded in
- * the cpuid.
- */
-#define U8500_ASIC_ID_LOC_ED_V1	(U8500_BOOT_ROM_BASE + 0x1FFF4)
-#define U8500_ASIC_ID_LOC_V2	(U8500_BOOT_ROM_BASE + 0x1DBF4)
-#define U8500_ASIC_REV_ED	0x01
-#define U8500_ASIC_REV_V10	0xA0
-#define U8500_ASIC_REV_V11	0xA1
-#define U8500_ASIC_REV_V20	0xB0
-
-/**
- * struct db8500_asic_id - fields of the ASIC ID
- * @process: the manufacturing process, 0x40 is 40 nm
- *  0x00 is "standard"
- * @partnumber: hithereto 0x8500 for DB8500
- * @revision: version code in the series
- * This field definion is not formally defined but makes
- * sense.
- */
-struct db8500_asic_id {
-	u8 process;
-	u16 partnumber;
-	u8 revision;
-};
-
-/* This isn't going to change at runtime */
-static struct db8500_asic_id db8500_id;
-
-static void __init get_db8500_asic_id(void)
-{
-	u32 asicid;
-
-	if (cpu_is_u8500v1() || cpu_is_u8500ed())
-		asicid = readl(__io_address(U8500_ASIC_ID_LOC_ED_V1));
-	else if (cpu_is_u8500v2())
-		asicid = readl(__io_address(U8500_ASIC_ID_LOC_V2));
-	else
-		BUG();
-
-	db8500_id.process = (asicid >> 24);
-	db8500_id.partnumber = (asicid >> 16) & 0xFFFFU;
-	db8500_id.revision = asicid & 0xFFU;
-}
-
-bool cpu_is_u8500v10(void)
-{
-	return (db8500_id.revision == U8500_ASIC_REV_V10);
-}
-
-bool cpu_is_u8500v11(void)
+void __init u8500_map_io(void)
 {
-	return (db8500_id.revision == U8500_ASIC_REV_V11);
-}
+	/*
+	 * Map the UARTs early so that the DEBUG_LL stuff continues to work.
+	 */
+	iotable_init(u8500_uart_io_desc, ARRAY_SIZE(u8500_uart_io_desc));
 
-bool cpu_is_u8500v20(void)
-{
-	return (db8500_id.revision == U8500_ASIC_REV_V20);
-}
+	ux500_map_io();
 
-void __init u8500_map_io(void)
-{
 	iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
 
 	if (cpu_is_u8500ed())
@@ -141,9 +87,6 @@ void __init u8500_map_io(void)
 		iotable_init(u8500_v1_io_desc, ARRAY_SIZE(u8500_v1_io_desc));
 	else if (cpu_is_u8500v2())
 		iotable_init(u8500_v2_io_desc, ARRAY_SIZE(u8500_v2_io_desc));
-
-	/* Read out the ASIC ID as early as we can */
-	get_db8500_asic_id();
 }
 
 static resource_size_t __initdata db8500_gpio_base[] = {
@@ -173,20 +116,6 @@ static void __init db8500_add_gpios(void)
  */
 void __init u8500_init_devices(void)
 {
-	/* Display some ASIC boilerplate */
-	pr_info("DB8500: process: %02x, revision ID: 0x%02x\n",
-		db8500_id.process, db8500_id.revision);
-	if (cpu_is_u8500ed())
-		pr_info("DB8500: Early Drop (ED)\n");
-	else if (cpu_is_u8500v10())
-		pr_info("DB8500: version 1.0\n");
-	else if (cpu_is_u8500v11())
-		pr_info("DB8500: version 1.1\n");
-	else if (cpu_is_u8500v20())
-		pr_info("DB8500: version 2.0\n");
-	else
-		pr_warning("ASIC: UNKNOWN SILICON VERSION!\n");
-
 	if (cpu_is_u8500ed())
 		dma40_u8500ed_fixup();
 
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 35a3af1..5a43107 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -27,10 +27,6 @@
 static void __iomem *l2x0_base;
 #endif
 
-void __init ux500_map_io(void)
-{
-}
-
 void __init ux500_init_irq(void)
 {
 	void __iomem *dist_base;
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
new file mode 100644
index 0000000..d35122e
--- /dev/null
+++ b/arch/arm/mach-ux500/id.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/cputype.h>
+#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/setup.h>
+
+struct dbx500_asic_id dbx500_id;
+
+static unsigned int ux500_read_asicid(phys_addr_t addr)
+{
+	phys_addr_t base = addr & ~0xfff;
+	struct map_desc desc = {
+		.virtual	= IO_ADDRESS(base),
+		.pfn		= __phys_to_pfn(base),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	};
+
+	iotable_init(&desc, 1);
+
+	/* As in devicemaps_init() */
+	local_flush_tlb_all();
+	flush_cache_all();
+
+	return readl(__io_address(addr));
+}
+
+static void ux500_print_soc_info(unsigned int asicid)
+{
+	unsigned int rev = dbx500_revision();
+
+	pr_info("DB%4x ", dbx500_partnumber());
+
+	if (rev == 0x01)
+		pr_cont("Early Drop");
+	else if (rev >= 0xA0)
+		pr_cont("v%d.%d" , (rev >> 4) - 0xA + 1, rev & 0xf);
+	else
+		pr_cont("Unknown");
+
+	pr_cont(" [%#010x]\n", asicid);
+}
+
+static unsigned int partnumber(unsigned int asicid)
+{
+	return (asicid >> 8) & 0xffff;
+}
+
+/*
+ * SOC		MIDR		ASICID ADDRESS		ASICID VALUE
+ * DB8500ed	0x410fc090	0x9001FFF4		0x00850001
+ * DB8500v1	0x411fc091	0x9001FFF4		0x008500A0
+ * DB8500v1.1	0x411fc091	0x9001FFF4		0x008500A1
+ * DB8500v2	0x412fc091	0x9001DBF4		0x008500B0
+ * DB5500v1	0x412fc091	0x9001FFF4		0x005500A0
+ */
+
+void __init ux500_map_io(void)
+{
+	unsigned int cpuid = read_cpuid_id();
+	unsigned int asicid = 0;
+	phys_addr_t addr = 0;
+
+	switch (cpuid) {
+	case 0x410fc090: /* DB8500ed */
+	case 0x411fc091: /* DB8500v1 */
+		addr = 0x9001FFF4;
+		break;
+
+	case 0x412fc091: /* DB8500v2 / DB5500v1 */
+		asicid = ux500_read_asicid(0x9001DBF4);
+		if (partnumber(asicid) == 0x8500)
+			/* DB8500v2 */
+			break;
+
+		/* DB5500v1 */
+		addr = 0x9001FFF4;
+		break;
+	}
+
+	if (addr)
+		asicid = ux500_read_asicid(addr);
+
+	if (!asicid) {
+		pr_err("Unable to identify SoC\n");
+		ux500_unknown_soc();
+	}
+
+	dbx500_id.process = asicid >> 24;
+	dbx500_id.partnumber = partnumber(asicid);
+	dbx500_id.revision = asicid & 0xff;
+
+	ux500_print_soc_info(asicid);
+}
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index bced4a8..bf63f26 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -34,57 +34,9 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/cputype.h>
-
-static inline bool cpu_is_u8500(void)
-{
-#ifdef CONFIG_UX500_SOC_DB8500
-	return 1;
-#else
-	return 0;
-#endif
-}
-
-#define CPUID_DB8500ED	0x410fc090
-#define CPUID_DB8500V1	0x411fc091
-#define CPUID_DB8500V2	0x412fc091
-
-static inline bool cpu_is_u8500ed(void)
-{
-	return cpu_is_u8500() && (read_cpuid_id() == CPUID_DB8500ED);
-}
-
-static inline bool cpu_is_u8500v1(void)
-{
-	return cpu_is_u8500() && (read_cpuid_id() == CPUID_DB8500V1);
-}
-
-static inline bool cpu_is_u8500v2(void)
-{
-	return cpu_is_u8500() && (read_cpuid_id() == CPUID_DB8500V2);
-}
-
-#ifdef CONFIG_UX500_SOC_DB8500
-bool cpu_is_u8500v10(void);
-bool cpu_is_u8500v11(void);
-bool cpu_is_u8500v20(void);
-#else
-static inline bool cpu_is_u8500v10(void) { return false; }
-static inline bool cpu_is_u8500v11(void) { return false; }
-static inline bool cpu_is_u8500v20(void) { return false; }
-#endif
-
-static inline bool cpu_is_u5500(void)
-{
-#ifdef CONFIG_UX500_SOC_DB5500
-	return 1;
-#else
-	return 0;
-#endif
-}
+#include <mach/id.h>
 
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
-#define ux500_unknown_soc()	BUG()
 
 #endif
 
diff --git a/arch/arm/mach-ux500/include/mach/id.h b/arch/arm/mach-ux500/include/mach/id.h
new file mode 100644
index 0000000..f1288d1
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/id.h
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __MACH_UX500_ID
+#define __MACH_UX500_ID
+
+/**
+ * struct dbx500_asic_id - fields of the ASIC ID
+ * @process: the manufacturing process, 0x40 is 40 nm 0x00 is "standard"
+ * @partnumber: hithereto 0x8500 for DB8500
+ * @revision: version code in the series
+ */
+struct dbx500_asic_id {
+	u16	partnumber;
+	u8	revision;
+	u8	process;
+};
+
+extern struct dbx500_asic_id dbx500_id;
+
+static inline unsigned int __attribute_const__ dbx500_partnumber(void)
+{
+	return dbx500_id.partnumber;
+}
+
+static inline unsigned int __attribute_const__ dbx500_revision(void)
+{
+	return dbx500_id.revision;
+}
+
+/*
+ * SOCs
+ */
+
+static inline bool __attribute_const__ cpu_is_u8500(void)
+{
+	return dbx500_partnumber() == 0x8500;
+}
+
+static inline bool __attribute_const__ cpu_is_u5500(void)
+{
+	return dbx500_partnumber() == 0x5500;
+}
+
+/*
+ * 8500 revisions
+ */
+
+static inline bool __attribute_const__ cpu_is_u8500ed(void)
+{
+	return cpu_is_u8500() && dbx500_revision() == 0x00;
+}
+
+static inline bool __attribute_const__ cpu_is_u8500v1(void)
+{
+	return cpu_is_u8500() && (dbx500_revision() & 0xf0) == 0xA0;
+}
+
+static inline bool __attribute_const__ cpu_is_u8500v10(void)
+{
+	return cpu_is_u8500() && dbx500_revision() == 0xA0;
+}
+
+static inline bool __attribute_const__ cpu_is_u8500v11(void)
+{
+	return cpu_is_u8500() && dbx500_revision() == 0xA1;
+}
+
+static inline bool __attribute_const__ cpu_is_u8500v2(void)
+{
+	return cpu_is_u8500() && ((dbx500_revision() & 0xf0) == 0xB0);
+}
+
+#define ux500_unknown_soc()	BUG()
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 5d84232..a7d363f 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -14,6 +14,7 @@
 #include <asm/mach/time.h>
 #include <linux/init.h>
 
+void __init ux500_map_io(void);
 extern void __init u5500_map_io(void);
 extern void __init u8500_map_io(void);
 
-- 
1.7.2.dirty
