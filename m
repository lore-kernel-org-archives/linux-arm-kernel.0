Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAF7C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:05:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78972086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fQnvY4ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78972086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sPCJk2N1qvwQWuErEayCu9Gh2tPu4UkCrTzEOUSQnOQ=; b=fQnvY4phLRMdRn
	S/iCMo6ciW6s6o9fRKw1IuM/jCGhROfbppwS6ZLVbjO3/l+5I4wZInh7vy3368kQwfhxMI6QOObDp
	eE/X+ONDWyz0JZ4kUzH6xqz0HVf3GUsVoKSRz9YGB5Or+65lUdxnCrVUruipky0Q3Wh2hI0vYi58A
	IFETvj7t+Qv5fXBe9C4E+ZYRPvD7QSQyavWA/9tmVZXV2bWyLyi4XeRum2XewoRH7bJcqYYrHDmWc
	Gogt7zHSDho3qsIUaVfX/C+mTtdVjjymmKwB6m/IO57KVtFQYDCHQ7vYDff1LKPH5nre6tVBRsOLy
	OBHEnSxP/yTEZHAx2tsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVMP-0001rI-WF; Thu, 13 Dec 2018 18:05:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVMM-0001ig-4r
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:05:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DC9DA78;
 Thu, 13 Dec 2018 10:05:07 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DF913F575;
 Thu, 13 Dec 2018 10:05:07 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 40E771AE0838; Thu, 13 Dec 2018 18:05:31 +0000 (GMT)
Date: Thu, 13 Dec 2018 18:05:31 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH 0/4] arm64: kpti: use nG mappings unless KPTI is
 force disabled
Message-ID: <20181213180530.GB18185@edgewater-inn.cambridge.arm.com>
References: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_100518_207020_95D75CBA 
X-CRM114-Status: GOOD (  22.84  )
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
Cc: John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ard,

On Thu, Dec 13, 2018 at 06:20:31PM +0100, Ard Biesheuvel wrote:
> John reports [0] that recent changes to the way the linear region is mapped
> is causing ~30 seconds stalls on boot, and this turns out to be due to the
> way we remap the linear space with nG mappings when enabling KPTI, which
> occurs with the MMU and caches off. Recent kernels map the linear region down
> to pages by default, so that restricted permissions can be applied at page
> granularity (so that module .text and .rodata are no longer writable via
> the linear map), and so the number of page table entries that require
> updating from G to nG is much higher, resulting in the observed delays.
> 
> This series refactors the logic that tests whether KPTI should be enabled
> so that the conditions that apply regardless of CPU identification are
> evaluated early, allowing us to create the mappings of the kernel and
> the linear region with nG attributes from the outset.
> 
> Patches #1 to #3 implement this so that we only create these nG mappings
> if KPTI is force enabled.
> 
> As a followup, #4 may be applied, which inverts the logic so that nG mappings
> are always created, unless KPTI is forced off. This allows us to get rid
> of the slow and complex asm routines that make this change later on, which
> is where the boot delays occur.

I think I'd like to keep those for now, since it would be nice to use global
mappings for the vast majority of CPUs that are not affected by kpti.

I had a crack at the problem and ended up with a slightly simpler diff
below.

Will

--->8

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 7689c7aa1d77..feb05f7b46b1 100644
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
@@ -44,6 +46,28 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
 	       cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
 }
 
+static inline bool arm64_kernel_use_ng_mappings(void)
+{
+	bool tx1_bug = false;
+
+	if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
+		return false;
+
+	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		return arm64_kernel_unmapped_at_el0();
+
+	if (IS_ENABLED(CONFIG_CAVIUM_ERRATUM_27456)) {
+		extern const struct midr_range cavium_erratum_27456_cpus[];
+
+		tx1_bug = static_branch_likely(&arm64_const_caps_ready) ?
+			  cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456) :
+			  is_midr_in_range_list(read_cpuid_id(),
+						cavium_erratum_27456_cpus);
+	}
+
+	return !tx1_bug;
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
index ff2fda3a98e1..2c42f57cf529 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -539,7 +539,7 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
 #endif
 
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
-static const struct midr_range cavium_erratum_27456_cpus[] = {
+const struct midr_range cavium_erratum_27456_cpus[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
 	/* Cavium ThunderX, T81 pass 1.0 */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7ea0b2f20262..c68f6ad6722f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1006,6 +1006,9 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 	if (kpti_applied)
 		return;
 
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && __kpti_forced <= 0)
+		return;
+
 	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
 
 	cpu_install_idmap();

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
