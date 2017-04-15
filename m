From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 15 Apr 2017 19:01:16 +0200
Subject: [patch 09/20] hwtracing/coresight-etm4x: Use
 cpuhp_setup_state_nocalls_locked()
References: <20170415170107.643253702@linutronix.de>
Message-ID: <20170415171651.995563335@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

etm_probe4() holds get_online_cpus() while invoking
cpuhp_setup_state_nocalls().

cpuhp_setup_state_nocalls() invokes get_online_cpus() as well. This is
correct, but prevents the conversion of the hotplug locking to a percpu
rwsem.

Use cpuhp_setup_state_nocalls_locked() to avoid the nested call.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org

---
 drivers/hwtracing/coresight/coresight-etm4x.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -990,12 +990,12 @@ static int etm4_probe(struct amba_device
 		dev_err(dev, "ETM arch init failed\n");
 
 	if (!etm4_count++) {
-		cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING,
-					  "arm/coresight4:starting",
-					  etm4_starting_cpu, etm4_dying_cpu);
-		ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
-						"arm/coresight4:online",
-						etm4_online_cpu, NULL);
+		cpuhp_setup_state_nocalls_locked(CPUHP_AP_ARM_CORESIGHT_STARTING,
+						 "arm/coresight4:starting",
+						 etm4_starting_cpu, etm4_dying_cpu);
+		ret = cpuhp_setup_state_nocalls_locked(CPUHP_AP_ONLINE_DYN,
+						       "arm/coresight4:online",
+						       etm4_online_cpu, NULL);
 		if (ret < 0)
 			goto err_arch_supported;
 		hp_online = ret;
