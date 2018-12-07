Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F5CC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DCE2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LJSCkLaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DCE2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bRed1wbCVVukusx4rcHQ4VRfdOFHh4osZ2tha+sdtzc=; b=LJSCkLaUDVrcn5XdzMr4Zz1xK/
	4uGgVmcFhRBcxlPofVHBk38ukE1K4eBTS5pZv/GLY0rjnmFt9wEwtkIQyYbwo+UznBX/wm994xnP2
	uYH/rzpkzFaAoq3Mpmtr2r9cI+wIWIEdMTA7InvVNG8LjN7FCxqLQRMy5BWaoDcrjg7RDdCqVoLgf
	QJx3/wDgG2VuRBLTUko0SlZ5RFGXE+5DV1koDiTKn2ttsfYjb7jWWe2k6Fqf9tbU1ftcABalFCGIX
	h6amLSrTeQiRCtCUUf6izCIb+p/apZloT5ZlSND5pB4iMPyORzWi1Ig7lQQisy5pbSRShJiEjdTby
	A5PHjj+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKal-0003bD-Fx; Fri, 07 Dec 2018 18:11:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKYa-0008Nk-05
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:09:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E27FF16A3;
 Fri,  7 Dec 2018 10:08:39 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0200D3F5AF;
 Fri,  7 Dec 2018 10:08:38 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 05/10] arm64: smccc: use asm EXPORT_SYMBOL()
Date: Fri,  7 Dec 2018 18:08:18 +0000
Message-Id: <20181207180823.36612-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207180823.36612-1-mark.rutland@arm.com>
References: <20181207180823.36612-1-mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_100856_511169_27FCEAB3 
X-CRM114-Status: GOOD (  11.67  )
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

As a step towards removing arm64ksyms.c, let's move the SMCCC exports to
the assembly file the functions are defined in.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c | 5 -----
 arch/arm64/kernel/smccc-call.S | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index d80e9cfc3062..74e29e69190b 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -26,7 +26,6 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
-#include <linux/arm-smccc.h>
 #include <linux/kprobes.h>
 
 #include <asm/checksum.h>
@@ -64,7 +63,3 @@ EXPORT_SYMBOL(_mcount);
 NOKPROBE_SYMBOL(_mcount);
 #endif
 
-	/* arm-smccc */
-EXPORT_SYMBOL(__arm_smccc_smc);
-EXPORT_SYMBOL(__arm_smccc_hvc);
-
diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 62522342e1e4..184332286a81 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -13,7 +13,9 @@
  */
 #include <linux/linkage.h>
 #include <linux/arm-smccc.h>
+
 #include <asm/asm-offsets.h>
+#include <asm/assembler.h>
 
 	.macro SMCCC instr
 	.cfi_startproc
@@ -40,6 +42,7 @@
 ENTRY(__arm_smccc_smc)
 	SMCCC	smc
 ENDPROC(__arm_smccc_smc)
+EXPORT_SYMBOL(__arm_smccc_smc)
 
 /*
  * void arm_smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
@@ -50,3 +53,4 @@ ENDPROC(__arm_smccc_smc)
 ENTRY(__arm_smccc_hvc)
 	SMCCC	hvc
 ENDPROC(__arm_smccc_hvc)
+EXPORT_SYMBOL(__arm_smccc_hvc)
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
