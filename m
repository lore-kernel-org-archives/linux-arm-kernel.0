From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 10 Apr 2013 16:22:08 +0200
Subject: [PATCH 03/18] ARM: ux500: cpuidle: replace for_each_online_cpu by
 for_each_possible_cpu
In-Reply-To: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1365603743-5618-4-git-send-email-daniel.lezcano@linaro.org>
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
