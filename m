From: yong.shen@linaro.org (yong.shen at linaro.org)
Date: Thu, 17 Feb 2011 10:01:38 +0100
Subject: [PATCH v3 2/3] ARM: IMX5: cpuidle driver
In-Reply-To: <1297933299-30367-1-git-send-email-yong.shen@linaro.org>
References: <1297933299-30367-1-git-send-email-yong.shen@linaro.org>
Message-ID: <1297933299-30367-3-git-send-email-yong.shen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

implement cpuidle driver for iMX5 SOCs, leave cpuidle params to board
related code.

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/Makefile  |    1 +
 arch/arm/mach-mx5/cpuidle.c |  112 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/cpuidle.h |   25 ++++++++++
 3 files changed, 138 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx5/cpuidle.c
 create mode 100644 arch/arm/mach-mx5/cpuidle.h

diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 0d43be9..12239e0 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -7,6 +7,7 @@ obj-y   := cpu.o mm.o clock-mx51-mx53.o devices.o
 obj-$(CONFIG_SOC_IMX50) += mm-mx50.o
 
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
+obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
 obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
 obj-$(CONFIG_MACH_MX53_EVK) += board-mx53_evk.o
diff --git a/arch/arm/mach-mx5/cpuidle.c b/arch/arm/mach-mx5/cpuidle.c
new file mode 100644
index 0000000..64bfb6f
--- /dev/null
+++ b/arch/arm/mach-mx5/cpuidle.c
@@ -0,0 +1,112 @@
+/*
+ * arch/arm/mach-mx5/cpuidle.c
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/cpuidle.h>
+#include <asm/proc-fns.h>
+#include <mach/hardware.h>
+#include "cpuidle.h"
+#include "crm_regs.h"
+
+static struct mx5_cpuidle_params *mx5_cpuidle_params;
+void mx5_cpuidle_board_params(struct mx5_cpuidle_params *cpuidle_params)
+{
+	mx5_cpuidle_params = cpuidle_params;
+}
+
+static int mx5_enter_idle(struct cpuidle_device *dev,
+			       struct cpuidle_state *state)
+{
+	struct timeval before, after;
+	int idle_time;
+	u32 plat_lpc, arm_srpgcr, ccm_clpcr;
+	u32 empgc0, empgc1;
+
+	local_irq_disable();
+	do_gettimeofday(&before);
+
+	plat_lpc = __raw_readl(MXC_CORTEXA8_PLAT_LPC) &
+	    ~(MXC_CORTEXA8_PLAT_LPC_DSM);
+	ccm_clpcr = __raw_readl(MXC_CCM_CLPCR) & ~(MXC_CCM_CLPCR_LPM_MASK);
+	arm_srpgcr = __raw_readl(MXC_SRPG_ARM_SRPGCR) & ~(MXC_SRPGCR_PCR);
+	empgc0 = __raw_readl(MXC_SRPG_EMPGC0_SRPGCR) & ~(MXC_SRPGCR_PCR);
+	empgc1 = __raw_readl(MXC_SRPG_EMPGC1_SRPGCR) & ~(MXC_SRPGCR_PCR);
+
+	/* for WAIT_CLK_ON, we do nothing but cpu_do_idle() */
+	if (state == &dev->states[WAIT_CLK_OFF])
+		ccm_clpcr |= (0x1 << MXC_CCM_CLPCR_LPM_OFFSET);
+	else if (state == &dev->states[WAIT_CLK_OFF_POWER_OFF]) {
+		/* Wait unclocked, power off */
+		plat_lpc |= MXC_CORTEXA8_PLAT_LPC_DSM
+			    | MXC_CORTEXA8_PLAT_LPC_DBG_DSM;
+		arm_srpgcr |= MXC_SRPGCR_PCR;
+		ccm_clpcr |= (0x1 << MXC_CCM_CLPCR_LPM_OFFSET);
+		ccm_clpcr &= ~MXC_CCM_CLPCR_VSTBY;
+		ccm_clpcr &= ~MXC_CCM_CLPCR_SBYOS;
+		if (tzic_enable_wake(1) != 0) {
+			local_irq_enable();
+			return 0;
+		}
+	}
+
+	__raw_writel(plat_lpc, MXC_CORTEXA8_PLAT_LPC);
+	__raw_writel(ccm_clpcr, MXC_CCM_CLPCR);
+	__raw_writel(arm_srpgcr, MXC_SRPG_ARM_SRPGCR);
+
+	cpu_do_idle();
+
+	do_gettimeofday(&after);
+	local_irq_enable();
+	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
+			(after.tv_usec - before.tv_usec);
+	return idle_time;
+}
+
+static struct cpuidle_driver mx5_cpuidle_driver = {
+	.name =         "mx5_idle",
+	.owner =        THIS_MODULE,
+};
+
+static DEFINE_PER_CPU(struct cpuidle_device, mx5_cpuidle_device);
+
+static int __init mx5_cpuidle_init(void)
+{
+	struct cpuidle_device *device;
+	int i;
+
+	if (mx5_cpuidle_params == NULL) {
+		printk(KERN_ERR "mx5_cpuidle_init: no cpuidle params\n");
+		return -ENODEV;
+	}
+
+	cpuidle_register_driver(&mx5_cpuidle_driver);
+
+	device = &per_cpu(mx5_cpuidle_device, smp_processor_id());
+	device->state_count = MX5_MAX_CPUIDLE_STATE;
+
+	for (i = 0; i < MX5_MAX_CPUIDLE_STATE && i < CPUIDLE_STATE_MAX; i++) {
+		device->states[i].enter = mx5_enter_idle;
+		device->states[i].exit_latency = mx5_cpuidle_params[i].latency;
+		device->states[i].flags = CPUIDLE_FLAG_TIME_VALID;
+	}
+
+	strcpy(device->states[WAIT_CLK_ON].name, "WFI 0");
+	strcpy(device->states[WAIT_CLK_ON].desc, "Wait with clock on");
+	strcpy(device->states[WAIT_CLK_OFF].name, "WFI 1");
+	strcpy(device->states[WAIT_CLK_OFF].desc, "Wait with clock off");
+	strcpy(device->states[WAIT_CLK_OFF_POWER_OFF].name, "WFI 2");
+	strcpy(device->states[WAIT_CLK_OFF_POWER_OFF].desc,
+			"Wait with clock off and power gating");
+
+	if (cpuidle_register_device(device)) {
+		printk(KERN_ERR "mx5_cpuidle_init: Failed registering\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+late_initcall(mx5_cpuidle_init);
diff --git a/arch/arm/mach-mx5/cpuidle.h b/arch/arm/mach-mx5/cpuidle.h
new file mode 100644
index 0000000..ffd7314
--- /dev/null
+++ b/arch/arm/mach-mx5/cpuidle.h
@@ -0,0 +1,25 @@
+/*
+ * arch/arm/mach-mx5/cpuidle.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+enum {
+	WAIT_CLK_ON,		/* c1 */
+	WAIT_CLK_OFF,		/* c2 */
+	WAIT_CLK_OFF_POWER_OFF, /* c3 */
+	MX5_MAX_CPUIDLE_STATE,
+};
+
+struct mx5_cpuidle_params {
+	unsigned int latency;
+};
+
+#ifdef CONFIG_CPU_IDLE
+extern void mx5_cpuidle_board_params(struct mx5_cpuidle_params *cpuidle_params);
+#else
+inline void mx5_cpuidle_board_params(struct mx5_cpuidle_params *cpuidle_params)
+{}
+#endif
-- 
1.7.1
