Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F35C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:45:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D0520868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MdrI6bRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D0520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VYz3Q8AS4fSJLwbCu6RTAAVAjNIyO6JQG/GmVCxlEPE=; b=MdrI6bRhfVNT10
	uUrMW1lpEsSJptaC0RcFY+zxrdsupNxdaP2mkfH+hi48fVdpGYbUw2uxenE5deKARHX0IwM6gq0Cx
	K4ns5ueuG/V8q5f75vSoBbLpY3cZfi4KeZsEHYGAbJONKxiqG0g14pGB5nW2akSFSTBqhn+elzCeV
	x1z2pY+EZVOKa6ujjTWbFZsXDDa51dRjgA/FM1QuKyMLuqvoMn00Wr5+vV5RqTPjLgK6tgqR+zeUQ
	HYU5d/jH2Kk8mVgpFpjspjVNCQng79DSeAcbHB1QkHXR08RH/gwNJFsPb/Pn24/YVc3D1FUYHQlnW
	nIiHfXcY11Fx9uemOJFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVYEk-00076i-DR; Sat, 08 Dec 2018 08:45:22 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVYDp-0005Cb-93; Sat, 08 Dec 2018 08:44:36 +0000
X-UUID: 0aaa5edce04e4e7886ff7a7167474148-20181208
X-UUID: 0aaa5edce04e4e7886ff7a7167474148-20181208
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1385563464; Sat, 08 Dec 2018 16:44:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 8 Dec 2018 16:44:08 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 8 Dec 2018 16:44:07 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 17/18] iommu/mediatek: Constify iommu_ops
Date: Sat, 8 Dec 2018 16:39:30 +0800
Message-ID: <1544258371-4600-18-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_004426_570481_AF1003F4 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, Arvind Yadav <arvind.yadav.cs@gmail.com>,
 yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

iommu_ops are not supposed to change at runtime.
Functions 'iommu_device_set_ops' and 'bus_set_iommu' working with
const iommu_ops provided by <linux/iommu.h>. So mark the non-const
structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[Yong: Change the title to iommu/mediatek: xx]
---
 drivers/iommu/mtk_iommu.c    | 4 ++--
 drivers/iommu/mtk_iommu_v1.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 9280031..03f5eee 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -119,7 +119,7 @@ struct mtk_iommu_domain {
 	struct iommu_domain		domain;
 };
 
-static struct iommu_ops mtk_iommu_ops;
+static const struct iommu_ops mtk_iommu_ops;
 
 static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
@@ -503,7 +503,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
-static struct iommu_ops mtk_iommu_ops = {
+static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
 	.domain_free	= mtk_iommu_domain_free,
 	.attach_dev	= mtk_iommu_attach_device,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 6d4551e..5fbf3ce 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -364,7 +364,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pa;
 }
 
-static struct iommu_ops mtk_iommu_ops;
+static const struct iommu_ops mtk_iommu_ops;
 
 /*
  * MTK generation one iommu HW only support one iommu domain, and all the client
@@ -526,7 +526,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	return 0;
 }
 
-static struct iommu_ops mtk_iommu_ops = {
+static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
 	.domain_free	= mtk_iommu_domain_free,
 	.attach_dev	= mtk_iommu_attach_device,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
