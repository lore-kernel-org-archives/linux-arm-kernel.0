From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:11 +0900
Subject: [PATCH 15/26] ARM: shmobile: Use ->init_late() on Koelsch
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <6dc00ab90fa8bc4fec2f9c206ee679d144bc7eb5.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Hook in shmobile_init_late() on Koelsch. This enables some PM
related things like CPUIdle and Suspend-to-RAM.

With this patch applied it is possible to use Suspend-to-RAM:
# echo enabled > /sys/class/tty/ttySC6/power/wakeup
# echo mem > /sys/power/state
(wake by sending a character on the serial console)

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 2 ++
 arch/arm/mach-shmobile/board-koelsch.c           | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 25b558f..a804a17 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -22,6 +22,7 @@
 #include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <mach/common.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7791.h>
 #include <asm/mach/arch.h>
@@ -47,5 +48,6 @@ DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.init_early	= r8a7791_init_early,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_add_standard_devices,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= koelsch_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 5b81a34..135929b 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -92,7 +92,8 @@ static const char * const koelsch_boards_compat_dt[] __initconst = {
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= r8a7791_init_early,
-	.init_machine	= koelsch_add_standard_devices,
 	.init_time	= rcar_gen2_timer_init,
+	.init_machine	= koelsch_add_standard_devices,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= koelsch_boards_compat_dt,
 MACHINE_END
-- 
1.8.4
