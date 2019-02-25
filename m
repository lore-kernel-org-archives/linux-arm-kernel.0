Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A441CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:05:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698542087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kD9KtB/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698542087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Q0pK7CGCdtSwiErPqes3B/29AeOfi/9eDcaSIEyevNk=; b=kD9KtB/PvsAxpkdfOGK7mRiEkv
	/3GO1T3oBvxvaraCYQ0+gjqFNRZMOH06IV2kLlkbuJSqkxDIUhfKkaKTexZfefFx7JamyYYzLyPzY
	BzFAZEjwQe4BLiYDRR8p1tY4rCl03BM3CgsfHqFp70ZyztGt9Ua8kyA7RvDeob2JA01JM0DeYkYpL
	afOEdEcd5d02uHiG/xpwsOV0jrrLPJ1zH5mDA6y00UZV7Nmh/pA2dIsW8JOFn82Ib7urmXMAXQC6f
	kKdnYTo+wnqdGqozgvOkNrFSCNKoO/ywCY7lE8mSJJauOGVIFj2C2Sps1XSr5g18/zy5Mk/L8jrfS
	kqHR5Sng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy8SS-0000G4-1f; Mon, 25 Feb 2019 05:05:40 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy8RD-0006Np-SA
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 05:04:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED4B615AD;
 Sun, 24 Feb 2019 21:04:22 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.42.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 151363F5C1;
 Sun, 24 Feb 2019 21:04:19 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 6/6] arm64/mm: Enable ARCH_ENABLE_SPLIT_PMD_PTLOCK
Date: Mon, 25 Feb 2019 10:33:59 +0530
Message-Id: <1551071039-20192-7-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_210424_774860_5CD5047D 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: mark.rutland@arm.com, yuzhao@google.com, Steve.Capper@arm.com,
 marc.zyngier@arm.com, Catalin.Marinas@arm.com, suzuki.poulose@arm.com,
 will.deacon@arm.com, james.morse@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enabling ARCH_ENABLE_SPLIT_PMD_PTLOCK should help reduce lock contention on
larger systems when the page tables are being modified concurrently. This
moves locking granularity from mm_struct (mm->page_table_lock) to per pmd
page table lock (page->ptl).

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig               |  4 +++
 arch/arm64/include/asm/pgalloc.h | 43 ++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..b909e5d3b951 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -285,6 +285,10 @@ config PGTABLE_LEVELS
 	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
 	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48
 
+config ARCH_ENABLE_SPLIT_PMD_PTLOCK
+	def_bool y
+	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && (PGTABLE_LEVELS > 2)
+
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index a02a4d1d967d..9e06238be9b6 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -35,15 +35,54 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pte);
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
+/*
+ * FIXME: _workaround might not be the right suffix here but it does
+ * indicate the intent behind it. Generic pgtable_pmd_page_ctor/dtor
+ * constructs neither do account the PMD page towards NR_PAGETABLE
+ * nor do they update page state with the new page type PageTable.
+ * Ideally pgtable_pmd_page_ctor/dtor should have been just taking care
+ * of page->pmd_huge_pte when applicable along with what is already
+ * achieved with pgtable_page_ctor/dtor constructs. Unfortunately that
+ * is not the case currently and changing those generic mm constructs
+ * might impact other archs. For now lets do the right thing here and
+ * drop this when generic PMD constructs accommodate required changes.
+ */
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && USE_SPLIT_PMD_PTLOCKS
+static inline void pgtable_pmd_page_ctor_workaround(struct page *page)
+{
+	page->pmd_huge_pte = NULL;
+}
+
+static inline void pgtable_pmd_page_dtor_workaround(struct page *page)
+{
+	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
+}
+#else
+static inline void pgtable_pmd_page_ctor_workaround(struct page *page) { }
+static inline void pgtable_pmd_page_dtor_workaround(struct page *page) { }
+#endif
+
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pmd_t *)pte_alloc_one_virt(mm);
+	pgtable_t ptr;
+
+	ptr = pte_alloc_one(mm);
+	if (!ptr)
+		return 0;
+
+	pgtable_pmd_page_ctor_workaround(ptr);
+	return (pmd_t *)page_to_virt(ptr);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
 {
+	struct page *page;
+
 	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
-	pte_free(mm, virt_to_page(pmdp));
+	page = virt_to_page(pmdp);
+
+	pgtable_pmd_page_dtor_workaround(page);
+	pte_free(mm, page);
 }
 
 static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
