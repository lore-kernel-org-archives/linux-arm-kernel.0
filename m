From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 17:59:56 +0900
Subject: [PATCH v4 13/19] ARM: shmobile: marzen-reference: Initialize CPG
 device
In-Reply-To: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
References: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1394701202-25823-14-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On multiplatform kernels clocks are handled by the CCF CPG driver. It
must be explicitly initialized by a call to r8a7779_clocks_init() with
the value of the boot mode pins.

Based on similar work for the Koelsch board by Laurent Pinchart.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index d3e8319..e261431 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -19,7 +19,8 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/clk-provider.h>
+#include <linux/clk/shmobile.h>
+#include <linux/clocksource.h>
 #include <linux/of_platform.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
@@ -27,11 +28,17 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 
-static void __init marzen_init(void)
+static void __init marzen_init_timer(void)
 {
 #ifdef CONFIG_COMMON_CLK
-	of_clk_init(NULL);
-#else
+	r8a7779_clocks_init(r8a7779_read_mode_pins());
+#endif
+	clocksource_of_init();
+}
+
+static void __init marzen_init(void)
+{
+#ifndef CONFIG_COMMON_CLK
 	r8a7779_clock_init();
 #endif
 	r8a7779_add_standard_devices_dt();
@@ -48,6 +55,7 @@ DT_MACHINE_START(MARZEN, "marzen")
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_init_delay,
+	.init_time	= marzen_init_timer,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
-- 
1.8.5.2
