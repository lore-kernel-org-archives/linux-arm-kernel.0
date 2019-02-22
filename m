Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5B2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:16:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87922086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qshckinh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87922086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TFwJQG9ve0bPEvfufKYUux/bwIGKe1Qp2hrC4jVn8cQ=; b=Qshckinh8uVggCMiFqvBQ3Dc6D
	mo9+BQs/Oo6PRbPOI2NJ955T2pTRaMJOT9wpdtFaMcKa/J0VscYAQSkktxv+pJ+x1huKWFA3W0a+j
	XKRqxRdJ0bfPuQmWSnhwvb1MLAw3hecVpe34dbxtYgYXqkQpkLdYUU1g+z5MMTMjV+RIW+T+mosEq
	jriwH9rMJXcS4rwVLml3dU4mNoNBaJRSY3sHqEnogKpkxzkP4nbRokG/lT+P80usATSY4Iv5Qkdt3
	PfARAEPWipEqN1qYcLO9HkVmWmYSgxEZV0nnbM2gPoIyn+zC6LKLPSVFbYitVClOXoqbkqXI0NUoJ
	4/uiTPoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx540-0002Vw-5U; Fri, 22 Feb 2019 07:16:04 +0000
Received: from out1.zte.com.cn ([202.103.147.172] helo=mxct.zte.com.cn)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx53q-0002NT-Pd; Fri, 22 Feb 2019 07:15:56 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 35B44732F508B31BCDC5;
 Fri, 22 Feb 2019 15:15:44 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x1M7FTGm037387;
 Fri, 22 Feb 2019 15:15:29 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019022215160783-1228925 ;
 Fri, 22 Feb 2019 15:16:07 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: linus.walleij@linaro.org
Subject: [PATCH 3/5] mt76: fix a leaked reference by adding a missing
 of_node_put
Date: Fri, 22 Feb 2019 15:15:40 +0800
Message-Id: <1550819742-32155-3-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
References: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-02-22 15:16:08,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-22 15:15:14, Serialize complete at 2019-02-22 15:15:14
X-MAIL: mse01.zte.com.cn x1M7FTGm037387
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_231554_996021_067ABAF0 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: wang.yi59@zte.com.cn, andrew@lunn.ch, alexandre.belloni@bootlin.com,
 f.fainelli@gmail.com, michal.simek@xilinx.com, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, Wen Yang <wen.yang99@zte.com.cn>, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 anirudh@xilinx.com, lorenzo.bianconi83@gmail.com, UNGLinuxDriver@microchip.com,
 John.Linn@xilinx.com, vivien.didelot@gmail.com, kvalo@codeaurora.org,
 nbd@nbd.name
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The call to of_find_node_by_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/net/wireless/mediatek/mt76/eeprom.c:58:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 48, but without a corresponding object release within this function.
./drivers/net/wireless/mediatek/mt76/eeprom.c:61:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 48, but without a corresponding object release within this function.
./drivers/net/wireless/mediatek/mt76/eeprom.c:67:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 48, but without a corresponding object release within this function.
./drivers/net/wireless/mediatek/mt76/eeprom.c:70:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 48, but without a corresponding object release within this function.
./drivers/net/wireless/mediatek/mt76/eeprom.c:72:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 48, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 530e559..a1529920d 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -54,22 +54,30 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
 		part = np->name;
 
 	mtd = get_mtd_device_nm(part);
-	if (IS_ERR(mtd))
-		return PTR_ERR(mtd);
+	if (IS_ERR(mtd)) {
+		ret =  PTR_ERR(mtd);
+		goto out_put_node;
+	}
 
-	if (size <= sizeof(*list))
-		return -EINVAL;
+	if (size <= sizeof(*list)) {
+		ret = -EINVAL;
+		goto out_put_node;
+	}
 
 	offset = be32_to_cpup(list);
 	ret = mtd_read(mtd, offset, len, &retlen, dev->eeprom.data);
 	put_mtd_device(mtd);
 	if (ret)
-		return ret;
+		goto out_put_node;
 
-	if (retlen < len)
-		return -EINVAL;
+	if (retlen < len) {
+		ret = -EINVAL;
+		goto out_put_node;
+	}
 
-	return 0;
+out_put_node:
+	of_node_put(np);
+	return ret;
 #else
 	return -ENOENT;
 #endif
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
