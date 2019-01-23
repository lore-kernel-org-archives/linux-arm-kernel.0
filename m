Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F5C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:53:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B226B20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dnPa3GDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B226B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=FRwEu0pTZ61Bpbz/voKGz02wme4wXiavhMXE2hvFRZ8=; b=dnP
	a3GDmpX9A3kI8a4gt1rrxuewOF+I3PhYMNX8boK9tHTinDdB/MYnpFqhcVEyaEQ2SWE0F6cgxepXk
	O6YNYP2pxKqJUd9bksvjQ6HhoWLjuVXzYu9cr+J6kjqdTH+P6nmCPi+H/6CstY80A+asgab6SD277
	UWt5lSnzmrWDojHLw7K9SD5iNlJ6EzYcPsGH//uCM2A6ZhSWMuMPcgCdCAQ1Ep8H5xDHHntt4g4n3
	DFvXG5ZWReNBveI8uR2BJHxkJRzePBowA/iCmVmBqonLPz45+TGzCns4RC09twLzhGi5IVax6Pehw
	Vuu5nJ7+pWHnsHgCjoUvCKquwBK6SwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDLy-0002HO-Lv; Wed, 23 Jan 2019 07:53:42 +0000
Received: from 8bytes.org ([81.169.241.247] helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDLu-0002Ey-LF; Wed, 23 Jan 2019 07:53:40 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BEB4239A; Wed, 23 Jan 2019 08:53:28 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/mediatek: Use correct fwspec in mtk_iommu_add_device()
Date: Wed, 23 Jan 2019 08:53:27 +0100
Message-Id: <20190123075327.27366-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_235338_876662_96EB5901 
X-CRM114-Status: UNSURE (   7.90  )
X-CRM114-Notice: Please train this message.
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
Cc: Joerg Roedel <jroedel@suse.de>, Frank Wunderlich <frank-w@public-files.de>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

The mtk_iommu_add_device() function keeps the fwspec in an
on-stack pointer and calls mtk_iommu_create_mapping(), which
might change its source, dev->iommu_fwspec. This causes the
on-stack pointer to be obsoleted and the device
initialization to fail. Update the on-stack fwspec pointer
after mtk_iommu_create_mapping() has been called.

Reported-by: Frank Wunderlich <frank-w@public-files.de>
Fixes: a9bf2eec5a6f ('iommu/mediatek: Use helper functions to access dev->iommu_fwspec')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/mtk_iommu_v1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 6ede4286b835..f60bdb85c4c0 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -442,6 +442,10 @@ static int mtk_iommu_add_device(struct device *dev)
 		iommu_spec.args_count = count;
 
 		mtk_iommu_create_mapping(dev, &iommu_spec);
+
+		/* dev->iommu_fwspec might have changed */
+		fwspec = dev_iommu_fwspec_get(dev);
+
 		of_node_put(iommu_spec.np);
 	}
 
-- 
2.13.7


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
