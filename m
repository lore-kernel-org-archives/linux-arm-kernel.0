From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:14 +0900
Subject: [PATCH 18/26] ARM: shmobile: Use ->init_late() on Lager
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <3fbbcbdf57a5172318d10d0f16a4e2d2c595fd75.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Hook in shmobile_init_late() on Lager V2. This enables some PM
related things like CPUIdle and Suspend-to-RAM.

With this patch applied it is possible to use Suspend-to-RAM:
# echo enabled > /sys/class/tty/ttySC6/power/wakeup
# echo mem > /sys/power/state
(wake by sending a character on the serial console)

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 2 ++
 arch/arm/mach-shmobile/board-lager.c           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 7df9ea0..51a3bcc 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <mach/common.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
@@ -41,5 +42,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
 	.init_early	= r8a7790_init_early,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_add_standard_devices,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f5dab34..d47052e 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -259,5 +259,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
 	.init_early	= r8a7790_init_early,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
-- 
1.8.4
