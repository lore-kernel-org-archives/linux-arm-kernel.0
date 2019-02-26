Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0282C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:55:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660EA20C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W24BqrS+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJhdwSZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660EA20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=b0MWrpu4Dy4df8GBNhuUQL7vQovMCIu0bxUcMm7GTeo=; b=W24BqrS+tdHSuG44kO3JXWJw9F
	kVKoL1g0eGg/N29M8cWjJ1/vsNGX5AfjJ3U/lfFGVApYETswU8dd7gzDb6Kw12zIIUxz0JqdMrfdO
	5rdQXNI8jVp3+fIt3ymt9GA0UHjy1HrNdPWPVoLBq3ZcRcasga6GHpsedPyHmYKuZe0fSvmIw/He9
	NCP+/9kXsW8/6Bff/xeeATPDL//RWIVseWyvomr9TRQzamyItvmLiaGZWoZsTwJ0hDkjJnENVaRCp
	N8/UxqoR8NsaG8v5XqEQRzTrR2kg3DaEH4AOtmb0TmaeF61FgWN8hRxMQBeNDpKbDoNlWkwBk7jmG
	qF7bxiBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gye99-0007tb-4O; Tue, 26 Feb 2019 14:55:51 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gye80-0005Pc-G6
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:54:44 +0000
Received: by mail-lj1-x241.google.com with SMTP id z20so11005325ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QFP37LMPbDEXb2WSHVoMAA8Lx3svlyaybruT2DgQlU0=;
 b=fJhdwSZT64oym87C1NPWYsxIEnup9PjcSrF5GkbD0dEkILjToBgGvkqSO1yuzAVcuY
 IwBVw3Zw38so85Mizik5Mbqonnymp5nRCUSAeVjgZe95R69zBRpRgVtL24+ppEzUedoB
 NpydwEpWMQecOd+BSrS93JvO1fV6wtFgLmZWITK7ROpK+jMaic+PXJolJziV/BwlXTzX
 46B54oWIwMLMFkGtSgKTYVr9lZwnOlZciD2cQ2YKRrdsNPOE3vDQUKLzNfiAsaxGEY0K
 d4e3kfGe1XkyNlfUhSKLa0rGM+V8qMLWduf0o4coYslRwFKe7cLZOi2CAdNUg62Of95u
 7oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QFP37LMPbDEXb2WSHVoMAA8Lx3svlyaybruT2DgQlU0=;
 b=TYosv/DA13NFkIsP08hzaR4yTWga1LHJNVhj63kWo2IX+NhCfwtsnwl1V3dBDojuoO
 IGmRWVdKLLr7nO2BSo8P6tSGlD7WsVgkIHSHkeFVkxKBicV4CzTpoy5mzVZojrmFQfS+
 kEb3NxIw57FAgp8OWnJdXwP8taHu6kgGHbfs3iu1z7a9DAse5jeDX166vdLrCPczTlIM
 OVAX6QvOpeGlSs1v/Np8WiSjPOtBQks8QHgWbcigJEB2q9bCOkPVxTFdnvOgM8VBqNYg
 ga8PKw1eNOmsGpW8OWjugyc34PvYp/W/ewecvXFPW8qb/3eMfPTlqlB1TXV+Mu1wP0cm
 nNZQ==
X-Gm-Message-State: AHQUAubR2YbdEwkNmfeB/RS0eZnpllB1GTuz+9J/rCP4GW75Uh4C56mh
 nLfVpoVQo05SU2mf0ZSqKSOs6g==
X-Google-Smtp-Source: AHgI3IZoxyPbTSnljzQM1jRy5kabLjUHxsOiMNs290/aMYRRyMHraw0tJ9QXBiD8tu67oy3ls34hDA==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr9516998ljk.92.1551192878914;
 Tue, 26 Feb 2019 06:54:38 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 06:54:38 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 5/8] cpuidle: teo: Convert to tick_nohz_get_next_timer()
Date: Tue, 26 Feb 2019 15:54:12 +0100
Message-Id: <20190226145415.19411-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_065440_612308_26275959 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-arm-msm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

Rather than using tick_nohz_get_sleep_length(), let's convert to use the
more flexible tick_nohz_get_next_timer|hrtimer() APIs. This should have no
functional change, but allows following changes to later drop the
tick_nohz_get_sleep_length() API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[Ulf: Clarified information in changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 drivers/cpuidle/governors/teo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 7d05efdbd3c6..bef1e95c597e 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -244,6 +244,9 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int duration_us, count;
 	int max_early_idx, idx, i;
 	ktime_t delta_tick;
+	ktime_t now = ktime_get();
+	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
+	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (cpu_data->last_state >= 0) {
 		teo_update(drv, dev);
@@ -252,7 +255,8 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	cpu_data->time_span_ns = local_clock();
 
-	cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
+	cpu_data->sleep_length_ns = ktime_sub(next_timer, now);
+	delta_tick = ktime_sub(next_hrtimer, now);
 	duration_us = ktime_to_us(cpu_data->sleep_length_ns);
 
 	count = 0;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
