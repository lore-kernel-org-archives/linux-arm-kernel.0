From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 15:23:40 +0100
Subject: [PATCH] kernel/stop_machine: remove HOTPLUG_CPU dependency
Message-ID: <3973773.5dBOxplscZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of things rely on stop_machine, not just HOTPLUG_CPU,
as got apparent, when we stopped building the functions for all
SMP configurations:

arch/arm/kernel/built-in.o: In function `patch_text':
arch/arm/kernel/patch.c:127: undefined reference to `stop_machine'
arch/arm/probes/built-in.o: In function `kprobes_remove_breakpoint':
arch/arm/probes/kprobes/core.c:184: undefined reference to `stop_machine'
arch/arm/probes/kprobes/core.c:184: undefined reference to `stop_machine'
kernel/built-in.o: In function `timekeeping_notify':
kernel/time/timekeeping.c:1096: undefined reference to `stop_machine'
mm/built-in.o: In function `build_all_zonelists':

This restores the original behavior by always compiling the stop_machine
function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 64dab25b058c ("kernel/stop_machine.c: remove CONFIG_SMP dependencies")
---
Found on ARM randconfig builds with today's linux-next, please apply
or fold into the original patch.

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b07adef99a82..a467e6c28a3b 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -529,8 +529,6 @@ static int __init cpu_stop_init(void)
 }
 early_initcall(cpu_stop_init);
 
-#ifdef CONFIG_HOTPLUG_CPU
-
 static int __stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
 {
 	struct multi_stop_data msdata = {
@@ -628,5 +626,3 @@ int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
 	mutex_unlock(&stop_cpus_mutex);
 	return ret ?: done.ret;
 }
-
-#endif	/* CONFIG_HOTPLUG_CPU */
