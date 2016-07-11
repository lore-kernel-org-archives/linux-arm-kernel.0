From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Mon, 11 Jul 2016 12:29:01 -0000
Subject: [patch 55/66] hwtracing: coresight-etm4x: Convert to hotplug state
 machine
References: <20160711122450.923603742@linutronix.de>
Message-ID: <20160711122535.280919206@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This driver has an asymmetry of ONLINE code without any corresponding tear
down code. Otherwise, this is a straightforward conversion.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 drivers/hwtracing/coresight/coresight-etm4x.c |   93 ++++++++++++++------------
 include/linux/cpuhotplug.h                    |    1 
 2 files changed, 53 insertions(+), 41 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -673,53 +673,52 @@ void etm4_config_trace_mode(struct etmv4
 	config->addr_acc[ETM_DEFAULT_ADDR_COMP + 1] = addr_acc;
 }
 
-static int etm4_cpu_callback(struct notifier_block *nfb, unsigned long action,
-			    void *hcpu)
+static int etm4_online_cpu(unsigned int cpu)
 {
-	unsigned int cpu = (unsigned long)hcpu;
+	if (!etmdrvdata[cpu])
+		return 0;
+
+	if (etmdrvdata[cpu]->boot_enable && !etmdrvdata[cpu]->sticky_enable)
+		coresight_enable(etmdrvdata[cpu]->csdev);
+	return 0;
+}
+
+static int etm4_starting_cpu(unsigned int cpu)
+{
+	if (!etmdrvdata[cpu])
+		return 0;
+
+	spin_lock(&etmdrvdata[cpu]->spinlock);
+	if (!etmdrvdata[cpu]->os_unlock) {
+		etm4_os_unlock(etmdrvdata[cpu]);
+		etmdrvdata[cpu]->os_unlock = true;
+	}
 
+	if (local_read(&etmdrvdata[cpu]->mode))
+		etm4_enable_hw(etmdrvdata[cpu]);
+	spin_unlock(&etmdrvdata[cpu]->spinlock);
+	return 0;
+}
+
+static int etm4_dying_cpu(unsigned int cpu)
+{
 	if (!etmdrvdata[cpu])
-		goto out;
+		return 0;
 
-	switch (action & (~CPU_TASKS_FROZEN)) {
-	case CPU_STARTING:
-		spin_lock(&etmdrvdata[cpu]->spinlock);
-		if (!etmdrvdata[cpu]->os_unlock) {
-			etm4_os_unlock(etmdrvdata[cpu]);
-			etmdrvdata[cpu]->os_unlock = true;
-		}
-
-		if (local_read(&etmdrvdata[cpu]->mode))
-			etm4_enable_hw(etmdrvdata[cpu]);
-		spin_unlock(&etmdrvdata[cpu]->spinlock);
-		break;
-
-	case CPU_ONLINE:
-		if (etmdrvdata[cpu]->boot_enable &&
-			!etmdrvdata[cpu]->sticky_enable)
-			coresight_enable(etmdrvdata[cpu]->csdev);
-		break;
-
-	case CPU_DYING:
-		spin_lock(&etmdrvdata[cpu]->spinlock);
-		if (local_read(&etmdrvdata[cpu]->mode))
-			etm4_disable_hw(etmdrvdata[cpu]);
-		spin_unlock(&etmdrvdata[cpu]->spinlock);
-		break;
-	}
-out:
-	return NOTIFY_OK;
-}
-
-static struct notifier_block etm4_cpu_notifier = {
-	.notifier_call = etm4_cpu_callback,
-};
+	spin_lock(&etmdrvdata[cpu]->spinlock);
+	if (local_read(&etmdrvdata[cpu]->mode))
+		etm4_disable_hw(etmdrvdata[cpu]);
+	spin_unlock(&etmdrvdata[cpu]->spinlock);
+	return 0;
+}
 
 static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
 {
 	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
 }
 
+static enum cpuhp_state hp_online;
+
 static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret;
@@ -767,8 +766,17 @@ static int etm4_probe(struct amba_device
 				etm4_init_arch_data,  drvdata, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
-	if (!etm4_count++)
-		register_hotcpu_notifier(&etm4_cpu_notifier);
+	if (!etm4_count++) {
+		cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CORESIGHT4_STARTING,
+					  "AP_ARM_CORESIGHT4_STARTING",
+					  etm4_starting_cpu, etm4_dying_cpu);
+		ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+						"AP_ARM_CORESIGHT4_ONLINE",
+						etm4_online_cpu, NULL);
+		if (ret < 0)
+			goto err_arch_supported;
+		hp_online = ret;
+	}
 
 	put_online_cpus();
 
@@ -809,8 +817,11 @@ static int etm4_probe(struct amba_device
 	return 0;
 
 err_arch_supported:
-	if (--etm4_count == 0)
-		unregister_hotcpu_notifier(&etm4_cpu_notifier);
+	if (--etm4_count == 0) {
+		cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT4_STARTING);
+		if (hp_online)
+			cpuhp_remove_state_nocalls(hp_online);
+	}
 	return ret;
 }
 
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -55,6 +55,7 @@ enum cpuhp_state {
 	CPUHP_AP_KVM_ARM_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
+	CPUHP_AP_ARM_CORESIGHT4_STARTING,
 	CPUHP_AP_LEDTRIG_STARTING,
 	CPUHP_AP_NOTIFY_STARTING,
 	CPUHP_AP_ONLINE,
