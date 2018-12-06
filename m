Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF82CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:57:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983172082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XfQQIX2y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tuyQ3PWi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kPHi2dOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983172082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EJVZEFeFU6cd27yE4M6bpAVD9nU4PWOw1k0N44wThus=; b=XfQQIX2y3pgmQos6zBoRYkX3gw
	etbDlAqMGcsvBAW7Qik9An4q8yaRZowrE2i0E50dEBKpQLw77OvJQIBGPECsara5PuYrRDcRltCv1
	sHv0hXMvCg7xhY9pBXG4hkbwhJFt/20BHsGXKRm5VAATKRb6DwlXXGNejYygIo1RHHMCXe+LjCPzL
	Kxt3q7jQuXL8ySvO4QA0O4sSq4sl0X3F3Hi18nZYfVLUNFKq+Sjo7DdXvNTwzdvin9IbCQKsiyjxw
	l0vzPEtS/S0kCC9/wX7sY1CHcrZ/q9hx3JloFU2hHagxpOYu0+9vfhGw59wsDBVn/efUzWvXPieEC
	OVhrkV1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUkn0-0003Dq-AT; Thu, 06 Dec 2018 03:57:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkmO-0002fn-Ps
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 03:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2y2cw2qzebvkA+Mtv/XDf/lXFAsgLnN70QsGjRHK68c=; b=tuyQ3PWieN+IvqWHGQwooMI9S
 TdYog9e3MLmFIooY6KdBC4mklB20SvzpGdd3Jta0jPhEIZoWE3k1vT8VFU8H+8K3vdfaADfBcnT+I
 j3dm3jL0XQjOs9hgUj6cmxp6cI2Sd1vZBDYCpLuZPVLj2RMsP03xjSIRSQpa22PC5cbbnCCuSt3tF
 4VyM3fN9rZAgWSTa3m+NsjbhNoxnbRY3OQUfmqHXAj0bJB6jDRr8ESjzP52T3BKbnqDQ4Yq2ZVvKN
 78IaOw27M/ysbSS3tUj7arzh72Xyfe1xtleY9wEUfFpkYjILZWw03WaMpkf9obGnWStgPSjNyfzA3
 r+ejru1xQ==;
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkmE-0003kk-5L
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:56:46 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id wB63trS6007398;
 Thu, 6 Dec 2018 12:55:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB63trS6007398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544068555;
 bh=2y2cw2qzebvkA+Mtv/XDf/lXFAsgLnN70QsGjRHK68c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kPHi2dOEi3qWH6h8XKwY274U9vnp6zKg7l3nNiKvf+kib3GV6+hakUNhgUnJJv/NF
 QHc/hlsIotcEtGB5VC2dt/W9jOMZqqbgx8hd5vZ3ylxiudEBtz8JnBgUwak7qri5rt
 Zpt+7C4FpNFZjl8l8IW8KZNAfoQ1ZMIV8KPl+Aiiilu2M+0j9fYu5OskyJ4UINipp7
 kdkbPwV862Vny5wy2cJZ1alQv9PL7LDEz2AIMbYuPxYGX7ZvElrn9bsnDorMCu/2CW
 oWeUxwZPvHto49Ojo8gn5cZ4aIXQT+MsT1D4wDwCF9w4GI/LiHEO9CTKWOrP9c6CJ/
 1zoDG2ayu67Zw==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 1/4] i2c: uniphier-f: fix timeout error after reading 8 bytes
Date: Thu,  6 Dec 2018 12:55:25 +0900
Message-Id: <1544068528-27657-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_225638_793856_18A685B0 
X-CRM114-Status: GOOD (  17.95  )
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

I was totally screwed up in commit eaba68785c2d ("i2c: uniphier-f:
fix race condition when IRQ is cleared"). Since that commit, if the
number of read bytes is multiple of the FIFO size (8, 16, 24... bytes),
the STOP condition could be issued twice, depending on the timing.
If this happens, the controller will go wrong, resulting in the timeout
error.

It was more than 3 years ago when I wrote this driver, so my memory
about this hardware was vague. Please let me correct the description
in the commit log of eaba68785c2d.

Clearing the IRQ status on exiting the IRQ handler is absolutely
fine. This controller makes a pause while any IRQ status is asserted.
If the IRQ status is cleared first, the hardware may start the next
transaction before the IRQ handler finishes what it supposed to do.

This partially reverts the bad commit with clear comments so that I
will never repeat this mistake.

I also investigated what is happening at the last moment of the read
mode. The UNIPHIER_FI2C_INT_RF interrupt is asserted a bit earlier
(by half a period of the clock cycle) than UNIPHIER_FI2C_INT_RB.

I consulted a hardware engineer, and I got the following information:

UNIPHIER_FI2C_INT_RF
    asserted at the falling edge of SCL at the 8th bit.

UNIPHIER_FI2C_INT_RB
    asserted at the rising edge of SCL at the 9th (ACK) bit.

In order to avoid calling uniphier_fi2c_stop() twice, check the latter
interrupt. I also commented this because it is obscure hardware internal.

Fixes: eaba68785c2d ("i2c: uniphier-f: fix race condition when IRQ is cleared")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index dd38474..fad2b00 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -173,8 +173,6 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 		"interrupt: enabled_irqs=%04x, irq_status=%04x\n",
 		priv->enabled_irqs, irq_status);
 
-	uniphier_fi2c_clear_irqs(priv, irq_status);
-
 	if (irq_status & UNIPHIER_FI2C_INT_STOP)
 		goto complete;
 
@@ -214,7 +212,13 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 
 	if (irq_status & (UNIPHIER_FI2C_INT_RF | UNIPHIER_FI2C_INT_RB)) {
 		uniphier_fi2c_drain_rxfifo(priv);
-		if (!priv->len)
+		/*
+		 * If the number of bytes to read is multiple of the FIFO size
+		 * (msg->len == 8, 16, 24, ...), the INT_RF bit is set a little
+		 * earlier than INT_RB. We wait for INT_RB to confirm the
+		 * completion of the current message.
+		 */
+		if (!priv->len && (irq_status & UNIPHIER_FI2C_INT_RB))
 			goto data_done;
 
 		if (unlikely(priv->flags & UNIPHIER_FI2C_MANUAL_NACK)) {
@@ -253,6 +257,13 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 	}
 
 handled:
+	/*
+	 * This controller makes a pause while any bit of the IRQ status is
+	 * asserted. Clear the asserted bit to kick the controller just before
+	 * exiting the handler.
+	 */
+	uniphier_fi2c_clear_irqs(priv, irq_status);
+
 	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
