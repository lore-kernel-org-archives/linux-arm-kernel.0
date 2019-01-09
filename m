Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CB2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:42:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACBC205F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VYDBan+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACBC205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XGQwfUFmtsaMRNj6JvxWhRIJfIkw3juvFmfyoR/2ka4=; b=VYDBan+kqwa+v1
	zgsSP23ZTeXkRNBqtEkXrCx76NN9KkFdMdlxNSyiQiw26oU+GxLevVBHQ/6UaOCnv7vL3u2l5gOC8
	JahY+YgpH91QfxVgL2s4GPX+YlcxL8XqbU6L3CAMQIRZx4ceC7ijSgmYo7v9K2Day32f8zcENWpH5
	LJw4G+K209ZSwjF/mXXYYSQ3wZJwHaBzlumgFMY++g39vWv8mlaTLBrNibVvkBAF/nIryESXBdJW4
	y9ZWaWPHoP6psJi18dKtUgTdQ3q0s3VKMkdm9IvfaX5+GweKEoMSKkDxMxL04NQ5p+cVlLYslj+3s
	a8sp2PzHZ+9LA4YvHCAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBJw-0002jX-JZ; Wed, 09 Jan 2019 10:42:48 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBJt-0002ie-S3
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:42:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19300A78;
 Wed,  9 Jan 2019 02:42:43 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BCC33F70D;
 Wed,  9 Jan 2019 02:42:41 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: sudeep.holla@arm.com,
	rjw@rjwysocki.net,
	viresh.kumar@linaro.org
Subject: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Date: Wed,  9 Jan 2019 10:42:36 +0000
Message-Id: <20190109104236.6532-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_024245_927107_04019444 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, qais.yousef@arm.com,
 quentin.perret@arm.com, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
frequency changes to provide scale-invariant load-tracking signals to
the scheduler. However, in the slow path, it does so while specifying
the current and max frequencies in different units, hence resulting in a
broken freq_scale factor.

Fix this by passing all frequencies in KHz, as stored in the CPUFreq
frequency table.

Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
message protocol")
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 50b1551ba894..3f0693439486 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	int ret;
 	struct scmi_data *priv = policy->driver_data;
 	struct scmi_perf_ops *perf_ops = handle->perf_ops;
-	u64 freq = policy->freq_table[index].frequency * 1000;
+	u64 freq = policy->freq_table[index].frequency;
 
-	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
+	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
 	if (!ret)
 		arch_set_freq_scale(policy->related_cpus, freq,
 				    policy->cpuinfo.max_freq);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
