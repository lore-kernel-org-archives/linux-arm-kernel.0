Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AB7C65BB0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935A7214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="thUKaMYe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QVJCzibU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="k1ewxlKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935A7214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MNdWTBsscH/J/PwClGdTV5dJ9JzkA21e0+HbyFbC01U=; b=thUKaMYedLT7/LcRIdnb/dGl2g
	INk0F4O7enLEGL3RoWejAKiermmy6Gx1lC7j+8Iw102SxmVYGymZhB1s5dsNJhmEWVDj5hj3DoUHS
	f/CIWgdJC68Fjz4GO1RuaxhWHx2u8IOZcKu6QnCdmMy7OW29CttU/ohhOz23C2HGO+ybLbDW2Y9p5
	972793PfB3fcaaWpOlB8FHURy/RsSs1mVZXoMjhQbDO3pCBylT9G83bY8bZT/FYknqbU0Iivzq88B
	xxL0fFXc6a2ArXuDuYfDducy0xgAnFHcy/RY0Th/Zp6/DAVS7Uq17bfR+4Fy1aqwaeQ/8Vt+1JQFw
	mVPxqIrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUkmS-0002ii-8B; Thu, 06 Dec 2018 03:56:52 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkmK-0002cc-TO
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 03:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vq9iTJECSWUXoTz65/XclZ3Mf1gaCLqGMYaa34hNQzo=; b=QVJCzibUrFg/Y+ICsSkLCsl2G
 uAegqCgdS8+5CVhDyXEQX8ih266mncLCXVfoyEUbLDyNzXHfmjusnADPfl6Fjl2R8nJyqv936Qybh
 5QC4lDKPSEHriMUjOqdvS3k3Lzq+6bTeMmaO1gyOa/Yi+CFwtBV1wHR8Yk2CLkoLjOuDMvnryBvKu
 HYxnxmGxAC6n72lSm1My8qkJQ5AVzu/lM7W4nDWpFy+6uYnHjOczPVPoqxputAqhMKg0dkxhVE7h1
 MOJ72RxcyhaLXlydO6RrtqHMK2sZd4p60zyDMmrzprPo3eHrZS8PLeEURuwID1dMDj6zIKtMEnvIN
 GL/HF7jxA==;
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkmE-0003ki-5t
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:56:43 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id wB63trS9007398;
 Thu, 6 Dec 2018 12:55:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB63trS9007398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544068556;
 bh=vq9iTJECSWUXoTz65/XclZ3Mf1gaCLqGMYaa34hNQzo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k1ewxlKKR/XsG0V3d2Akt8g4TCv+aHm8a3OUtlC8uoyfqlPwXE86mMbvpBNYHAlGk
 BFw+pLk33zxTefChgiYmvRz76SlVxWnBLj35a8HUEWMpcUJvqzCTkbzMoN2pUZkxVO
 Aqgk9SixT51vdYPldt7PYFF3ed0DzNmduOj+Q644GKI6qusqPACK6k1PxU+L4pmCMi
 qJHrijhwNA+bowo36nqA7rR6QrV4MySgNH/FvcX0nvGW4lGgfRtR/KRfMYth4XZPhf
 VIM1lNbkIJWyYvU3QofXTnynRpj/7Xjn0nbU2rsVxvBhaxfCe/4mWpILRNuQCp570B
 x4fQeA+ztAolA==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 4/4] i2c: uniphier-f: fix violation of tLOW requirement for
 Fast-mode
Date: Thu,  6 Dec 2018 12:55:28 +0900
Message-Id: <1544068528-27657-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_225638_790295_A696D938 
X-CRM114-Status: GOOD (  12.44  )
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

 drivers/i2c/busses/i2c-uniphier-f.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index d8a5db14..03da4a5 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -518,9 +518,26 @@ static void uniphier_fi2c_hw_init(struct uniphier_fi2c_priv *priv)
 
 	uniphier_fi2c_reset(priv);
 
+	/*
+	 *  Standard-mode: tLOW + tHIGH = 10 us
+	 *  Fast-mode:     tLOW + tHIGH = 2.5 us
+	 */
 	writel(cyc, priv->membase + UNIPHIER_FI2C_CYC);
-	writel(cyc / 2, priv->membase + UNIPHIER_FI2C_LCTL);
+	/*
+	 *  Standard-mode: tLOW = 4.7 us, tHIGH = 4.0 us, tBUF = 4.7 us
+	 *  Fast-mode:     tLOW = 1.3 us, tHIGH = 0.6 us, tBUF = 1.3 us
+	 * "tLow/tHIGH = 5/4" meets both.
+	 */
+	writel(cyc * 5 / 9, priv->membase + UNIPHIER_FI2C_LCTL);
+	/*
+	 *  Standard-mode: tHD;STA = 4.0 us, tSU;STA = 4.7 us, tSU;STO = 4.0 us
+	 *  Fast-mode:     tHD;STA = 0.6 us, tSU;STA = 0.6 us, tSU;STO = 0.6 us
+	 */
 	writel(cyc / 2, priv->membase + UNIPHIER_FI2C_SSUT);
+	/*
+	 *  Standard-mode: tSU;DAT = 250 ns
+	 *  Fast-mode:     tSU;DAT = 100 ns
+	 */
 	writel(cyc / 16, priv->membase + UNIPHIER_FI2C_DSUT);
 
 	uniphier_fi2c_prepare_operation(priv);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
