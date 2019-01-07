Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0106C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E33A2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cn1FPtP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E33A2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=m6wOf2CZATmRCbixIv8QxT5ccSHqhKoVDcqnwNnf5CM=; b=Cn1FPtP4rAYK+m
	QKe+k4tpDrci8WR0fgBIcBNQoPhkjThXJczMPERPKhf8C92QuNmha+RQD+xu4EZczXBp4j8th2eg1
	JVqjuhVREcTqNhYnIGV2dYvjAoMscYjd/G7ih97LxogJERjUa5fEjjCzWMwzLxnZgmCVRs+Ap0B4x
	o2PvDKO09ComxTaKi9nGCRKO55qjPkFmhsflfSykQaI1UauIaFgcc6eYaRg79fnYGwyZibLpWYjWT
	3Eq2ASYRdD5DV3YRCkWHOKOznPzXhDne/rsvrIAgo663x50+41ekWDog94k/vYt1cEjuFfi9rvRKo
	wN4doQFe4xyuP1FH6RmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggYKi-0004HP-Mj; Mon, 07 Jan 2019 17:05:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggYKf-0004Gw-39
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 17:04:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E30451596;
 Mon,  7 Jan 2019 09:04:54 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19EF83F5A0;
 Mon,  7 Jan 2019 09:04:53 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH] iommu/of: Fix probe-deferral
Date: Mon,  7 Jan 2019 17:04:50 +0000
Message-Id: <b158bd8aae8e9fd1a7fc7960cf17fa623dd47b11.1546880690.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_090457_143017_FE096BA5 
X-CRM114-Status: GOOD (  16.80  )
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
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Whilst iommu_probe_device() does check for non-NULL ops as the previous
code did, it does not do so in the same order relative to the other
checks, and as a result means that -EPROBE_DEFER returned by of_xlate()
(plus any real error condition too) gets overwritten with -EINVAL and
leads to various misbehaviour.

Reinstate the original logic, but without implicitly relying on ops
being set to infer !err as the initial condition (now that the validity
of ops for its own sake is checked elsewhere).

Fixes: 641fb0efbff0 ("iommu/of: Don't call iommu_ops->add_device directly")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index d8947b28db2d..f04a6df65eb8 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -224,7 +224,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * probe for dev, replay it to get things in order.
 	 */
-	if (dev->bus && !device_iommu_mapped(dev))
+	if (!err && dev->bus && !device_iommu_mapped(dev))
 		err = iommu_probe_device(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
-- 
2.19.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
