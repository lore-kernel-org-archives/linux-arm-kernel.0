From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 17 Jan 2018 12:04:45 +0000
Subject: [PATCH 3/3] arm64: perf: Set PMU interrupt as NMI
In-Reply-To: <1516190685-20048-1-git-send-email-julien.thierry@arm.com>
References: <1516190685-20048-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1516190685-20048-4-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If pseudo-NMIs are supported by the kernel, treat PMU interrupt as such.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 drivers/perf/arm_pmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 40ad36f..c18d425 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -545,6 +545,7 @@ void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
 		return;
 	}

+	irq_set_irqchip_state(irq, IRQCHIP_STATE_NMI, false);
 	free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
 }

@@ -597,6 +598,7 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
 				    IRQF_NO_THREAD;
 		}

+		irq_set_irqchip_state(irq, IRQCHIP_STATE_NMI, true);
 		err = request_irq(irq, handler, irq_flags, "arm-pmu",
 				  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
 	}
@@ -609,6 +611,7 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)

 err_out:
 	pr_err("unable to request IRQ%d for ARM PMU counters\n", irq);
+	irq_set_irqchip_state(irq, IRQCHIP_STATE_NMI, false);
 	return err;
 }

@@ -650,6 +653,7 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
 	irq = armpmu_get_cpu_irq(pmu, cpu);
 	if (irq) {
 		if (irq_is_percpu_devid(irq)) {
+			irq_set_irqchip_state(irq, IRQCHIP_STATE_NMI, true);
 			enable_percpu_irq(irq, IRQ_TYPE_NONE);
 			return 0;
 		}
@@ -667,8 +671,10 @@ static int arm_perf_teardown_cpu(unsigned int cpu, struct hlist_node *node)
 		return 0;

 	irq = armpmu_get_cpu_irq(pmu, cpu);
-	if (irq && irq_is_percpu_devid(irq))
+	if (irq && irq_is_percpu_devid(irq)) {
 		disable_percpu_irq(irq);
+		irq_set_irqchip_state(irq, IRQCHIP_STATE_NMI, false);
+	}

 	return 0;
 }
--
1.9.1
