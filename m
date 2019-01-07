Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94582C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:29:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C35F20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pt8cebF3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oBSETjQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C35F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9keooWcxd/DyG+zd2ubmtWx5LF9KKLt4aRsIpwbdpmE=; b=pt8cebF31KtyPR
	SfrDiFdRo15RefU3hIOuD5DZuQfgP1IWiS0owu9WiB5+T2fxtH5eXQMxdhLvcyod3K6Cx5rW+Golb
	WCbY27nsGRloi1Lkroj0HYkVJDyLQ57r4D34XmVwSn3wS+RAeG4NSm4nHbhlT06XfISXVcExbGTFf
	2gST2SFJ89rF0OWA99S1BCVjvs4itS0BORElQ/OeQQ0kfv5k6+X/QAgQ9lb+RiXUqAvhKs5lvoBsE
	JziD4hD6dQsTX7Csd1ECHZTBqe33alCTuTqU7l5tDid/wQ5zTGXUX/n+sg4QnY3iYh1DajPc3SuS8
	6lCzMCsQaOYWc++m4RFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggLb5-00008g-5Z; Mon, 07 Jan 2019 03:29:03 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggLaQ-0007uC-LZ
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 03:28:25 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c32c7440000>; Sun, 06 Jan 2019 19:28:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sun, 06 Jan 2019 19:28:20 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sun, 06 Jan 2019 19:28:20 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Jan
 2019 03:28:19 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 03:28:19 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c32c7520000>; Sun, 06 Jan 2019 19:28:19 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH 2/6] clocksource: tegra: add Tegra210 timer driver
Date: Mon, 7 Jan 2019 11:28:06 +0800
Message-ID: <20190107032810.13522-3-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107032810.13522-1-josephl@nvidia.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546831684; bh=s8IY+h9IkiprqLgYA1ZLKIoVj6hPmRxlGX95RnCfMwo=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=oBSETjQwAtSvWPL4jZQiQnPOSBAqbh3Uz+qTYENJjEhtyR5tGe91EFt1Ll65nBQJt
 KztDyryjXKbz7PADmMzV00JQ2G7SVmRRw5ZwfxyzQbsFNyS05eGLa5CrmZX2a1jF+0
 DWi3CW7D1dNQSEOt2ct2spjiG1/QhNvNjyz5Ud6n479AOe4HLjh4Cg2SNOM3XkFCsq
 xmA4u06uGcZkQORL6PIpp4TjYZEyBMSM6M/X1dZmp3xtT2H8vhetTSzr5oc6+DaE1F
 irxXfzHiYA7rAI+9oEqBWATpnMTausip4cq0n2S1bVxJU42s65TVLq3Ts4fOsecD+K
 kxTlxKMBxkveA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_192822_719819_127FA2D5 
X-CRM114-Status: GOOD (  16.11  )
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
 drivers/clocksource/Kconfig          |   3 +
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-tegra210.c | 240 +++++++++++++++++++++++++++
 include/linux/cpuhotplug.h           |   1 +
 4 files changed, 245 insertions(+)
 create mode 100644 drivers/clocksource/timer-tegra210.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a9e26f6a81a1..e6e3e64b6320 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -135,6 +135,9 @@ config TEGRA_TIMER
 	help
 	  Enables support for the Tegra driver.
 
+config TEGRA210_TIMER
+	def_bool ARCH_TEGRA_210_SOC
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
index 000000000000..d88c127d3b3b
--- /dev/null
+++ b/drivers/clocksource/timer-tegra210.c
@@ -0,0 +1,240 @@
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
+static u32 tegra210_timer_freq;
+static void __iomem *tegra210_timer_reg_base;
+static u32 usec_config;
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
+
+#define TIMER_FOR_CPU(cpu) (TIMER10_OFFSET + (cpu) * 8)
+
+struct tegra210_clockevent {
+	struct clock_event_device evt;
+	char name[20];
+	void __iomem *reg_base;
+};
+#define to_tegra_cevt(p) (container_of(p, struct tegra210_clockevent, evt))
+
+static struct tegra210_clockevent __percpu *tegra210_evt;
+
+static int tegra210_timer_set_next_event(unsigned long cycles,
+					 struct clock_event_device *evt)
+{
+	struct tegra210_clockevent *tevt;
+
+	tevt = to_tegra_cevt(evt);
+	writel(TIMER_PTV_EN |
+	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
+	       tevt->reg_base + TIMER_PTV);
+
+	return 0;
+}
+
+static inline void timer_shutdown(struct tegra210_clockevent *tevt)
+{
+	writel(0, tevt->reg_base + TIMER_PTV);
+}
+
+static int tegra210_timer_shutdown(struct clock_event_device *evt)
+{
+	struct tegra210_clockevent *tevt;
+
+	tevt = to_tegra_cevt(evt);
+	timer_shutdown(tevt);
+
+	return 0;
+}
+
+static int tegra210_timer_set_periodic(struct clock_event_device *evt)
+{
+	struct tegra210_clockevent *tevt;
+
+	tevt = to_tegra_cevt(evt);
+	writel(TIMER_PTV_EN | TIMER_PTV_PER | ((tegra210_timer_freq / HZ) - 1),
+	       tevt->reg_base + TIMER_PTV);
+
+	return 0;
+}
+
+static irqreturn_t tegra210_timer_isr(int irq, void *dev_id)
+{
+	struct tegra210_clockevent *tevt;
+
+	tevt = dev_id;
+	writel(TIMER_PCR_INTR_CLR, tevt->reg_base + TIMER_PCR);
+	tevt->evt.event_handler(&tevt->evt);
+
+	return IRQ_HANDLED;
+}
+
+static int tegra210_timer_setup(unsigned int cpu)
+{
+	struct tegra210_clockevent *tevt = per_cpu_ptr(tegra210_evt, cpu);
+
+	irq_force_affinity(tevt->evt.irq, cpumask_of(cpu));
+	enable_irq(tevt->evt.irq);
+
+	clockevents_config_and_register(&tevt->evt, tegra210_timer_freq,
+					1, /* min */
+					0x1fffffff); /* 29 bits */
+
+	return 0;
+}
+
+static int tegra210_timer_stop(unsigned int cpu)
+{
+	struct tegra210_clockevent *tevt = per_cpu_ptr(tegra210_evt, cpu);
+
+	tevt->evt.set_state_shutdown(&tevt->evt);
+	disable_irq_nosync(tevt->evt.irq);
+
+	return 0;
+}
+
+static int tegra_timer_suspend(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		void __iomem *reg_base = tegra210_timer_reg_base +
+					 TIMER_FOR_CPU(cpu);
+		writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	}
+
+	return 0;
+}
+
+static void tegra_timer_resume(void)
+{
+	writel(usec_config, tegra210_timer_reg_base + TIMERUS_USEC_CFG);
+}
+
+static struct syscore_ops tegra_timer_syscore_ops = {
+	.suspend = tegra_timer_suspend,
+	.resume = tegra_timer_resume,
+};
+
+static int __init tegra210_timer_init(struct device_node *np)
+{
+	int cpu, ret;
+	struct tegra210_clockevent *tevt;
+	struct clk *clk;
+
+	tegra210_evt = alloc_percpu(struct tegra210_clockevent);
+	if (!tegra210_evt)
+		return -ENOMEM;
+
+	tegra210_timer_reg_base = of_iomap(np, 0);
+	if (!tegra210_timer_reg_base)
+		return -ENXIO;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return -EINVAL;
+
+	clk_prepare_enable(clk);
+	tegra210_timer_freq = clk_get_rate(clk);
+
+	for_each_possible_cpu(cpu) {
+		tevt = per_cpu_ptr(tegra210_evt, cpu);
+		tevt->reg_base = tegra210_timer_reg_base + TIMER_FOR_CPU(cpu);
+		tevt->evt.irq = irq_of_parse_and_map(np, cpu);
+		if (!tevt->evt.irq) {
+			pr_err("%s: can't map IRQ for CPU%d\n",
+			       __func__, cpu);
+			return -EINVAL;
+		}
+
+		snprintf(tevt->name, ARRAY_SIZE(tevt->name),
+			 "tegra210_timer%d", cpu);
+		tevt->evt.name = tevt->name;
+		tevt->evt.cpumask = cpumask_of(cpu);
+		tevt->evt.set_next_event = tegra210_timer_set_next_event;
+		tevt->evt.set_state_shutdown = tegra210_timer_shutdown;
+		tevt->evt.set_state_periodic = tegra210_timer_set_periodic;
+		tevt->evt.set_state_oneshot = tegra210_timer_shutdown;
+		tevt->evt.tick_resume = tegra210_timer_shutdown;
+		tevt->evt.features = CLOCK_EVT_FEAT_PERIODIC |
+			CLOCK_EVT_FEAT_ONESHOT;
+		tevt->evt.rating = 460;
+
+		irq_set_status_flags(tevt->evt.irq, IRQ_NOAUTOEN);
+		ret = request_irq(tevt->evt.irq, tegra210_timer_isr,
+				  IRQF_TIMER | IRQF_NOBALANCING,
+				  tevt->name, tevt);
+		if (ret) {
+			pr_err("%s: cannot setup irq %d for CPU%d\n",
+				__func__, tevt->evt.irq, cpu);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * Configure microsecond timers to have 1MHz clock
+	 * Config register is 0xqqww, where qq is "dividend", ww is "divisor"
+	 * Uses n+1 scheme
+	 */
+	switch (tegra210_timer_freq) {
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
+		return -EINVAL;
+	}
+
+	writel(usec_config, tegra210_timer_reg_base + TIMERUS_USEC_CFG);
+
+	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
+			  "AP_TEGRA_TIMER_STARTING", tegra210_timer_setup,
+			  tegra210_timer_stop);
+
+	register_syscore_ops(&tegra_timer_syscore_ops);
+
+	return 0;
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
