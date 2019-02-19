Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFBFC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:34:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28ADD2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RBgkD8Eh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="MRTuwdl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ADD2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nwkbRdPwIA4UTpWrtHv7B5VM6OCIVdJ32zRlwD/I5+g=; b=RBgkD8EhJqeG+n
	X/wwn2ItvDmWxgJAwMIVnUYFx8RgTXa5neaV6TNUadANhQgijQekO5ikNSrK0p8BBZ7QA+DDVn1+8
	jKAnn++Avmt029xl7JkJoA4XDHMKb6M6SSmKN6uqBFMUWDiDRdxEjVivt8YMNCwnqC20sbj8xASIQ
	X3O3mAhBMrVB0JEZzca3dcBtXZLAxH6JasLmX7CwPNCNnJLZa5KDsAHwJIWDBVkZAUtMg8rliZHZh
	hWzQu++eUIIkVpZwMnB92l1MHavBtSQCW9eXzR0mVeksjvXbKPjro26eU5BXA2exFCQwo3+4cjzby
	DDBDupKqunoAeZtE54Rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvuIW-000513-8T; Tue, 19 Feb 2019 01:34:12 +0000
Received: from m12-12.163.com ([220.181.12.12])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvuIS-00050U-4H
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 01:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vJOxl
 iD3ylQNF+bK3c+e1E/IPoF2RmPsUHSYa4f68G4=; b=MRTuwdl5hca/5724t3b7h
 Dr4LnqeBtUejGLE3FLMPjrnSDFE6WlxYKdmkKEBXyDrzZ9jcRIA4oPda3nQqtHIk
 QxTdlSzkMwEIxZtXJ7j0abGg+7jzZXdI7OshAkJaP6+Lzssht9u8AcVH1ngs3FoR
 ggyP35j3nDDxE0Prw/iT4w=
Received: from localhost.localdomain (unknown [117.36.119.220])
 by smtp8 (Coremail) with SMTP id DMCowAC3NM4CXWtcMmt4GQ--.10745S3;
 Tue, 19 Feb 2019 09:33:55 +0800 (CST)
From: Shikai Wang <sxauwsk@163.com>
To: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2] i2c: cadence: try reset when master receive arbitration
 lost
Date: Tue, 19 Feb 2019 09:24:47 +0800
Message-Id: <20190219012447.5900-1-sxauwsk@163.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CM-TRANSID: DMCowAC3NM4CXWtcMmt4GQ--.10745S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1xGw4UZr1DAw17CryUKFg_yoW8Gw1Upa
 1DG39IkrW0qr4IqFs7Ar17ZF98uwsYga4UKF4Fk34q9F15CrWDtFy3tF95XF4xCry5Xw1a
 qrZ0y39rG3W2vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgTmDUUUUU=
X-Originating-IP: [117.36.119.220]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/1tbiQBRgJlSIZQ4tnwABsW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_173408_519742_AA5ADBE4 
X-CRM114-Status: GOOD (  11.09  )
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
Cc: Wolfram Sang <wsa@the-dreams.de>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 Shikai Wang <sxauwsk@163.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When the adapter receive arbitration lost error interrupts,
cdns_i2c_master_xfer return to the caller directly instead of resetting
the adapter which resulted in the adapter being out of control.

So when driver detect err_status such as arbitration lost,
then try to repair and fix it.

Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Shikai Wang <sxauwsk@163.com>
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
