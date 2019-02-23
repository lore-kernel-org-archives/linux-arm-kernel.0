Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250D7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:55:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D71206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rtgusoyq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH8pG9Is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D71206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aXklGaXK/q73CY1n6ruiCosMpbu77u1UjaKXdqf7ILo=; b=rtgusoyqA4i9/4
	d2a15uDOk7Y6MQOq3jK4KnPDQlkaPhXVCNPEICvDjHM0k4aTd2A7KpC81On8fO4NqEgkdZPS6+edf
	SFJ6F+fS4jNWfzxe/4fHnEjYY0HGqUUvca6WjXCUCX0Rv1Oee6vSl2V2joDvjYk0YMvAei8iQ59iR
	m+5ZqombzkFab2KDtAYRJlziGAxa7ftEzYvogUWDUVk9Zy5+p5lrFBUOfqW8xdYHr9zt3+4Yyki5t
	X0frSrT7X1ll6jJbc8e8xkZhU0kXAtYFlORtvVWDdA8MWtm0hDpOheQZTQRxXUeVztoFaMqvG5mG4
	QcYEyyo8sE+jTaZtezLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxRDB-0000fs-0V; Sat, 23 Feb 2019 06:55:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxRD7-0000ek-Oc
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 06:54:59 +0000
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net
 [107.3.167.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AE87B20850;
 Sat, 23 Feb 2019 06:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550904896;
 bh=2XrlCUT7qEpiaH1OBGcETHEtJDXAxNreBpz708hMj6g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dH8pG9IsMdbMk6KKeeKvBeeScV/LFII8AuBpV861tCOE5IirCGhlcS1kXSxCk+n/c
 yTbJJDb+KAME+nUkHH4DqyQNWn2exSmBnZPN6kpQ+Oh9aekLD/qrwYd6JaM+e7uen5
 XD5UQLIYhmLiPoshNn2Y3+tS8XuyD2fndgaPBu0I=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 2/2] crypto: arm64/chacha - fix hchacha_block_neon() for big
 endian
Date: Fri, 22 Feb 2019 22:54:08 -0800
Message-Id: <20190223065408.6279-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190223065408.6279-1-ebiggers@kernel.org>
References: <20190223065408.6279-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_225457_819724_17EDC23E 
X-CRM114-Status: UNSURE (   9.38  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Eric Biggers <ebiggers@google.com>

On big endian arm64 kernels, the xchacha20-neon and xchacha12-neon
self-tests fail because hchacha_block_neon() outputs little endian words
but the C code expects native endianness.  Fix it to output the words in
native endianness (which also makes it match the arm32 version).

Fixes: cc7cf991e9eb ("crypto: arm64/chacha20 - add XChaCha20 support")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/chacha-neon-core.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/chacha-neon-core.S b/arch/arm64/crypto/chacha-neon-core.S
index bfb80e10ff7b0..706c4e10e9e29 100644
--- a/arch/arm64/crypto/chacha-neon-core.S
+++ b/arch/arm64/crypto/chacha-neon-core.S
@@ -158,8 +158,8 @@ ENTRY(hchacha_block_neon)
 	mov		w3, w2
 	bl		chacha_permute
 
-	st1		{v0.16b}, [x1], #16
-	st1		{v3.16b}, [x1]
+	st1		{v0.4s}, [x1], #16
+	st1		{v3.4s}, [x1]
 
 	ldp		x29, x30, [sp], #16
 	ret
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
