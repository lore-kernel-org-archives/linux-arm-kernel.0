Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A59C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:14:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4886B21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eXYc2sB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4886B21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pGJCaVzYJSj37Th+HK1jqywErRqhMPPothGhOZNLXp4=; b=eXYc2sB8iOTMGD
	nUW0RxmP9OsSpR4Lyx3Uzt3GfFDEX+ARTQK8PCq1DJ3QXL5YYQEF1OLpezaS/eapOnJnQR60q3Ugk
	jRPrn+q496z8jOdMsvWnhWHwz0pw/3P3N9fOzxL+xMJZH6ThD8wcezn+yiAEPE1+pPWTFlu9vpMjS
	8OZGr0F6K5+jvj8uHzRPx9awilMgqlq0zWyrCr8YwUjNIL1/0QlpUgj9Iah9siDQLMa8Ffw3P8RIZ
	uSxAcLw4+ARFDxfcFPdHGTtdzd0U8D1MomqnqSUY5BDPTYPEX+JkF2gldHI13EFW+IJyyh+XfATTP
	1QSsZRjpiptkJhrdCf/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gma9u-0008C5-9s; Thu, 24 Jan 2019 08:14:46 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gma9r-0008A5-Aa; Thu, 24 Jan 2019 08:14:44 +0000
X-UUID: eb4be2f60f5347f485b135d686c27a7a-20190124
X-UUID: eb4be2f60f5347f485b135d686c27a7a-20190124
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <erin.lo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1551620192; Thu, 24 Jan 2019 00:14:19 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 00:14:18 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 16:14:14 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Thu, 24 Jan 2019 16:14:14 +0800
From: Erin Lo <erin.lo@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier
 <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v6 1/6] irqchip/mtk-sysirq: support 4 interrupt parameters for
 sysirq
Date: Thu, 24 Jan 2019 16:07:15 +0800
Message-ID: <1548317240-44682-2-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_001443_369651_B7687775 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>,
 Seiya Wang <seiya.wang@mediatek.com>, erin.lo@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, mars.cheng@mediatek.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Seiya Wang <seiya.wang@mediatek.com>

To support partitioned PPIs, 4 interrupt parameters should be valid
for sysirq.

Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 drivers/irqchip/irq-mtk-sysirq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 90aaf19..282736a 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -81,7 +81,7 @@ static int mtk_sysirq_domain_translate(struct irq_domain *d,
 				       unsigned int *type)
 {
 	if (is_of_node(fwspec->fwnode)) {
-		if (fwspec->param_count != 3)
+		if (fwspec->param_count != 3 && fwspec->param_count != 4)
 			return -EINVAL;
 
 		/* No PPI should point to this domain */
@@ -104,7 +104,7 @@ static int mtk_sysirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	struct irq_fwspec *fwspec = arg;
 	struct irq_fwspec gic_fwspec = *fwspec;
 
-	if (fwspec->param_count != 3)
+	if (fwspec->param_count != 3 && fwspec->param_count != 4)
 		return -EINVAL;
 
 	/* sysirq doesn't support PPI */
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
