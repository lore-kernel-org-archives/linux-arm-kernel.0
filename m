Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D38C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:55:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D76206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cMhjXGU4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vz5fNhgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D76206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6dFDNoigsuf7aytjvhpaKSVVUNnvb1q3/Zm5d/7o6sI=; b=cMhjXGU4MlvBuJ
	UjmzMOstCK0KrmnuGCS3FyIXqosKOq3NbOCC2sDgBLQV20DpkeAIJ0p70XKIy8W9FxHnB6qwx0CKv
	uvjZ7ZlySA4ObFrK7uhgZbxJRCnkgETlXLSy8DLxBV9wx/fOmzNIY/CCnzcf6eQS1noaaLFBM5x5+
	RQsmlhFidt+HGlgb/WtBO0qY4loY7cfOOxvCdtq5Tmp4ngxg3Z36u2Ijb6q3gtXSRqsDlbjzKmi9Y
	WsOaBFSGdSAiXnjpwW/7MUO29ntQ1oPhYIkmvTqLnp9sH8gXdmVNAhEJNA4K9zLXrvTfIWr88bXUv
	Ckgd0VDRhCOP9Bsv5ghg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxRDj-0002Mj-OF; Sat, 23 Feb 2019 06:55:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxRD7-0000ei-P9
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 06:55:00 +0000
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net
 [107.3.167.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 66CAF2084F;
 Sat, 23 Feb 2019 06:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550904896;
 bh=VOex6a/KVhlniQ8M81yXqiQT1HF/i0aCsGxN28g2aCQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vz5fNhgpEd1BCWfZWFFB+4gbagJU6ox4k3j5tamwEIRo71g92bEwjTENhD3HGc8is
 ZBym1atSSeiIhQuTQrVfplVMXBLvyoIvy7csGmYUhXMnF2LqZ6O1RO0CN3uZQOyxVq
 APDMqSn4DVsccd0lyYGdfv6mpKHwKmOihgAM5d7k=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 1/2] crypto: arm64/chacha - fix chacha_4block_xor_neon() for
 big endian
Date: Fri, 22 Feb 2019 22:54:07 -0800
Message-Id: <20190223065408.6279-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190223065408.6279-1-ebiggers@kernel.org>
References: <20190223065408.6279-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_225457_830299_EA78C92B 
X-CRM114-Status: UNSURE (   8.12  )
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

The change to encrypt a fifth ChaCha block using scalar instructions
caused the chacha20-neon, xchacha20-neon, and xchacha12-neon self-tests
to start failing on big endian arm64 kernels.  The bug is that the
keystream block produced in 32-bit scalar registers is directly XOR'd
with the data words, which are loaded and stored in native endianness.
Thus in big endian mode the data bytes end up XOR'd with the wrong
bytes.  Fix it by byte-swapping the keystream words in big endian mode.

Fixes: 2fe55987b262 ("crypto: arm64/chacha - use combined SIMD/ALU routine for more speed")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/chacha-neon-core.S | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/crypto/chacha-neon-core.S b/arch/arm64/crypto/chacha-neon-core.S
index 021bb9e9784b2..bfb80e10ff7b0 100644
--- a/arch/arm64/crypto/chacha-neon-core.S
+++ b/arch/arm64/crypto/chacha-neon-core.S
@@ -532,6 +532,10 @@ ENTRY(chacha_4block_xor_neon)
 	add		v3.4s, v3.4s, v19.4s
 	  add		a2, a2, w8
 	  add		a3, a3, w9
+CPU_BE(	  rev		a0, a0		)
+CPU_BE(	  rev		a1, a1		)
+CPU_BE(	  rev		a2, a2		)
+CPU_BE(	  rev		a3, a3		)
 
 	ld4r		{v24.4s-v27.4s}, [x0], #16
 	ld4r		{v28.4s-v31.4s}, [x0]
@@ -552,6 +556,10 @@ ENTRY(chacha_4block_xor_neon)
 	add		v7.4s, v7.4s, v23.4s
 	  add		a6, a6, w8
 	  add		a7, a7, w9
+CPU_BE(	  rev		a4, a4		)
+CPU_BE(	  rev		a5, a5		)
+CPU_BE(	  rev		a6, a6		)
+CPU_BE(	  rev		a7, a7		)
 
 	// x8[0-3] += s2[0]
 	// x9[0-3] += s2[1]
@@ -569,6 +577,10 @@ ENTRY(chacha_4block_xor_neon)
 	add		v11.4s, v11.4s, v27.4s
 	  add		a10, a10, w8
 	  add		a11, a11, w9
+CPU_BE(	  rev		a8, a8		)
+CPU_BE(	  rev		a9, a9		)
+CPU_BE(	  rev		a10, a10	)
+CPU_BE(	  rev		a11, a11	)
 
 	// x12[0-3] += s3[0]
 	// x13[0-3] += s3[1]
@@ -586,6 +598,10 @@ ENTRY(chacha_4block_xor_neon)
 	add		v15.4s, v15.4s, v31.4s
 	  add		a14, a14, w8
 	  add		a15, a15, w9
+CPU_BE(	  rev		a12, a12	)
+CPU_BE(	  rev		a13, a13	)
+CPU_BE(	  rev		a14, a14	)
+CPU_BE(	  rev		a15, a15	)
 
 	// interleave 32-bit words in state n, n+1
 	  ldp		w6, w7, [x2], #64
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
