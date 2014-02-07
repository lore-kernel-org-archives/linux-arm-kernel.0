From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 7 Feb 2014 13:35:06 +0900
Subject: [PATCH v2 6/6] ARM: tegra: cpuidle: use firmware for power down
In-Reply-To: <1391747706-1847-1-git-send-email-acourbot@nvidia.com>
References: <1391747706-1847-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1391747706-1847-7-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Attempt to invoke the prepare_idle() and do_idle() firmware calls
to power down a CPU so an underlying firmware gets informed of
the idle operation and performs it by itself if designed in such a way.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index e0b87300243d..558067ddc186 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -19,6 +19,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/clockchips.h>
+#include <asm/firmware.h>
 
 #include <asm/cpuidle.h>
 #include <asm/suspend.h>
@@ -45,7 +46,15 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
 
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
 
-	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
+	call_firmware_op(prepare_idle);
+
+	switch (call_firmware_op(do_idle)) {
+	case -ENOSYS:
+		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
+		break;
+	default:
+		break;
+	}
 
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
 
-- 
1.8.5.3
