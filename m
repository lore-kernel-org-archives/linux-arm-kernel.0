From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Jan 2013 20:56:17 -0700
Subject: [PATCH] ARM: imx: fix imx31-dt.c time-related warning
Message-ID: <1359518177-21245-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Commit 6bb27d7 "ARM: delete struct sys_timer" caused the following:

arch/arm/mach-imx/imx31-dt.c:56:2: warning: initialization from incompatible pointer type [enabled by default]
arch/arm/mach-imx/imx31-dt.c:56:2: warning: (near initialization for ?__mach_desc_IMX31_DT.init_time?) [enabled by default]

This is because mx31_clocks_init_dt() returns int, whereas the .init_time
field prototype expects a function returning void. Implement a wrapper so
that the prototypes match.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is based on arm-soc's timer/cleanup branch, which contains
the commit mentioned above.
---
 arch/arm/mach-imx/imx31-dt.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index f9a6909..b5c04ee 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -43,12 +43,17 @@ static const char *imx31_dt_board_compat[] __initdata = {
 	NULL
 };
 
+static void __init imx31_dt_timer_init(void)
+{
+	mx31_clocks_init_dt();
+}
+
 DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
 	.map_io		= mx31_map_io,
 	.init_early	= imx31_init_early,
 	.init_irq	= mx31_init_irq,
 	.handle_irq	= imx31_handle_irq,
-	.init_time	= mx31_clocks_init_dt,
+	.init_time	= imx31_dt_timer_init,
 	.init_machine	= imx31_dt_init,
 	.dt_compat	= imx31_dt_board_compat,
 	.restart	= mxc_restart,
-- 
1.7.10.4
