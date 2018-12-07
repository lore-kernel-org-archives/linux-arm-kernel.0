Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18556C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:10:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3ECF2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EzLkzTfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ECF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ikXVCJhutz80+Y+LSFTLQ7eKqGkLL7x3gNIyrXk95aM=; b=EzLkzTfY6sJiFzOyQxnI0o70eR
	VVAW5eofN/3Ve1XxRa1Wf8LA6mYiwEv8cQkPrjC89FLk+Pe5ehxpRcYukf1HbNFKfJe7NszOAkbp1
	Rz2C2OANQPDDUoxpZYu2KNOUNLvru+Qso8hzHcF4t6aSgPK1XdHDqrS2CPbv4jM2LBhXrzvvooVM7
	opPJexTUM+uEGX9jjaAVJ0xpXbsdBK1Okgg5UsqabJboPdIGE0jjqsKIjojjyFepwSwrwKGFkAcCK
	9igBZPZfYRaxEDr/NT+x7P43MW4HIw3gvsodatxnnya3/bjJMFPBvdBle9mf1qCw+qqURyLnzFcsF
	rZOIV24Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKaI-00032o-EE; Fri, 07 Dec 2018 18:10:42 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKYZ-0008Nq-VV
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:09:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A62691A25;
 Fri,  7 Dec 2018 10:08:42 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B99543F5AF;
 Fri,  7 Dec 2018 10:08:41 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 07/10] arm64: uaccess: use asm EXPORT_SYMBOL()
Date: Fri,  7 Dec 2018 18:08:20 +0000
Message-Id: <20181207180823.36612-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207180823.36612-1-mark.rutland@arm.com>
References: <20181207180823.36612-1-mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_100856_385569_75EEBD0E 
X-CRM114-Status: GOOD (  11.24  )
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

As a step towards removing arm64ksyms.c, let's move the uaccess exports
to the assembly files the functions are defined in.  As we have to
include <asm/assembler.h>, the existing includes are fixed to follow the
usual ordering conventions.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c  | 7 -------
 arch/arm64/lib/clear_user.S     | 2 ++
 arch/arm64/lib/copy_from_user.S | 4 +++-
 arch/arm64/lib/copy_in_user.S   | 4 +++-
 arch/arm64/lib/copy_to_user.S   | 4 +++-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 784b257d9643..02019667e319 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -24,18 +24,11 @@
 #include <linux/delay.h>
 #include <linux/in6.h>
 #include <linux/syscalls.h>
-#include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/kprobes.h>
 
 #include <asm/checksum.h>
 
-	/* user mem (segment) */
-EXPORT_SYMBOL(__arch_copy_from_user);
-EXPORT_SYMBOL(__arch_copy_to_user);
-EXPORT_SYMBOL(__arch_clear_user);
-EXPORT_SYMBOL(__arch_copy_in_user);
-
 	/* string / mem functions */
 #ifndef CONFIG_KASAN
 EXPORT_SYMBOL(strchr);
diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index 21ba0b29621b..feb225bd4b80 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -18,6 +18,7 @@
 #include <linux/linkage.h>
 
 #include <asm/asm-uaccess.h>
+#include <asm/assembler.h>
 
 	.text
 
@@ -53,6 +54,7 @@ uao_user_alternative 9f, strb, sttrb, wzr, x0, 0
 	uaccess_disable_not_uao x2, x3
 	ret
 ENDPROC(__arch_clear_user)
+EXPORT_SYMBOL(__arch_clear_user)
 
 	.section .fixup,"ax"
 	.align	2
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 20305d485046..dea6c762d52f 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -16,8 +16,9 @@
 
 #include <linux/linkage.h>
 
-#include <asm/cache.h>
 #include <asm/asm-uaccess.h>
+#include <asm/assembler.h>
+#include <asm/cache.h>
 
 /*
  * Copy from user space to a kernel buffer (alignment handled by the hardware)
@@ -71,6 +72,7 @@ ENTRY(__arch_copy_from_user)
 	mov	x0, #0				// Nothing to copy
 	ret
 ENDPROC(__arch_copy_from_user)
+EXPORT_SYMBOL(__arch_copy_from_user)
 
 	.section .fixup,"ax"
 	.align	2
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 54b75deb1d16..a84227fbf716 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -18,8 +18,9 @@
 
 #include <linux/linkage.h>
 
-#include <asm/cache.h>
 #include <asm/asm-uaccess.h>
+#include <asm/assembler.h>
+#include <asm/cache.h>
 
 /*
  * Copy from user space to user space (alignment handled by the hardware)
@@ -73,6 +74,7 @@ ENTRY(__arch_copy_in_user)
 	mov	x0, #0
 	ret
 ENDPROC(__arch_copy_in_user)
+EXPORT_SYMBOL(__arch_copy_in_user)
 
 	.section .fixup,"ax"
 	.align	2
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index fda6172d6b88..ef44c7ca3ffb 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -16,8 +16,9 @@
 
 #include <linux/linkage.h>
 
-#include <asm/cache.h>
 #include <asm/asm-uaccess.h>
+#include <asm/assembler.h>
+#include <asm/cache.h>
 
 /*
  * Copy to user space from a kernel buffer (alignment handled by the hardware)
@@ -70,6 +71,7 @@ ENTRY(__arch_copy_to_user)
 	mov	x0, #0
 	ret
 ENDPROC(__arch_copy_to_user)
+EXPORT_SYMBOL(__arch_copy_to_user)
 
 	.section .fixup,"ax"
 	.align	2
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
