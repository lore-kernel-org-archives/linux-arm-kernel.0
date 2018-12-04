Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C485C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:56:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F99F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GnwBMiQh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy4kgkVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F99F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=95f1GKQTW2AsHCf+XAlLoJ5XDqfek+yjVaWD8JTKFb8=; b=GnwBMiQhpBZmWV
	gKqvHU2F8C1NzJVpJH93wvcJYH6qbSUs7TN8lLjdFMSTgEMCkx6iYjUT3JPBkyCAk0eijZCfkKG3r
	y51MS+owHdXQ1wBrk1NLCotAE739B9QQ+Q9UVZvpBRCaus8sCsFpoWcgeYoX9eZTVMy066tifNsn6
	6ei2z1a7O+8V5LTo/bB+hFUzZuoTFtf8vLOtvnP+wCTpBL+YeTYEkb8SFZrE0U6aVbbuP+tjBzdKt
	W5dNcYtq63C9GpmCJmkO5XVPLJ8zAVcBv2lC96KyCxOzJgPL6a8uB0e4RlHdvlzBYFR4XN7YneYrD
	j4MMG8g00EJqj2z8ZNmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU1p1-0005Cx-4R; Tue, 04 Dec 2018 03:56:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU1oo-00054o-HZ
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 03:56:20 +0000
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net
 [24.23.142.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8018820850;
 Tue,  4 Dec 2018 03:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543895767;
 bh=dsZdKhxiXHRtHC8kR7xOWADk3Xigamj3ZRqAAI73dZk=;
 h=From:To:Cc:Subject:Date:From;
 b=Xy4kgkVQEGMi2I+i8RmN7tNjWW243412p3K/mEKOWEz+Y6p5yk2Ek3KYSZBjxXLRE
 ctuEti6sCcwgINnFBdg0/OzhbDMMkb4SOQCp4gPfsJ3VCi0lkZiMQsrCww0SckDoHO
 GtF6xmJ81H68m5EItEtIcODvm4TNRPmPkETh5cSs=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH v2 0/4] crypto: ARM64 NEON optimized XChaCha and NHPoly1305
 (for Adiantum)
Date: Mon,  3 Dec 2018 19:52:48 -0800
Message-Id: <20181204035252.14853-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_195618_607039_A9DF4415 
X-CRM114-Status: GOOD (  12.68  )
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

Hello,

This series optimizes the Adiantum encryption mode for ARM64 by adding
an ARM64 NEON accelerated implementation of NHPoly1305, specifically the
NH part; and by modifying the existing ARM64 NEON implementation of
ChaCha20 to support XChaCha20 and XChaCha12.

This greatly improves Adiantum performance on ARM64.  For example,
encrypting 4096-byte messages (single-threaded) on a Raspberry Pi 3
Model B v1.2, which has a Cortex-A53 processor:

                           Before            After
                           ---------         ---------
adiantum(xchacha12,aes)    44.1 MB/s         82.7 MB/s
adiantum(xchacha20,aes)    35.5 MB/s         65.7 MB/s

Decryption is almost exactly the same speed as encryption.

The biggest benefit comes from accelerating XChaCha.  Accelerating NH
gives a somewhat smaller, but still significant benefit.

Performance on 512-byte inputs is also improved, though that is much
slower in the first place.  When Adiantium is used with dm-crypt (or
cryptsetup), we recommend using a 4096-byte sector size.

For comparison, on the same hardware AES-256-XTS encryption is only
24.5 MB/s and decryption 21.6 MB/s, both using the NEON-bitsliced
implementation ("xts-aes-neonbs").  That is the fastest AES-256-XTS
implementation on this processor, since it doesn't have the ARMv8
Cryptography Extensions.  This is despite Adiantum also being a super-
pseudorandom permutation (SPRP) over the entire sector, unlike XTS.

Note that XChaCha20 and XChaCha12 can be used for other purposes too.

Changed since v1:
  - Create full stack frame in hchacha_block_neon() and
    chacha_block_xor_neon().
  - Use x30 instead of lr.
  - Fix whitespace in nh-neon-core.S.

Eric Biggers (4):
  crypto: arm64/nhpoly1305 - add NEON-accelerated NHPoly1305
  crypto: arm64/chacha20 - add XChaCha20 support
  crypto: arm64/chacha20 - refactor to allow varying number of rounds
  crypto: arm64/chacha - add XChaCha12 support

 arch/arm64/crypto/Kconfig                     |   7 +-
 arch/arm64/crypto/Makefile                    |   7 +-
 ...hacha20-neon-core.S => chacha-neon-core.S} |  92 +++++---
 arch/arm64/crypto/chacha-neon-glue.c          | 207 ++++++++++++++++++
 arch/arm64/crypto/chacha20-neon-glue.c        | 133 -----------
 arch/arm64/crypto/nh-neon-core.S              | 103 +++++++++
 arch/arm64/crypto/nhpoly1305-neon-glue.c      |  77 +++++++
 7 files changed, 461 insertions(+), 165 deletions(-)
 rename arch/arm64/crypto/{chacha20-neon-core.S => chacha-neon-core.S} (90%)
 create mode 100644 arch/arm64/crypto/chacha-neon-glue.c
 delete mode 100644 arch/arm64/crypto/chacha20-neon-glue.c
 create mode 100644 arch/arm64/crypto/nh-neon-core.S
 create mode 100644 arch/arm64/crypto/nhpoly1305-neon-glue.c

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
