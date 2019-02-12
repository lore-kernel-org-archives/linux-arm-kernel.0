Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB64C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:02:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D472222C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zgx1quje";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="hME3mkaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D472222C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BB9GBrKfs91k9c64nVuIwuWjv3H2VPUW4WE21Oug+5Y=; b=Zgx1qujetFFiSM
	fjtQ+NmFh1laD4+cEbhHLJ3iHrzhrAOVZKQ6Og8qrn+sXyl+LVmV1mOc/z/KwPVQQrRyzr4lj7eVJ
	M59CPCGp0FoZ0+XBNlJ0ZzUTD6yLyaYvGHhz7r2qlFr7o5ivTxzxdo6ZckPrfJkI1QrBC96nDhwxk
	0bAI/UkkXRDp2m4wuZFsw0kZnU19+RW9TlIMh1odJY5O9i7KGv6I5eVGaFQoN52XZlbkLhRpUnf5h
	rlQbfBcr0wGqEAPoX6DTuhjBaZl7tHChljuiCagYvg3qveaIOUz4rYkFEyrKKxEcuy3UTIQZMn1fB
	Xqui7KN8UPZalXQU+GgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gteGN-0006Bh-0h; Tue, 12 Feb 2019 20:02:39 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gteFn-0005gV-J3
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:02:07 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id F340E5C0E10;
 Tue, 12 Feb 2019 21:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1550001718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bun+cvAdHIasxPqS/vNFHAp3EC4NvD/DWIC9oBLQ0+E=;
 b=hME3mkazxA/uN2rYhG6PjJfFHgpovUyK2UqrrxrEZ+CKhap4wiXYyE2SrMD5kp7qtSHpW5
 VRuXPcsUg4FrnolQWFcpWT06Pikhi/BeppsKBjPfPHFC9F4jBbJ3YT63dxzuxmuXhexd4z
 4xik/Z/5bZW3igCUOeJUEXju9IQiZY4=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH v3 4/5] ARM: use unified assembler in c files
Date: Tue, 12 Feb 2019 21:02:00 +0100
Message-Id: <a0aa512943024821fae210854b89ac0f430f388a.1550001435.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550001435.git.stefan@agner.ch>
References: <cover.1550001435.git.stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_120204_152473_42037F46 
X-CRM114-Status: GOOD (  13.32  )
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
 ard.biesheuvel@linaro.org, will.deacon@arm.com, julien.thierry@arm.com,
 ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com,
 Nicolas Pitre <nico@linaro.org>, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use unified assembler syntax (UAL) in inline assembler. Divided
syntax is considered deprecated. This will also allow to build
the kernel using LLVM's integrated assembler.

When compiling non-Thumb2 GCC always emits a ".syntax divided"
at the beginning of the inline assembly which makes the
assembler fail. Since GCC 5 there is the -masm-syntax-unified
GCC option which make GCC assume unified syntax asm and hence
emits ".syntax unified" even in ARM mode. However, the option
is broken since GCC version 6 (see GCC PR88648 [1]). Work
around by adding ".syntax unified" as part of the inline
assembly.

[0] https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html#index-masm-syntax-unified
[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88648

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
Changes in v2:
- Force unified syntax for inline assembler using .syntax unified
Changes in v3:
- Describe reason for adding ".syntax unified"

 arch/arm/mm/copypage-v4mc.c | 3 ++-
 arch/arm/mm/copypage-v4wb.c | 3 ++-
 arch/arm/mm/copypage-v4wt.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index b03202cddddb..f74cdce6d4da 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -45,6 +45,7 @@ static void mc_copy_user_page(void *from, void *to)
 	int tmp;
 
 	asm volatile ("\
+	.syntax unified\n\
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
@@ -56,7 +57,7 @@ static void mc_copy_user_page(void *from, void *to)
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
+	ldmiane	%0!, {r2, r3, ip, lr}		@ 4\n\
 	bne	1b				@ "
 	: "+&r" (from), "+&r" (to), "=&r" (tmp)
 	: "2" (PAGE_SIZE / 64)
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index cd3e165afeed..6d336740aae4 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -27,6 +27,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
 	int tmp;
 
 	asm volatile ("\
+	.syntax unified\n\
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, %0, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
@@ -38,7 +39,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, %1, c7, c10, 4		@ 1   drain WB"
 	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index 8614572e1296..3851bb396442 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -25,6 +25,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
 	int tmp;
 
 	asm volatile ("\
+	.syntax unified\n\
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 1:	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4+1\n\
@@ -34,7 +35,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, %2, c7, c7, 0		@ flush ID cache"
 	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
