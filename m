Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A337C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:42:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFBF2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LvtPqho8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFBF2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cBOEqGUnNwGk2X1X60htwq96Qu5d/+Py81Op9EwDM3k=; b=LvtPqho8sZnhb/
	KJSntOUXBriV3KQbtiYlmQAjVPxVIGLqDxk07WaHVi8e3LsSfcN7j2UQSFCLPz7jmF90U5bpPYFfL
	fQIZaCEV3heFt0/MLgmomgvBdiexKqnvxbDRBhMkgtl3XmainNKnEk780puQ5E8KWBwVHfaAY8fHV
	6z5extpuMIapUTDKLB5aqJj9bwhg+2NDdnmkEkSkkdHrncuXGRWzWZe4kBFJKguEMfr40l+B8EaYJ
	FWS5um89UMbEUJHzORaOknFjGdws6mqs9wVY+Gv+o1hlGXcO7CNIlncgZuh2LJBvHqhR+8/rVwlxY
	yanTOa+dWXqpPJ6cI0UA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggXyt-0002lg-0q; Mon, 07 Jan 2019 16:42:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggXyp-0002lB-W3
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 16:42:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0DF01596;
 Mon,  7 Jan 2019 08:42:21 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 102583F5A0;
 Mon,  7 Jan 2019 08:42:19 -0800 (PST)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ACPI/IORT: Fix build when CONFIG_IOMMU_API=n
Date: Mon,  7 Jan 2019 16:42:07 +0000
Message-Id: <20190107164208.27789-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_084224_038200_5148CE55 
X-CRM114-Status: GOOD (  11.01  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-acpi@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
 Qian Cai <cai@lca.pw>, Hanjun Guo <hanjun.guo@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Qian Cai <cai@lca.pw>

Commit 8097e53eaba2 ("ACPI/IORT: Use helper functions to access
dev->iommu_fwspec") changed by mistake the iort_fwspec_iommu_ops() stub
definition (compiled in when CONFIG_IOMMU_API=n), that caused the
following compilation failure:

drivers/acpi/arm64/iort.c:880:1: error: expected identifier or
'(' before '{' token
 { return NULL; }
 ^
drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops'
used but never defined
 static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
                                       ^~~~~~~~~~~~~~~~~~~~~

Fix it.

Fixes: 8097e53eaba2 ("ACPI/IORT: Use helper functions to access dev->iommu_fwspec")
Signed-off-by: Qian Cai <cai@lca.pw>
[lorenzo.pieralisi@arm.com: updated tags and log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index fdd90ffceb85..5d29783ee5bd 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -876,7 +876,7 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	return (resv == its->its_count) ? resv : -ENODEV;
 }
 #else
-static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
+static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
 { return NULL; }
 static inline int iort_add_device_replay(const struct iommu_ops *ops,
 					 struct device *dev)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
