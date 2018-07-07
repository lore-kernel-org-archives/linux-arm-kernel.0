From: stefan@agner.ch (Stefan Agner)
Date: Sat,  7 Jul 2018 23:16:56 +0200
Subject: [PATCH] arm: perf: prevent unbind/bind via sysfs
Message-ID: <20180707211656.2920-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unbinding and rebinding the ARM PMU driver via sysfs leads to a
warning followed by more errors:
  WARNING: CPU: 0 PID: 217 at kernel/irq/chip.c:1034 irq_modify_status+0x150/0x16c
  ..
  genirq: Flags mismatch irq 19. 00010c04 (arm-pmu) vs. 00010c04 (arm-pmu)
  hw perfevents: unable to request IRQ19 for ARM PMU counters
  hw perfevents: /pmu: failed to register PMU devices!
  armv7-pmu: probe of pmu failed with error -16

The driver is clearly not designed to be removed. Disable bind/
unbind for this driver.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/kernel/perf_event_v7.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 57f01e059f39..5a5116794440 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -2030,6 +2030,7 @@ static struct platform_driver armv7_pmu_driver = {
 	.driver		= {
 		.name	= "armv7-pmu",
 		.of_match_table = armv7_pmu_of_device_ids,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= armv7_pmu_device_probe,
 };
-- 
2.18.0
