From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 17:52:37 +0100
Subject: [PATCH 1/7] clk: mvebu: init all mvebu clock types from
 mvebu_clocks_init()
In-Reply-To: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353343963-23034-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu_clocks_init() function should register all the mvebu clock
types, so that all mvebu platforms only have to call
mvebu_clocks_init().

This fixes mach-mvebu because mvebu_clk_gating_init() was never called
and therefore none of the gating clocks were registered.

mach-kirkwood and mach-dove are updated to not call
mvebu_clk_gating_init() a second time. Thanks to this, it is no longer
necessary to expose mvebu_clk_gating_init() beyond the clock
framework, so we get rid of its prototype in <linux/clk/mvebu.h> and
we add it in a private drivers/clk/mvebu/clk-gating-ctrl.h header
file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/common.c         |    1 -
 arch/arm/mach-kirkwood/board-dt.c   |    1 -
 drivers/clk/mvebu/clk-gating-ctrl.h |   18 ++++++++++++++++++
 drivers/clk/mvebu/clk.c             |    2 ++
 include/linux/clk/mvebu.h           |    1 -
 5 files changed, 20 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/mvebu/clk-gating-ctrl.h

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 4b09d12..6a2c4dc 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -421,7 +421,6 @@ static void __init dove_legacy_clk_init(void)
 static void __init dove_of_clk_init(void)
 {
 	mvebu_clocks_init();
-	mvebu_clk_gating_init();
 	dove_legacy_clk_init();
 }
 
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index f55393b..40db4a8 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -80,7 +80,6 @@ static void __init kirkwood_legacy_clk_init(void)
 static void __init kirkwood_of_clk_init(void)
 {
 	mvebu_clocks_init();
-	mvebu_clk_gating_init();
 	kirkwood_legacy_clk_init();
 }
 
diff --git a/drivers/clk/mvebu/clk-gating-ctrl.h b/drivers/clk/mvebu/clk-gating-ctrl.h
new file mode 100644
index 0000000..20cc4ad
--- /dev/null
+++ b/drivers/clk/mvebu/clk-gating-ctrl.h
@@ -0,0 +1,18 @@
+/*
+ * Marvell EBU gating clock handling
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MVEBU_CLK_GATING_H
+#define __MVEBU_CLK_GATING_H
+
+void __init mvebu_clk_gating_init(void);
+
+#endif
diff --git a/drivers/clk/mvebu/clk.c b/drivers/clk/mvebu/clk.c
index dc310d6..3f0e43e 100644
--- a/drivers/clk/mvebu/clk.c
+++ b/drivers/clk/mvebu/clk.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include "clk-core.h"
 #include "clk-cpu.h"
+#include "clk-gating-ctrl.h"
 
 static const __initconst struct of_device_id clk_match[] = {
 #ifdef CONFIG_MVEBU_CLK_CPU
@@ -33,5 +34,6 @@ static const __initconst struct of_device_id clk_match[] = {
 void __init mvebu_clocks_init(void)
 {
 	mvebu_core_clk_init();
+	mvebu_clk_gating_init();
 	of_clk_init(clk_match);
 }
diff --git a/include/linux/clk/mvebu.h b/include/linux/clk/mvebu.h
index 70c366f..8c4ae71 100644
--- a/include/linux/clk/mvebu.h
+++ b/include/linux/clk/mvebu.h
@@ -18,6 +18,5 @@
 #define __CLK_MVEBU_H_
 
 void __init mvebu_clocks_init(void);
-void mvebu_clk_gating_init(void);
 
 #endif
-- 
1.7.9.5
