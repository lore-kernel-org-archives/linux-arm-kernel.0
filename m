From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Sep 2011 23:17:47 +0800
Subject: [PATCH v2 3/3] ARM: CSR: PM: add sleep entry for SiRFprimaII
In-Reply-To: <1316618267-4348-1-git-send-email-21cnbao@gmail.com>
References: <1316618267-4348-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1316618267-4348-4-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

This patch adds suspend-to-mem support for prima2. It will make prima2
enter DEEPSLEEP mode while accepting PM_SUSPEND_MEM command.

Signed-off-by: Rongjun Ying <baohua.song@csr.com>
Signed-off-by: Barry Song <baohua.song@csr.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
-v2:
 don't call l2x0_of_init after resuming as Shawn's patch[1] seems
 not to be applied;
 Since people still need some time to figure out the best way for l2
 resume, we move the l2 re-init to bootloader for the moment to keep
 things go ahead.

 arch/arm/mach-prima2/Makefile |    1 +
 arch/arm/mach-prima2/pm.c     |  149 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-prima2/pm.h     |   31 +++++++++
 arch/arm/mach-prima2/sleep.S  |   64 ++++++++++++++++++
 4 files changed, 245 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-prima2/pm.c
 create mode 100644 arch/arm/mach-prima2/pm.h
 create mode 100644 arch/arm/mach-prima2/sleep.S

diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index f49d70b..13dd160 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -6,3 +6,4 @@ obj-y += prima2.o
 obj-y += rtciobrg.o
 obj-$(CONFIG_DEBUG_LL) += lluart.o
 obj-$(CONFIG_CACHE_L2X0) += l2x0.o
+obj-$(CONFIG_SUSPEND) += pm.o sleep.o
diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
new file mode 100644
index 0000000..0ba39f3
--- /dev/null
+++ b/arch/arm/mach-prima2/pm.c
@@ -0,0 +1,149 @@
+/*
+ * power management entry for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <linux/rtc/sirfsoc_rtciobrg.h>
+#include <asm/suspend.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include "pm.h"
+
+/*
+ * suspend asm codes will access these to make DRAM become self-refresh and
+ * system sleep
+ */
+u32 sirfsoc_pwrc_base;
+void __iomem *sirfsoc_memc_base;
+
+static void sirfsoc_set_wakeup_source(void)
+{
+	u32 pwr_trigger_en_reg;
+	pwr_trigger_en_reg = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
+		SIRFSOC_PWRC_TRIGGER_EN);
+#define X_ON_KEY_B (1 << 0)
+	sirfsoc_rtc_iobrg_writel(pwr_trigger_en_reg | X_ON_KEY_B,
+		sirfsoc_pwrc_base + SIRFSOC_PWRC_TRIGGER_EN);
+}
+
+static void sirfsoc_set_sleep_mode(u32 mode)
+{
+	u32 sleep_mode = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
+		SIRFSOC_PWRC_PDN_CTRL);
+	sleep_mode &= ~(SIRFSOC_SLEEP_MODE_MASK << 1);
+	sleep_mode |= mode << 1;
+	sirfsoc_rtc_iobrg_writel(sleep_mode, sirfsoc_pwrc_base +
+		SIRFSOC_PWRC_PDN_CTRL);
+}
+
+static int sirfsoc_pre_suspend_power_off(void)
+{
+	u32 wakeup_entry = virt_to_phys(cpu_resume);
+
+	sirfsoc_rtc_iobrg_writel(wakeup_entry, sirfsoc_pwrc_base +
+		SIRFSOC_PWRC_SCRATCH_PAD1);
+
+	sirfsoc_set_wakeup_source();
+
+	sirfsoc_set_sleep_mode(SIRFSOC_DEEP_SLEEP_MODE);
+
+	return 0;
+}
+
+static int sirfsoc_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_MEM:
+		sirfsoc_pre_suspend_power_off();
+
+		outer_flush_all();
+		outer_disable();
+		/* go zzz */
+		cpu_suspend(0, sirfsoc_finish_suspend);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct platform_suspend_ops sirfsoc_pm_ops = {
+	.enter = sirfsoc_pm_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+static int __init sirfsoc_pm_init(void)
+{
+	suspend_set_ops(&sirfsoc_pm_ops);
+	return 0;
+}
+late_initcall(sirfsoc_pm_init);
+
+static const struct of_device_id pwrc_ids[] = {
+	{ .compatible = "sirf,prima2-pwrc" },
+	{}
+};
+
+static int __init sirfsoc_of_pwrc_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, pwrc_ids);
+	if (!np)
+		panic("unable to find compatible pwrc node in dtb\n");
+
+	/*
+	 * pwrc behind rtciobrg is not located in memory space
+	 * though the property is named reg. reg only means base
+	 * offset for pwrc. then of_iomap is not suitable here.
+	 */
+	if (of_property_read_u32(np, "reg", &sirfsoc_pwrc_base))
+		panic("unable to find base address of pwrc node in dtb\n");
+
+	of_node_put(np);
+
+	return 0;
+}
+postcore_initcall(sirfsoc_of_pwrc_init);
+
+static const struct of_device_id memc_ids[] = {
+	{ .compatible = "sirf,prima2-memc" },
+	{}
+};
+
+static int __devinit sirfsoc_memc_probe(struct platform_device *op)
+{
+	struct device_node *np = op->dev.of_node;
+
+	sirfsoc_memc_base = of_iomap(np, 0);
+	if (!sirfsoc_memc_base)
+		panic("unable to map memc registers\n");
+
+	return 0;
+}
+
+static struct platform_driver sirfsoc_memc_driver = {
+	.probe		= sirfsoc_memc_probe,
+	.driver = {
+		.name = "sirfsoc-memc",
+		.owner = THIS_MODULE,
+		.of_match_table	= memc_ids,
+	},
+};
+
+static int __init sirfsoc_memc_init(void)
+{
+	return platform_driver_register(&sirfsoc_memc_driver);
+}
+postcore_initcall(sirfsoc_memc_init);
diff --git a/arch/arm/mach-prima2/pm.h b/arch/arm/mach-prima2/pm.h
new file mode 100644
index 0000000..aa2b428
--- /dev/null
+++ b/arch/arm/mach-prima2/pm.h
@@ -0,0 +1,31 @@
+/*
+ * arch/arm/mach-prima2/pm.h
+ *
+ * Copyright (C) 2011 CSR
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _MACH_PRIMA2_PM_H_
+#define _MACH_PRIMA2_PM_H_
+
+#define SIRFSOC_PWR_SLEEPFORCE		0x01
+
+#define SIRFSOC_SLEEP_MODE_MASK         0x3
+#define SIRFSOC_DEEP_SLEEP_MODE         0x1
+
+#define SIRFSOC_PWRC_PDN_CTRL           0x0
+#define SIRFSOC_PWRC_PON_OFF            0x4
+#define SIRFSOC_PWRC_TRIGGER_EN         0x8
+#define SIRFSOC_PWRC_PIN_STATUS         0x14
+#define SIRFSOC_PWRC_SCRATCH_PAD1       0x18
+#define SIRFSOC_PWRC_SCRATCH_PAD2       0x1C
+
+#ifndef __ASSEMBLY__
+extern int sirfsoc_finish_suspend(unsigned long);
+#endif
+
+#endif
+
diff --git a/arch/arm/mach-prima2/sleep.S b/arch/arm/mach-prima2/sleep.S
new file mode 100644
index 0000000..0745abc
--- /dev/null
+++ b/arch/arm/mach-prima2/sleep.S
@@ -0,0 +1,64 @@
+/*
+ * sleep mode for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+#include <asm/assembler.h>
+
+#include "pm.h"
+
+#define DENALI_CTL_22_OFF	0x58
+#define DENALI_CTL_112_OFF	0x1c0
+
+	.text
+
+ENTRY(sirfsoc_finish_suspend)
+	@ r5: 	mem controller
+	ldr     r0, =sirfsoc_memc_base
+	ldr	r5, [r0]
+	@ r6: 	pwrc base offset
+	ldr     r0, =sirfsoc_pwrc_base
+	ldr	r6, [r0]
+	@ r7: 	rtc iobrg controller
+	ldr     r0, =sirfsoc_rtciobrg_base
+	ldr	r7, [r0]
+
+	@ Read the power control register and set the
+	@ sleep force bit.
+	add	r0, r6, #SIRFSOC_PWRC_PDN_CTRL
+	bl	__sirfsoc_rtc_iobrg_readl
+	orr	r0,r0,#SIRFSOC_PWR_SLEEPFORCE
+	add	r1, r6, #SIRFSOC_PWRC_PDN_CTRL
+	bl	sirfsoc_rtc_iobrg_pre_writel
+	mov	r1, #0x1
+
+	@ read the MEM ctl register and set the self
+	@ refresh bit
+
+	ldr	r2, [r5, #DENALI_CTL_22_OFF]
+	orr	r2, r2, #0x1
+
+	@ Following code has to run from cache since
+	@ the RAM is going to self refresh mode
+	.align 5
+	str	r2, [r5, #DENALI_CTL_22_OFF]
+
+1:
+	ldr	r4, [r5, #DENALI_CTL_112_OFF]
+	tst	r4, #0x1
+	bne	1b
+
+	@ write SLEEPFORCE through rtc iobridge
+
+	str	r1, [r7]
+	@ wait rtc io bridge sync
+1:
+	ldr	r3, [r7]
+	tst	r3, #0x01
+	bne	1b
+	b .
-- 
1.7.0.4
