Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78B1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45022184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cUCMVNnj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="yJXIoeis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45022184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IfP+4F0aTVstIF0Bek9VRluDt+6Z8cXa9kiygwsvqB0=; b=cUCMVNnjn3B0/b
	IVD31lweJRWYJt2pvLx/8ZJxSs3sTY64iu+5teXSYt25BiTNNg+lTuPmBaLWOmMYZ5HF4vyTOA2eg
	g5tXPg5BPuGbnApd9MSihfW5h/bRX9WsrjE8/i2J1XYa+jbzijaVGLG5XgElyAAhkMg6VfPHCMgaG
	K2zZIXdtDDtCNrU4T/Of35riqYxygOhq07N5HTYN/0Mnr1cN1Lx7RsDYwiTP2KlJO2dQY2qKsS496
	3ozGhe7YH4AdxlowouhteWrZJ42o4+OLSxjmxPUKHKUaEcTv/3gd5TYfCAZbJhUPADI97gK+fg4Im
	H25yT/Q9ilFZmOIuEdWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfAr1-0001Xa-9Q; Thu, 03 Jan 2019 21:48:39 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfAqW-00014V-GB
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 21:48:11 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id B08DB5C0DDD;
 Thu,  3 Jan 2019 22:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1546552084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nm4UmKZymvFz3g4I1uxh32+ZhB2G26RZTf6BIquMT90=;
 b=yJXIoeisnxddINmwN39ZHj+JAuzeVDTn1UH/6K4YvXOHmGagmySEJzLiI2ct+79pOmhNQL
 NkN7J/DQx+puP8yB+g1pCUlAX6PgQ/MdJLWwlim5nkRVIjagqg+u7U6ZOdP2wO4jKhxD1D
 Gys+/LYDKwV5j0ns1P6pbVvBlQhc9Z0=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH v2 2/3] ARM: uaccess: use unified assembler language syntax
Date: Thu,  3 Jan 2019 22:48:14 +0100
Message-Id: <5ef2acc655abfbe8bfa2cd30ecc5c2286b8fdfa3.1546551693.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1546551693.git.stefan@agner.ch>
References: <cover.1546551693.git.stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_134808_854905_34B31E7B 
X-CRM114-Status: GOOD (  12.03  )
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


 arch/arm/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 6390a40f16e7..a50f9b4e2574 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -86,7 +86,8 @@ static inline void set_fs(mm_segment_t fs)
 #define __range_ok(addr, size) ({ \
 	unsigned long flag, roksum; \
 	__chk_user_ptr(addr);	\
-	__asm__("adds %1, %2, %3; sbcccs %1, %1, %0; movcc %0, #0" \
+	__asm__(".syntax unified\n" \
+		"adds %1, %2, %3; sbcscc %1, %1, %0; movcc %0, #0" \
 		: "=&r" (flag), "=&r" (roksum) \
 		: "r" (addr), "Ir" (size), "0" (current_thread_info()->addr_limit) \
 		: "cc"); \
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
