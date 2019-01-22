Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA2C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:57:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0CF21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pa9a4eDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0CF21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jn9hSiYtBUjFzbcY+VRtmq2A712bBKf8NWM44yp7GcM=; b=Pa9a4eDPlhIf9i
	nfWVp3J+rW+9vXYkVqofubQEJ5/R+nyCoS70f8EWjaJo1qa1FlwOty8RtguOcRkWiqWEd+1PTZ6d9
	H4dcD0L4tjthrshqCgmSp4p/xVAsRfM9+q5SyfZppKOr9PWibzSh24dhJOecrfI0fbcZcdJTye2QR
	wFzY3MtVK4cY96ZTBAKXwFEaYTuFV8mMkR0w653qt8Gr5Ht6QLmNOI0tdi+oX7dVaj0rsQ28/q3DO
	ZgZ78ODZeTopHxDInOk46cXGPUjUdRvSG7PURWEDxbH/sRaZYfFQZspW5zVXmFfpLSnV84SuSXt5I
	uEbg6ZR1TFFeksyXgegA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm0Iy-00064X-FC; Tue, 22 Jan 2019 17:57:44 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm0Ij-0005gK-BE
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 17:57:30 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id F2B578125;
 Tue, 22 Jan 2019 17:57:35 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck
 reparenting
Date: Tue, 22 Jan 2019 09:57:15 -0800
Message-Id: <20190122175717.13428-2-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122175717.13428-1-tony@atomide.com>
References: <20190122175717.13428-1-tony@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_095729_425680_1C43D296 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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
Cc: Ladislav Michl <ladis@linux-mips.org>, Keerthy <j-keerthy@ti.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Sebastian Reichel <sre@kernel.org>,
 Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc") moved some omap4 timers to probe with ti-sysc
interconnect target module. Turns out this broke pwm-omap-dmtimer
where we now try to reparent the clock to itself with the following:

omap_dm_timer_of_set_source: failed to set parent

With ti-sysc, we can now configure the clock sources in the dts
with assigned-clocks and assigned-clock-parents. So we should be able
to remove omap_dm_timer_of_set_source with clean-up patches later on.
But for now, let's just fix it first by checking if parent and fck
are the same and bail out of so.

Fixes: 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc")
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
 drivers/clocksource/timer-ti-dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -154,6 +154,10 @@ static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
 	if (IS_ERR(parent))
 		return -ENODEV;
 
+	/* Bail out if both clocks point to fck */
+	if (clk_is_match(parent, timer->fclk))
+		return 0;
+
 	ret = clk_set_parent(timer->fclk, parent);
 	if (ret < 0)
 		pr_err("%s: failed to set parent\n", __func__);
-- 
2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
