Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B68C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478482082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sbdX8oQy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="N5WC2H/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478482082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wIya2b7yvMk9uPTbz6hTnP23onoJXG14bxNoWh/ShX0=; b=sbdX8oQyqRpz9OjFzCQ+djXd57
	n2xoy5+ZWX+rXLpa9DApg7ZQR1NCQ2noc4ImWshkQYdsTA72dlxjiNgrFoyBV2m5RB0oyhsnFPNTq
	12ffhM72GQ0NkI1ioNmZBQz/EVMMvpyD2PGg9FtCZQSy6Sa12Wl4OVCtbfyXc8KdCmHn5bnqzxdDN
	aYm6TcWh6uLojVwVXW66YpsNMOEo0HmVlHONmde5Qj/0DVHcQOoObUcmlf71bHyTyKCob/LathFqd
	4RBCMN+2m2dZ9X0iziYsbYMoff7/hNd0J//dQst61pmVwX33KaOigoDXJDNKd6iuqGRdKK0yAiUAb
	idwc8qUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUkmC-0002WG-9t; Thu, 06 Dec 2018 03:56:36 +0000
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUklw-0002Fw-6B
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:56:33 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id wB63trS8007398;
 Thu, 6 Dec 2018 12:55:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB63trS8007398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544068556;
 bh=i2DTwxcgMHeHYcJ2f2azxuoZs+0qhk4Q7YQ7oWQJxew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N5WC2H/19yIcfPFEM11mY3qrS+Dnr9VtgGLKAPEEzKvosZOQB6FhhFkTUJ+ME17cq
 qVTZX3NojjlORMZn4SUYlKzCLSyiT+jOJSjEEbeq2m6jv9ipvDARy7mgPgfaBUvp0e
 RzYLffsbwNhdGywqJFTlJC3BKLEsFHI5/Zj37Oslp7noqh+S8yMRWAVJQSq50+Zfyi
 uXP0DA3VZTRrxrJLxJ9MclnSUZIUqUT6wWt5SkTF3SzsQC8af322i9bmWcUqbhn73Y
 BcewCncPKUhKKsp8htfrvPQ9dit9hmtx9vwyyGqNCJ0qJKUfUKVbOBmNU/0iWdE2IS
 mWgghyI6yiowg==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 3/4] i2c: uniphier: fix violation of tLOW requirement for
 Fast-mode
Date: Thu,  6 Dec 2018 12:55:27 +0900
Message-Id: <1544068528-27657-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_195620_862714_4B739FC0 
X-CRM114-Status: UNSURE (   9.26  )
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, the clock duty is set as tLOW/tHIGH = 1/1. For Fast-mode,
tLOW is set to 1.25 us while the I2C spec requires tLOW >= 1.3 us.

tLOW/tHIGH = 5/4 would meet both Standard-mode and Fast-mode:
  Standard-mode: tLOW = 5.56 us, tHIGH = 4.44 us
  Fast-mode:     tLOW = 1.39 us, tHIGH = 1.11 us

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 454f914..c488e55 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -320,7 +320,13 @@ static void uniphier_i2c_hw_init(struct uniphier_i2c_priv *priv)
 
 	uniphier_i2c_reset(priv, true);
 
-	writel((cyc / 2 << 16) | cyc, priv->membase + UNIPHIER_I2C_CLK);
+	/*
+	 * Bit30-16: clock cycles of tLOW.
+	 *  Standard-mode: tLOW = 4.7 us, tHIGH = 4.0 us
+	 *  Fast-mode:     tLOW = 1.3 us, tHIGH = 0.6 us
+	 * "tLow/tHIGH = 5/4" meets both.
+	 */
+	writel((cyc * 5 / 9 << 16) | cyc, priv->membase + UNIPHIER_I2C_CLK);
 
 	uniphier_i2c_reset(priv, false);
 }
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
