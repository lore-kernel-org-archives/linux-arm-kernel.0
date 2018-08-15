From: hoan.tran@amperecomputing.com (Hoan Tran)
Date: Wed, 15 Aug 2018 11:31:35 -0700
Subject: [PATCH] perf: xgene: Add CPU hotplug support
Message-ID: <1534357895-19031-1-git-send-email-hoan.tran@amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds CPU hotplug support where the PMU migrates the context to
another online CPU when its CPU is offline.

It fixes the below issue where the user does offline the CPU which is assigned
to this PMU.

Assuming, CPU0 is assigned for this PMU. When the user does offline CPU0
        [root@(none) ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
This PMU does not work anymore and shows the below error.
        [root@(none) ~]# perf stat -a -e l3c0/cycle-count/,l3c0/write/ sleep 1
        Error:
        The sys_perf_event_open() syscall returned with 19 (No such device) for event (l3c0/cycle-count/).
        /bin/dmesg may provide additional information.
        No CONFIG_PERF_EVENTS=y kernel support configured?

With this patch, when CPU0 is offline, PMU migrates to another online CPU and
works on that CPU.

Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
---
 drivers/perf/xgene_pmu.c   | 71 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0e31f13..248a3f7 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -21,6 +21,7 @@

 #include <linux/acpi.h>
 #include <linux/clk.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -130,12 +131,14 @@ struct xgene_pmu_ops {

 struct xgene_pmu {
        struct device *dev;
+       struct hlist_node node;
        int version;
        void __iomem *pcppmu_csr;
        u32 mcb_active_mask;
        u32 mc_active_mask;
        u32 l3c_active_mask;
        cpumask_t cpu;
+       int irq;
        raw_spinlock_t lock;
        const struct xgene_pmu_ops *ops;
        struct list_head l3cpmus;
@@ -1806,6 +1809,53 @@ static const struct acpi_device_id xgene_pmu_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, xgene_pmu_acpi_match);
 #endif

+static int xgene_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+       struct xgene_pmu *xgene_pmu = hlist_entry_safe(node, struct xgene_pmu,
+                                                      node);
+
+       if (cpumask_empty(&xgene_pmu->cpu))
+               cpumask_set_cpu(cpu, &xgene_pmu->cpu);
+
+       /* Overflow interrupt also should use the same CPU */
+       WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
+
+       return 0;
+}
+
+static int xgene_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+       struct xgene_pmu *xgene_pmu = hlist_entry_safe(node, struct xgene_pmu,
+                                                      node);
+       struct xgene_pmu_dev_ctx *ctx;
+       unsigned int target;
+
+       if (!cpumask_test_and_clear_cpu(cpu, &xgene_pmu->cpu))
+               return 0;
+       target = cpumask_any_but(cpu_online_mask, cpu);
+       if (target >= nr_cpu_ids)
+               return 0;
+
+       list_for_each_entry(ctx, &xgene_pmu->mcpmus, next) {
+               perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target);
+       }
+       list_for_each_entry(ctx, &xgene_pmu->mcbpmus, next) {
+               perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target);
+       }
+       list_for_each_entry(ctx, &xgene_pmu->l3cpmus, next) {
+               perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target);
+       }
+       list_for_each_entry(ctx, &xgene_pmu->iobpmus, next) {
+               perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target);
+       }
+
+       cpumask_set_cpu(target, &xgene_pmu->cpu);
+       /* Overflow interrupt also should use the same CPU */
+       WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
+
+       return 0;
+}
+
 static int xgene_pmu_probe(struct platform_device *pdev)
 {
        const struct xgene_pmu_data *dev_data;
@@ -1815,6 +1865,14 @@ static int xgene_pmu_probe(struct platform_device *pdev)
        int irq, rc;
        int version;

+       /* Install a hook to update the reader CPU in case it goes offline */
+       rc = cpuhp_setup_state_multi(CPUHP_AP_PERF_XGENE_ONLINE,
+                                     "CPUHP_AP_PERF_XGENE_ONLINE",
+                                     xgene_pmu_online_cpu,
+                                     xgene_pmu_offline_cpu);
+       if (rc)
+               return rc;
+
        xgene_pmu = devm_kzalloc(&pdev->dev, sizeof(*xgene_pmu), GFP_KERNEL);
        if (!xgene_pmu)
                return -ENOMEM;
@@ -1865,6 +1923,7 @@ static int xgene_pmu_probe(struct platform_device *pdev)
                dev_err(&pdev->dev, "No IRQ resource\n");
                return -EINVAL;
        }
+
        rc = devm_request_irq(&pdev->dev, irq, xgene_pmu_isr,
                                IRQF_NOBALANCING | IRQF_NO_THREAD,
                                dev_name(&pdev->dev), xgene_pmu);
@@ -1873,6 +1932,8 @@ static int xgene_pmu_probe(struct platform_device *pdev)
                return rc;
        }

+       xgene_pmu->irq = irq;
+
        raw_spin_lock_init(&xgene_pmu->lock);

        /* Check for active MCBs and MCUs */
@@ -1883,13 +1944,11 @@ static int xgene_pmu_probe(struct platform_device *pdev)
                xgene_pmu->mc_active_mask = 0x1;
        }

-       /* Pick one core to use for cpumask attributes */
-       cpumask_set_cpu(smp_processor_id(), &xgene_pmu->cpu);
-
-       /* Make sure that the overflow interrupt is handled by this CPU */
-       rc = irq_set_affinity(irq, &xgene_pmu->cpu);
+       /* Add this instance to the list used by the hotplug callback */
+       rc = cpuhp_state_add_instance(CPUHP_AP_PERF_XGENE_ONLINE,
+                                     &xgene_pmu->node);
        if (rc) {
-               dev_err(&pdev->dev, "Failed to set interrupt affinity!\n");
+               dev_err(&pdev->dev, "Error %d registering hotplug", rc);
                return rc;
        }

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 8796ba3..afefca8a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -164,6 +164,7 @@ enum cpuhp_state {
        CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
        CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
        CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
+       CPUHP_AP_PERF_XGENE_ONLINE,
        CPUHP_AP_WORKQUEUE_ONLINE,
        CPUHP_AP_RCUTREE_ONLINE,
        CPUHP_AP_ONLINE_DYN,
--
2.7.4

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is for the sole use of the intended recipient(s) and contains information that is confidential and proprietary to Ampere Computing or its subsidiaries. It is to be used solely for the purpose of furthering the parties' business relationship. Any review, copying, or distribution of this email (or any attachments thereto) is strictly prohibited. If you are not the intended recipient, please contact the sender immediately and permanently delete the original and any copies of this email and any attachments thereto.
