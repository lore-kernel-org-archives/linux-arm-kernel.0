Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57100C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:29:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2540D214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ry/dWHts";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Bo9wOw/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2540D214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Chc1+Y95APJRb4HZrlF7n9Ty18tsa5mUL2lQJqYd8bs=; b=Ry/dWHtszWaXnz
	UpZvxLViDy741U9IgaQcS5IlAOz39Xjm5J1i9C0rLVb+3r3QM2ncSGL8lKO5M6oUCoIeLyC9gRtTB
	dP/XqqIzcjYR072IoIkuHHUNArtvgHiM2ftaYNtQTxu7SzSYlC9hj5nIQPeyPWDLMXbwKap7KKnoS
	LT75VXyuSbbKnRdzeiVdVf0TD60YigUdgSkEBePMRT+4724zuTBxkSL2OA2J3NsCIyHOWYznvKVJ/
	6BibWr9WGiAUQ1AWmB5FFXUsb43MUxRvkJ7+eKnWSOHBM1wIHNB+yf8iHEe8onoQak/mce1Y192d0
	5E9tyEmpHjtFMJdiPhFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPi5-0006rw-ST; Tue, 29 Jan 2019 09:29:37 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPh3-000660-64
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:28:40 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c501c980000>; Tue, 29 Jan 2019 01:27:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 29 Jan 2019 01:28:32 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 29 Jan 2019 01:28:32 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:28:31 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 09:28:31 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c501cbe0003>; Tue, 29 Jan 2019 01:28:31 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V3 2/6] clocksource: tegra: add Tegra210 timer driver
Date: Tue, 29 Jan 2019 17:28:19 +0800
Message-ID: <20190129092823.24983-3-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129092823.24983-1-josephl@nvidia.com>
References: <20190129092823.24983-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548754073; bh=4x6nuXuko2c/BDlMH8AouSukGtzTKsJT0wlaaq4gsD4=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=Bo9wOw/Pfkiz+6VbZaeRj87IctMRTl0Pf0wE2hGHiMSviAzt+qRasOKdGteULRHvC
 hK8uNBwK2qjlvBTmsfqaO3M50bWcctFJ/m0e6CfdiKgpHL9O3UQ8hkJtLsEXpED36x
 c4Plc9M6h0F4uhlMDg9Tv9gcSnxrRsJ/YwgFZPNOaBPY6gDwJ8yHSTP14gUzMgApqv
 ArjbVqjp58lQ36p5XVt7I+zd+oWYsgCXYZTtP6KG4DJ/q0mMvDIevyNxRwTDCxHZS8
 dY2T7KBqbxH6Y6P4/l5OsWpBhKunRV3JboD9ZzG7nAOF5+hIxjJM6BbAoLZplhyYjN
 xrQAkEzpWUXXg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012833_693552_E2F51068 
X-CRM114-Status: GOOD (  17.10  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for the Tegra210 timer that runs at oscillator clock
(TMR10-TMR13). We need these timers to work as clock event device and to
replace the ARMv8 architected timer due to it can't survive across the
power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
source when CPU suspends in power down state.

Based on the work of Antti P Miettinen <amiettinen@nvidia.com>

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
v3:
 * use timer-of API
v2:
 * add error clean-up code
---
 drivers/clocksource/Kconfig          |   8 +
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-tegra210.c | 246 +++++++++++++++++++++++++++
 include/linux/cpuhotplug.h           |   1 +
 4 files changed, 256 insertions(+)
 create mode 100644 drivers/clocksource/timer-tegra210.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a9e26f6a81a1..059b1b3f2adb 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -135,6 +135,14 @@ config TEGRA_TIMER
 	help
 	  Enables support for the Tegra driver.
 
+config TEGRA210_TIMER
+	bool "Tegra210 timer driver"
+	default y if ARCH_TEGRA_210_SOC
+	depends on ARCH_TEGRA_210_SOC
+	select TIMER_OF
+	help
+	  Enable support for the Tegra210 driver.
+
 config VT8500_TIMER
 	bool "VT8500 timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index cdd210ff89ea..95de59c8a47b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
 obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra20.o
+obj-$(CONFIG_TEGRA210_TIMER)	+= timer-tegra210.o
 obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
diff --git a/drivers/clocksource/timer-tegra210.c b/drivers/clocksource/timer-tegra210.c
new file mode 100644
index 000000000000..7bc751c7da99
--- /dev/null
+++ b/drivers/clocksource/timer-tegra210.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014-2019, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/percpu.h>
+#include <linux/syscore_ops.h>
+
+#include "timer-of.h"
+
+#define TIMER_PTV		0x0
+#define TIMER_PTV_EN		BIT(31)
+#define TIMER_PTV_PER		BIT(30)
+#define TIMER_PCR		0x4
+#define TIMER_PCR_INTR_CLR	BIT(30)
+#define TIMERUS_CNTR_1US	0x10
+#define TIMERUS_USEC_CFG	0x14
+
+#define TIMER10_OFFSET		0x90
+#define TIMER10_IRQ_IDX		10
+
+#define TIMER_FOR_CPU(cpu) (TIMER10_OFFSET + (cpu) * 8)
+#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
+#define get_cpu_timer_reg_base(evt) 				\
+({								\
+	struct timer_of *to = to_timer_of(evt);			\
+	timer_of_base(to) + TIMER_FOR_CPU(smp_processor_id());	\
+})
+
+static u32 usec_config;
+
+static int tegra210_timer_set_next_event(unsigned long cycles,
+					 struct clock_event_device *evt)
+{
+	void __iomem *reg_base = get_cpu_timer_reg_base(evt);
+
+	writel(TIMER_PTV_EN |
+	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
+	       reg_base + TIMER_PTV);
+
+	return 0;
+}
+
+static int tegra210_timer_shutdown(struct clock_event_device *evt)
+{
+	void __iomem *reg_base = get_cpu_timer_reg_base(evt);
+
+	writel(0, reg_base + TIMER_PTV);
+
+	return 0;
+}
+
+static int tegra210_timer_set_periodic(struct clock_event_device *evt)
+{
+	void __iomem *reg_base = get_cpu_timer_reg_base(evt);
+
+	writel(TIMER_PTV_EN | TIMER_PTV_PER |
+	       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
+	       reg_base + TIMER_PTV);
+
+	return 0;
+}
+
+static irqreturn_t tegra210_timer_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	void __iomem *reg_base = get_cpu_timer_reg_base(evt);
+
+	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
+	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
+	.clkevt = {
+		.name = "tegra_timer",
+		.rating = 460,
+		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+		.set_next_event = tegra210_timer_set_next_event,
+		.set_state_shutdown = tegra210_timer_shutdown,
+		.set_state_periodic = tegra210_timer_set_periodic,
+		.set_state_oneshot = tegra210_timer_shutdown,
+		.tick_resume = tegra210_timer_shutdown,
+	},
+};
+
+static int tegra210_timer_setup(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
+
+	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
+	enable_irq(to->clkevt.irq);
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					1, /* min */
+					0x1fffffff); /* 29 bits */
+
+	return 0;
+}
+
+static int tegra210_timer_stop(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
+
+	to->clkevt.set_state_shutdown(&to->clkevt);
+	disable_irq_nosync(to->clkevt.irq);
+
+	return 0;
+}
+
+static int tegra_timer_suspend(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
+		void __iomem *reg_base = timer_of_base(to) +
+					 TIMER_FOR_CPU(cpu);
+		writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	}
+
+	return 0;
+}
+
+static void tegra_timer_resume(void)
+{
+	struct timer_of *to = this_cpu_ptr(&tegra_to);
+	writel(usec_config, timer_of_base(to) + TIMERUS_USEC_CFG);
+}
+
+static struct syscore_ops tegra_timer_syscore_ops = {
+	.suspend = tegra_timer_suspend,
+	.resume = tegra_timer_resume,
+};
+
+static int __init tegra210_timer_init(struct device_node *np)
+{
+	int cpu, ret = 0;
+	struct timer_of *to;
+
+	to = this_cpu_ptr(&tegra_to);
+	ret = timer_of_init(np, to);
+	if (ret)
+		goto out_to;
+
+	for_each_possible_cpu(cpu) {
+		struct timer_of *cpu_to;
+		cpu_to = per_cpu_ptr(&tegra_to, cpu);
+
+		cpu_to->of_base.base = timer_of_base(to);
+		cpu_to->of_clk.rate = timer_of_rate(to);
+		cpu_to->clkevt.cpumask = cpumask_of(cpu);
+
+		cpu_to->clkevt.irq =
+			irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
+		if (!cpu_to->clkevt.irq) {
+			pr_err("%s: can't map IRQ for CPU%d\n",
+			       __func__, cpu);
+			ret = -EINVAL;
+			goto out_to;
+		}
+
+		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
+		ret = request_irq(cpu_to->clkevt.irq, tegra210_timer_isr,
+				  IRQF_TIMER | IRQF_NOBALANCING,
+				  cpu_to->clkevt.name, &cpu_to->clkevt);
+		if (ret) {
+			pr_err("%s: cannot setup irq %d for CPU%d\n",
+				__func__, cpu_to->clkevt.irq, cpu);
+			ret = -EINVAL;
+			goto out_irq;
+		}
+	}
+
+	/*
+	 * Configure microsecond timers to have 1MHz clock
+	 * Config register is 0xqqww, where qq is "dividend", ww is "divisor"
+	 * Uses n+1 scheme
+	 */
+	switch (timer_of_rate(to)) {
+	case 12000000:
+		usec_config = 0x000b; /* (11+1)/(0+1) */
+		break;
+	case 12800000:
+		usec_config = 0x043f; /* (63+1)/(4+1) */
+		break;
+	case 13000000:
+		usec_config = 0x000c; /* (12+1)/(0+1) */
+		break;
+	case 16800000:
+		usec_config = 0x0453; /* (83+1)/(4+1) */
+		break;
+	case 19200000:
+		usec_config = 0x045f; /* (95+1)/(4+1) */
+		break;
+	case 26000000:
+		usec_config = 0x0019; /* (25+1)/(0+1) */
+		break;
+	case 38400000:
+		usec_config = 0x04bf; /* (191+1)/(4+1) */
+		break;
+	case 48000000:
+		usec_config = 0x002f; /* (47+1)/(0+1) */
+		break;
+	default:
+		ret = -EINVAL;
+		goto out_irq;
+	}
+
+	writel(usec_config, timer_of_base(to) + TIMERUS_USEC_CFG);
+
+	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
+			  "AP_TEGRA_TIMER_STARTING", tegra210_timer_setup,
+			  tegra210_timer_stop);
+
+	register_syscore_ops(&tegra_timer_syscore_ops);
+
+	return ret;
+
+out_irq:
+	for_each_possible_cpu(cpu) {
+		struct timer_of *cpu_to;
+		cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		if (cpu_to->clkevt.irq) {
+			free_irq(cpu_to->clkevt.irq, &cpu_to->clkevt);
+			irq_dispose_mapping(cpu_to->clkevt.irq);
+		}
+	}
+out_to:
+	timer_of_cleanup(to);
+
+	return ret;
+}
+
+TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_timer_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index fd586d0301e7..e78281d07b70 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -121,6 +121,7 @@ enum cpuhp_state {
 	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
+	CPUHP_AP_TEGRA_TIMER_STARTING,
 	CPUHP_AP_ARMADA_TIMER_STARTING,
 	CPUHP_AP_MARCO_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
