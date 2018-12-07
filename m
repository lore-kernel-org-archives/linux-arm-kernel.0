Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B703C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:09:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5ED2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XXzsoJzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5ED2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=IbSdP6Y8SzwBfsf0SzkWel+QOeL7JUN21CfqTIgDiW4=; b=XXzsoJzuy0ldPwAopzT3DN1iMS
	85tCnzYKccxBFR6WDKYGUL3WuZ7VUJvgd4nr/8HBaKcy+xPDmCMGPx9Bs08RALf0dkY5grmbgJGH1
	TNu3pnIld0GjYlrJJGtgLbVJLCSMaEfBpdPq/JAKPKSy6x9PDETsQuwEkjy9Rh0r/xJz4ob69C2YP
	Kj/xlp5mrXOsgjBuLWTlqkbRyZ5MKs5hD9xWOzZahJiRNhhEYANGZp9SNL2nATWL9CFWx58CBUj5S
	wVKaYELgzkvuuLGM9WV4kCG2Zp/ylAfwmtMTCogCl8GRuwCKVXjEcFQLa5my8qFeTVZLpnVKxho5k
	eyEJyb2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKYc-00007b-4J; Fri, 07 Dec 2018 18:08:58 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKYO-0008MW-Ke
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:08:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AE261682;
 Fri,  7 Dec 2018 10:08:38 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E9153F5AF;
 Fri,  7 Dec 2018 10:08:37 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 04/10] arm64: tishift: use asm EXPORT_SYMBOL()
Date: Fri,  7 Dec 2018 18:08:17 +0000
Message-Id: <20181207180823.36612-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207180823.36612-1-mark.rutland@arm.com>
References: <20181207180823.36612-1-mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_100844_703634_3FB979E3 
X-CRM114-Status: GOOD (  11.12  )
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

As a step towards removing arm64ksyms.c, let's move the tishift exports
to the assembly file the functions are defined in.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c | 7 -------
 arch/arm64/lib/tishift.S       | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 73237dc8a994..d80e9cfc3062 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -68,10 +68,3 @@ NOKPROBE_SYMBOL(_mcount);
 EXPORT_SYMBOL(__arm_smccc_smc);
 EXPORT_SYMBOL(__arm_smccc_hvc);
 
-	/* tishift.S */
-extern long long __ashlti3(long long a, int b);
-EXPORT_SYMBOL(__ashlti3);
-extern long long __ashrti3(long long a, int b);
-EXPORT_SYMBOL(__ashrti3);
-extern long long __lshrti3(long long a, int b);
-EXPORT_SYMBOL(__lshrti3);
diff --git a/arch/arm64/lib/tishift.S b/arch/arm64/lib/tishift.S
index 0fdff97794de..047622536535 100644
--- a/arch/arm64/lib/tishift.S
+++ b/arch/arm64/lib/tishift.S
@@ -5,6 +5,8 @@
 
 #include <linux/linkage.h>
 
+#include <asm/assembler.h>
+
 ENTRY(__ashlti3)
 	cbz	x2, 1f
 	mov	x3, #64
@@ -25,6 +27,7 @@ ENTRY(__ashlti3)
 	mov	x0, x2
 	ret
 ENDPROC(__ashlti3)
+EXPORT_SYMBOL(__ashlti3)
 
 ENTRY(__ashrti3)
 	cbz	x2, 1f
@@ -46,6 +49,7 @@ ENTRY(__ashrti3)
 	mov	x1, x2
 	ret
 ENDPROC(__ashrti3)
+EXPORT_SYMBOL(__ashrti3)
 
 ENTRY(__lshrti3)
 	cbz	x2, 1f
@@ -67,3 +71,4 @@ ENTRY(__lshrti3)
 	mov	x1, x2
 	ret
 ENDPROC(__lshrti3)
+EXPORT_SYMBOL(__lshrti3)
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
