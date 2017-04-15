From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 15 Apr 2017 19:01:15 +0200
Subject: [patch 08/20] hwtracing/coresight-etm3x: Use the locked version of
 cpuhp_setup_state_nocalls()
References: <20170415170107.643253702@linutronix.de>
Message-ID: <20170415171651.902904567@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

etm_probe() holds get_online_cpus() while invoking
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
 drivers/hwtracing/coresight/coresight-etm3x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index a51b6b64ecdf..0887265f361d 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -803,12 +803,12 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		dev_err(dev, "ETM arch init failed\n");
 
 	if (!etm_count++) {
-		cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING,
-					  "arm/coresight:starting",
-					  etm_starting_cpu, etm_dying_cpu);
-		ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
-						"arm/coresight:online",
-						etm_online_cpu, NULL);
+		cpuhp_setup_state_nocalls_locked(CPUHP_AP_ARM_CORESIGHT_STARTING,
+						 "arm/coresight:starting",
+						 etm_starting_cpu, etm_dying_cpu);
+		ret = cpuhp_setup_state_nocalls_locked(CPUHP_AP_ONLINE_DYN,
+						       "arm/coresight:online",
+						       etm_online_cpu, NULL);
 		if (ret < 0)
 			goto err_arch_supported;
 		hp_online = ret;
-- 
2.11.0
