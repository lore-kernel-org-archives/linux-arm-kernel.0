Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C5C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:43:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A69220449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qDyJ+PrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A69220449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=eQV9VfYs+RfOptwsI4dBethfijSahh2I2+yMiR3c/NE=; b=qDy
	J+PrNNzI+BkrQ7ww9nuEHQZW/96uyU3FPoEndzO3xuwRbUi63fK/YeQV0kLdq/hDbUORmvk9+whmW
	k7V8cskNZ8EojzPa3aqYSfu/H/q6zKlj3hYaIbwJrErNh6bo9ZhpNTQTmjW5KjoZReFJ/IaYenE1r
	ytpj4CknfU1WOr0Sw14YyimxmMTqKccrIYv5YHnnEY/Hj1FSihjmMGD/xx/AOA7Hvbc20Tm46zhYG
	e55rlb02T2uofdzVmOwoFIB/e82azZZWL2velDNaHASdnnx5hGG8zmC481Vy2YBY/UO+DnXmLDWpu
	XwUWxAcY6W56onw3mMwUdGbVVMzKL6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwMXn-0002EL-Ru; Wed, 20 Feb 2019 07:43:51 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwMXa-00022m-TF
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 07:43:41 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 20 Feb 2019 16:43:37 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B50CA6117D;
 Wed, 20 Feb 2019 16:43:37 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 20 Feb 2019 16:43:37 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 495A640368;
 Wed, 20 Feb 2019 16:43:37 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 34994120459;
 Wed, 20 Feb 2019 16:43:37 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@kernel.org
Subject: [PATCH v3 6/9] clocksource/drivers/timer-milbeaut: Introduce timer
 for Milbeaut SoCs
Date: Wed, 20 Feb 2019 16:44:16 +0900
Message-Id: <1550648656-10929-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_234339_583375_CB90FFDE 
X-CRM114-Status: GOOD (  20.52  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add timer driver for Milbeaut SoCs series.

The timer has two 32-bit width down counters, one of which is configured
as a clockevent device and the other is configured as a clock source.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig          |   9 ++
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-milbeaut.c | 161 +++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/clocksource/timer-milbeaut.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a9e26f6..9101b8f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -634,4 +634,13 @@ config GX6605S_TIMER
 	help
 	  This option enables support for gx6605s SOC's timer.
 
+config MILBEAUT_TIMER
+	bool "Milbeaut timer driver" if COMPILE_TEST
+	depends on OF
+	depends on ARM
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  Enables the support for Milbeaut timer driver.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index cdd210f..6f2543b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
 obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
+obj-$(CONFIG_MILBEAUT_TIMER)	+= timer-milbeaut.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
 obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
new file mode 100644
index 0000000..f2019a8
--- /dev/null
+++ b/drivers/clocksource/timer-milbeaut.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Socionext Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include "timer-of.h"
+
+#define MLB_TMR_TMCSR_OFS	0x0
+#define MLB_TMR_TMR_OFS		0x4
+#define MLB_TMR_TMRLR1_OFS	0x8
+#define MLB_TMR_TMRLR2_OFS	0xc
+#define MLB_TMR_REGSZPCH	0x10
+
+#define MLB_TMR_TMCSR_OUTL	BIT(5)
+#define MLB_TMR_TMCSR_RELD	BIT(4)
+#define MLB_TMR_TMCSR_INTE	BIT(3)
+#define MLB_TMR_TMCSR_UF	BIT(2)
+#define MLB_TMR_TMCSR_CNTE	BIT(1)
+#define MLB_TMR_TMCSR_TRG	BIT(0)
+
+#define MLB_TMR_TMCSR_CSL_DIV2	0
+#define MLB_TMR_DIV_CNT		2
+
+#define MLB_TMR_SRC_CH  (1)
+#define MLB_TMR_EVT_CH  (0)
+
+#define MLB_TMR_SRC_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_SRC_CH)
+#define MLB_TMR_EVT_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_EVT_CH)
+
+#define MLB_TMR_SRC_TMCSR_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMCSR_OFS)
+#define MLB_TMR_SRC_TMR_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMR_OFS)
+#define MLB_TMR_SRC_TMRLR1_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMRLR1_OFS)
+#define MLB_TMR_SRC_TMRLR2_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMRLR2_OFS)
+
+#define MLB_TMR_EVT_TMCSR_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMCSR_OFS)
+#define MLB_TMR_EVT_TMR_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMR_OFS)
+#define MLB_TMR_EVT_TMRLR1_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMRLR1_OFS)
+#define MLB_TMR_EVT_TMRLR2_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMRLR2_OFS)
+
+#define MLB_TIMER_RATING	500
+
+static irqreturn_t mlb_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *clk = dev_id;
+	struct timer_of *to = to_timer_of(clk);
+	u32 val;
+
+	val = readl_relaxed(timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	val &= ~MLB_TMR_TMCSR_UF;
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+
+	clk->event_handler(clk);
+
+	return IRQ_HANDLED;
+}
+
+static int mlb_set_state_periodic(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
+
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+
+	writel_relaxed(to->of_clk.period, timer_of_base(to) +
+				MLB_TMR_EVT_TMRLR1_OFS);
+	val |= MLB_TMR_TMCSR_RELD | MLB_TMR_TMCSR_CNTE |
+		MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	return 0;
+}
+
+static int mlb_set_state_oneshot(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
+
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	return 0;
+}
+
+static int mlb_clkevt_next_event(unsigned long event,
+				   struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+
+	writel_relaxed(event, timer_of_base(to) + MLB_TMR_EVT_TMRLR1_OFS);
+	writel_relaxed(MLB_TMR_TMCSR_CSL_DIV2 |
+			MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_INTE |
+			MLB_TMR_TMCSR_TRG, timer_of_base(to) +
+			MLB_TMR_EVT_TMCSR_OFS);
+	return 0;
+}
+
+static int mlb_config_clock_source(struct timer_of *to)
+{
+	writel_relaxed(0, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
+	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMR_OFS);
+	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR1_OFS);
+	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR2_OFS);
+	writel_relaxed(BIT(4) | BIT(1) | BIT(0), timer_of_base(to) +
+		MLB_TMR_SRC_TMCSR_OFS);
+	return 0;
+}
+
+static int mlb_config_clock_event(struct timer_of *to)
+{
+	writel_relaxed(0, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	return 0;
+}
+
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+
+	.clkevt = {
+		.name = "mlb-clkevt",
+		.rating = MLB_TIMER_RATING,
+		.cpumask = cpu_possible_mask,
+		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_oneshot = mlb_set_state_oneshot,
+		.set_state_periodic = mlb_set_state_periodic,
+		.set_next_event = mlb_clkevt_next_event,
+	},
+
+	.of_irq = {
+		.flags = IRQF_TIMER | IRQF_IRQPOLL,
+		.handler = mlb_timer_interrupt,
+	},
+};
+
+static u64 notrace mlb_timer_sched_read(void)
+{
+	return ~readl_relaxed(timer_of_base(&to) + MLB_TMR_SRC_TMR_OFS);
+}
+
+static int __init mlb_timer_init(struct device_node *node)
+{
+	int ret;
+	unsigned long rate;
+
+	ret = timer_of_init(node, &to);
+	if (ret)
+		return ret;
+
+	rate = timer_of_rate(&to) / MLB_TMR_DIV_CNT;
+	mlb_config_clock_source(&to);
+	clocksource_mmio_init(timer_of_base(&to) + MLB_TMR_SRC_TMR_OFS,
+		node->name, rate, MLB_TIMER_RATING, 32,
+		clocksource_mmio_readl_down);
+	sched_clock_register(mlb_timer_sched_read, 32, rate);
+	mlb_config_clock_event(&to);
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 15,
+		0xffffffff);
+	return 0;
+}
+TIMER_OF_DECLARE(mlb_peritimer, "socionext,milbeaut-timer",
+		mlb_timer_init);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
