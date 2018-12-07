Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7508C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:11:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A857A2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ObSVW63r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A857A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=f0nCmNRWA65aV5u4lcVhsxYZqIEZ/bt46Zc2caYCgPo=; b=ObSVW63rV10YFp4qrR+MDr9b6z
	kwS5ivQJrvcCwS7UVCCgaV1V5LOnN7dgu4TvgNo91F1oEK4dr1R9H9i6wbUPIRd28k7MOi2CVuviu
	Lk/I6Y9ENFP+6pIAY0N7n01TIptp6yafiqbmMsb3OzIluRiYRjKYv5Lx1ZGvAM1X1cR9KDq2ijW2d
	Hw6swhU4CKjmmCzTdSzkGh/5K3j8lphOU9+2RkpQpuYnnXVJ5xHYB4qQO6/ik28bFSOiO6BoCDWVX
	GXyjjk2ZWibVF8HigQcNE+zarQTe47+E8A2OnLX0TwZYkMwbJTyZdH7HMGt2EloiQ2PRIsfndf1gr
	EXtH6pQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKaa-0003KQ-0z; Fri, 07 Dec 2018 18:11:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKYZ-0008Nw-VT
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:09:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 440081AED;
 Fri,  7 Dec 2018 10:08:44 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 57ED33F5AF;
 Fri,  7 Dec 2018 10:08:43 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 08/10] arm64: string: use asm EXPORT_SYMBOL()
Date: Fri,  7 Dec 2018 18:08:21 +0000
Message-Id: <20181207180823.36612-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207180823.36612-1-mark.rutland@arm.com>
References: <20181207180823.36612-1-mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_100856_511408_C14F561C 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For a while now it's been possible to use EXPORT_SYMBOL() in assembly
files, which allows us to place exports immediately after assembly
functions, as we do for C functions.

As a step towards removing arm64ksyms.c, let's move the string routine
exports to the assembly files the functions are defined in. Routines
which should only be exported for !KASAN builds are exported using the
EXPORT_SYMBOL_NOKASAN() helper.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c | 20 --------------------
 arch/arm64/lib/memchr.S        |  1 +
 arch/arm64/lib/memcmp.S        |  1 +
 arch/arm64/lib/memcpy.S        |  2 ++
 arch/arm64/lib/memmove.S       |  2 ++
 arch/arm64/lib/memset.S        |  2 ++
 arch/arm64/lib/strchr.S        |  1 +
 arch/arm64/lib/strcmp.S        |  1 +
 arch/arm64/lib/strlen.S        |  1 +
 arch/arm64/lib/strncmp.S       |  1 +
 arch/arm64/lib/strnlen.S       |  1 +
 arch/arm64/lib/strrchr.S       |  1 +
 12 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 02019667e319..c142103bc0fe 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -19,7 +19,6 @@
 
 #include <linux/export.h>
 #include <linux/sched.h>
-#include <linux/string.h>
 #include <linux/cryptohash.h>
 #include <linux/delay.h>
 #include <linux/in6.h>
@@ -29,25 +28,6 @@
 
 #include <asm/checksum.h>
 
-	/* string / mem functions */
-#ifndef CONFIG_KASAN
-EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strncmp);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memchr);
-#endif
-
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(__memcpy);
-EXPORT_SYMBOL(__memmove);
-
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(_mcount);
 NOKPROBE_SYMBOL(_mcount);
diff --git a/arch/arm64/lib/memchr.S b/arch/arm64/lib/memchr.S
index 0f164a4baf52..f146b7ecd28f 100644
--- a/arch/arm64/lib/memchr.S
+++ b/arch/arm64/lib/memchr.S
@@ -42,3 +42,4 @@ WEAK(memchr)
 2:	mov	x0, #0
 	ret
 ENDPIPROC(memchr)
+EXPORT_SYMBOL_NOKASAN(memchr)
diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
index fb295f52e9f8..e2e629b09049 100644
--- a/arch/arm64/lib/memcmp.S
+++ b/arch/arm64/lib/memcmp.S
@@ -256,3 +256,4 @@ CPU_LE( rev	data2, data2 )
 	mov	result, #0
 	ret
 ENDPIPROC(memcmp)
+EXPORT_SYMBOL_NOKASAN(memcmp)
diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index 67613937711f..b4f82888ed60 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -74,4 +74,6 @@ ENTRY(memcpy)
 #include "copy_template.S"
 	ret
 ENDPIPROC(memcpy)
+EXPORT_SYMBOL(memcpy)
 ENDPROC(__memcpy)
+EXPORT_SYMBOL(__memcpy)
diff --git a/arch/arm64/lib/memmove.S b/arch/arm64/lib/memmove.S
index a5a4459013b1..ef12f719d99d 100644
--- a/arch/arm64/lib/memmove.S
+++ b/arch/arm64/lib/memmove.S
@@ -197,4 +197,6 @@ ENTRY(memmove)
 	b.ne	.Ltail63
 	ret
 ENDPIPROC(memmove)
+EXPORT_SYMBOL(memmove)
 ENDPROC(__memmove)
+EXPORT_SYMBOL(__memmove)
diff --git a/arch/arm64/lib/memset.S b/arch/arm64/lib/memset.S
index f2670a9f218c..a79cf118d6d0 100644
--- a/arch/arm64/lib/memset.S
+++ b/arch/arm64/lib/memset.S
@@ -216,4 +216,6 @@ ENTRY(memset)
 	b.ne	.Ltail_maybe_long
 	ret
 ENDPIPROC(memset)
+EXPORT_SYMBOL(memset)
 ENDPROC(__memset)
+EXPORT_SYMBOL(__memset)
diff --git a/arch/arm64/lib/strchr.S b/arch/arm64/lib/strchr.S
index 7c83091d1bcd..b179421f46c7 100644
--- a/arch/arm64/lib/strchr.S
+++ b/arch/arm64/lib/strchr.S
@@ -40,3 +40,4 @@ WEAK(strchr)
 	csel	x0, x0, xzr, eq
 	ret
 ENDPROC(strchr)
+EXPORT_SYMBOL_NOKASAN(strchr)
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 7d5d15398bfb..c306c7b88574 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -232,3 +232,4 @@ CPU_BE(	orr	syndrome, diff, has_nul )
 	sub	result, data1, data2, lsr #56
 	ret
 ENDPIPROC(strcmp)
+EXPORT_SYMBOL_NOKASAN(strcmp)
diff --git a/arch/arm64/lib/strlen.S b/arch/arm64/lib/strlen.S
index 8e0b14205dcb..2a0240937416 100644
--- a/arch/arm64/lib/strlen.S
+++ b/arch/arm64/lib/strlen.S
@@ -124,3 +124,4 @@ CPU_LE( lsr	tmp2, tmp2, tmp1 )	/* Shift (tmp1 & 63).  */
 	csel	data2, data2, data2a, le
 	b	.Lrealigned
 ENDPIPROC(strlen)
+EXPORT_SYMBOL_NOKASAN(strlen)
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index 66bd145935d9..c5d567afb039 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -308,3 +308,4 @@ CPU_BE( orr	syndrome, diff, has_nul )
 	mov	result, #0
 	ret
 ENDPIPROC(strncmp)
+EXPORT_SYMBOL_NOKASAN(strncmp)
diff --git a/arch/arm64/lib/strnlen.S b/arch/arm64/lib/strnlen.S
index 355be04441fe..e21e536d420e 100644
--- a/arch/arm64/lib/strnlen.S
+++ b/arch/arm64/lib/strnlen.S
@@ -169,3 +169,4 @@ CPU_LE( lsr	tmp2, tmp2, tmp4 )	/* Shift (tmp1 & 63).  */
 	mov	len, limit
 	ret
 ENDPIPROC(strnlen)
+EXPORT_SYMBOL_NOKASAN(strnlen)
diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
index ea84924d5990..47e1593016dc 100644
--- a/arch/arm64/lib/strrchr.S
+++ b/arch/arm64/lib/strrchr.S
@@ -41,3 +41,4 @@ WEAK(strrchr)
 2:	mov	x0, x3
 	ret
 ENDPIPROC(strrchr)
+EXPORT_SYMBOL_NOKASAN(strrchr)
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
