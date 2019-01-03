Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE7AC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB6F2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YhCgiMo5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="TYA9x5Pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB6F2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wgDt1Ufwvy49IMachKo/5bgD1sOrX+BxPzDumVAgwIU=; b=YhCgiMo5843R/F
	9HrgO5ckXeZWEKA4N3dxR5DKasxsXGhU28s/EYrSe2pNejcVLqfAqOyDf9XIHKaW+p3C1I9Ji/EIK
	NoRq4vKqUmhSPihJwJ0uzJwZleZvAo7UxFDrnsrAjzrkhauxfvpbTpALMRvCU4ZfILglZJelHpxCR
	BnuUIBphh461ZZbn37fqdACSfN1OiDu/KFp2UGJ7w8uf0ayRx6SgZ2HG+9tympFHkOezHTIGFQr9P
	fpbbsRQuExyToywpEtYvbFZpRMYuDsr/9HnZqbTVabsF5e+TLpOVs0XiQypYHSkISFYC53zVlncRI
	JMWA1ysNo+dGoERi5wXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfAqZ-000161-UA; Thu, 03 Jan 2019 21:48:11 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfAqW-00014Y-Fk
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 21:48:10 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id CA7F05C0DDF;
 Thu,  3 Jan 2019 22:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1546552084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51xr4xYeiDI4RYE/PzJ1r3c7j9DrlQRWm/NtP3kFLMo=;
 b=TYA9x5Pbx82LwyMAxfQFwLLbyerlqWRVh6xzfBxrmlh0atGvPW3XcVQsq/y2JumNzAfNWt
 CrI/k3g0KviFz4yPmJ3bpS5PPO4RCqSgg0m7bnXUT6HvQx1fSYo3Ic+rj6rd+oeRLah9yI
 75rzeDJ1Tv2q5z8ZZMuV7DxF6z7B57s=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH v2 3/3] ARM: spinlock: use unified assembler language syntax
Date: Thu,  3 Jan 2019 22:48:15 +0100
Message-Id: <ad0fbab91f337ec99e3a2a3d60886a785da34366.1546551693.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1546551693.git.stefan@agner.ch>
References: <cover.1546551693.git.stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_134808_845127_38C67F06 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: nicolas.pitre@linaro.org, mark.rutland@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, peterz@infradead.org, will.deacon@arm.com,
 julien.thierry@arm.com, ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, mingo@redhat.com, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert the conditional infix to a postfix to make sure this inline
assembly is unified syntax. Since gcc assumes non-unified syntax
when emitting ARM instructions, make sure to define the syntax as
unified.

This allows to use LLVM's integrated assembler.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes since v1:
- Explicitly use unified syntax for inline assembly


 arch/arm/include/asm/spinlock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 099c78fcf62d..8f009e788ad4 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -210,11 +210,12 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 
 	prefetchw(&rw->lock);
 	__asm__ __volatile__(
+"	.syntax unified\n"
 "1:	ldrex	%0, [%2]\n"
 "	adds	%0, %0, #1\n"
 "	strexpl	%1, %0, [%2]\n"
 	WFE("mi")
-"	rsbpls	%0, %1, #0\n"
+"	rsbspl	%0, %1, #0\n"
 "	bmi	1b"
 	: "=&r" (tmp), "=&r" (tmp2)
 	: "r" (&rw->lock)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
