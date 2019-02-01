Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2A9C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:32:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4402086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BKcdrKlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4402086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qkmS+Fiffd51uleQjCR5SnJlFpIoO9cMjMC1irBkdlw=; b=BKcdrKlx8lZacH
	HA0lp6/p9/neFrYk/l/fyhuvNZQQaghbR6jJqVEf7i7dme2ehe3HbJjsf8OnDKzzLt0GbzI3XsoQs
	KkUlebA1pNKnbDkzWfFHt19CaWQw/2G1HmDeqHhLPgJXdZ9rICifhC5YwfiHuhbbSvRIxvFjnLv/m
	QqNNhvHK7lfi2kDvcn0Pgb4WW6ZTqwk7Ar/1643VwspY8KeZkQzm3G4q2dZixb/WJ6zPgEI101HHU
	Lhfn8/+JNA9q+Frqn2hqi7OaQSuAa+qqtgxs8ROLctQEiYdOTTzOav+UgXikXRHMKZOZqCs92FFLf
	HU5i2vR9Ig/8O72Xt/Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpVAz-0003UT-HR; Fri, 01 Feb 2019 09:31:57 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpVAJ-0002j9-Rn
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 09:31:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3C7715BF;
 Fri,  1 Feb 2019 01:31:14 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E37B33F71E;
 Fri,  1 Feb 2019 01:31:12 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 nm@ti.com, sboyd@kernel.org, mka@chromium.org
Subject: [PATCH v3 3/5] cpufreq: scpi: Register an Energy Model
Date: Fri,  1 Feb 2019 09:30:59 +0000
Message-Id: <20190201093101.31869-4-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201093101.31869-1-quentin.perret@arm.com>
References: <20190201093101.31869-1-quentin.perret@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_013116_308836_E90ACAAD 
X-CRM114-Status: GOOD (  12.94  )
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

Now that PM_OPP provides a helper function to estimate the power
consumed by CPUs, make sure to try and register an Energy Model (EM)
from scpi-cpufreq, hence ensuring interested subsystems (the task
scheduler, for example) can make use of that information when available.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 99449738faa4..8e77a67a8d8c 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -98,7 +98,7 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 
 static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int ret;
+	int ret, nr_opp;
 	unsigned int latency;
 	struct device *cpu_dev;
 	struct scpi_data *priv;
@@ -129,8 +129,8 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	ret = dev_pm_opp_get_opp_count(cpu_dev);
-	if (ret <= 0) {
+	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+	if (nr_opp <= 0) {
 		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret = -EPROBE_DEFER;
 		goto out_free_opp;
@@ -170,6 +170,9 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible = false;
+
+	dev_pm_opp_of_register_em(policy->cpus, nr_opp);
+
 	return 0;
 
 out_free_cpufreq_table:
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
