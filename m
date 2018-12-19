Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67200C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:08:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873E9217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TiGzRGEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873E9217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/qR50t8RtMsSpTMnhQ2G48/1hEFCcbdVDoFZBEt87+s=; b=TiGzRGEfglPmoy
	4UzDbMMh9n/i+0hJn57g0CEKgl7g35mTqlxK6bObI7QblDmfWp+2lk2IaZRxMTHBSlcMyCe0SW7Uy
	FY/8MH/1p7NTFSFijHhRRlalMHElHauGJRpTd9zfH4A/qrY9+0Iy6Byhf20J4QFkXD+2dotstcYe9
	qRXDXllDX8Kz6TwFmMsLH4FmNMhlLTgwvYP0YYFa8nd67TgSIsfHdKOBVR24z0EyeMI7QGl2Pr8XZ
	IcL4geTBmtVIEYiYJndVzXWzm1tjMSl2nk7ye2cktVG4U50WKlMyF4qYmhM3bqXSvvWq6LwJAdXjw
	cgy1Gq9cDwbos8Nu+uow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgGZ-0002H2-KF; Wed, 19 Dec 2018 18:08:19 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgDF-0006E7-5S
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:05:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A73B315BE;
 Wed, 19 Dec 2018 10:04:45 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2782D3F675;
 Wed, 19 Dec 2018 10:04:43 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 13/28] KVM: arm64: Add support for creating PUD hugepages at
 stage 2
Date: Wed, 19 Dec 2018 18:03:34 +0000
Message-Id: <20181219180349.242681-14-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_100454_163788_CC07FCD3 
X-CRM114-Status: GOOD (  22.60  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, punitagrawal@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Suzuki Poulose <suzuki.poulose@arm.com>,
 Lukas Braun <koomi@moshbit.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Punit Agrawal <punit.agrawal@arm.com>

KVM only supports PMD hugepages at stage 2. Now that the various page
handling routines are updated, extend the stage 2 fault handling to
map in PUD hugepages.

Addition of PUD hugepage support enables additional page sizes (e.g.,
1G with 4K granule) which can be useful on cores that support mapping
larger block sizes in the TLB entries.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
[ Replace BUG() => WARN_ON(1) for arm32 PUD helpers ]
Signed-off-by: Suzuki Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h         |  20 +++++
 arch/arm/include/asm/stage2_pgtable.h  |   5 ++
 arch/arm64/include/asm/kvm_mmu.h       |  16 ++++
 arch/arm64/include/asm/pgtable-hwdef.h |   2 +
 arch/arm64/include/asm/pgtable.h       |   2 +
 virt/kvm/arm/mmu.c                     | 104 +++++++++++++++++++++++--
 6 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 4b4b2146e6a0..3a875fc1b63c 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -84,11 +84,14 @@ void kvm_clear_hyp_idmap(void);
 
 #define kvm_pfn_pte(pfn, prot)	pfn_pte(pfn, prot)
 #define kvm_pfn_pmd(pfn, prot)	pfn_pmd(pfn, prot)
+#define kvm_pfn_pud(pfn, prot)	(__pud(0))
 
 #define kvm_pud_pfn(pud)	({ WARN_ON(1); 0; })
 
 
 #define kvm_pmd_mkhuge(pmd)	pmd_mkhuge(pmd)
+/* No support for pud hugepages */
+#define kvm_pud_mkhuge(pud)	( {WARN_ON(1); pud; })
 
 /*
  * The following kvm_*pud*() functions are provided strictly to allow
@@ -105,6 +108,23 @@ static inline bool kvm_s2pud_readonly(pud_t *pud)
 	return false;
 }
 
+static inline void kvm_set_pud(pud_t *pud, pud_t new_pud)
+{
+	WARN_ON(1);
+}
+
+static inline pud_t kvm_s2pud_mkwrite(pud_t pud)
+{
+	WARN_ON(1);
+	return pud;
+}
+
+static inline pud_t kvm_s2pud_mkexec(pud_t pud)
+{
+	WARN_ON(1);
+	return pud;
+}
+
 static inline bool kvm_s2pud_exec(pud_t *pud)
 {
 	WARN_ON(1);
diff --git a/arch/arm/include/asm/stage2_pgtable.h b/arch/arm/include/asm/stage2_pgtable.h
index f6a7ea805232..f9017167a8d1 100644
--- a/arch/arm/include/asm/stage2_pgtable.h
+++ b/arch/arm/include/asm/stage2_pgtable.h
@@ -68,4 +68,9 @@ stage2_pmd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
 #define stage2_pmd_table_empty(kvm, pmdp)	kvm_page_empty(pmdp)
 #define stage2_pud_table_empty(kvm, pudp)	false
 
+static inline bool kvm_stage2_has_pud(struct kvm *kvm)
+{
+	return false;
+}
+
 #endif	/* __ARM_S2_PGTABLE_H_ */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 9f941f70775c..8af4b1befa42 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -184,12 +184,16 @@ void kvm_clear_hyp_idmap(void);
 #define kvm_mk_pgd(pudp)					\
 	__pgd(__phys_to_pgd_val(__pa(pudp)) | PUD_TYPE_TABLE)
 
+#define kvm_set_pud(pudp, pud)		set_pud(pudp, pud)
+
 #define kvm_pfn_pte(pfn, prot)		pfn_pte(pfn, prot)
 #define kvm_pfn_pmd(pfn, prot)		pfn_pmd(pfn, prot)
+#define kvm_pfn_pud(pfn, prot)		pfn_pud(pfn, prot)
 
 #define kvm_pud_pfn(pud)		pud_pfn(pud)
 
 #define kvm_pmd_mkhuge(pmd)		pmd_mkhuge(pmd)
+#define kvm_pud_mkhuge(pud)		pud_mkhuge(pud)
 
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
 {
@@ -203,6 +207,12 @@ static inline pmd_t kvm_s2pmd_mkwrite(pmd_t pmd)
 	return pmd;
 }
 
+static inline pud_t kvm_s2pud_mkwrite(pud_t pud)
+{
+	pud_val(pud) |= PUD_S2_RDWR;
+	return pud;
+}
+
 static inline pte_t kvm_s2pte_mkexec(pte_t pte)
 {
 	pte_val(pte) &= ~PTE_S2_XN;
@@ -215,6 +225,12 @@ static inline pmd_t kvm_s2pmd_mkexec(pmd_t pmd)
 	return pmd;
 }
 
+static inline pud_t kvm_s2pud_mkexec(pud_t pud)
+{
+	pud_val(pud) &= ~PUD_S2_XN;
+	return pud;
+}
+
 static inline void kvm_set_s2pte_readonly(pte_t *ptep)
 {
 	pteval_t old_pteval, pteval;
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 336e24cddc87..6f1c187f1c86 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -193,6 +193,8 @@
 #define PMD_S2_RDWR		(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
 #define PMD_S2_XN		(_AT(pmdval_t, 2) << 53)  /* XN[1:0] */
 
+#define PUD_S2_RDONLY		(_AT(pudval_t, 1) << 6)   /* HAP[2:1] */
+#define PUD_S2_RDWR		(_AT(pudval_t, 3) << 6)   /* HAP[2:1] */
 #define PUD_S2_XN		(_AT(pudval_t, 2) << 53)  /* XN[1:0] */
 
 /*
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index bb0f3f17a7a9..576128635f3c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -390,6 +390,8 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
+#define pud_mkhuge(pud)		(__pud(pud_val(pud) & ~PUD_TABLE_BIT))
+
 #define __pud_to_phys(pud)	__pte_to_phys(pud_pte(pud))
 #define __phys_to_pud_val(phys)	__phys_to_pte_val(phys)
 #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 3893ea6a50bf..2dcff38868d4 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -115,6 +115,25 @@ static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
 	put_page(virt_to_page(pmd));
 }
 
+/**
+ * stage2_dissolve_pud() - clear and flush huge PUD entry
+ * @kvm:	pointer to kvm structure.
+ * @addr:	IPA
+ * @pud:	pud pointer for IPA
+ *
+ * Function clears a PUD entry, flushes addr 1st and 2nd stage TLBs. Marks all
+ * pages in the range dirty.
+ */
+static void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr, pud_t *pudp)
+{
+	if (!stage2_pud_huge(kvm, *pudp))
+		return;
+
+	stage2_pud_clear(kvm, pudp);
+	kvm_tlb_flush_vmid_ipa(kvm, addr);
+	put_page(virt_to_page(pudp));
+}
+
 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 				  int min, int max)
 {
@@ -1022,7 +1041,7 @@ static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
 	pmd_t *pmd;
 
 	pud = stage2_get_pud(kvm, cache, addr);
-	if (!pud)
+	if (!pud || stage2_pud_huge(kvm, *pud))
 		return NULL;
 
 	if (stage2_pud_none(kvm, *pud)) {
@@ -1083,6 +1102,36 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 	return 0;
 }
 
+static int stage2_set_pud_huge(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
+			       phys_addr_t addr, const pud_t *new_pudp)
+{
+	pud_t *pudp, old_pud;
+
+	pudp = stage2_get_pud(kvm, cache, addr);
+	VM_BUG_ON(!pudp);
+
+	old_pud = *pudp;
+
+	/*
+	 * A large number of vcpus faulting on the same stage 2 entry,
+	 * can lead to a refault due to the
+	 * stage2_pud_clear()/tlb_flush(). Skip updating the page
+	 * tables if there is no change.
+	 */
+	if (pud_val(old_pud) == pud_val(*new_pudp))
+		return 0;
+
+	if (stage2_pud_present(kvm, old_pud)) {
+		stage2_pud_clear(kvm, pudp);
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
+	} else {
+		get_page(virt_to_page(pudp));
+	}
+
+	kvm_set_pud(pudp, *new_pudp);
+	return 0;
+}
+
 /*
  * stage2_get_leaf_entry - walk the stage2 VM page tables and return
  * true if a valid and present leaf-entry is found. A pointer to the
@@ -1149,6 +1198,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			  phys_addr_t addr, const pte_t *new_pte,
 			  unsigned long flags)
 {
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
 	bool iomap = flags & KVM_S2PTE_FLAG_IS_IOMAP;
@@ -1157,7 +1207,31 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 	VM_BUG_ON(logging_active && !cache);
 
 	/* Create stage-2 page table mapping - Levels 0 and 1 */
-	pmd = stage2_get_pmd(kvm, cache, addr);
+	pud = stage2_get_pud(kvm, cache, addr);
+	if (!pud) {
+		/*
+		 * Ignore calls from kvm_set_spte_hva for unallocated
+		 * address ranges.
+		 */
+		return 0;
+	}
+
+	/*
+	 * While dirty page logging - dissolve huge PUD, then continue
+	 * on to allocate page.
+	 */
+	if (logging_active)
+		stage2_dissolve_pud(kvm, addr, pud);
+
+	if (stage2_pud_none(kvm, *pud)) {
+		if (!cache)
+			return 0; /* ignore calls from kvm_set_spte_hva */
+		pmd = mmu_memory_cache_alloc(cache);
+		stage2_pud_populate(kvm, pud, pmd);
+		get_page(virt_to_page(pud));
+	}
+
+	pmd = stage2_pmd_offset(kvm, pud, addr);
 	if (!pmd) {
 		/*
 		 * Ignore calls from kvm_set_spte_hva for unallocated
@@ -1557,12 +1631,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	}
 
 	vma_pagesize = vma_kernel_pagesize(vma);
-	if (vma_pagesize == PMD_SIZE && !logging_active) {
-		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
+	/*
+	 * PUD level may not exist for a VM but PMD is guaranteed to
+	 * exist.
+	 */
+	if ((vma_pagesize == PMD_SIZE ||
+	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pud(kvm))) &&
+	    !logging_active) {
+		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
 	} else {
 		/*
 		 * Fallback to PTE if it's not one of the Stage 2
-		 * supported hugepage sizes
+		 * supported hugepage sizes or the corresponding level
+		 * doesn't exist
 		 */
 		vma_pagesize = PAGE_SIZE;
 
@@ -1661,7 +1742,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	needs_exec = exec_fault ||
 		(fault_status == FSC_PERM && stage2_is_exec(kvm, fault_ipa));
 
-	if (vma_pagesize == PMD_SIZE) {
+	if (vma_pagesize == PUD_SIZE) {
+		pud_t new_pud = kvm_pfn_pud(pfn, mem_type);
+
+		new_pud = kvm_pud_mkhuge(new_pud);
+		if (writable)
+			new_pud = kvm_s2pud_mkwrite(new_pud);
+
+		if (needs_exec)
+			new_pud = kvm_s2pud_mkexec(new_pud);
+
+		ret = stage2_set_pud_huge(kvm, memcache, fault_ipa, &new_pud);
+	} else if (vma_pagesize == PMD_SIZE) {
 		pmd_t new_pmd = kvm_pfn_pmd(pfn, mem_type);
 
 		new_pmd = kvm_pmd_mkhuge(new_pmd);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
