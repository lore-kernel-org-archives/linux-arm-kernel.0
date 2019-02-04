Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB7BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:21:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9395207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q8LuYZGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9395207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5udqQ9ovsZ7LF5H6n7uPHziqY4GcdL0p/ecT+q9D6vc=; b=Q8LuYZGkYbd1br
	E8zsQHUhurTSK8ZN+oGUtkctzbA3rFywUr1GDfxpc5ckyil+3HVC+JfIbqtBxz2cLoMft+Ix8JVJx
	u3PvoLBE2zIHyLRNy5iPJ540zKUtcFzmsljD+wxO9YHN9wM/Ci8zgnM3TQSoq74nN+d+GiHZkY9Dk
	BzlKapdsMzSuwl+kPfQG1s0awbdwP3Xxihi/1xJDnbHLi+e7frnguJ1DUdPjE/MP/nfmFGL1HfArQ
	J0zCwh6hJM6D2TFf1MoXaoBw/vgIBVvvf/wjOSuiQP3sKl5m1h1Djj+rTZ6LrYcxOv8ttxeYDH9Cl
	fjLqJC8mHyn/X/RzahfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqcJu-0000Uu-DT; Mon, 04 Feb 2019 11:21:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqc8g-0000LY-DS
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 11:10:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0E40A78;
 Mon,  4 Feb 2019 03:10:07 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E05683F675;
 Mon,  4 Feb 2019 03:10:05 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 nm@ti.com, sboyd@kernel.org, mka@chromium.org
Subject: [PATCH v4 4/5] cpufreq: arm_big_little: Register an Energy Model
Date: Mon,  4 Feb 2019 11:09:51 +0000
Message-Id: <20190204110952.16025-5-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204110952.16025-1-quentin.perret@arm.com>
References: <20190204110952.16025-1-quentin.perret@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_031010_743806_81E64E2C 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: quentin.perret@arm.com, dietmar.eggemann@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Now that PM_OPP provides a helper function to estimate the power
consumed by CPUs, make sure to try and register an Energy Model (EM)
from the arm_big_little CPUFreq driver, hence ensuring interested
subsystems (the task scheduler, for example) can make use of that
information when available.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/arm_big_little.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index cf62a1f64dd7..7fe52fcddcf1 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -487,6 +487,8 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency =
 				arm_bL_ops->get_transition_latency(cpu_dev);
 
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
