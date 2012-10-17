From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:33:42 +0100
Subject: [PATCH 5/7] ARM: perf: register cpu_notifier at driver init
In-Reply-To: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
References: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350488024-3224-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <Mark.Rutland@arm.com>

The current practice of registering the cpu hotplug notifier at PMU
registration time won't be safe with multiple PMUs, as we'll repeatedly
attempt to register the notifier. This has the unfortunate effect of
silently corrupting the notifier list, leading to boot stalling.

Instead, register the notifier at init time. Its sanity checks will
prevent anything bad from happening if the notifier is called before we
have any PMUs registered.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 02244fa..71c824c 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -285,7 +285,6 @@ static int __devinit cpu_pmu_device_probe(struct platform_device *pdev)
 	cpu_pmu = pmu;
 	cpu_pmu->plat_device = pdev;
 	cpu_pmu_init(cpu_pmu);
-	register_cpu_notifier(&cpu_pmu_hotplug_notifier);
 	armpmu_register(cpu_pmu, cpu_pmu->name, PERF_TYPE_RAW);
 
 	return 0;
@@ -303,6 +302,16 @@ static struct platform_driver cpu_pmu_driver = {
 
 static int __init register_pmu_driver(void)
 {
-	return platform_driver_register(&cpu_pmu_driver);
+	int err;
+
+	err = register_cpu_notifier(&cpu_pmu_hotplug_notifier);
+	if (err)
+		return err;
+
+	err = platform_driver_register(&cpu_pmu_driver);
+	if (err)
+		unregister_cpu_notifier(&cpu_pmu_hotplug_notifier);
+
+	return err;
 }
 device_initcall(register_pmu_driver);
-- 
1.7.4.1
