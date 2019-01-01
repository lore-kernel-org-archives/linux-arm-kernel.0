Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB98C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:52:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2372075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p7YYTeky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2372075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O0qAM/8JwKCa+GGHqA17hzC0XdGczc6sOCBb2W8XgnE=; b=p7YYTekyP/L38T
	qH/WBRBY0VUlQ+MmZahX5LfSTrZuJbxtPBePe58G7xVU25vzWZrj22LnSbYR/YZw6HGfNUvziXCfd
	G17DcUHE8ggmdrsyB2N+a7FRhRunXMESQSZj4Al2q9RpJfGFOuxN06kFVID0yvKDWelyRz9fcU5PJ
	QQuDgTbEONqdSf+00SoQjf3Te4HvC86Z82pC7klnYizKH7ZL55q/PQl2Nj3omm8wPyM46JJXH+MDW
	avVCnhsbmlTww+OUGyQ0r+c1yKY0P8SVKxXGQFAza3upmDbTc8jKtQQ0wZwM85BmMyn/2pfHGZWdj
	/26BAAXWxFbvO3Rs+LIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geC2P-0002IN-HR; Tue, 01 Jan 2019 04:52:21 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geC1z-0001y7-ON; Tue, 01 Jan 2019 04:51:58 +0000
X-UUID: 7edc5f1ea9404f02b99ab1f00cd5f1fb-20190101
X-UUID: 7edc5f1ea9404f02b99ab1f00cd5f1fb-20190101
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1466982651; Tue, 01 Jan 2019 12:51:50 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 12:51:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 12:51:48 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob
 Herring <robh+dt@kernel.org>
Subject: [PATCH 02/13] driver core: Remove the link if there is no driver with
 AUTO flag
Date: Tue, 1 Jan 2019 12:51:05 +0800
Message-ID: <1546318276-18993-3-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 79505BBE12833B41BBCDE2CAFB788151A8D5FC51391A36032ADF8B6884827C3C2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_205156_373388_85A37271 
X-CRM114-Status: GOOD (  12.76  )
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
 yong.wu@mediatek.com, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DL_FLAG_AUTOREMOVE_CONSUMER/SUPPLIER means "Remove the link
automatically on consumer/supplier driver unbind", that means we should
remove whole the device_link when there is no this driver no matter what
the ref_count of the link is.

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
The ref_count of our device_link normally is over 1. When the consumer
device driver is removed, whole the device_link should be removed.
Thus, I add this patch.
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd7..4f3c5bc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -511,7 +511,7 @@ static void __device_links_no_driver(struct device *dev)
 			continue;
 
 		if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
-			kref_put(&link->kref, __device_link_del);
+			__device_link_del(&link->kref);
 		else if (link->status != DL_STATE_SUPPLIER_UNBIND)
 			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 	}
@@ -556,7 +556,7 @@ void device_links_driver_cleanup(struct device *dev)
 		 */
 		if (link->status == DL_STATE_SUPPLIER_UNBIND &&
 		    link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
-			kref_put(&link->kref, __device_link_del);
+			__device_link_del(&link->kref);
 
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
