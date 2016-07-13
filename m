From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Wed, 13 Jul 2016 17:16:54 -0000
Subject: [patch V2 51/67] hwtracing/coresight-etm3x: Convert to hotplug state
 machine
References: <20160713153219.128052238@linutronix.de>
Message-ID: <20160713153337.147128995@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <rcochran@linutronix.de>

This driver has an asymmetry of ONLINE code without any corresponding tear
down code. Otherwise, this is a straightforward conversion.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 drivers/hwtracing/coresight/coresight-etm3x.c |   90 ++++++++++++++------------
 include/linux/cpuhotplug.h                    |    1 
 2 files changed, 50 insertions(+), 41 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -51,6 +51,8 @@ module_param_named(boot_enable, boot_ena
 static int etm_count;
 static struct etm_drvdata *etmdrvdata[NR_CPUS];
 
+static enum cpuhp_state hp_online;
+
 /*
  * Memory mapped writes to clear os lock are not supported on some processors
  * and OS lock must be unlocked before any memory mapped access on such
@@ -481,8 +483,7 @@ static int etm_enable_sysfs(struct cores
 
 	/*
 	 * Configure the ETM only if the CPU is online.  If it isn't online
-	 * hw configuration will take place when 'CPU_STARTING' is received
-	 * in @etm_cpu_callback.
+	 * hw configuration will take place on the local CPU during bring up.
 	 */
 	if (cpu_online(drvdata->cpu)) {
 		ret = smp_call_function_single(drvdata->cpu,
@@ -641,47 +642,44 @@ static const struct coresight_ops etm_cs
 	.source_ops	= &etm_source_ops,
 };
 
-static int etm_cpu_callback(struct notifier_block *nfb, unsigned long action,
-			    void *hcpu)
+static int etm_online_cpu(unsigned int cpu)
 {
-	unsigned int cpu = (unsigned long)hcpu;
-
 	if (!etmdrvdata[cpu])
-		goto out;
+		return 0;
 
-	switch (action & (~CPU_TASKS_FROZEN)) {
-	case CPU_STARTING:
-		spin_lock(&etmdrvdata[cpu]->spinlock);
-		if (!etmdrvdata[cpu]->os_unlock) {
-			etm_os_unlock(etmdrvdata[cpu]);
-			etmdrvdata[cpu]->os_unlock = true;
-		}
-
-		if (local_read(&etmdrvdata[cpu]->mode))
-			etm_enable_hw(etmdrvdata[cpu]);
-		spin_unlock(&etmdrvdata[cpu]->spinlock);
-		break;
+	if (etmdrvdata[cpu]->boot_enable && !etmdrvdata[cpu]->sticky_enable)
+		coresight_enable(etmdrvdata[cpu]->csdev);
+	return 0;
+}
 
-	case CPU_ONLINE:
-		if (etmdrvdata[cpu]->boot_enable &&
-		    !etmdrvdata[cpu]->sticky_enable)
-			coresight_enable(etmdrvdata[cpu]->csdev);
-		break;
+static int etm_starting_cpu(unsigned int cpu)
+{
+	if (!etmdrvdata[cpu])
+		return 0;
 
-	case CPU_DYING:
-		spin_lock(&etmdrvdata[cpu]->spinlock);
-		if (local_read(&etmdrvdata[cpu]->mode))
-			etm_disable_hw(etmdrvdata[cpu]);
-		spin_unlock(&etmdrvdata[cpu]->spinlock);
-		break;
+	spin_lock(&etmdrvdata[cpu]->spinlock);
+	if (!etmdrvdata[cpu]->os_unlock) {
+		etm_os_unlock(etmdrvdata[cpu]);
+		etmdrvdata[cpu]->os_unlock = true;
 	}
-out:
-	return NOTIFY_OK;
+
+	if (local_read(&etmdrvdata[cpu]->mode))
+		etm_enable_hw(etmdrvdata[cpu]);
+	spin_unlock(&etmdrvdata[cpu]->spinlock);
+	return 0;
 }
 
-static struct notifier_block etm_cpu_notifier = {
-	.notifier_call = etm_cpu_callback,
-};
+static int etm_dying_cpu(unsigned int cpu)
+{
+	if (!etmdrvdata[cpu])
+		return 0;
+
+	spin_lock(&etmdrvdata[cpu]->spinlock);
+	if (local_read(&etmdrvdata[cpu]->mode))
+		etm_disable_hw(etmdrvdata[cpu]);
+	spin_unlock(&etmdrvdata[cpu]->spinlock);
+	return 0;
+}
 
 static bool etm_arch_supported(u8 arch)
 {
@@ -806,9 +804,17 @@ static int etm_probe(struct amba_device
 				     etm_init_arch_data,  drvdata, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
-	if (!etm_count++)
-		register_hotcpu_notifier(&etm_cpu_notifier);
-
+	if (!etm_count++) {
+		cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING,
+					  "AP_ARM_CORESIGHT_STARTING",
+					  etm_starting_cpu, etm_dying_cpu);
+		ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+						"AP_ARM_CORESIGHT_ONLINE",
+						etm_online_cpu, NULL);
+		if (ret < 0)
+			goto err_arch_supported;
+		hp_online = ret;
+	}
 	put_online_cpus();
 
 	if (etm_arch_supported(drvdata->arch) == false) {
@@ -839,7 +845,6 @@ static int etm_probe(struct amba_device
 
 	pm_runtime_put(&adev->dev);
 	dev_info(dev, "%s initialized\n", (char *)id->data);
-
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
 		drvdata->boot_enable = true;
@@ -848,8 +853,11 @@ static int etm_probe(struct amba_device
 	return 0;
 
 err_arch_supported:
-	if (--etm_count == 0)
-		unregister_hotcpu_notifier(&etm_cpu_notifier);
+	if (--etm_count == 0) {
+		cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
+		if (hp_online)
+			cpuhp_remove_state_nocalls(hp_online);
+	}
 	return ret;
 }
 
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -50,6 +50,7 @@ enum cpuhp_state {
 	CPUHP_AP_KVM_ARM_VGIC_STARTING,
 	CPUHP_AP_KVM_ARM_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
+	CPUHP_AP_ARM_CORESIGHT_STARTING,
 	CPUHP_AP_LEDTRIG_STARTING,
 	CPUHP_AP_NOTIFY_STARTING,
 	CPUHP_AP_ONLINE,
