Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28259C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:50:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED09A218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rti53Dgh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="HoXJ+lXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED09A218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ODwYA6rhc589QWdbALbZ8kf2IJyEweP1Nv1PRBoMRoQ=; b=Rti53Dghdz/TLD
	3uGNdkkEvnThSbJC08CH5g+9SqgmXkgZLEcP0lSOKYZ8fJzAb1oXdm3NYfe7L01Gm4Qs4HLBvaTh2
	T1ApaAe0Nddh2KPlBnmcyj+RhBfW7rhDp2C8orVWjyh6IlKjsv06L4A1qx3MXtZAZA3pIpIPDVZ/3
	9IqQAs5nvB0s6gCFQK7mF1GedMMh6RpEQV73qERoinjmbuJ/bFfLCAmM1ZTTFC45UDWtyKPWJa+MH
	ZiBGWxGTvBHYQb5RLR5F74HHgU/1ioDvIVxx8H/gvxDIVUZwUGZx9ZjDbuze/0Yo4QWxFCl/m12kr
	vPx792F3emruPHwKbHNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfZV-0001lE-Oo; Mon, 18 Feb 2019 09:50:45 +0000
Received: from m12-14.163.com ([220.181.12.14])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfZS-0001kZ-0g
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:50:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=P2vcV
 6f8loVaf/ZIiX2dpDXisvZU04xacdx/G8A6NQo=; b=HoXJ+lXF3jE+cgyInkc8G
 GC/NTw6YVxqDMdPLEt3vzoSAaMvSL04q8gBvDZ0n8qR4wzS3wJzmrvM19VLqs+4H
 GhU0Iq0xiklmAImmaw+LTX0YNVMAZ0t+C3HWRoz4dXHqEqj6pFNqIrf00kx0Nusk
 Q2u2yl4bJtbviuES75Iu9I=
Received: from localhost.localdomain (unknown [202.100.35.16])
 by smtp10 (Coremail) with SMTP id DsCowADnYA_vf2pcFKt1GQ--.1550S3;
 Mon, 18 Feb 2019 17:50:40 +0800 (CST)
From: Shikai Wang <sxauwsk@163.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] i2c: cadence: try reset when master receive arbitration lost
Date: Mon, 18 Feb 2019 17:41:32 +0800
Message-Id: <20190218094132.5226-1-sxauwsk@163.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CM-TRANSID: DsCowADnYA_vf2pcFKt1GQ--.1550S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1xGw4UZr1DAr4rKFy7trb_yoW8Gw15pa
 1DGrZIkrW0qr4IqFs7Ar17ZF98uwsYga4jkF4Fk34q9F15CrWDtFy3tF98XF4xCryrX34a
 qrZ0y39rG3W2vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jc_-PUUUUU=
X-Originating-IP: [202.100.35.16]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/xtbBzxBfJlaD1XcVlAAAsQ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_015042_848920_125058B9 
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
Cc: linux-kernel@vger.kernel.org, sxauwsk@163.com,
 Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When the adapter receive arbitration lost error interrupts,
cdns_i2c_master_xfer return to the caller directly instead of resetting
the adapter which resulted in the adapter being out of control.

So when driver detect err_status such as arbitration lost,
then try to repair and fix it.

Signed-off-by: Shikai Wang <sxauwsk@163.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/i2c/busses/i2c-cadence.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b13605718291..595b0d56ff1a 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 	cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
 			  CDNS_I2C_IDR_OFFSET);
 
-	/* If it is bus arbitration error, try again */
-	if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
-		return -EAGAIN;
-
 	return 0;
 }
 
@@ -624,6 +620,12 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		if (id->err_status) {
 			cdns_i2c_master_reset(adap);
 
+			/* If it is bus arbitration error, try again */
+			if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
+				ret = -EAGAIN;
+				goto out;
+			}
+
 			if (id->err_status & CDNS_I2C_IXR_NACK) {
 				ret = -ENXIO;
 				goto out;
-- 
2.19.2



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
