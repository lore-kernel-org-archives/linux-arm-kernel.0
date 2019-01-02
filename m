Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94231C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:35:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB302171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N1VLg9fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB302171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tz2sth6Q8I92Yf6rUpz11O3z6RnXS4rii8wApO+V20k=; b=N1VLg9fn/mHwSF
	CvxammUkp/PbSvYq4Ml6SEUzKpxmju5R3a6P6GNreq8zvjOoNy9OC57+5OanpA5fKHPWvecMO/tQt
	scl8LpEgJKMiAgtC+1etY7f2kF4mIRAG7/GpzojPPrmBeYN84dFASqxpQ/OiunnkkvVgjLk4TXrpV
	XqRWa6XyRoZaE4ySnucWA54mj0JBmCKqGAKT+0fyf3eWI8gwYcSwQtVA2DR7wnVMs44M3ErYnpOW3
	d7FiKYBcrtbfovErwLz5MvgbOnKwXWOY8MHr81oZwCqlr8kGrJkgLqnFZLRksMEmHzHDyP2M4nNrV
	W+fE2yAAkddFj9OcfyYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geVQr-0004lz-MD; Wed, 02 Jan 2019 01:34:53 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geVQn-0004lO-7z; Wed, 02 Jan 2019 01:34:51 +0000
X-UUID: 10f49348f6eb4f47a8bd3afb9f35cf0c-20190102
X-UUID: 10f49348f6eb4f47a8bd3afb9f35cf0c-20190102
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <chunfeng.yun@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1332452201; Wed, 02 Jan 2019 09:34:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 2 Jan 2019 09:34:24 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 09:34:18 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] usb: devio: update max count of DPs per interval for ISOC
Date: Wed, 2 Jan 2019 09:33:56 +0800
Message-ID: <1546392836-7087-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_173449_503043_4DB43516 
X-CRM114-Status: GOOD (  10.70  )
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
Cc: devicetree@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The failure happened when I tried to send up to 96DPs per an interval
for SSP ISOC transations by libusb, this is used to verify SSP ISOC
function of USB3 GEN2 controller, so update it as 96DPs.
(refer usb3.1r1.0 section 8.12.6 Isochronous Transactions)

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: update changelog text suggested by Greg
---
 drivers/usb/core/devio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index a75bc0b8a50f..82c16210e34c 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1564,12 +1564,10 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 		}
 		for (totlen = u = 0; u < number_of_packets; u++) {
 			/*
-			 * arbitrary limit need for USB 3.0
-			 * bMaxBurst (0~15 allowed, 1~16 packets)
-			 * bmAttributes (bit 1:0, mult 0~2, 1~3 packets)
-			 * sizemax: 1024 * 16 * 3 = 49152
+			 * arbitrary limit need for USB 3.1 Gen2
+			 * sizemax: 96 DPs at SSP, 96 * 1024 = 98304
 			 */
-			if (isopkt[u].length > 49152) {
+			if (isopkt[u].length > 98304) {
 				ret = -EINVAL;
 				goto error;
 			}
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
