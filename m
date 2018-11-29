Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A55C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:31:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224EE213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HNBwyIcj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qA8u7dp6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6m0EYyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224EE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rwrHprbmeB4Fxv9ofLbpFEkqqLJ7O7kMKHSxSW8kZwo=; b=HNBwyIcjrb1daNdpaCxCKiwQ+W
	8kYQGv9kv5sGf37BsgHEkN0nI70NKfyQyWR/nxvEB5N7Q71zjF2fDg9cgGzNsghSyC6YNCmCOGfzi
	jtQNQvKyQgPtP+CLcVfJHvujqBdF1khELWGaTD+VMMnlV3MOG5F2oJ5rRMv4t8/CyA4lFiCFFg2cv
	m5nNNSaIZ642AtF5JsuH4Kfq6wEVi5s2LVEjGZ2rSAJ1NLGTSG+ebK0/cf401DnqST2MJx1Wkyl7B
	ZM9Z8R9DCA3ubQvefZfR/MR4N73xk1Blp1KTI2bwmzGTxJTORqd7Sql6fnqj7zD/0KA0KNwMQMEfB
	0CEiSZ4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSR5z-00035k-2M; Thu, 29 Nov 2018 18:31:27 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSR5w-00035b-Jm
 for linux-arm-kernel@bombadil.infradead.org; Thu, 29 Nov 2018 18:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3t2vyFxKLnIeRsykykXv6/9Q0Qsu6Nz8v2F0owXov5U=; b=qA8u7dp6N6MZZbu1BYOp0ie5F
 F17OZ6S9O6GqrylAwN07+GuBl9FgwrS3HWO5Nt2/N+RtxMf+oBxs/02ljfqa2+wn6RJnvacpunvPq
 r+0Oemtp3YgrEHG7PPTNn/fCAG8gpW7aRVoAN7f2cbmjaSlbZ96ranM+7NYrFqjFYjH5DuRxS/FNz
 YmDlfzBVaDwHyQo8RiZ7Bp6ZBFDIfN4917OpV5IJf1FsMtKzua6sl7uoqCKzy9u9ZQztqnBpavibc
 rzMkrq5UVTlfyfscIq6mQcoAcSUp2LhAYK8ASzT/XRnli8LWyxXCTjxMxxvDcpvki8HQXC8k1afmw
 CEXnOy2yA==;
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPu-0003oZ-NV
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:48:00 +0000
Received: by mail-lj1-x242.google.com with SMTP id c19-v6so2531395lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3t2vyFxKLnIeRsykykXv6/9Q0Qsu6Nz8v2F0owXov5U=;
 b=E6m0EYylUq2Ibxx2zDTr+getdoAXAblt6NGSV5xnZi+anl5A9e/0htj8QZMpMF512l
 AiV1KScgBl/lv5TQptuE8nTGJrfWqH+rbUj9OP94f7ViYYpIkOCdbPfmx5cVlgvm0xTc
 KI2xBQgpTUrEt020geOSiKICiHi1PKWxfnZGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3t2vyFxKLnIeRsykykXv6/9Q0Qsu6Nz8v2F0owXov5U=;
 b=A8kOqL8wNDywty0kKUrOi4Q/fEbZUEBIxMU5dqZNZoeCIH8YEnRnkRqe+6PeWGjf7N
 mj+HPL6V4dxE976K+3wJe/FXG6b9m/phIwQ9NcrhzLuDkasA/+g1z7FgvjsbkSpwqbAe
 pykQf7J4ucal+m2WEtJipRH3aLFHbk93jTa6cZclxg3/m55OEQG+ifVKcKQUIy9Msofr
 sJZaLi9IRIhiclugnWF1VLX5sO0OjMl8yz8lg3F/N9rHZcJjpAZlhsHJaa0QHtn1Yj+H
 Jdz+tuOKaGrAwUAT9RwCBDt7ptvtjNgjilZF3DATI088qQlSHTEduhavPQRqZG/xiwr3
 gY9g==
X-Gm-Message-State: AA+aEWbwtQiZDwBhipC0BK9zkRA1kuqJUfckXWyyBhM5qupMRzf47ozA
 9KP5wr5Jtgp0aXJUYBFGQCH+4A==
X-Google-Smtp-Source: AFSGD/UWoMttAcw7++cNF/9mzFJwLwWDB8IZ1w4ykCERuAaM1HAR5F/wdmCVK3YlklPIHBfdzF9PKg==
X-Received: by 2002:a2e:1551:: with SMTP id 17-v6mr1736107ljv.68.1543513665097; 
 Thu, 29 Nov 2018 09:47:45 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:44 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 21/27] drivers: firmware: psci: Add a helper to attach a
 CPU to its PM domain
Date: Thu, 29 Nov 2018 18:46:54 +0100
Message-Id: <20181129174700.16585-22-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_124758_823214_C3E8A544 
X-CRM114-Status: GOOD (  18.08  )
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

Introduce a new PSCI DT helper function, psci_dt_attach_cpu(), which takes
a CPU number as an in-parameter and attaches the CPU's struct device to its
corresponding PM domain. Additionally, the helper prepares the CPU to be
power managed via runtime PM, which is the last step needed to enable the
interaction with the PM domain through the runtime PM callbacks.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch: Replaces "PM / Domains: Add helper functions to
	  attach/detach CPUs to/from genpd".

---
 drivers/firmware/psci/psci.h           |  1 +
 drivers/firmware/psci/psci_pm_domain.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index 05af462cc96e..fbc9980dee69 100644
--- a/drivers/firmware/psci/psci.h
+++ b/drivers/firmware/psci/psci.h
@@ -15,6 +15,7 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 int psci_dt_init_pm_domains(struct device_node *np);
 int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, u32 *psci_states);
+int psci_dt_attach_cpu(int cpu);
 #else
 static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
 #endif
diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
index 6c9d6a644c7f..b0fa7da8a0ce 100644
--- a/drivers/firmware/psci/psci_pm_domain.c
+++ b/drivers/firmware/psci/psci_pm_domain.c
@@ -12,8 +12,10 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 
@@ -367,4 +369,21 @@ int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
 
 	return 0;
 }
+
+int psci_dt_attach_cpu(int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+	int ret;
+
+	ret = dev_pm_domain_attach(dev, true);
+	if (ret)
+		return ret;
+
+	pm_runtime_irq_safe(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
 #endif
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
