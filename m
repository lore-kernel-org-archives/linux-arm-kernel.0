From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Tue,  1 Mar 2011 21:17:13 +0800
Subject: [PATCH 2/3] arm: pmu: support pmu irq routed from CTI
In-Reply-To: <1298985434-3009-1-git-send-email-tom.leiming@gmail.com>
References: <1298985434-3009-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <1298985434-3009-3-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <tom.leiming@gmail.com>

This patch introduces pmu_platform_data struct to
support pmu irq routed from CTI, such as implemented
on OMAP4.

Generally speaking, clearing cti irq should be done in
irq handler, also enabling cti module after calling
request_irq and disabling cti module before calling
free_irq.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/include/asm/pmu.h   |   12 ++++++++++
 arch/arm/kernel/perf_event.c |   51 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 8ccea012..afb879e 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -12,11 +12,23 @@
 #ifndef __ARM_PMU_H__
 #define __ARM_PMU_H__
 
+#include <asm/cti.h>
+
 enum arm_pmu_type {
 	ARM_PMU_DEVICE_CPU	= 0,
 	ARM_NUM_PMU_DEVICES,
 };
 
+#define MAX_CTI_NUM  4
+/*If the irq of pmu is routed from CTI, the pmu_platfrom_data
+ * instance must be passed to pmu driver via platform_data of
+ * platform_devic.dev*/
+struct pmu_platform_data {
+	int use_cti_irq;
+	int cti_cnt;
+	struct cti cti[MAX_CTI_NUM];
+};
+
 #ifdef CONFIG_CPU_HAS_PMU
 
 /**
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index d150ad1..85791b0 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -377,10 +377,38 @@ validate_group(struct perf_event *event)
 	return 0;
 }
 
+static inline int cti_irq(struct pmu_platform_data *data)
+{
+	return data && data->use_cti_irq;
+}
+
+static inline struct cti *irq_to_cti(struct pmu_platform_data *data,
+	int irq)
+{
+	int idx;
+
+	for(idx = 0; idx < data->cti_cnt; idx++)
+		if (data->cti[idx].irq == irq)
+			return &data->cti[idx];
+	return NULL;
+}
+
+static inline irqreturn_t armpmu_handle_irq(int irq_num, void *dev)
+{
+	struct pmu_platform_data *data = dev;
+
+	if (cti_irq(data))
+		cti_irq_ack(irq_to_cti(data, irq_num));
+
+	return armpmu->handle_irq(irq_num, NULL);
+}
+
+
 static int
 armpmu_reserve_hardware(void)
 {
 	int i, err = -ENODEV, irq;
+	struct pmu_platform_data *data;
 
 	pmu_device = reserve_pmu(ARM_PMU_DEVICE_CPU);
 	if (IS_ERR(pmu_device)) {
@@ -395,26 +423,31 @@ armpmu_reserve_hardware(void)
 		return -ENODEV;
 	}
 
+	data = pmu_device->dev.platform_data;
 	for (i = 0; i < pmu_device->num_resources; ++i) {
 		irq = platform_get_irq(pmu_device, i);
 		if (irq < 0)
 			continue;
 
-		err = request_irq(irq, armpmu->handle_irq,
+		err = request_irq(irq, armpmu_handle_irq,
 				  IRQF_DISABLED | IRQF_NOBALANCING,
-				  "armpmu", NULL);
+				  "armpmu", data);
 		if (err) {
 			pr_warning("unable to request IRQ%d for ARM perf "
 				"counters\n", irq);
 			break;
-		}
+		} else if (cti_irq(data))
+			cti_enable(irq_to_cti(data, irq));
 	}
 
 	if (err) {
 		for (i = i - 1; i >= 0; --i) {
 			irq = platform_get_irq(pmu_device, i);
-			if (irq >= 0)
-				free_irq(irq, NULL);
+			if (irq >= 0) {
+				if (cti_irq(data))
+					cti_enable(irq_to_cti(data, irq));
+				free_irq(irq, data);
+			}
 		}
 		release_pmu(pmu_device);
 		pmu_device = NULL;
@@ -427,11 +460,15 @@ static void
 armpmu_release_hardware(void)
 {
 	int i, irq;
+	struct pmu_platform_data *data = pmu_device->dev.platform_data;
 
 	for (i = pmu_device->num_resources - 1; i >= 0; --i) {
 		irq = platform_get_irq(pmu_device, i);
-		if (irq >= 0)
-			free_irq(irq, NULL);
+		if (irq >= 0) {
+			if (cti_irq(data))
+				cti_enable(irq_to_cti(data, irq));
+			free_irq(irq, data);
+		}
 	}
 	armpmu->stop();
 
-- 
1.7.3
