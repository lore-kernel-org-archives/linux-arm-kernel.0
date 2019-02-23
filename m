Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C06C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:55:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373EC2084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NvbcetsP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7m68T8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373EC2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N8FH5XczHGTT3us0UZXIN5MAADQ5WkxYjsyL7SVK6Vs=; b=NvbcetsP7pP+Tm
	YQUHt6RmssbaOwO+JJlsvBZ1wpwpAr6Ov2D/c55K/qWQHCem5k6T6MreU6Yi1JiOtMt4z15h64MVc
	AJtSsIgwVC1+RRyn5oDGPrR8sL81Frz2RWVBUHp7xN0EJ/DYQnwrNEjAqgmi7+pLbK4QPbiGkjnsu
	cNuifxda/0sRGkUSxi6FLLwzDdo/BW4JNmhSsmqvBhgtRfo60rEnJOWDeofHnH9+vGTLvDzvQZK4l
	vd91qJHMW6bFwOxIVhatr6fBWVRI4t1uFS6huipcHqCpx6X+6jhi3/WUBa99kM0jM2gchUr7l2YAo
	7yt31I/d2QoLuib10mGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxRDM-0001SN-0j; Sat, 23 Feb 2019 06:55:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxRD7-0000ef-Ox
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 06:54:59 +0000
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net
 [107.3.167.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 13461206B6;
 Sat, 23 Feb 2019 06:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550904896;
 bh=Fi5RcKlY33Q/JZGZ95BKFi0vQ+WhbtLEdR4ENFo+40s=;
 h=From:To:Cc:Subject:Date:From;
 b=P7m68T8ccurxE4wMdJyrygKuwFNMQK54rgWSwkb8gEp+Arghq7unl+fVdQ5WMrJ79
 XZQK6ezLeqU1Gojbr5V091WpS8JHgUnlM3yQyu+eYtUbFrUakN8tViEkpoBOm7F+mV
 R3JUogbIqnTPu9lp0D7luMJpb2qusMtEpJdDtHf4=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 0/2] crypto: arm64/chacha - fix for big endian
Date: Fri, 22 Feb 2019 22:54:06 -0800
Message-Id: <20190223065408.6279-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_225457_824237_F9747638 
X-CRM114-Status: UNSURE (   6.99  )
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

I ran the crypto self-tests on big endian arm and arm64 kernels in QEMU.
The arm64 implementation of ChaCha (and XChaCha) is failing, so this
series fixes it.

Please consider sending to Linus for v5.0 if there's time, as this fixes
commits that are new in v5.0.

Eric Biggers (2):
  crypto: arm64/chacha - fix chacha_4block_xor_neon() for big endian
  crypto: arm64/chacha - fix hchacha_block_neon() for big endian

 arch/arm64/crypto/chacha-neon-core.S | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
