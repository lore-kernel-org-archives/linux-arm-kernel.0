From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 14 Jun 2016 18:29:53 -0700
Subject: [PATCH v2 6/6] i.MX: Do not explicitly call l2x0_of_init()
In-Reply-To: <1465954193-5894-1-git-send-email-andrew.smirnov@gmail.com>
References: <1465954193-5894-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1465954193-5894-7-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to explicitly call l2x0_of_init() since it will be
called as a part of init_IRQ() (see arch/arm/kernel/irq.c for
details). This way we can simplify imx_init_l2cache() and ditch the call
to it on i.MX35 (which does not claim compatibility with
"arm,pl310-cache") alltogether.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mach-imx/imx35-dt.c    | 10 +++-------
 arch/arm/mach-imx/mach-imx6q.c  |  2 ++
 arch/arm/mach-imx/mach-imx6sl.c |  2 ++
 arch/arm/mach-imx/mach-imx6sx.c |  2 ++
 arch/arm/mach-imx/system.c      | 12 ++++--------
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
index e939603..52ab2c2 100644
--- a/arch/arm/mach-imx/imx35-dt.c
+++ b/arch/arm/mach-imx/imx35-dt.c
@@ -20,12 +20,6 @@
 #include "common.h"
 #include "mx35.h"
 
-static void __init imx35_irq_init(void)
-{
-	imx_init_l2cache();
-	mx35_init_irq();
-}
-
 static const char * const imx35_dt_board_compat[] __initconst = {
 	"fsl,imx35",
 	NULL
@@ -34,6 +28,8 @@ static const char * const imx35_dt_board_compat[] __initconst = {
 DT_MACHINE_START(IMX35_DT, "Freescale i.MX35 (Device Tree Support)")
 	.map_io		= mx35_map_io,
 	.init_early	= imx35_init_early,
-	.init_irq	= imx35_irq_init,
+	.init_irq	= mx35_init_irq,
 	.dt_compat	= imx35_dt_board_compat,
+	.l2c_aux_val 	= 0,
+	.l2c_aux_mask	= ~0,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index cb27d56..9360a8a 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -413,4 +413,6 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
 	.init_machine	= imx6q_init_machine,
 	.init_late      = imx6q_init_late,
 	.dt_compat	= imx6q_dt_compat,
+	.l2c_aux_val 	= 0,
+	.l2c_aux_mask	= ~0,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 3003263..c665551 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -79,4 +79,6 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
 	.init_machine	= imx6sl_init_machine,
 	.init_late      = imx6sl_init_late,
 	.dt_compat	= imx6sl_dt_compat,
+	.l2c_aux_val 	= 0,
+	.l2c_aux_mask	= ~0,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 6a0b061..2c3f927 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -107,4 +107,6 @@ DT_MACHINE_START(IMX6SX, "Freescale i.MX6 SoloX (Device Tree)")
 	.init_machine	= imx6sx_init_machine,
 	.dt_compat	= imx6sx_dt_compat,
 	.init_late	= imx6sx_init_late,
+	.l2c_aux_val 	= 0,
+	.l2c_aux_mask	= ~0,
 MACHINE_END
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 9ea01e3..a89df44 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -98,13 +98,11 @@ void __init imx_init_l2cache(void)
 
 	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
 	if (!np)
-		goto out;
+		return;
 
 	l2x0_base = of_iomap(np, 0);
-	if (!l2x0_base) {
-		of_node_put(np);
-		goto out;
-	}
+	if (!l2x0_base)
+		goto put_node;
 
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		/* Configure the L2 PREFETCH and POWER registers */
@@ -121,9 +119,7 @@ void __init imx_init_l2cache(void)
 	}
 
 	iounmap(l2x0_base);
+put_node:
 	of_node_put(np);
-
-out:
-	l2x0_of_init(0, ~0);
 }
 #endif
-- 
2.5.5
