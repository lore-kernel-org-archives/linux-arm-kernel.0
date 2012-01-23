From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Jan 2012 17:52:10 +0000
Subject: [PATCH] ARM: realview: fix mapping of MPCore private memory region
Message-ID: <1327341130-23332-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 0536bdf33faf (ARM: move iotable mappings within
the vmalloc region), the RealView PB11MP cannot boot anymore.

This is caused by the way the mappings are described on this
platform (define replaced by hex values for clarity):

{	/* GIC CPU interface mapping */
        .virtual        = IO_ADDRESS(0x1F000100),
        .pfn            = __phys_to_pfn(0x1F000100),
        .length         = SZ_4K,
        .type           = MT_DEVICE,
}, {	/* GIC distributor mapping */
        .virtual        = IO_ADDRESS(0x1F001000),
        .pfn            = __phys_to_pfn(0x1F001000),
        .length         = SZ_4K,
        .type           = MT_DEVICE,
}

The first mapping ends up reserving two pages, and clashes with
the second one, which triggers a BUG_ON in vm_area_add_early().

In order to solve this problem, treat the MPCore private memory
region (containing the SCU, the GIC and the TWD) as a single region,
as described in the TRM:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0360f/CACGDJJC.html

The EB11MP is converted the same way, even if it manages to avoid
the problem.

Tested on both PB11MP and EB11MP.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-realview/include/mach/board-eb.h     |   18 ++++++++++--------
 arch/arm/mach-realview/include/mach/board-pb11mp.h |    2 ++
 arch/arm/mach-realview/realview_eb.c               |   11 +++--------
 arch/arm/mach-realview/realview_pb11mp.c           |   13 ++++---------
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-realview/include/mach/board-eb.h b/arch/arm/mach-realview/include/mach/board-eb.h
index 794a8d9..124bce6 100644
--- a/arch/arm/mach-realview/include/mach/board-eb.h
+++ b/arch/arm/mach-realview/include/mach/board-eb.h
@@ -47,21 +47,23 @@
 #define REALVIEW_EB_USB_BASE		0x4F000000	/* USB */
 
 #ifdef CONFIG_REALVIEW_EB_ARM11MP_REVB
-#define REALVIEW_EB11MP_SCU_BASE	0x10100000	/* SCU registers */
-#define REALVIEW_EB11MP_GIC_CPU_BASE	0x10100100	/* Generic interrupt controller CPU interface */
-#define REALVIEW_EB11MP_TWD_BASE	0x10100600
-#define REALVIEW_EB11MP_GIC_DIST_BASE	0x10101000	/* Generic interrupt controller distributor */
+#define REALVIEW_EB11MP_PRIV_MEM_BASE	0x1F000000
 #define REALVIEW_EB11MP_L220_BASE	0x10102000	/* L220 registers */
 #define REALVIEW_EB11MP_SYS_PLD_CTRL1	0xD8		/* Register offset for MPCore sysctl */
 #else
-#define REALVIEW_EB11MP_SCU_BASE	0x1F000000	/* SCU registers */
-#define REALVIEW_EB11MP_GIC_CPU_BASE	0x1F000100	/* Generic interrupt controller CPU interface */
-#define REALVIEW_EB11MP_TWD_BASE	0x1F000600
-#define REALVIEW_EB11MP_GIC_DIST_BASE	0x1F001000	/* Generic interrupt controller distributor */
+#define REALVIEW_EB11MP_PRIV_MEM_BASE	0x1F000000
 #define REALVIEW_EB11MP_L220_BASE	0x1F002000	/* L220 registers */
 #define REALVIEW_EB11MP_SYS_PLD_CTRL1	0x74		/* Register offset for MPCore sysctl */
 #endif
 
+#define REALVIEW_EB11MP_PRIV_MEM_SIZE	SZ_8K
+#define REALVIEW_EB11MP_PRIV_MEM_OFF(x)	(REALVIEW_EB11MP_PRIV_MEM_BASE + (x))
+
+#define REALVIEW_EB11MP_SCU_BASE	REALVIEW_EB11MP_PRIV_MEM_OFF(0)		/* SCU registers */
+#define REALVIEW_EB11MP_GIC_CPU_BASE	REALVIEW_EB11MP_PRIV_MEM_OFF(0x0100)	/* Generic interrupt controller CPU interface */
+#define REALVIEW_EB11MP_TWD_BASE	REALVIEW_EB11MP_PRIV_MEM_OFF(0x0600)
+#define REALVIEW_EB11MP_GIC_DIST_BASE	REALVIEW_EB11MP_PRIV_MEM_OFF(0x1000)	/* Generic interrupt controller distributor */
+
 /*
  * Core tile identification (REALVIEW_SYS_PROCID)
  */
diff --git a/arch/arm/mach-realview/include/mach/board-pb11mp.h b/arch/arm/mach-realview/include/mach/board-pb11mp.h
index 7abf918..aa2d4e0 100644
--- a/arch/arm/mach-realview/include/mach/board-pb11mp.h
+++ b/arch/arm/mach-realview/include/mach/board-pb11mp.h
@@ -75,6 +75,8 @@
 /*
  * Testchip peripheral and fpga gic regions
  */
+#define REALVIEW_TC11MP_PRIV_MEM_BASE		0x1F000000
+#define REALVIEW_TC11MP_PRIV_MEM_SIZE		SZ_8K
 #define REALVIEW_TC11MP_SCU_BASE		0x1F000000	/* IRQ, Test chip */
 #define REALVIEW_TC11MP_GIC_CPU_BASE		0x1F000100	/* Test chip interrupt controller CPU interface */
 #define REALVIEW_TC11MP_TWD_BASE		0x1F000600
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index e629621..9578145 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -91,14 +91,9 @@ static struct map_desc realview_eb_io_desc[] __initdata = {
 
 static struct map_desc realview_eb11mp_io_desc[] __initdata = {
 	{
-		.virtual	= IO_ADDRESS(REALVIEW_EB11MP_SCU_BASE),
-		.pfn		= __phys_to_pfn(REALVIEW_EB11MP_SCU_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= IO_ADDRESS(REALVIEW_EB11MP_GIC_DIST_BASE),
-		.pfn		= __phys_to_pfn(REALVIEW_EB11MP_GIC_DIST_BASE),
-		.length		= SZ_4K,
+		.virtual	= IO_ADDRESS(REALVIEW_EB11MP_PRIV_MEM_BASE),
+		.pfn		= __phys_to_pfn(REALVIEW_EB11MP_PRIV_MEM_BASE),
+		.length		= REALVIEW_EB11MP_PRIV_MEM_SIZE,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= IO_ADDRESS(REALVIEW_EB11MP_L220_BASE),
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 127a3fd..2147335 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -64,15 +64,10 @@ static struct map_desc realview_pb11mp_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(REALVIEW_PB11MP_GIC_DIST_BASE),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= IO_ADDRESS(REALVIEW_TC11MP_GIC_CPU_BASE),
-		.pfn		= __phys_to_pfn(REALVIEW_TC11MP_GIC_CPU_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= IO_ADDRESS(REALVIEW_TC11MP_GIC_DIST_BASE),
-		.pfn		= __phys_to_pfn(REALVIEW_TC11MP_GIC_DIST_BASE),
-		.length		= SZ_4K,
+	}, {	/* Maps the SCU, GIC CPU interface, TWD, GIC DIST */
+		.virtual	= IO_ADDRESS(REALVIEW_TC11MP_PRIV_MEM_BASE),
+		.pfn		= __phys_to_pfn(REALVIEW_TC11MP_PRIV_MEM_BASE),
+		.length		= REALVIEW_TC11MP_PRIV_MEM_SIZE,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= IO_ADDRESS(REALVIEW_SCTL_BASE),
-- 
1.7.7.1
