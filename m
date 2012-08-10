From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 10 Aug 2012 10:44:08 +0200
Subject: [PATCH 3/4] ARM: ux500: reform Ux500 family names
Message-ID: <1344588248-8670-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Counting the U9540 and the new U8540 as a U8500 family member
does not work. Instead, split the function in two:

cpu_is_u8500_family() covering U8500 and U8520
cpu_is_ux540_family() covering U9540 and U8540

This works much better in practice. Update users to keep the
same behaviour.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cache-l2x0.c      |  2 +-
 arch/arm/mach-ux500/cpu-db8500.c      |  2 +-
 arch/arm/mach-ux500/cpu.c             |  2 +-
 arch/arm/mach-ux500/include/mach/id.h | 21 +++++++++++++--------
 arch/arm/mach-ux500/platsmp.c         |  2 +-
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index dc12394..75d5b51 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -38,7 +38,7 @@ static int __init ux500_l2x0_init(void)
 {
 	u32 aux_val = 0x3e000000;
 
-	if (cpu_is_u8500_family())
+	if (cpu_is_u8500_family() || cpu_is_ux540_family())
 		l2x0_base = __io_address(U8500_L2CC_BASE);
 	else
 		ux500_unknown_soc();
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index db3c52d..2dd8593 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -80,7 +80,7 @@ void __init u8500_map_io(void)
 
 	iotable_init(u8500_common_io_desc, ARRAY_SIZE(u8500_common_io_desc));
 
-	if (cpu_is_u9540())
+	if (cpu_is_ux540_family())
 		iotable_init(u9540_io_desc, ARRAY_SIZE(u9540_io_desc));
 	else
 		iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e2360e7..4b0a9b3 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -51,7 +51,7 @@ void __init ux500_init_irq(void)
 	void __iomem *dist_base;
 	void __iomem *cpu_base;
 
-	if (cpu_is_u8500_family()) {
+	if (cpu_is_u8500_family() || cpu_is_ux540_family()) {
 		dist_base = __io_address(U8500_GIC_DIST_BASE);
 		cpu_base = __io_address(U8500_GIC_CPU_BASE);
 	} else
diff --git a/arch/arm/mach-ux500/include/mach/id.h b/arch/arm/mach-ux500/include/mach/id.h
index d1240e4..c7fcf69 100644
--- a/arch/arm/mach-ux500/include/mach/id.h
+++ b/arch/arm/mach-ux500/include/mach/id.h
@@ -46,14 +46,24 @@ static inline bool __attribute_const__ cpu_is_u8520(void)
 	return dbx500_partnumber() == 0x8520;
 }
 
+static inline bool cpu_is_u8500_family(void)
+{
+	return cpu_is_u8500() || cpu_is_u8520();
+}
+
 static inline bool __attribute_const__ cpu_is_u9540(void)
 {
 	return dbx500_partnumber() == 0x9540;
 }
 
-static inline bool cpu_is_u8500_family(void)
+static inline bool __attribute_const__ cpu_is_u8540(void)
+{
+	return dbx500_partnumber() == 0x8540;
+}
+
+static inline bool cpu_is_ux540_family(void)
 {
-	return cpu_is_u8500() || cpu_is_u9540();
+	return cpu_is_u9540() || cpu_is_u8540();
 }
 
 /*
@@ -97,12 +107,7 @@ static inline bool cpu_is_u8500v21(void)
 
 static inline bool cpu_is_u8500v20_or_later(void)
 {
-	/*
-	 * U9540 has so much in common with U8500 that is is considered a
-	 * U8500 variant.
-	 */
-	return cpu_is_u9540() ||
-		(cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11());
+	return (cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11());
 }
 
 static inline bool ux500_is_svp(void)
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index da1d5ad..cb35897 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -48,7 +48,7 @@ static void write_pen_release(int val)
 
 static void __iomem *scu_base_addr(void)
 {
-	if (cpu_is_u8500_family())
+	if (cpu_is_u8500_family() || cpu_is_ux540_family())
 		return __io_address(U8500_SCU_BASE);
 	else
 		ux500_unknown_soc();
-- 
1.7.11.3
