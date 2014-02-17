From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Feb 2014 15:23:24 +0100
Subject: [PATCH v4 06/13] ARM: mvebu: add workaround for data abort issue on
 Armada 375
In-Reply-To: <1392647011-30117-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392647011-30117-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392647011-30117-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Early versions of Armada 375 SoC have a bug where the BootROM leaves
an external data abort pending. The kernel is hit by this data abort
as soon as it enters userspace, because it unmasks the data aborts at
this moment. We register a custom abort handler below to ignore the
first data abort to work around this problem.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index f60ed1b..3d4feae 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -36,6 +36,27 @@ static void __init mvebu_map_io(void)
 	debug_ll_io_init();
 }
 
+/*
+ * Early versions of Armada 375 SoC have a bug where the BootROM
+ * leaves an external data abort pending. The kernel is hit by this
+ * data abort as soon as it enters userspace, because it unmasks the
+ * data aborts at this moment. We register a custom abort handler
+ * below to ignore the first data abort to work around this
+ * problem.
+ */
+static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
+					struct pt_regs *regs)
+{
+	static int ignore_first;
+
+	if (!ignore_first && fsr == 0x1406) {
+		ignore_first = 1;
+		return 0;
+	}
+
+	return 1;
+}
+
 static void __init mvebu_timer_and_clk_init(void)
 {
 	of_clk_init(NULL);
@@ -45,6 +66,10 @@ static void __init mvebu_timer_and_clk_init(void)
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_of_init(0, ~0UL);
 #endif
+
+	if (of_machine_is_compatible("marvell,armada375"))
+		hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
+				"imprecise external abort");
 }
 
 static void __init i2c_quirk(void)
-- 
1.8.3.2
