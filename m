From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 12 Feb 2014 11:43:44 +0900
Subject: [PATCH v3] ARM: tegra: cpuidle: use firmware for power down
In-Reply-To: <52FAD4C2.80803@nvidia.com>
References: <52FAD4C2.80803@nvidia.com>
Message-ID: <1392173024-11567-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Attempt to invoke the prepare_idle() and do_idle() firmware calls
to power down a CPU so an underlying firmware gets informed of
the idle operation and performs it by itself if designed in such a way.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
This is the only v3 patch in the series.

Changes since v2:
- Use an if statement instead of a switch to handle the single return
  code we need to care about.

 arch/arm/mach-tegra/cpuidle-tegra114.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index e0b87300243d..b5fb7c110c64 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -19,6 +19,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/clockchips.h>
+#include <asm/firmware.h>
 
 #include <asm/cpuidle.h>
 #include <asm/suspend.h>
@@ -45,7 +46,11 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
 
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
 
-	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
+	call_firmware_op(prepare_idle);
+
+	/* Do suspend by ourselves if the firmware does not implement it */
+	if (call_firmware_op(do_idle) == -ENOSYS)
+		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
 
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
 
-- 
1.8.5.4
