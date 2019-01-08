Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE460C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:38:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B6E2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R3fqiyMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B6E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=eGHFJwAyIQbZyzHsYdC8wI16IpU4yJuE2lImI2aLStY=; b=R3f
	qiyMgOMiE6FI/7dH5E0NGvbIZZhepJd6hiPbfF6n3eFz5N6rznO+x6fzMHLK+Y/NuxCZ7K3K/63SP
	5tIk4KMDdhMvT7nTxtVB6GR9GYoMX0wSKbLf33X9McbTNQgLz3P5Kktoo02YL/Cvd9zbt3xBrp/Y/
	0MGuPDOXAvDjmSjQ6Qq8dRtkzIWeYXb+0TukfvI97vg74ajmUnXU2a4Jge603YLA0RrJzZnIWoLL/
	Vnzeig31A9DwOuY4mJYtx5q0onIrP+bf+8n6JlE6Q/rHM/Sy6rjCHgW2C4uczBI0rH1ZZdeQ/jdbZ
	l0KUnSdYrP8lpdcT7keXHsW1e4/RiuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguOD-0002rs-2a; Tue, 08 Jan 2019 16:38:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguO9-0002rT-Tf
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:38:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 942C9A78;
 Tue,  8 Jan 2019 08:38:01 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8A073F5AF;
 Tue,  8 Jan 2019 08:38:00 -0800 (PST)
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: kpti: Avoid rewriting early page tables when KASLR is
 enabled
Date: Tue,  8 Jan 2019 16:37:53 +0000
Message-Id: <20190108163753.32418-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_083801_963693_0A4CFD69 
X-CRM114-Status: GOOD (  17.16  )
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
 arch/arm64/include/asm/mmu.h          | 37 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-prot.h |  4 ++--
 arch/arm64/kernel/cpu_errata.c        |  2 +-
 arch/arm64/kernel/cpufeature.c        |  7 ++++++-
 4 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 43596b1a5897..06a0c84718d6 100644
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
@@ -44,6 +46,41 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
 	       cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
 }
 
+static inline bool arm64_kernel_use_ng_mappings(void)
+{
+	bool tx1_bug = false;
+
+	/* What's a kpti? Use global mappings if we don't know. */
+	if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
+		return false;
+
+	/*
+	 * Note: this function is called before the CPU capabilities have
+	 * been configured, so our early mappings will be global. If we
+	 * later determine that kpti is required, then the page tables
+	 * will be rewritten by kpti_install_ng_mappings().
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
+	if (IS_ENABLED(CONFIG_CAVIUM_ERRATUM_27456)) {
+		extern const struct midr_range cavium_erratum_27456_cpus[];
+
+		tx1_bug = static_branch_likely(&arm64_const_caps_ready) ?
+			  cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456) :
+			  is_midr_in_range_list(read_cpuid_id(),
+						cavium_erratum_27456_cpus);
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
index 4f272399de89..2cac775cd069 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
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
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
