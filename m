Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:29:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248C32089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m7oiiVvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248C32089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Op1KvL/onIN7vI5ClwxBLO0T3TzLcJ0kx5MkmMuxMBo=; b=m7oiiVvNht5cl6rwpvjkLjwKjr
	91PtfJgErpA0C5o4/c5lRqXIIU9afkNU0oEg0Py21v0i6NKEoUL6D5USWuGbYLlb80I3UJhdxCvu0
	rZDLV2jZsCy6Ey3+knUXTEFX90DvMyaHBsBNgvOI6p2CXi6SYW2ne0nOAV7ACTm/DbVss3tWd5/Tw
	xiQd3Qu3r0nq/MmhO7hn1JCpsFryEqzZgGCoWEXDDB/UQrPU4YQq6uBDfyrgXCj4Sp2UH+j6agn8c
	8kAFRJNW0nDxy6rI13YC4DcoZlkYjN1H7FMKl+okRkK8ZSVNGJ4lLavDgPf3t1V0VsfoyQnP+QzAP
	O61HzUlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggXmU-0005EG-QP; Mon, 07 Jan 2019 16:29:38 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggXl9-0003ia-E7
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 16:28:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA9B81650;
 Mon,  7 Jan 2019 08:28:14 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C0723F5A0;
 Mon,  7 Jan 2019 08:28:10 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Russell King <linux@armlinux.org.uk>,
 suzuki.poulose@arm.com, robin.murphy@arm.com,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v4 07/13] drivers/perf: perf/core: use PERF_PMU_CAP_NO_EXCLUDE
 for exclude incapable PMUs
Date: Mon,  7 Jan 2019 16:27:24 +0000
Message-Id: <1546878450-20341-8-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_082816_916540_48E91E78 
X-CRM114-Status: GOOD (  15.93  )
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
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For drivers that do not support context exclusion let's advertise the
PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm-cci.c                        | 10 +---------
 drivers/perf/arm-ccn.c                        |  6 ++----
 drivers/perf/arm_dsu_pmu.c                    |  9 ++-------
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |  1 +
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  1 +
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  |  1 +
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  9 ---------
 7 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 1bfeb16..bfd03e0 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1327,15 +1327,6 @@ static int cci_pmu_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
-	/* We have no filtering of any kind */
-	if (event->attr.exclude_user	||
-	    event->attr.exclude_kernel	||
-	    event->attr.exclude_hv	||
-	    event->attr.exclude_idle	||
-	    event->attr.exclude_host	||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/*
 	 * Following the example set by other "uncore" PMUs, we accept any CPU
 	 * and rewrite its affinity dynamically rather than having perf core
@@ -1433,6 +1424,7 @@ static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 		.stop		= cci_pmu_stop,
 		.read		= pmu_read,
 		.attr_groups	= pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	cci_pmu->plat_device = pdev;
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 7dd850e..2ae7602 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -741,10 +741,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	if (has_branch_stack(event) || event->attr.exclude_user ||
-			event->attr.exclude_kernel || event->attr.exclude_hv ||
-			event->attr.exclude_idle || event->attr.exclude_host ||
-			event->attr.exclude_guest) {
+	if (has_branch_stack(event)) {
 		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
 		return -EINVAL;
 	}
@@ -1290,6 +1287,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 		.read = arm_ccn_pmu_event_read,
 		.pmu_enable = arm_ccn_pmu_enable,
 		.pmu_disable = arm_ccn_pmu_disable,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	/* No overflow interrupt? Have to use a timer instead. */
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 660cb8a..5851de5 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -562,13 +562,7 @@ static int dsu_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	if (has_branch_stack(event) ||
-	    event->attr.exclude_user ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv ||
-	    event->attr.exclude_idle ||
-	    event->attr.exclude_host ||
-	    event->attr.exclude_guest) {
+	if (has_branch_stack(event)) {
 		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
 		return -EINVAL;
 	}
@@ -735,6 +729,7 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 		.read		= dsu_pmu_read,
 
 		.attr_groups	= dsu_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);
diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 69372e2..0eba947 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -396,6 +396,7 @@ static int hisi_ddrc_pmu_probe(struct platform_device *pdev)
 		.stop		= hisi_uncore_pmu_stop,
 		.read		= hisi_uncore_pmu_read,
 		.attr_groups	= hisi_ddrc_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	ret = perf_pmu_register(&ddrc_pmu->pmu, name, -1);
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 443906e..2553a84 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -407,6 +407,7 @@ static int hisi_hha_pmu_probe(struct platform_device *pdev)
 		.stop		= hisi_uncore_pmu_stop,
 		.read		= hisi_uncore_pmu_read,
 		.attr_groups	= hisi_hha_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	ret = perf_pmu_register(&hha_pmu->pmu, name, -1);
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 0bde5d9..cf1cc34 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -397,6 +397,7 @@ static int hisi_l3c_pmu_probe(struct platform_device *pdev)
 		.stop		= hisi_uncore_pmu_stop,
 		.read		= hisi_uncore_pmu_read,
 		.attr_groups	= hisi_l3c_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	ret = perf_pmu_register(&l3c_pmu->pmu, name, -1);
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 9efd241..f028cbc 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -142,15 +142,6 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
-	/* counters do not have these bits */
-	if (event->attr.exclude_user	||
-	    event->attr.exclude_kernel	||
-	    event->attr.exclude_host	||
-	    event->attr.exclude_guest	||
-	    event->attr.exclude_hv	||
-	    event->attr.exclude_idle)
-		return -EINVAL;
-
 	/*
 	 *  The uncore counters not specific to any CPU, so cannot
 	 *  support per-task
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
