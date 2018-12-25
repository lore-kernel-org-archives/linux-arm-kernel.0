Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BFBC64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:25:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E29218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NYAyR00y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E29218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oy4aQc3b6tZ5o2Y1i2gXKlFUgxsA8iO7H6AtV7BsFho=; b=NYAyR00y+n1qk7
	QYuW51AKzi1iQFxizwkqEBhM7JQJHt2D/RMQUtLlu62T8h4iRWo7ZqOoRIbLmGdlUTgEBSWeg5HCU
	2L0gTfuecEznJuw1z+BWBm1XYbpX86QlQldVSQKftvSdYWaGtjpCjdfZDxzwkcdHmY23Bmn7i9ose
	Q0GVEKt452/+xbH4PQXmWgdWsy2V/J0Jmdr6iBa78wbil7OJP/tm9Inec7yPhQ+I6ACjavEtu7Qgi
	5G+sudnZh2QBeaZJKDgs9FE61aYZBHD1kTKYLEjuSjEBFHIfKeBRQAvYHEVsZquuMy76gK8XR3PmQ
	T76YxG6xHFddGiQ3P+1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbeHj-0001OY-IR; Tue, 25 Dec 2018 04:25:39 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbeHd-0001Mt-HB; Tue, 25 Dec 2018 04:25:37 +0000
X-UUID: 8c966f9564934e5cad4f1eb6a4213bf5-20181225
X-UUID: 8c966f9564934e5cad4f1eb6a4213bf5-20181225
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <chuanjia.liu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 679132772; Tue, 25 Dec 2018 12:25:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 25 Dec 2018 12:25:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Dec 2018 12:25:16 +0800
From: <chuanjia.liu@mediatek.com>
To: <sean.wang@kernel.org>, <linus.walleij@linaro.org>,
 <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
 <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] pinctrl:mediatek:add EINT support to virtual GPIOs
Date: Tue, 25 Dec 2018 12:23:58 +0800
Message-ID: <1545711838-20444-1-git-send-email-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-TM-SNTS-SMTP: 709753F672622637475F74091239B3160F9481542974F72D2853B8419EB951A42000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_202533_695601_7B6D1816 
X-CRM114-Status: GOOD (  11.67  )
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
Cc: youlin.pei@mediatek.com, zhiyong.tao@mediatek.com, eddie.huang@mediatek.com,
 hailong.fan@mediatek.com, Chuanjia Liu <Chuanjia.Liu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>

Virtual gpio only used inside SOC and not being exported to outside SOC.
Some modules use virtual gpio as eint and doesn't nedd SMT.
So this patch add EINT support to virtual GPIOs.

Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
---
change note:
v3 : 1. modify subject and description
      2. modify comments
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 4a9e0d4c2bbc..a0db145f798d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -290,7 +290,15 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
 		return err;
 
 	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
-	if (err)
+	/*
+	 *SMT is supposed to be supported by every real GPIO and doesn't
+	 *support virtual GPIOs, so the extra condition err != -ENOTSUPP
+	 *is just for adding EINT support to these virtual GPIOs. It should
+	 *add an extra flag in the pin descriptor when more pins with
+	 *distinctive characteristic come out.
+	 */
+
+	if (err && err != -ENOTSUPP)
 		return err;
 
 	return 0;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
