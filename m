Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E96C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:13:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4EC217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HS4cm1MQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4EC217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hir8kX/josaWO53lWw/e5ERtD9wgOz8Aik3Qh1WvLTg=; b=HS4cm1MQcavy8U
	lI0cUXesm2m1+5dqk5H5ubsjBPx79bBjTLR68VRF8URgl+GaesnvSktmsBWqw0WiGqqNYIoD/f5co
	RJbY47b3LGOIylURW/nqpY7SXh8dyn6zQRb7P7n8OODV6alJBt5B2UAOZWpuJLKe643uOmMm70dEJ
	/r+lNiXrTQRVuytHwALTLMVN3sVUgiXBspRlg/2Z6cPi2ENbUxoZYPGPmm2Y+quumqJzxRmSgk+0K
	Rcsa6/J0GFIYH64EsrF/nDFT1qA2iHYeYM1ju5XAhX7OF8LFdANXm3cu0BAoGrMhXVSb2TBqUBpe7
	4lYcUO4SZtkFoPv3tZ0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycXn-0005Oy-Uj; Tue, 26 Feb 2019 13:13:11 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycX0-0004TT-OX; Tue, 26 Feb 2019 13:12:26 +0000
X-UUID: 195dde52d21b415aac4a0830caeb163d-20190226
X-UUID: 195dde52d21b415aac4a0830caeb163d-20190226
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 325874519; Tue, 26 Feb 2019 05:11:35 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Feb 2019 05:11:33 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Feb 2019 21:11:31 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Feb 2019 21:11:31 +0800
From: Qii Wang <qii.wang@mediatek.com>
To: <wsa@the-dreams.de>
Subject: [PATCH v5 4/5] i2c: mediatek: Add i2c and apdma sync in i2c driver
Date: Tue, 26 Feb 2019 21:10:59 +0800
Message-ID: <1551186660-16902-5-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com>
References: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_051223_374103_83368BF8 
X-CRM114-Status: UNSURE (   9.94  )
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
Cc: devicetree@vger.kernel.org, qii.wang@mediatek.com,
 srv_heupstream@mediatek.com, robh@kernel.org, leilk.liu@mediatek.com,
 xinping.qian@mediatek.com, linux-kernel@vger.kernel.org,
 liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When i2c and apdma use different source clocks, we should enable
synchronization between them.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 14d6b38..75d88e1 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -77,6 +77,8 @@
 #define I2C_CONTROL_DIR_CHANGE          (0x1 << 4)
 #define I2C_CONTROL_ACKERR_DET_EN       (0x1 << 5)
 #define I2C_CONTROL_TRANSFER_LEN_CHANGE (0x1 << 6)
+#define I2C_CONTROL_DMAACK_EN           (0x1 << 8)
+#define I2C_CONTROL_ASYNC_MODE          (0x1 << 9)
 #define I2C_CONTROL_WRAPPER             (0x1 << 0)
 
 #define I2C_DRV_NAME		"i2c-mt65xx"
@@ -169,6 +171,7 @@ struct mtk_i2c_compatible {
 	unsigned char aux_len_reg: 1;
 	unsigned char support_33bits: 1;
 	unsigned char timing_adjust: 1;
+	unsigned char dma_sync: 1;
 };
 
 struct mtk_i2c {
@@ -218,6 +221,7 @@ struct mtk_i2c {
 	.aux_len_reg = 1,
 	.support_33bits = 1,
 	.timing_adjust = 1,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt6577_compat = {
@@ -229,6 +233,7 @@ struct mtk_i2c {
 	.aux_len_reg = 0,
 	.support_33bits = 0,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt6589_compat = {
@@ -240,6 +245,7 @@ struct mtk_i2c {
 	.aux_len_reg = 0,
 	.support_33bits = 0,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt7622_compat = {
@@ -251,6 +257,7 @@ struct mtk_i2c {
 	.aux_len_reg = 1,
 	.support_33bits = 0,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt8173_compat = {
@@ -261,6 +268,7 @@ struct mtk_i2c {
 	.aux_len_reg = 1,
 	.support_33bits = 1,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct of_device_id mtk_i2c_of_match[] = {
@@ -360,6 +368,9 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
 
 	control_reg = I2C_CONTROL_ACKERR_DET_EN |
 		      I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
+	if (i2c->dev_comp->dma_sync)
+		control_reg |= I2C_CONTROL_DMAACK_EN | I2C_CONTROL_ASYNC_MODE;
+
 	mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
 	mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
 
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
