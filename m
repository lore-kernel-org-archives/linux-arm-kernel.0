Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CD1C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:22:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADC0217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rYBa7ugg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADC0217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XRdDwZJXODFCL5bV/3gKlB9kwR5E4ZDciAAs/7wTEwM=; b=rYBa7uggVUhKGS9MK+VXT44y7g
	G9py03A6NwzPG8r0y00bLHF3lol9mJU+BC8amC7wMJqFB0ReF2TUAK2mLw+hsDuLRSwgq6w8ADSBP
	kFzBaH8pPcyaoKjVDelzUsy7WgX2dm9LTBHXznjX0qJaGdDVgBnfyF04XAvRgBsOcXNRx7LKjM6Dp
	WLJX88zY9/9dFvwGLRPTiJojljMbuzhb3AlWgL1CcZIqy0L0H2ojszU7hwHHcXxNnQylww/9zC7Nv
	PFo2mOM2OXLmekvnKGdicze3Zr7biAvTsAEby3UoDjtp6mk3c/2r6kTkHNS43Dgu6Xv2DmEAtwS41
	fDCF2tzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmXTR-00044D-26; Thu, 24 Jan 2019 05:22:45 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmXRZ-0002Vb-84
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 05:20:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B04AD1650;
 Wed, 23 Jan 2019 21:20:48 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.40.157])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7B653F5C1;
 Wed, 23 Jan 2019 21:20:45 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/6] arm64/mm: Make all page table pages cycles through
 standard constructs
Date: Thu, 24 Jan 2019 10:50:18 +0530
Message-Id: <1548307220-19756-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
References: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_212050_026114_1F1F991E 
X-CRM114-Status: GOOD (  15.71  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, Steve.Capper@arm.com, will.deacon@arm.com,
 james.morse@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently there are inconsistencies during page table page's allocation,
initialization and destruction. Not all those pages go through standard
constructors pgtable_page_ctor/pgtable_page_dtor which is very much
essential for proper initialization and accounting. Not going through
proper pgtable_page_ctor/pgtable_page_dtor cycle makes them vulnerable
for bad page state errors during page table tear down process.

This makes all levels of page table pages either for the user space or
for the kernel mappings go through these standard constructs. While
here pte_free() has been modified to accommodate pages which might not
have been allocated through buddy system but instead came from memblock
[1] directly during early boot process. Those pages must not go through
the pgtable_page_dtor() and instead are freed with free_reserved_page().

PGD based page table page which is allocated from 'pgd_cache' kmem cache
in certain situations (PGD_SIZE != PAGE_SIZE ) is excluded from being
cycled through pgtable_page_[ctor/dtor]. This is not a problem because
this slab never gets freed back to buddy allocator.

All stage-2 page table pages must cycle through pgtable_page_[ctor/dtor]
constructs for proper initialization and accounting. Use the standard
pte_alloc_one() and pte_free() for their allocation and release instead
of calling into the buddy allocator directly.

[1] Page table page allocation from memblock

(a) early_pgtable_alloc (passed with __create_pgd_mapping)
(b) vmemmap_pgd|pud_populate (vmemmap_populate)

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgalloc.h | 42 ++++++++++++++++++++++++++++++++--------
 arch/arm64/mm/pgd.c              |  4 ++--
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 52fa47c..076764f 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -29,17 +29,21 @@
 #define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm);
+static inline unsigned long pte_alloc_one_virt(struct mm_struct *mm);
+static inline void pte_free(struct mm_struct *mm, pgtable_t pte);
+
 #if CONFIG_PGTABLE_LEVELS > 2
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pmd_t *)__get_free_page(PGALLOC_GFP);
+	return (pmd_t *)pte_alloc_one_virt(mm);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
 {
 	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
-	free_page((unsigned long)pmdp);
+	pte_free(mm, virt_to_page(pmdp));
 }
 
 static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
@@ -62,13 +66,13 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pud_t *)__get_free_page(PGALLOC_GFP);
+	return (pud_t *)pte_alloc_one_virt(mm);
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pudp)
 {
 	BUG_ON((unsigned long)pudp & (PAGE_SIZE-1));
-	free_page((unsigned long)pudp);
+	pte_free(mm, virt_to_page(pudp));
 }
 
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
@@ -93,7 +97,7 @@ extern void pgd_free(struct mm_struct *mm, pgd_t *pgdp);
 static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)__get_free_page(PGALLOC_GFP);
+	return (pte_t *)pte_alloc_one_virt(mm);
 }
 
 static inline pgtable_t
@@ -111,19 +115,41 @@ pte_alloc_one(struct mm_struct *mm)
 	return pte;
 }
 
+static inline unsigned long
+pte_alloc_one_virt(struct mm_struct *mm)
+{
+	pgtable_t ptr;
+
+	ptr = pte_alloc_one(mm);
+	if (!ptr)
+		return 0;
+
+	return (unsigned long) page_to_virt(ptr);
+}
+
 /*
  * Free a PTE table.
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *ptep)
 {
 	if (ptep)
-		free_page((unsigned long)ptep);
+		pte_free(mm, virt_to_page(ptep));
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
 {
-	pgtable_page_dtor(pte);
-	__free_page(pte);
+	/*
+	 * Some page table pages might have come from memblock either
+	 * with vmemmap_alloc_block (during vmemmap_populate) or with
+	 * early_pgtable_alloc (during __create_pgd_mapping). These
+	 * pages should be freed with free_reserved_page() instead.
+	 */
+	if (PageReserved(pte)) {
+		free_reserved_page(pte);
+	} else {
+		pgtable_page_dtor(pte);
+		__free_page(pte);
+	}
 }
 
 static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t ptep,
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 8cb4e39..e344075 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -31,7 +31,7 @@ static struct kmem_cache *pgd_cache __ro_after_init;
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	if (PGD_SIZE == PAGE_SIZE)
-		return (pgd_t *)__get_free_page(PGALLOC_GFP);
+		return (pgd_t *)pte_alloc_one_virt(mm);
 	else
 		return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
 }
@@ -39,7 +39,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
 	if (PGD_SIZE == PAGE_SIZE)
-		free_page((unsigned long)pgd);
+		pte_free(mm, virt_to_page(pgd));
 	else
 		kmem_cache_free(pgd_cache, pgd);
 }
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
