From: Nitin.Chaudhary@zii.aero (Nitin Chaudhary)
Date: Thu, 18 Aug 2016 18:40:58 -0700
Subject: [PATCH 1/3] Error: Fix mmdc compilation errors due to cpu notifier
In-Reply-To: <1471570860-2087-1-git-send-email-Nitin.Chaudhary@zii.aero>
References: <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <1471570860-2087-1-git-send-email-Nitin.Chaudhary@zii.aero>
Message-ID: <1471570860-2087-2-git-send-email-Nitin.Chaudhary@zii.aero>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-imx/mmdc.c   | 89 ++++++++++++++++++++++------------------------
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 372b59c..95c222d 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -77,13 +77,14 @@ struct mmdc_pmu
        struct pmu pmu;
        void __iomem *mmdc_base;
        cpumask_t cpu;
-       struct notifier_block cpu_nb;
        struct hrtimer hrtimer;
        unsigned int irq;
        struct device *dev;
        struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];
 };

+static struct mmdc_pmu *pmu_mmdc;
+
 static unsigned int mmdc_poll_period_us = 1000000;
 module_param_named(pmu_poll_period_us, mmdc_poll_period_us, uint,
                        S_IRUGO | S_IWUSR);
@@ -96,7 +97,6 @@ static ktime_t mmdc_timer_period(void)
 static ssize_t mmdc_cpumask_show(struct device *dev,
                struct device_attribute *attr, char *buf)
 {
-       struct mmdc_pmu *pmu_mmdc = dev_get_drvdata(dev);
        return cpumap_print_to_pagebuf(true, buf, &pmu_mmdc->cpu);
 }

@@ -149,7 +149,7 @@ static const struct attribute_group * attr_groups[] = {
        NULL,
 };

-static u32 mmdc_read_counter(struct mmdc_pmu *pmu_mmdc, int cfg, u64 prev_val)
+static u32 mmdc_read_counter(int cfg, u64 prev_val)
 {
        u32 val;
        void __iomem *mmdc_base, *reg;
@@ -184,7 +184,6 @@ static u32 mmdc_read_counter(struct mmdc_pmu *pmu_mmdc, int cfg, u64 prev_val)

 static void mmdc_enable_profiling(struct perf_event *event)
 {
-       struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
        void __iomem *mmdc_base, *reg;

        mmdc_base = pmu_mmdc->mmdc_base;
@@ -193,32 +192,27 @@ static void mmdc_enable_profiling(struct perf_event *event)
        writel_relaxed(DBG_EN, reg);
 }

-static int mmdc_cpu_notifier(struct notifier_block *nb,
-        unsigned long action, void *hcpu)
+static int mmdc_cpu_offline(unsigned int cpu)
 {
-       struct mmdc_pmu *pmu_mmdc = container_of(nb, struct mmdc_pmu, cpu_nb);
-       unsigned int cpu = (long)hcpu; /* for (long) see kernel/cpu.c */
        unsigned int target;
-
-       switch (action & ~CPU_TASKS_FROZEN) {
-               case CPU_DOWN_PREPARE:
-                       if (!cpumask_test_and_clear_cpu(cpu, &pmu_mmdc->cpu))
-                               break;
-                       target = cpumask_any_but(cpu_online_mask, cpu);
-                       if (target >= nr_cpu_ids)
-                               break;
-                       perf_pmu_migrate_context(&pmu_mmdc->pmu, cpu, target);
-                       cpumask_set_cpu(target, &pmu_mmdc->cpu);
-               default:
-                       break;
-    }
-
-       return NOTIFY_OK;
+       struct mmdc_pmu *pmu_ptr = pmu_mmdc;
+       if (!cpumask_test_and_clear_cpu(cpu, &pmu_ptr->cpu))
+               return 0;
+       target = cpumask_any_but(cpu_online_mask, cpu);
+       if (target >= nr_cpu_ids)
+               return 0;
+
+       perf_pmu_migrate_context(&pmu_ptr->pmu, cpu, target);
+       cpumask_set_cpu(target, &pmu_ptr->cpu);
+       /*
+       if(pmu_ptr->irq)
+               WARN_ON(irq_set_affinity_hint(pmu_ptr->irq, &pmu_ptr->cpu) != 0);
+       */
+       return 0;
 }

 static int mmdc_event_init(struct perf_event *event)
 {
-       struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
        if (event->attr.type != event->pmu->type)
                return -ENOENT;

@@ -243,17 +237,15 @@ static int mmdc_event_init(struct perf_event *event)

 static void mmdc_event_update(struct perf_event * event)
 {
-       struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
        u32 val;
        u64 prev_val;
        prev_val = local64_read(&event->count);
-       val = mmdc_read_counter(pmu_mmdc, (int) event->attr.config, prev_val);
+       val = mmdc_read_counter((int)event->attr.config, prev_val);
        local64_add(val - (u32)(prev_val&0xFFFFFFFF) , &event->count);
 }

 static void mmdc_event_start(struct perf_event *event, int flags)
 {
-       struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
        void __iomem *mmdc_base, *reg;

        local64_set(&event->count, 0);
@@ -268,7 +260,6 @@ static void mmdc_event_start(struct perf_event *event, int flags)

 static int mmdc_event_add(struct perf_event *event, int flags)
 {
-       struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
        int cfg = (int)event->attr.config;
        if (cfg >= 1 && cfg <= MMDC_NUM_COUNTERS)
                pmu_mmdc->mmdc_events[cfg - 1] = event;
@@ -279,7 +270,6 @@ static int mmdc_event_add(struct perf_event *event, int flags)

 static void mmdc_event_stop(struct perf_event *event, int flags)
 {
-       struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
        void __iomem *mmdc_base, *reg;
        int cfg = (int)event->attr.config;

@@ -300,7 +290,7 @@ static void mmdc_event_del(struct perf_event *event, int flags)
        mmdc_event_stop(event, PERF_EF_UPDATE);
 }

-static void mmdc_overflow_handler(struct mmdc_pmu *pmu_mmdc)
+static void mmdc_overflow_handler(void)
 {
        int i;
        u32 val;
@@ -312,7 +302,7 @@ static void mmdc_overflow_handler(struct mmdc_pmu *pmu_mmdc)
                if (event)
                {
                        prev_val = local64_read(&event->count);
-                       val = mmdc_read_counter(pmu_mmdc, i + 1, prev_val);
+                       val = mmdc_read_counter(i + 1, prev_val);
                        local64_add(val - (u32)(prev_val&0xFFFFFFFF) , &event->count);
                }
        }
@@ -320,16 +310,13 @@ static void mmdc_overflow_handler(struct mmdc_pmu *pmu_mmdc)

 static enum hrtimer_restart mmdc_timer_handler(struct hrtimer *hrtimer)
 {
-       struct mmdc_pmu *pmu_mmdc = container_of(hrtimer, struct mmdc_pmu,
-                       hrtimer);
-
-       mmdc_overflow_handler(pmu_mmdc);
+       mmdc_overflow_handler();

        hrtimer_forward_now(hrtimer, mmdc_timer_period());
        return HRTIMER_RESTART;
 }

-static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc, void __iomem *mmdc_base, struct device *dev)
+static int mmdc_pmu_init(void __iomem *mmdc_base, struct device *dev)
 {
        int mmdc_num;
        *pmu_mmdc = (struct mmdc_pmu) {
@@ -347,12 +334,9 @@ static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc, void __iomem *mmdc_base, str
        };

        mmdc_num = ida_simple_get(&mmdc_ida, 0, 0, GFP_KERNEL);
-
+
        cpumask_set_cpu(smp_processor_id(), &pmu_mmdc->cpu);

-       pmu_mmdc->cpu_nb.notifier_call = mmdc_cpu_notifier;
-       pmu_mmdc->cpu_nb.priority = CPU_PRI_PERF + 1;
-
        pmu_mmdc->dev = dev;
        return mmdc_num;
 }
@@ -361,11 +345,11 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 {
        struct device_node *np = pdev->dev.of_node;
        void __iomem *mmdc_base, *reg;
-       struct mmdc_pmu *pmu_mmdc;
        char * name;
        u32 val;
-       int timeout = 0x400;
+       int timeout = 0x800;
        int mmdc_num;
+       int err;

        mmdc_base = of_iomap(np, 0);
        WARN_ON(!mmdc_base);
@@ -390,7 +374,7 @@ static int imx_mmdc_probe(struct platform_device *pdev)
        if (unlikely(!timeout)) {
                pr_warn("%s: failed to enable automatic power saving\n",
                        __func__);
-               return -EBUSY;
+               //return -EBUSY;
        }
        pmu_mmdc = kzalloc(sizeof(*pmu_mmdc), GFP_KERNEL);

@@ -398,12 +382,18 @@ static int imx_mmdc_probe(struct platform_device *pdev)
                pr_err("failed to allocate PMU device!\n");
                return -ENOMEM;
        }
-       mmdc_num = mmdc_pmu_init(pmu_mmdc, mmdc_base, &pdev->dev);
+       mmdc_num = mmdc_pmu_init(mmdc_base, &pdev->dev);
        dev_info(pmu_mmdc->dev, "No access to interrupts, using timer.\n");
        hrtimer_init(&pmu_mmdc->hrtimer, CLOCK_MONOTONIC,
                        HRTIMER_MODE_REL);
        pmu_mmdc->hrtimer.function = mmdc_timer_handler;
-       register_cpu_notifier(&pmu_mmdc->cpu_nb);
+
+       err = cpuhp_setup_state(CPUHP_AP_PERF_ARM_MMDC_ONLINE,
+                               "AP_PERF_ARM_MMDC_ONLINE", NULL,
+                               mmdc_cpu_offline);
+       if(err)
+               goto error_cpu_notifier;
+
        if (mmdc_num == 0) {
                name = "mmdc";
        } else {
@@ -413,12 +403,19 @@ static int imx_mmdc_probe(struct platform_device *pdev)
        }
        platform_set_drvdata(pdev, pmu_mmdc);
        perf_pmu_register(&(pmu_mmdc->pmu), name, -1);
+
+       dev_info(pmu_mmdc->dev, "%s success\n",__func__);
+
        return 0;
+
+error_cpu_notifier:
+       cpuhp_remove_state_nocalls(CPUHP_AP_PERF_ARM_MMDC_ONLINE);
+       kfree(pmu_mmdc);
+       return err;
 }

 static int imx_mmdc_remove(struct platform_device *pdev)
 {
-       struct mmdc_pmu *pmu_mmdc = platform_get_drvdata(pdev);
        perf_pmu_unregister(&pmu_mmdc->pmu);
        kfree(pmu_mmdc);
        return 0;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 242bf53..c059342 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -86,6 +86,7 @@ enum cpuhp_state {
        CPUHP_AP_PERF_S390_SF_ONLINE,
        CPUHP_AP_PERF_ARM_CCI_ONLINE,
        CPUHP_AP_PERF_ARM_CCN_ONLINE,
+       CPUHP_AP_PERF_ARM_MMDC_ONLINE,
        CPUHP_AP_WORKQUEUE_ONLINE,
        CPUHP_AP_RCUTREE_ONLINE,
        CPUHP_AP_NOTIFY_ONLINE,
--
2.7.4


________________________________


This email and any files transmitted with it are confidential & proprietary to Zodiac Inflight Innovations. This information is intended solely for the use of the individual or entity to which it is addressed. Access or transmittal of the information contained in this e-mail, in full or in part, to any other organization or persons is not authorized.
