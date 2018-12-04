Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF93C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:56:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF4D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QjSJRmAX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU1Dv1/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF4D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZReLyOyxWGn+bLi01ieFBDMvvQZ4d8PoC82OiEn1kL4=; b=QjSJRmAXfQ4vH2
	qESJ2/ns2MvTz/i3JIT/10BUFLIWiRHvlQ0yoweB6K4M1sFbIBWRntlZMUynuB7ybHhT22TajRqDh
	O+j7qHX6hXUA/7ypaQS/JTTcsIgdst0QVJ8v5ZHuPnHl83Z0GJLDx53oJ7l2uzw1879g4st5znotT
	bmKflzLQBugMy142CpejtGV+InFH4intAFRqsijyU6prIAYEJKqMvG7ByyoY48MRX8gAA20bJBnHN
	wmdHSTAP7KzCdxk2m6OI8dcTIHxVisVQRglpcBt9pUpnj4b4oLMvJG8kYHv3yC2XuZ799LLXrau/D
	BZgSCgL1lQrw2r+/NoUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU1os-00056H-JD; Tue, 04 Dec 2018 03:56:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU1oo-00054t-Ha
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 03:56:20 +0000
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net
 [24.23.142.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ED30E214DA;
 Tue,  4 Dec 2018 03:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543895769;
 bh=9sqEpCOjIyWA2Z9z1Qrp9WtcLxh4o/dxsqsNsRv+aLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cU1Dv1/qRyL4eZgfrDygHyWN/4hjxW/HvodmSXDhxFCAbUCcXPJrrQSnElIiIA84g
 7t0Fu/1yEHI3Ky4t/hTxqr3nb/7Tyz8URpRlCAURkcjLSNCF+C0U9HsEmxGiP9a44z
 muiw9cAiYJH05AmByrKVVmQvioy9ExR2I5DDMxH4=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH v2 4/4] crypto: arm64/chacha - add XChaCha12 support
Date: Mon,  3 Dec 2018 19:52:52 -0800
Message-Id: <20181204035252.14853-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204035252.14853-1-ebiggers@kernel.org>
References: <20181204035252.14853-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_195618_603980_420920AF 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Eric Biggers <ebiggers@google.com>

Now that the ARM64 NEON implementation of ChaCha20 and XChaCha20 has
been refactored to support varying the number of rounds, add support for
XChaCha12.  This is identical to XChaCha20 except for the number of
rounds, which is 12 instead of 20.  This can be used by Adiantum.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/Kconfig            |  2 +-
 arch/arm64/crypto/chacha-neon-glue.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index d54ddb8468ef..d9a523ecdd83 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -101,7 +101,7 @@ config CRYPTO_AES_ARM64_NEON_BLK
 	select CRYPTO_SIMD
 
 config CRYPTO_CHACHA20_NEON
-	tristate "ChaCha20 and XChaCha20 stream ciphers using NEON instructions"
+	tristate "ChaCha20, XChaCha20, and XChaCha12 stream ciphers using NEON instructions"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_CHACHA20
diff --git a/arch/arm64/crypto/chacha-neon-glue.c b/arch/arm64/crypto/chacha-neon-glue.c
index 4d992029b912..346eb85498a1 100644
--- a/arch/arm64/crypto/chacha-neon-glue.c
+++ b/arch/arm64/crypto/chacha-neon-glue.c
@@ -161,6 +161,22 @@ static struct skcipher_alg algs[] = {
 		.setkey			= crypto_chacha20_setkey,
 		.encrypt		= xchacha_neon,
 		.decrypt		= xchacha_neon,
+	}, {
+		.base.cra_name		= "xchacha12",
+		.base.cra_driver_name	= "xchacha12-neon",
+		.base.cra_priority	= 300,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct chacha_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= CHACHA_KEY_SIZE,
+		.max_keysize		= CHACHA_KEY_SIZE,
+		.ivsize			= XCHACHA_IV_SIZE,
+		.chunksize		= CHACHA_BLOCK_SIZE,
+		.walksize		= 4 * CHACHA_BLOCK_SIZE,
+		.setkey			= crypto_chacha12_setkey,
+		.encrypt		= xchacha_neon,
+		.decrypt		= xchacha_neon,
 	}
 };
 
@@ -187,3 +203,5 @@ MODULE_ALIAS_CRYPTO("chacha20");
 MODULE_ALIAS_CRYPTO("chacha20-neon");
 MODULE_ALIAS_CRYPTO("xchacha20");
 MODULE_ALIAS_CRYPTO("xchacha20-neon");
+MODULE_ALIAS_CRYPTO("xchacha12");
+MODULE_ALIAS_CRYPTO("xchacha12-neon");
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
