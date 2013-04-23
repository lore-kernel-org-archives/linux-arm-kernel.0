From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 23 Apr 2013 10:54:32 +0200
Subject: [V4 patch 02/15] ARM: ux500: cpuidle: replace for_each_online_cpu by
 for_each_possible_cpu
In-Reply-To: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1366707285-12179-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the drivers are using, in their initialization function, the
for_each_possible_cpu macro.

Using for_each_online_cpu means the driver must handle the initialization
of the cpuidle device when a cpu is up which is not the case here.

Change the macro to for_each_possible_cpu as that fix the hotplug
initialization and make the initialization routine consistent with the
rest of the code in the different drivers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpuidle.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index c29c1bf..5657d4a 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -125,7 +125,7 @@ int __init ux500_idle_init(void)
 		return ret;
 	}
 
-	for_each_online_cpu(cpu) {
+	for_each_possible(cpu) {
 		device = &per_cpu(ux500_cpuidle_device, cpu);
 		device->cpu = cpu;
 		ret = cpuidle_register_device(device);
@@ -139,7 +139,7 @@ out:
 	return ret;
 
 out_unregister:
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		device = &per_cpu(ux500_cpuidle_device, cpu);
 		cpuidle_unregister_device(device);
 	}
-- 
1.7.9.5
