Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C35C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:05:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFE020C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bK55E7pU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFE020C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SlGDQMehIzUpv+f3pLxntrRLpPzujl8nGIkHj/fFd3s=; b=bK55E7pUsubRpK
	ReVJQfPXbARFZMRd+ncrjFowvnBU0AcG69/ce93+b1Ou2KFrHqa1jVfS4emTrj1QcJXcVpi01b2HJ
	LeJg7kCPh1bTR8093opFrL90oH+1oy8wOiJ5MjTEAf7O4BTmvKgGqKHgZK3oQf3aYu1zk24TytNay
	Km8+295FUw4UzA69t4szFKg4XlJ/xtw/cx33XVVBWdcu9fVQCIZJJ5u3ORkRjhVCzHrnx8LNASvkj
	j+kFEc0hjstEa7waFkqOVFZylngBRWZP6a8x9nFHN3FSrpw7rIqoID3ZZLox5CSdo9UikisurRNLo
	KICOr1Zb3UjQr8zr9wag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmM2-0006Xh-S5; Mon, 18 Feb 2019 17:05:18 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmLL-0004az-5F
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:04:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A07C19BF;
 Mon, 18 Feb 2019 09:04:20 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.153])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7BBB3FB75;
 Mon, 18 Feb 2019 09:04:18 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/9] arm64: mm: Logic to make offset_ttbr1 conditional
Date: Mon, 18 Feb 2019 17:02:44 +0000
Message-Id: <20190218170245.14915-9-steve.capper@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218170245.14915-1-steve.capper@arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_090435_221504_DF479C17 
X-CRM114-Status: GOOD (  18.14  )
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
Cc: crecklin@redhat.com, Steve Capper <steve.capper@arm.com>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
 will.deacon@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When running with a 52-bit userspace VA and a 48-bit kernel VA we offset
ttbr1_el1 to allow the kernel pagetables with a 52-bit PTRS_PER_PGD to
be used for both userspace and kernel.

Moving on to a 52-bit kernel VA we no longer require this offset to
ttbr1_el1 should we be running on a system with HW support for 52-bit
VAs.

This patch introduces alternative logic to offset_ttbr1 and expands out
the very early case in head.S. We need to use the alternative framework
as offset_ttbr1 is used in places in the kernel where it is not possible
to safely adrp address kernel constants (such as the kpti paths); thus
code patching is the safer route.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/include/asm/assembler.h | 10 +++++++++-
 arch/arm64/include/asm/cpucaps.h   |  3 ++-
 arch/arm64/kernel/cpufeature.c     | 18 ++++++++++++++++++
 arch/arm64/kernel/head.S           | 14 +++++++++++++-
 arch/arm64/kernel/hibernate-asm.S  |  1 +
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 4feb6119c3c9..58ed5d086e1e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -551,6 +551,14 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	.macro	offset_ttbr1, ttbr
 #ifdef CONFIG_ARM64_USER_VA_BITS_52
 	orr	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
+#endif
+
+#ifdef CONFIG_ARM64_USER_KERNEL_VA_BITS_52
+alternative_if_not ARM64_HAS_52BIT_VA
+	orr	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
+alternative_else
+	nop
+alternative_endif
 #endif
 	.endm
 
@@ -560,7 +568,7 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
  * to be nop'ed out when dealing with 52-bit kernel VAs.
  */
 	.macro	restore_ttbr1, ttbr
-#ifdef CONFIG_ARM64_USER_VA_BITS_52
+#if defined(CONFIG_ARM64_USER_VA_BITS_52) || defined(CONFIG_ARM64_KERNEL_VA_BITS_52)
 	bic	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
 #endif
 	.endm
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 82e9099834ae..d71aecb6d6db 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -60,7 +60,8 @@
 #define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		39
 #define ARM64_HAS_GENERIC_AUTH_ARCH		40
 #define ARM64_HAS_GENERIC_AUTH_IMP_DEF		41
+#define ARM64_HAS_52BIT_VA			42
 
-#define ARM64_NCAPS				42
+#define ARM64_NCAPS				43
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f6d84e2c92fe..2e150c564f2a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -944,6 +944,16 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 	return has_cpuid_feature(entry, scope);
 }
 
+#ifdef CONFIG_ARM64_USER_KERNEL_VA_BITS_52
+extern u64 vabits_actual;
+static bool __maybe_unused
+has_52bit_kernel_va(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	return vabits_actual == 52;
+}
+
+#endif /* CONFIG_ARM64_USER_KERNEL_VA_BITS_52 */
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 
@@ -1480,6 +1490,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 	},
 #endif /* CONFIG_ARM64_PTR_AUTH */
+#ifdef CONFIG_ARM64_USER_KERNEL_VA_BITS_52
+	{
+		.desc = "52-bit kernel VA",
+		.capability = ARM64_HAS_52BIT_VA,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_52bit_kernel_va,
+	},
+#endif /* CONFIG_ARM64_USER_KERNEL_VA_BITS_52 */
 	{},
 };
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 68c391b26858..4877b82d2091 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -789,7 +789,19 @@ ENTRY(__enable_mmu)
 	phys_to_ttbr x1, x1
 	phys_to_ttbr x2, x2
 	msr	ttbr0_el1, x2			// load TTBR0
-	offset_ttbr1 x1
+
+#if defined(CONFIG_ARM64_USER_VA_BITS_52)
+	orr     x1, x1, #TTBR1_BADDR_4852_OFFSET
+#endif
+
+#if defined(CONFIG_ARM64_USER_KERNEL_VA_BITS_52)
+	ldr_l	x3, vabits_actual
+	cmp	x3, #52
+	b.eq	1f
+	orr     x1, x1, #TTBR1_BADDR_4852_OFFSET
+1:
+#endif
+
 	msr	ttbr1_el1, x1			// load TTBR1
 	isb
 	msr	sctlr_el1, x0
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
index fe36d85c60bd..d32725a2b77f 100644
--- a/arch/arm64/kernel/hibernate-asm.S
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -19,6 +19,7 @@
 #include <linux/linkage.h>
 #include <linux/errno.h>
 
+#include <asm/alternative.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/cputype.h>
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
