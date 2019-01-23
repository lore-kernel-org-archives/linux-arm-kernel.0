Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6FDC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:05:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DC620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cPCSWhsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DC620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sTyEX7Yl/Hxs5RMyGyP8hc0/muYxXSHdrmcGwJeD4n4=; b=cPCSWhsA4b+w2l
	Es2XP0sGpd6i87JGxDELqAnb6MRtsWJW61hqUoo3Al5wFu3I09Mu9oS3AVzWim7EfkdKSR5tykl/P
	uyVqcB11hTgWb6w9T8UJmmZ3tLgjkaAD+w1K1tn/boPs9nNhQXIoYFAwlO2u/bO1xLK7UAWRh9h4K
	22meFy+rHBK5BCN0hA8PvNra7OTxO0aepDmDNblGzaYs7NSUUF6FjFHnjEuGwkOj2dVDz85UpL0VB
	RdFSp0+ZWBoeHRqUMqSCCIbCAvbp6wBtJtO8h0EQjaIo8Iuqcws55bt9vqDsfd+y2gsjGlbWS33Ke
	+76j28/Wa+oivU9K4Y6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmHHr-0002dh-5d; Wed, 23 Jan 2019 12:05:43 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmHHm-0002cI-Tc; Wed, 23 Jan 2019 12:05:40 +0000
X-UUID: a67e6320d0714e57bfc4a70c9e77d54d-20190123
X-UUID: a67e6320d0714e57bfc4a70c9e77d54d-20190123
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <chaotian.jing@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 372308187; Wed, 23 Jan 2019 04:05:31 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 23 Jan 2019 04:05:30 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 23 Jan 2019 20:05:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 23 Jan 2019 20:05:28 +0800
From: Chaotian Jing <chaotian.jing@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: mediatek: fix incorrect register setting of
 hs400_cmd_int_delay
Date: Wed, 23 Jan 2019 20:05:25 +0800
Message-ID: <1548245125-31664-1-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_040538_962114_B2BC9C29 
X-CRM114-Status: GOOD (  10.36  )
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
Cc: linux-arm-kernel@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>,
 srv_heupstream@mediatek.com, Sean Wang <sean.wang@mediatek.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yong Mao <yong.mao@mediatek.com>, linux-mediatek@lists.infradead.org,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 jjian zhou <jjian.zhou@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

to set cmd internal delay, need set PAD_TUNE register but not PAD_CMD_TUNE
register.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 8afeaf8..833ef05 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -846,7 +846,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 
 	if (timing == MMC_TIMING_MMC_HS400 &&
 	    host->dev_comp->hs400_tune)
-		sdr_set_field(host->base + PAD_CMD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_CMDRRDLY,
 			      host->hs400_cmd_int_delay);
 	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->mmc->actual_clock,
-- 
1.8.1.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
