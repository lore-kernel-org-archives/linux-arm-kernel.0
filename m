Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627CDC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:10:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B7F2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a5CozWvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B7F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V7PxMs4EbZxzbCCQKhkMGuv4pDNNJGwvvi+YMAl6wa8=; b=a5CozWvpIS2mfR
	I7hhTzLNVUuLpEUmQj5/7avBElYY6fTV5SAjLR2gr7zLAh8HCCrpe2AAbM7hGWQM2NinrkIjGIEYI
	3AxFiCvGe+NEaDZLcpnyKMRU1EOp4lXYsc2wVrpwqZ2EOLFO8U222uR/6zjkLpEJEjxxwe6eMw/8Q
	BxsOX8ay6gCWeNqSvOkVJaAq0nmOpGfKZfvNGOvRTL+FH4xPTqvFRykJYorFNSJhzFpZKRQ6zW1jW
	T6+85DLhZeW5NQwei9Or2QjBJxqCH77MJxclcL1j6WCUr1f2iBvpLgE022Ca/QlHFjdP+fxk2RGPy
	Kpjxp3zKrzbmZ4WM4vCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhlP-0005Q2-1U; Mon, 04 Feb 2019 17:10:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhkj-0003QL-9c
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:09:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D24151684;
 Mon,  4 Feb 2019 09:09:48 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 593A23F589;
 Mon,  4 Feb 2019 09:09:47 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com,
	mark.rutland@arm.com
Subject: [PATCH 5/5] perf/arm_dsu: Fix CPU hotplug races
Date: Mon,  4 Feb 2019 17:09:08 +0000
Message-Id: <d376f6bbd5804616b38145780789785b19a37543.1549299188.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1549299188.git.robin.murphy@arm.com>
References: <cover.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_090950_216739_7DA33330 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: suzuki.poulose@arm.com, peterz@infradead.org, bigeasy@linutronix.de,
 linux-kernel@vger.kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Like other system PMUs which associate themselves with an arbitrary CPU
for housekeeping purposes, arm_dsu has a race between registering the
hotplug notifier and registering the PMU device, such that the hotplug
niotifier can potentially fire and attempt to migrate the PMU context
before the latter is valid. This is easily resolved by inhibiting
hotplug until both the notifier and PMU device are successfully set up.

For the same reason, also suppress any synchronous notifier calls in the
cleanup path if PMU registration fails.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_dsu_pmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 660cb8ac886a..cfaca06b964a 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -717,7 +717,8 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 
 	dsu_pmu->irq = irq;
 	platform_set_drvdata(pdev, dsu_pmu);
-	rc = cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
+	cpus_read_lock();
+	rc = cpuhp_state_add_instance_cpuslocked(dsu_pmu_cpuhp_state,
 						&dsu_pmu->cpuhp_node);
 	if (rc)
 		return rc;
@@ -738,9 +739,10 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	};
 
 	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);
+	cpus_read_unlock();
 	if (rc) {
-		cpuhp_state_remove_instance(dsu_pmu_cpuhp_state,
-						 &dsu_pmu->cpuhp_node);
+		cpuhp_state_remove_instance_nocalls(dsu_pmu_cpuhp_state,
+						    &dsu_pmu->cpuhp_node);
 		irq_set_affinity_hint(dsu_pmu->irq, NULL);
 	}
 
-- 
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
