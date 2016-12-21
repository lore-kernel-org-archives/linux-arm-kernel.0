From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 21 Dec 2016 19:21:23 +0100 (CET)
Subject: ARM: imx: mmdc: Fix completely broken cpu hotplug code
Message-ID: <alpine.DEB.2.20.1612211917490.3424@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu hotplug support of this perf driver is broken in several ways:

1) It adds a instance before setting up the state.

2) The state for the instance is different from the state of the
   callback. It's just a randomly chosen state.

3) The instance registration is not error checked so nobody noticed that
   the call can never succeed.

4) The state for the multi install callbacks is chosen randomly and
   overwrites existing state. This is now prevented by the core code so the
   call is guaranteed to fail.

5) The error exit path in the init function leaves the instance registered
   and then frees the memory which contains the enqueued hlist node.

6) The remove function is removing the state and not the instance.

Fix it by:

- Setting up the state before adding instances. Use a dynamically allocated
  state for it.

- Install instances after the state has been set up

- Remove the instance in the error path before freeing memory

- Remove instance not the state in the driver remove callback

While at is use raw_cpu_processor_id(), because cpu_processor_id() cannot
be used in preemptible context, and set the driver data after successful
registration of the pmu.

Fixes: e76bdfd7403a ("ARM: imx: Added perf functionality to mmdc driver")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Zhengyu Shen <zhengyu.shen@nxp.com>
Cc: Frank Li <frank.li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>

---
 arch/arm/mach-imx/mmdc.c   |   34 ++++++++++++++++++++++------------
 include/linux/cpuhotplug.h |    1 +
 2 files changed, 23 insertions(+), 12 deletions(-)

--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -60,6 +60,7 @@
 
 #define to_mmdc_pmu(p) container_of(p, struct mmdc_pmu, pmu)
 
+static enum cpuhp_state cpuhp_mmdc_state;
 static int ddr_type;
 
 struct fsl_mmdc_devtype_data {
@@ -451,8 +452,8 @@ static int imx_mmdc_remove(struct platfo
 {
 	struct mmdc_pmu *pmu_mmdc = platform_get_drvdata(pdev);
 
+	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	perf_pmu_unregister(&pmu_mmdc->pmu);
-	cpuhp_remove_state_nocalls(CPUHP_ONLINE);
 	kfree(pmu_mmdc);
 	return 0;
 }
@@ -472,6 +473,18 @@ static int imx_mmdc_perf_init(struct pla
 		return -ENOMEM;
 	}
 
+	/* The first instance registers the hotplug state */
+	if (!cpuhp_mmdc_state) {
+		ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+					      "perf/arm/mmdc:online", NULL,
+					      mmdc_pmu_offline_cpu);
+		if (ret < 0) {
+			pr_err("cpuhp_setup_state_multi failed\n");
+			goto pmu_free;
+		}
+		cpuhp_mmdc_state = ret;
+	}
+
 	mmdc_num = mmdc_pmu_init(pmu_mmdc, mmdc_base, &pdev->dev);
 	if (mmdc_num == 0)
 		name = "mmdc";
@@ -485,26 +498,23 @@ static int imx_mmdc_perf_init(struct pla
 			HRTIMER_MODE_REL);
 	pmu_mmdc->hrtimer.function = mmdc_pmu_timer_handler;
 
-	cpuhp_state_add_instance_nocalls(CPUHP_ONLINE,
-					 &pmu_mmdc->node);
-	cpumask_set_cpu(smp_processor_id(), &pmu_mmdc->cpu);
-	ret = cpuhp_setup_state_multi(CPUHP_AP_NOTIFY_ONLINE,
-				      "MMDC_ONLINE", NULL,
-				      mmdc_pmu_offline_cpu);
-	if (ret) {
-		pr_err("cpuhp_setup_state_multi failure\n");
-		goto pmu_register_err;
-	}
+	cpumask_set_cpu(raw_smp_processor_id(), &pmu_mmdc->cpu);
+
+	/* Register the pmu instance for cpu hotplug */
+	cpuhp_state_add_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 
 	ret = perf_pmu_register(&(pmu_mmdc->pmu), name, -1);
-	platform_set_drvdata(pdev, pmu_mmdc);
 	if (ret)
 		goto pmu_register_err;
+
+	platform_set_drvdata(pdev, pmu_mmdc);
 	return 0;
 
 pmu_register_err:
 	pr_warn("MMDC Perf PMU failed (%d), disabled\n", ret);
+	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	hrtimer_cancel(&pmu_mmdc->hrtimer);
+pmu_free:
 	kfree(pmu_mmdc);
 	return ret;
 }
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -140,6 +140,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
 	CPUHP_AP_PERF_ARM_CCN_ONLINE,
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
+	CPUHP_AP_PERF_ARM_MMDC_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_NOTIFY_ONLINE,
