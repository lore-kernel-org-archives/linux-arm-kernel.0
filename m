Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6684C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:10:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFF6208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QsE/0QeJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VJTSoB6y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lw3qleMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFF6208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=+QxeLb2r7MFtHKAkyl8ZZKi0VeRjLu7hT8ajDP8lbqI=; b=QsE/0QeJGl+WvIK5NOjllJqEsz
	E0xXiyXkpAMttQmIwV424BLnt0jx0Cud7rbLxQrDjL9ev7gC9TtthrRIJZerZcgDXKBbV0M9Hv1YT
	ZSyzfpaBEtJxDiS7qoQcs+AEJL2fOSo6HGT66q0KIk/Pu3BZ1UThlf3OWUrtjA2mZNAFafWywQU2K
	DPOhUJPjibXEgxdwIG2TMnfrLsguxmJ7aG9SmmDi/gJu2GMJxQfybZsFlN+xMMuRtJ6v++CZgzyau
	KYZUwS0h+Ww/s4vzHPo2vN3yJY4/bd8GlFEEVurMo4x/okfz0kbnhg1sGQp8zYVRr9HC6PC35I3cN
	LzJaHBag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUkzy-0007pO-NS; Thu, 06 Dec 2018 04:10:50 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkmO-0002fm-Q9
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 03:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i2ojI7R92ngd4Xq06C6mSR5SZWE8QuYiZ8bI+8Q1qyI=; b=VJTSoB6ykMkvz2kpua8nCwbl7
 3CMHJQrYsMmb9ZTmEN3UCvPJp5Y7YqwR3o1zwRPsU/nA/3drjhUfV/wJvRmGfhFsyTKjxQKxySYCw
 vzz6D5EkytQwz65CpsxcJ8I5ScpIuAUFXgeaXYfZoBXA/YXkkC2Qh1obPUMfHIHwX+Gy+ueqQJ/bI
 enwiVeJNGlq7ztWmpeHkfuU2AdYwjSG7vrklRMHMdSoMmws2nbZEKfUXEEx+BFcnNYvn84geX713a
 iYqFk+1z0bJoJgSSXGsnmFEQS9DsIMvw7BiueUi7QLz3zALikUwvq0XUwMvu6Gso4pqclDQ1FN5RN
 0ZjUZj1lA==;
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkmE-0003kh-6R
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:56:46 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id wB63trS7007398;
 Thu, 6 Dec 2018 12:55:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB63trS7007398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544068555;
 bh=i2ojI7R92ngd4Xq06C6mSR5SZWE8QuYiZ8bI+8Q1qyI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lw3qleMFLx7MX5hI2QHV+N1op9V3rzX2NxKj4ltz9br1n2EUdhJgOO8Yy6UW3yGC6
 40hSFYWCpcX+5XzSj4zpC9S1lSqy2tpPL+yx+5+YfpARAVQn/DmH8bAKL99Fekh1g/
 eRsyOBwGoeREpuLOF1KfwqmezRX7VYC9lPVrLobqkEdJbkvaIED8WKo0yw4WkD9MST
 HcggJZHWRxMtXgutDem94exOe41dzM3hmorTTUeQx8Of5tOMB1G70fSBB/KitdNQAj
 HEtQ8boE90NnN9IBzcXYSCW+Cbgxn90D06lZqVC6tDaBs8l69PTBmE1YMcbPH76eRX
 kaQh/KGg0/wqg==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 2/4] i2c: uniphier-f: fill TX-FIFO only in IRQ handler for
 repeated START
Date: Thu,  6 Dec 2018 12:55:26 +0900
Message-Id: <1544068528-27657-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_225638_795115_C304D350 
X-CRM114-Status: GOOD (  14.98  )
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

 - For a repeated START condition, this controller starts data transfer
   immediately after the slave address is written to the TX-FIFO.

 - Once the TX-FIFO empty interrupt is asserted, the controller makes
   a pause even if additional data are written to the TX-FIFO.

Given those circumstances, the data after a repeated START may not be
transferred if the interrupt is asserted while the TX-FIFO is being
filled up. A more reliable way is to append TX data only in the
interrupt handler.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index fad2b00..d8a5db14 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -269,7 +269,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void uniphier_fi2c_tx_init(struct uniphier_fi2c_priv *priv, u16 addr)
+static void uniphier_fi2c_tx_init(struct uniphier_fi2c_priv *priv, u16 addr,
+				  bool repeat)
 {
 	priv->enabled_irqs |= UNIPHIER_FI2C_INT_TE;
 	uniphier_fi2c_set_irqs(priv);
@@ -279,8 +280,12 @@ static void uniphier_fi2c_tx_init(struct uniphier_fi2c_priv *priv, u16 addr)
 	/* set slave address */
 	writel(UNIPHIER_FI2C_DTTX_CMD | addr << 1,
 	       priv->membase + UNIPHIER_FI2C_DTTX);
-	/* first chunk of data */
-	uniphier_fi2c_fill_txfifo(priv, true);
+	/*
+	 * First chunk of data. For a repeated START condition, do not write
+	 * data to the TX fifo here to avoid the timing issue.
+	 */
+	if (!repeat)
+		uniphier_fi2c_fill_txfifo(priv, true);
 }
 
 static void uniphier_fi2c_rx_init(struct uniphier_fi2c_priv *priv, u16 addr)
@@ -361,7 +366,7 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 	if (is_read)
 		uniphier_fi2c_rx_init(priv, msg->addr);
 	else
-		uniphier_fi2c_tx_init(priv, msg->addr);
+		uniphier_fi2c_tx_init(priv, msg->addr, repeat);
 
 	dev_dbg(&adap->dev, "start condition\n");
 	/*
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
