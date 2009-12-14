From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 14 Dec 2009 14:04:38 +0000
Subject: [PATCH 2/5] arm/oprofile: reserve the PMU when starting
In-Reply-To: <1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
Message-ID: <1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that we have access to the performance counters and
that they aren't being used by perf events or anything else.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
---
 arch/arm/oprofile/op_model_arm11_core.c |    4 +-
 arch/arm/oprofile/op_model_arm11_core.h |    4 +-
 arch/arm/oprofile/op_model_mpcore.c     |   42 ++++++++++++++++--------------
 arch/arm/oprofile/op_model_v6.c         |   33 ++++++++++++++----------
 arch/arm/oprofile/op_model_v7.c         |   30 ++++++++++++++--------
 arch/arm/oprofile/op_model_v7.h         |    4 +-
 arch/arm/oprofile/op_model_xscale.c     |   35 ++++++++++++++-----------
 7 files changed, 85 insertions(+), 67 deletions(-)

diff --git a/arch/arm/oprofile/op_model_arm11_core.c b/arch/arm/oprofile/op_model_arm11_core.c
index ad80752..ef3e265 100644
--- a/arch/arm/oprofile/op_model_arm11_core.c
+++ b/arch/arm/oprofile/op_model_arm11_core.c
@@ -132,7 +132,7 @@ static irqreturn_t arm11_pmu_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-int arm11_request_interrupts(int *irqs, int nr)
+int arm11_request_interrupts(const int *irqs, int nr)
 {
 	unsigned int i;
 	int ret = 0;
@@ -153,7 +153,7 @@ int arm11_request_interrupts(int *irqs, int nr)
 	return ret;
 }
 
-void arm11_release_interrupts(int *irqs, int nr)
+void arm11_release_interrupts(const int *irqs, int nr)
 {
 	unsigned int i;
 
diff --git a/arch/arm/oprofile/op_model_arm11_core.h b/arch/arm/oprofile/op_model_arm11_core.h
index 6f8538e..1902b99 100644
--- a/arch/arm/oprofile/op_model_arm11_core.h
+++ b/arch/arm/oprofile/op_model_arm11_core.h
@@ -39,7 +39,7 @@
 int arm11_setup_pmu(void);
 int arm11_start_pmu(void);
 int arm11_stop_pmu(void);
-int arm11_request_interrupts(int *, int);
-void arm11_release_interrupts(int *, int);
+int arm11_request_interrupts(const int *, int);
+void arm11_release_interrupts(const int *, int);
 
 #endif
diff --git a/arch/arm/oprofile/op_model_mpcore.c b/arch/arm/oprofile/op_model_mpcore.c
index 4ce0f98..f73ce87 100644
--- a/arch/arm/oprofile/op_model_mpcore.c
+++ b/arch/arm/oprofile/op_model_mpcore.c
@@ -32,6 +32,7 @@
 /* #define DEBUG */
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/sched.h>
 #include <linux/oprofile.h>
 #include <linux/interrupt.h>
@@ -43,6 +44,7 @@
 #include <mach/hardware.h>
 #include <mach/board-eb.h>
 #include <asm/system.h>
+#include <asm/pmu.h>
 
 #include "op_counter.h"
 #include "op_arm_model.h"
@@ -58,6 +60,7 @@
  * Bitmask of used SCU counters
  */
 static unsigned int scu_em_used;
+static const struct pmu_irqs *pmu_irqs;
 
 /*
  * 2 helper fns take a counter number from 0-7 (not the userspace-visible counter number)
@@ -225,33 +228,40 @@ static int em_setup_ctrs(void)
 	return 0;
 }
 
-static int arm11_irqs[] = {
-	[0]	= IRQ_EB11MP_PMU_CPU0,
-	[1]	= IRQ_EB11MP_PMU_CPU1,
-	[2]	= IRQ_EB11MP_PMU_CPU2,
-	[3]	= IRQ_EB11MP_PMU_CPU3
-};
-
 static int em_start(void)
 {
 	int ret;
 
-	ret = arm11_request_interrupts(arm11_irqs, ARRAY_SIZE(arm11_irqs));
+	pmu_irqs = reserve_pmu();
+	if (IS_ERR(pmu_irqs)) {
+		ret = PTR_ERR(pmu_irqs);
+		goto out;
+	}
+
+	ret = arm11_request_interrupts(pmu_irqs->irqs, pmu_irqs->num_irqs);
 	if (ret == 0) {
 		em_call_function(arm11_start_pmu);
 
 		ret = scu_start();
-		if (ret)
-			arm11_release_interrupts(arm11_irqs, ARRAY_SIZE(arm11_irqs));
+		if (ret) {
+			arm11_release_interrupts(pmu_irqs->irqs,
+						 pmu_irqs->num_irqs);
+		} else {
+			release_pmu(pmu_irqs);
+			pmu_irqs = NULL;
+		}
 	}
+
+out:
 	return ret;
 }
 
 static void em_stop(void)
 {
 	em_call_function(arm11_stop_pmu);
-	arm11_release_interrupts(arm11_irqs, ARRAY_SIZE(arm11_irqs));
+	arm11_release_interrupts(pmu_irqs->irqs, pmu_irqs->num_irqs);
 	scu_stop();
+	release_pmu(pmu_irqs);
 }
 
 /*
@@ -283,15 +293,7 @@ static int em_setup(void)
 	em_route_irq(IRQ_EB11MP_PMU_SCU6, 3);
 	em_route_irq(IRQ_EB11MP_PMU_SCU7, 3);
 
-	/*
-	 * Send CP15 PMU interrupts to the owner CPU.
-	 */
-	em_route_irq(IRQ_EB11MP_PMU_CPU0, 0);
-	em_route_irq(IRQ_EB11MP_PMU_CPU1, 1);
-	em_route_irq(IRQ_EB11MP_PMU_CPU2, 2);
-	em_route_irq(IRQ_EB11MP_PMU_CPU3, 3);
-
-	return 0;
+	return init_pmu();
 }
 
 struct op_arm_model_spec op_mpcore_spec = {
diff --git a/arch/arm/oprofile/op_model_v6.c b/arch/arm/oprofile/op_model_v6.c
index e468017..a22357a 100644
--- a/arch/arm/oprofile/op_model_v6.c
+++ b/arch/arm/oprofile/op_model_v6.c
@@ -19,42 +19,47 @@
 /* #define DEBUG */
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/sched.h>
 #include <linux/oprofile.h>
 #include <linux/interrupt.h>
 #include <asm/irq.h>
 #include <asm/system.h>
+#include <asm/pmu.h>
 
 #include "op_counter.h"
 #include "op_arm_model.h"
 #include "op_model_arm11_core.h"
 
-static int irqs[] = {
-#ifdef CONFIG_ARCH_OMAP2
-	3,
-#endif
-#ifdef CONFIG_ARCH_BCMRING
-	IRQ_PMUIRQ, /* for BCMRING, ARM PMU interrupt is 43 */
-#endif
-#ifdef CONFIG_ARCH_PC3XX
-        IRQ_NPMUIRQ,
-#endif
-};
+static const struct pmu_irqs *pmu_irqs;
 
 static void armv6_pmu_stop(void)
 {
 	arm11_stop_pmu();
-	arm11_release_interrupts(irqs, ARRAY_SIZE(irqs));
+	arm11_release_interrupts(pmu_irqs->irqs, pmu_irqs->num_irqs);
+	release_pmu(pmu_irqs);
+	pmu_irqs = NULL;
 }
 
 static int armv6_pmu_start(void)
 {
 	int ret;
 
-	ret = arm11_request_interrupts(irqs, ARRAY_SIZE(irqs));
-	if (ret >= 0)
+	pmu_irqs = reserve_pmu();
+	if (IS_ERR(pmu_irqs)) {
+		ret = PTR_ERR(pmu_irqs);
+		goto out;
+	}
+
+	ret = arm11_request_interrupts(pmu_irqs->irqs, pmu_irqs->num_irqs);
+	if (ret >= 0) {
 		ret = arm11_start_pmu();
+	} else {
+		release_pmu(pmu_irqs);
+		pmu_irqs = NULL;
+	}
 
+out:
 	return ret;
 }
 
diff --git a/arch/arm/oprofile/op_model_v7.c b/arch/arm/oprofile/op_model_v7.c
index f20295f..9258fca 100644
--- a/arch/arm/oprofile/op_model_v7.c
+++ b/arch/arm/oprofile/op_model_v7.c
@@ -11,11 +11,14 @@
  */
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/oprofile.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/smp.h>
 
+#include <asm/pmu.h>
+
 #include "op_counter.h"
 #include "op_arm_model.h"
 #include "op_model_v7.h"
@@ -299,7 +302,7 @@ static irqreturn_t armv7_pmnc_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-int armv7_request_interrupts(int *irqs, int nr)
+int armv7_request_interrupts(const int *irqs, int nr)
 {
 	unsigned int i;
 	int ret = 0;
@@ -322,7 +325,7 @@ int armv7_request_interrupts(int *irqs, int nr)
 	return ret;
 }
 
-void armv7_release_interrupts(int *irqs, int nr)
+void armv7_release_interrupts(const int *irqs, int nr)
 {
 	unsigned int i;
 
@@ -366,12 +369,7 @@ static void armv7_pmnc_dump_regs(void)
 }
 #endif
 
-
-static int irqs[] = {
-#ifdef CONFIG_ARCH_OMAP3
-	INT_34XX_BENCH_MPU_EMUL,
-#endif
-};
+static const struct pmu_irqs *pmu_irqs;
 
 static void armv7_pmnc_stop(void)
 {
@@ -379,19 +377,29 @@ static void armv7_pmnc_stop(void)
 	armv7_pmnc_dump_regs();
 #endif
 	armv7_stop_pmnc();
-	armv7_release_interrupts(irqs, ARRAY_SIZE(irqs));
+	armv7_release_interrupts(pmu_irqs->irqs, pmu_irqs->num_irqs);
+	release_pmu(pmu_irqs);
+	pmu_irqs = NULL;
 }
 
 static int armv7_pmnc_start(void)
 {
 	int ret;
 
+	pmu_irqs = reserve_pmu();
+	if (IS_ERR(pmu_irqs))
+		return PTR_ERR(pmu_irqs);
+
 #ifdef DEBUG
 	armv7_pmnc_dump_regs();
 #endif
-	ret = armv7_request_interrupts(irqs, ARRAY_SIZE(irqs));
-	if (ret >= 0)
+	ret = armv7_request_interrupts(pmu_irqs->irqs, pmu_irqs->num_irqs);
+	if (ret >= 0) {
 		armv7_start_pmnc();
+	} else {
+		release_pmu(pmu_irqs);
+		pmu_irqs = NULL;
+	}
 
 	return ret;
 }
diff --git a/arch/arm/oprofile/op_model_v7.h b/arch/arm/oprofile/op_model_v7.h
index 0e19bcc..9ca334b 100644
--- a/arch/arm/oprofile/op_model_v7.h
+++ b/arch/arm/oprofile/op_model_v7.h
@@ -97,7 +97,7 @@
 int armv7_setup_pmu(void);
 int armv7_start_pmu(void);
 int armv7_stop_pmu(void);
-int armv7_request_interrupts(int *, int);
-void armv7_release_interrupts(int *, int);
+int armv7_request_interrupts(const int *, int);
+void armv7_release_interrupts(const int *, int);
 
 #endif
diff --git a/arch/arm/oprofile/op_model_xscale.c b/arch/arm/oprofile/op_model_xscale.c
index 724ab9c..1d34a02 100644
--- a/arch/arm/oprofile/op_model_xscale.c
+++ b/arch/arm/oprofile/op_model_xscale.c
@@ -17,12 +17,14 @@
 /* #define DEBUG */
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/sched.h>
 #include <linux/oprofile.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
 #include <asm/cputype.h>
+#include <asm/pmu.h>
 
 #include "op_counter.h"
 #include "op_arm_model.h"
@@ -33,17 +35,6 @@
 #define	PMU_RESET	(CCNT_RESET | PMN_RESET)
 #define PMU_CNT64	0x008	/* Make CCNT count every 64th cycle */
 
-/* TODO do runtime detection */
-#ifdef CONFIG_ARCH_IOP32X
-#define XSCALE_PMU_IRQ  IRQ_IOP32X_CORE_PMU
-#endif
-#ifdef CONFIG_ARCH_IOP33X
-#define XSCALE_PMU_IRQ  IRQ_IOP33X_CORE_PMU
-#endif
-#ifdef CONFIG_ARCH_PXA
-#define XSCALE_PMU_IRQ  IRQ_PMU
-#endif
-
 /*
  * Different types of events that can be counted by the XScale PMU
  * as used by Oprofile userspace. Here primarily for documentation
@@ -367,6 +358,8 @@ static irqreturn_t xscale_pmu_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static const struct pmu_irqs *pmu_irqs;
+
 static void xscale_pmu_stop(void)
 {
 	u32 pmnc = read_pmnc();
@@ -374,20 +367,30 @@ static void xscale_pmu_stop(void)
 	pmnc &= ~PMU_ENABLE;
 	write_pmnc(pmnc);
 
-	free_irq(XSCALE_PMU_IRQ, results);
+	free_irq(pmu_irqs->irqs[0], results);
+	release_pmu(pmu_irqs);
+	pmu_irqs = NULL;
 }
 
 static int xscale_pmu_start(void)
 {
 	int ret;
-	u32 pmnc = read_pmnc();
+	u32 pmnc;
+
+	pmu_irqs = reserve_pmu();
+	if (IS_ERR(pmu_irqs))
+		return PTR_ERR(pmu_irqs);
+
+	pmnc = read_pmnc();
 
-	ret = request_irq(XSCALE_PMU_IRQ, xscale_pmu_interrupt, IRQF_DISABLED,
-			"XScale PMU", (void *)results);
+	ret = request_irq(pmu_irqs->irqs[0], xscale_pmu_interrupt,
+			  IRQF_DISABLED, "XScale PMU", (void *)results);
 
 	if (ret < 0) {
 		printk(KERN_ERR "oprofile: unable to request IRQ%d for XScale PMU\n",
-			XSCALE_PMU_IRQ);
+		       pmu_irqs->irqs[0]);
+		release_pmu(pmu_irqs);
+		pmu_irqs = NULL;
 		return ret;
 	}
 
-- 
1.6.5.4
