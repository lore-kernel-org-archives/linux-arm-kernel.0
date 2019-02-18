Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE85DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:45:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C6E2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EbsNnG5h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="R0lXaQnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C6E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hf9l5JnQ2rlT9mWTfk5svM2h0xAzWKS3mo6TtPMDH50=; b=EbsNnG5hjy1+JN
	6deG9yk/92Gim9J1/w7z6ok4Z79laD44W5J219U7yMEiEVGeQJRGeWbIL0GJXffdpfjDK+Y6dqioK
	lAu4r5qZ0gmzTN3jpdsky2kDzGO70v+UVje2wV3lG+NAbdHnWvyXtD+st8rm3qXBBSg6RV4nAchW1
	xnFGDwksVHF5IVkkZey+q8JGpuQAQI9fz/SMSw4PuQSsIkZHHUjjzYPTdkVNm0y87K30GJiSP+23M
	DdGjUmABEI834SUgu8uRjhf+ohr9H1XYYVDjifRewJESV1CJuL2sySLuWY9oOmudEWnW/ipzGMoJR
	5z1NWb8Y0qnVLczw2qQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gveXs-00042C-MZ; Mon, 18 Feb 2019 08:45:00 +0000
Received: from m12-16.163.com ([220.181.12.16])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gveXn-00041L-Gq
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:44:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Dw9Pe
 j+fnj+RHCbvYGdm4LntG421zy/HfA2jQFdBX1s=; b=R0lXaQnrUEhAqmUIPHD0R
 x5tVj7Fc81ch6i5iVScP9KwekP0BZk4ttB8N6GayMAA5z1FLMcesVvdORB9FGnga
 E8NVDPSnrtgRsGCZvMbSFaJDeSEgh7JOCgOueHg0o3qp3Bi5nNvCr3gEuV9l1lpu
 uWJjg/tsnKrHFFtpdENr+c=
Received: from localhost.localdomain (unknown [202.100.35.16])
 by smtp12 (Coremail) with SMTP id EMCowADXYgVvcGpc0qeTGA--.53770S3;
 Mon, 18 Feb 2019 16:44:33 +0800 (CST)
From: sxauwsk <sxauwsk@163.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] i2c: cadence: try reset when master receive arbitration lost
Date: Mon, 18 Feb 2019 16:35:22 +0800
Message-Id: <20190218083522.4681-1-sxauwsk@163.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CM-TRANSID: EMCowADXYgVvcGpc0qeTGA--.53770S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1xGw4UZr1DCr45ZF1fZwb_yoW8GFWkpa
 1DGrZIkrW0qr1IqFs7Ar17ZF98uwsYga4jkr4Fk34DuF15Cr4DtFy3tF98XF4xCryrXrya
 qrZ8t39rG3W2vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2xRDUUUUU=
X-Originating-IP: [202.100.35.16]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/xtbBZxFfJlettFNQqwAAsp
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_004456_590258_1C750927 
X-CRM114-Status: GOOD (  10.91  )
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

Signed-off-by: sxauwsk <sxauwsk@163.com>
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
