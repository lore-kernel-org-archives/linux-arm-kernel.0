Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA13C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:58:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12129217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G6WGAtHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12129217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4OjO60YTv629GONfIUFGqvZOd7B5nOM+Yd3RzzYSWLw=; b=G6WGAtHT2EHqhZ
	pzpwqAUGrvvaZJW0J2yCYfQ7L5GtIi/WJz1ZcSamNghcEEY7J8cISOkb+EiA7PzQ3eV00JHU7wgB8
	RCvhzaBhTBcZ7wf6UdGPzfT2zCeNvjnG1B3AlPa0/Pc/x+3IlA770FQYTpWDRg74/GkipSXX+242M
	t9kGahdiUOKtHQWv32dM6d0l9yyn7FqNAFZyOUi+mJ73SUyVvCfdsuMT/kd9vCJDY62cu/GolgLKu
	5zKvpm3k78o3gkGyW1f8cpzPirnnXNFJzU8IyMpLUzPmfUa7+ZSCVuAR3P46TSwgoc14N43Cg/bRC
	wBNr0+anmDZBQ9MjrY8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm0JS-0006ey-FA; Tue, 22 Jan 2019 17:58:14 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm0Il-0005od-JS
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 17:57:33 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id EDE56814C;
 Tue, 22 Jan 2019 17:57:37 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] bus: ti-sysc: Fix timer handling with drop
 pm_runtime_irq_safe()
Date: Tue, 22 Jan 2019 09:57:16 -0800
Message-Id: <20190122175717.13428-3-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122175717.13428-1-tony@atomide.com>
References: <20190122175717.13428-1-tony@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_095731_679318_F7D2C6B0 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: Ladislav Michl <ladis@linux-mips.org>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Sebastian Reichel <sre@kernel.org>,
 Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Keerthy <j-keerthy@ti.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc") started producing a warning for pwm-omap-dmtimer:

WARNING: CPU: 0 PID: 77 at drivers/bus/omap_l3_noc.c:147
l3_interrupt_handler+0x2f8/0x388
44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle):
Data Access in Supervisor mode during Functional access
...
__pm_runtime_idle
omap_dm_timer_disable
pwm_omap_dmtimer_start
pwm_omap_dmtimer_enable
pwm_apply_state
pwm_vibrator_start
pwm_vibrator_play_work

This is because the timer that pwm-omap-dmtimer is using is now being
probed with ti-sysc interconnect target module instead of omap_device
and the ti-sysc quirk for SYSC_QUIRK_LEGACY_IDLE is not fully
compatible with what omap_device has been doing.

We could fix this by reverting the timer changes and have the timer
probe again with omap_device. Or we could add more quirk handling to
ti-sysc driver. But as these options don't work nicely as longer term
solutions, let's just make timers probe with ti-sysc without any
quirks.

To do this, all we need to do is remove quirks for timers for ti-sysc,
and drop the bogus pm_runtime_irq_safe() flag for timer-ti-dm.

We should not use pm_runtime_irq_safe() anyways for drivers as it will
take a permanent use count on the parent device blocking the parent
devices from idling and has been forcing ti-sysc driver to use a
quirk flag.

Note that we will move the timer data to DEBUG section later on in
clean-up patches.

Fixes: 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc")
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c             | 4 ++--
 drivers/clocksource/timer-ti-dm.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -879,10 +879,10 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("smartreflex", 0, -1, 0x38, -1, 0x00000000, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("timer", 0, 0, 0x10, 0x14, 0x00000015, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
+		   0),
 	/* Some timers on omap4 and later */
 	SYSC_QUIRK("timer", 0, 0, 0x10, -1, 0x4fff1301, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
+		   0),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 	/* Uarts on omap4 and later */
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -868,7 +868,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	timer->pdev = pdev;
 
 	pm_runtime_enable(dev);
-	pm_runtime_irq_safe(dev);
 
 	if (!timer->reserved) {
 		ret = pm_runtime_get_sync(dev);
-- 
2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
