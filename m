Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BCAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:51:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE072173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PUGc3R+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE072173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=anBy3IxmqQDqG7A1Gywi5m+lQSdZIjXG/A2rc35mSCQ=; b=PUG
	c3R+ojNkIvMVfwmNUrXo3XblLCEKS9X0U05AzwP65RodRr6o5L+DfmlS0Vy96e5lEqzmaJBucd6HV
	a0VsdyhRak+olyUNxDF9F3tbNXgbYgVTzMVoZcoE/cX2potgee9HOXgLA2+yJDGguBLiLLaB4sBE4
	BAYS6g9Fvqr2o0jwkd8TcPJ2nboArFYZN8hsD5PH1nZNA6aZJGGDT7vMVly7I3mTT+sWtx9KWcqo4
	bBJ8U0WBFk1nBoUkVGWTUyLiGlRlwBlL379e2G0wj2H+ul7kRJVbJOXFWBfWfjGoXKLaQq/3Flr61
	/KGoHGuCYtIWB98lWRiAEp1ju0k2mAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXwJ-0007GE-GV; Thu, 10 Jan 2019 10:51:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXwG-0007Ff-G9
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:51:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7383CA78;
 Thu, 10 Jan 2019 02:51:49 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA8263F694;
 Thu, 10 Jan 2019 02:51:48 -0800 (PST)
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] arm64: kpti: Avoid rewriting early page tables when KASLR
 is enabled
Date: Thu, 10 Jan 2019 10:51:43 +0000
Message-Id: <20190110105143.27008-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_025152_549886_C05B4F63 
X-CRM114-Status: GOOD (  21.86  )
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
Cc: Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A side effect of commit c55191e96caa ("arm64: mm: apply r/o permissions
of VM areas to its linear alias as well") is that the linear map is
created with page granularity, which means that transitioning the early
page table from global to non-global mappings when enabling kpti can
take a significant amount of time during boot.

Given that most CPU implementations do not require kpti, this mainly
impacts KASLR builds where kpti is forcefully enabled. However, in these
situations we know early on that non-global mappings are required and
can avoid the use of global mappings from the beginning. The only gotcha
is Cavium erratum #27456, which we must detect based on the MIDR value
of the boot CPU.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v2: Fix module builds by exporting kimage_vaddr and avoiding references
    to cavium_erratum_27456_cpus. Minor comment tweaks.

 arch/arm64/include/asm/mmu.h          | 41 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-prot.h |  4 ++--
 arch/arm64/kernel/cpu_errata.c        |  2 +-
 arch/arm64/kernel/cpufeature.c        |  9 ++++++--
 arch/arm64/kernel/head.S              |  1 +
 5 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 43596b1a5897..bbb47402cd2b 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_MMU_H
 #define __ASM_MMU_H
 
+#include <asm/cputype.h>
+
 #define MMCF_AARCH32	0x1	/* mm context flag for AArch32 executables */
 #define USER_ASID_BIT	48
 #define USER_ASID_FLAG	(UL(1) << USER_ASID_BIT)
@@ -44,6 +46,45 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
 	       cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
 }
 
+static inline bool arm64_kernel_use_ng_mappings(void)
+{
+	bool tx1_bug;
+
+	/* What's a kpti? Use global mappings if we don't know. */
+	if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
+		return false;
+
+	/*
+	 * Note: this function is called before the CPU capabilities have
+	 * been configured, so our early mappings will be global. If we
+	 * later determine that kpti is required, then
+	 * kpti_install_ng_mappings() will make them non-global.
+	 */
+	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		return arm64_kernel_unmapped_at_el0();
+
+	/*
+	 * KASLR is enabled so we're going to be enabling kpti on non-broken
+	 * CPUs regardless of their susceptibility to Meltdown. Rather
+	 * than force everybody to go through the G -> nG dance later on,
+	 * just put down non-global mappings from the beginning.
+	 */
+	if (!IS_ENABLED(CONFIG_CAVIUM_ERRATUM_27456)) {
+		tx1_bug = false;
+#ifndef MODULE
+	} else if (!static_branch_likely(&arm64_const_caps_ready)) {
+		extern const struct midr_range cavium_erratum_27456_cpus[];
+
+		tx1_bug = is_midr_in_range_list(read_cpuid_id(),
+						cavium_erratum_27456_cpus);
+#endif
+	} else {
+		tx1_bug = __cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456);
+	}
+
+	return !tx1_bug && kaslr_offset() > 0;
+}
+
 typedef void (*bp_hardening_cb_t)(void);
 
 struct bp_hardening_data {
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 78b942c1bea4..986e41c4c32b 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -37,8 +37,8 @@
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
-#define PTE_MAYBE_NG		(arm64_kernel_unmapped_at_el0() ? PTE_NG : 0)
-#define PMD_MAYBE_NG		(arm64_kernel_unmapped_at_el0() ? PMD_SECT_NG : 0)
+#define PTE_MAYBE_NG		(arm64_kernel_use_ng_mappings() ? PTE_NG : 0)
+#define PMD_MAYBE_NG		(arm64_kernel_use_ng_mappings() ? PMD_SECT_NG : 0)
 
 #define PROT_DEFAULT		(_PROT_DEFAULT | PTE_MAYBE_NG)
 #define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_MAYBE_NG)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 09ac548c9d44..9950bb0cbd52 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -553,7 +553,7 @@ static const struct midr_range arm64_repeat_tlbi_cpus[] = {
 #endif
 
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
-static const struct midr_range cavium_erratum_27456_cpus[] = {
+const struct midr_range cavium_erratum_27456_cpus[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
 	/* Cavium ThunderX, T81 pass 1.0 */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4f272399de89..f6d84e2c92fe 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -983,7 +983,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 
 	/* Useful for KASLR robustness */
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
-		return true;
+		return kaslr_offset() > 0;
 
 	/* Don't force KPTI for CPUs that are not vulnerable */
 	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
@@ -1003,7 +1003,12 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 	static bool kpti_applied = false;
 	int cpu = smp_processor_id();
 
-	if (kpti_applied)
+	/*
+	 * We don't need to rewrite the page-tables if either we've done
+	 * it already or we have KASLR enabled and therefore have not
+	 * created any global mappings at all.
+	 */
+	if (kpti_applied || kaslr_offset() > 0)
 		return;
 
 	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c7213674cb24..15d79a8e5e5e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -475,6 +475,7 @@ ENDPROC(__primary_switched)
 
 ENTRY(kimage_vaddr)
 	.quad		_text - TEXT_OFFSET
+EXPORT_SYMBOL(kimage_vaddr)
 
 /*
  * If we're fortunate enough to boot at EL2, ensure that the world is
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
