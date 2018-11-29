Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9B0C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:01:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D2D21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ALroGfJn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MgMAZ/4t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPPBOHan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D2D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=d2I/cXoFtaKWfrwbPa5LBApgU87xFURcnLvfL2A0q0I=; b=ALroGfJnOpENKeudabVJ7HOupM
	NMA6yLZzsEkKC+8x2eMOTuy8qO2RV2+9Xbveed0wW68e1mRwSIVr6UF8i7+ijAWdDBXV/HO+J3QZ4
	D5eFQNs6gJDW/1ZiszA+rNzK19Yz7wTx1W5c+AIQL5mhb4sNBMIHAaUuc5y8+lhtXnulA8/WM7TZS
	5ERaEq6BeaygzIgeMZZ3X9xCkgPQ7jY0X4eV9SlcImfl4AvbLVuh3Wle6alXUYakoH1O8dFuFvuBe
	qARumuLiGPbv36OZP0C82fhb7MqtkiMcxN1QNKy2lLmOofVF7i4KzwgVFnf843hPXYo7GKXxbQTD7
	VT97xSOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQcj-00068o-06; Thu, 29 Nov 2018 18:01:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQcZ-0005tF-Cp
 for linux-arm-kernel@bombadil.infradead.org; Thu, 29 Nov 2018 18:01:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8XcXgSMicdNFExYNvXv93BQqc4PUMWszq8Q+N0PwQJQ=; b=MgMAZ/4tvqaJw8e1WJm4aCfDZ
 tuYrYKEanSROsOQMHT09hVOTCd90M+ryxRSpCVnxI8EQUDFmWs0meYOZtH/ZnnhJzhH0/FRM75paQ
 z3OaY4Gj7hX/nEO0iu0fkAdUs3UdvOJN2YhniqdsQVKlhbepe0OnBPgyXct+RVf4PzN1nB/ZkcZRE
 hyKKy3dwqyZdOrxN6Z9ihwcvD4xQZRL01t1MGr/cRKq0xhSB4EecGzg0bKZ2lMMAwYWfEtQpfin7z
 b4/Cqz8AphetwTXx2eiM7+tDyd0bKHzyaD8iYHZ9ciXOgOi+x0DAH8UCXuLBI6Ti/vprGNBy1DvUA
 aub050IiQ==;
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPz-0005A0-Kc
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:48:07 +0000
Received: by mail-lf1-x144.google.com with SMTP id a16so2111504lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8XcXgSMicdNFExYNvXv93BQqc4PUMWszq8Q+N0PwQJQ=;
 b=UPPBOHaniBcnAzLge02a1Ved7MDAgwg3PT63fbQBxmWP6r7IUNmB9wBF+cpdUregbU
 YNpOhRm0kjRcXF6xnbJ01Ca2Erys97CKhH7FfDfbIj5YdHlt1zhk9sD+G18xFUEPnTeG
 o/6qnFNHOkaoXtqDBngZxRNXPyWTOoR/EGa+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8XcXgSMicdNFExYNvXv93BQqc4PUMWszq8Q+N0PwQJQ=;
 b=pn8YFPB/4WXrCerxrqMZJYoYX6LFz5cPUCyEW3wQoqvoNWE/+GHhJimgUB0ssvi4Ci
 V3hMa+azt7Id/anoDgZ5H9KoQU+BV15ELlW66yDoO1LyrQuvlfN+uxgpS4FcovxGuNNn
 kbbVWylphf/KFTdyS3Iw39ZTvW6u+OMlGA5ZbVKz0O5vdCmuyXVd9UaaMKc8NnTnRaDZ
 /ZI1TJHS+NMUknCSENAzmNaugqzufzt7hynjebMAydp5vYY5EA7K67BLw+Gt6ly+HQXF
 dJUFK+QsNQdZcXzIrGhJ15/Z0HPHdvgh1vHq4S5fD9c3y5Jo/XnGtjfJll5EzT7UJLUt
 LxAA==
X-Gm-Message-State: AA+aEWZSvWrs2esA3bieAC8SEjZY58tPA57yDnX/4ZGHgbXSnjrh94yM
 vU2OGqZNItRW1WHDsfeZFqrBEA==
X-Google-Smtp-Source: AFSGD/Vv4orDwR+nTAJgZv7KcoNBHuFUfJ1RXoB3WL0hhWGM6CeGAm1v2qYblWtvCG+N9/GJet3jBw==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr1586183lfj.12.1543513671100; 
 Thu, 29 Nov 2018 09:47:51 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:50 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 24/27] drivers: firmware: psci: Support CPU hotplug for
 the hierarchical model
Date: Thu, 29 Nov 2018 18:46:57 +0100
Message-Id: <20181129174700.16585-25-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_174803_801587_5D7C8378 
X-CRM114-Status: GOOD (  21.69  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When the hierarchical CPU topology is used and when a CPU has been put
offline (hotplug), that same CPU prevents its PM domain and thus also
potential master PM domains, from being powered off. This is because genpd
observes the CPU's struct device to remain being active from a runtime PM
point of view.

To deal with this, let's decrease the runtime PM usage count by calling
pm_runtime_put_sync_suspend() of the CPU's struct device when putting it
offline. Consequentially, we must then increase the runtime PM usage for
the CPU, while putting it online again.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Make it work when the hierarchical CPU topology is used, which may be
	  used both for OSI and PC mode.
	- Rework the code to prevent "BUG: sleeping function called from
	  invalid context".
---
 drivers/firmware/psci/psci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index b03bccce0a5d..f62c4963eb62 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -15,6 +15,7 @@
 
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
@@ -199,9 +200,20 @@ static int psci_cpu_suspend(u32 state, unsigned long entry_point)
 
 static int psci_cpu_off(u32 state)
 {
+	struct device *dev;
 	int err;
 	u32 fn;
 
+	/*
+	 * When the hierarchical CPU topology is used, decrease the runtime PM
+	 * usage count for the current CPU, as to allow other parts in the
+	 * topology to enter low power states.
+	 */
+	if (psci_dt_topology) {
+		dev = get_cpu_device(smp_processor_id());
+		pm_runtime_put_sync_suspend(dev);
+	}
+
 	fn = psci_function_id[PSCI_FN_CPU_OFF];
 	err = invoke_psci_fn(fn, state, 0, 0);
 	return psci_to_linux_errno(err);
@@ -209,6 +221,7 @@ static int psci_cpu_off(u32 state)
 
 static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 {
+	struct device *dev;
 	int err;
 	u32 fn;
 
@@ -216,6 +229,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
 	/* Clear the domain state to start fresh. */
 	psci_set_domain_state(0);
+
+	/* Increase runtime PM usage count if the hierarchical CPU toplogy. */
+	if (!err && psci_dt_topology) {
+		dev = get_cpu_device(cpuid);
+		pm_runtime_get_sync(dev);
+	}
+
 	return psci_to_linux_errno(err);
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
