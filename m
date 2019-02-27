Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA22C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:11:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4E620842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jv1eEK0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4E620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0YgPtPnmsGVx0tr2omgE4oPZl4aX9kXoiD2mKmULgTs=; b=Jv1eEK0eSTM331
	Yx1YOfAOYxM6LP8ysNIf9TMGN/Gn8wU0K3r8D8JJ3QDrka8o/b4Z0ofTe1cEkw3AHA6UJRT3RadrJ
	tbk9YKeT6ZhloiIH6MhierC5qmxINkyDvCqjDIrgBavK93U4Maj/WyphPMpq9Em+VeskE+QJ7RL16
	+sPC1Rvab/RfOyGjF0mx0PgBa+NaUKCinqZ58AnsnwaQClx8MGPNJ20uLUQaz9VTudV44b99T50+t
	DMTExIXzD2J/iq92svqroMFoFmvttxcv6fcliVysq3kIjBEQjaHETbgYs77c2dxTV2huVlrP1oYKs
	0YXp5NWRlm3mEzKD9zng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz2jd-0005BE-OF; Wed, 27 Feb 2019 17:11:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2gl-0000qT-6r
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:08:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E223A78;
 Wed, 27 Feb 2019 09:08:11 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D78CF3F738;
 Wed, 27 Feb 2019 09:08:07 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v3 27/34] mm: pagewalk: Add 'depth' parameter to pte_hole
Date: Wed, 27 Feb 2019 17:06:01 +0000
Message-Id: <20190227170608.27963-28-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_090811_257544_60702184 
X-CRM114-Status: GOOD (  20.71  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pte_hole() callback is called at multiple levels of the page tables.
Code dumping the kernel page tables needs to know what at what depth
the missing entry is. Add this is an extra parameter to pte_hole().
When the depth isn't know (e.g. processing a vma) then -1 is passed.

The depth that is reported is the actual level where the entry is
missing (ignoring any folding that is in place), i.e. any levels where
PTRS_PER_P?D is set to 1 are ignored.

Note that depth starts at 0 for a PGD so that PUD/PMD/PTE retain their
natural numbers as levels 2/3/4.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 fs/proc/task_mmu.c |  4 ++--
 include/linux/mm.h |  6 ++++--
 mm/hmm.c           |  2 +-
 mm/migrate.c       |  1 +
 mm/mincore.c       |  1 +
 mm/pagewalk.c      | 31 +++++++++++++++++++++++++------
 6 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f0ec9edab2f3..91131cd4e9e0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -474,7 +474,7 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 
 #ifdef CONFIG_SHMEM
 static int smaps_pte_hole(unsigned long addr, unsigned long end,
-		struct mm_walk *walk)
+			  __always_unused int depth, struct mm_walk *walk)
 {
 	struct mem_size_stats *mss = walk->private;
 
@@ -1203,7 +1203,7 @@ static int add_to_pagemap(unsigned long addr, pagemap_entry_t *pme,
 }
 
 static int pagemap_pte_hole(unsigned long start, unsigned long end,
-				struct mm_walk *walk)
+			    __always_unused int depth, struct mm_walk *walk)
 {
 	struct pagemapread *pm = walk->private;
 	unsigned long addr = start;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1a4b1615d012..4ae3634a9118 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1420,7 +1420,9 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
  *	       pmd_trans_huge() pmds.  They may simply choose to
  *	       split_huge_page() instead of handling it explicitly.
  * @pte_entry: if set, called for each non-empty PTE (4th-level) entry
- * @pte_hole: if set, called for each hole at all levels
+ * @pte_hole: if set, called for each hole at all levels,
+ *            depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD, 4:PTE
+ *            any depths where PTRS_PER_P?D is equal to 1 are skipped
  * @hugetlb_entry: if set, called for each hugetlb entry
  * @test_walk: caller specific callback function to determine whether
  *             we walk over the current vma or not. Returning 0
@@ -1445,7 +1447,7 @@ struct mm_walk {
 	int (*pte_entry)(pte_t *pte, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
 	int (*pte_hole)(unsigned long addr, unsigned long next,
-			struct mm_walk *walk);
+			int depth, struct mm_walk *walk);
 	int (*hugetlb_entry)(pte_t *pte, unsigned long hmask,
 			     unsigned long addr, unsigned long next,
 			     struct mm_walk *walk);
diff --git a/mm/hmm.c b/mm/hmm.c
index a04e4b810610..e3e6b8fda437 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -440,7 +440,7 @@ static void hmm_range_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
 }
 
 static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
-			     struct mm_walk *walk)
+			     __always_unused int depth, struct mm_walk *walk)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
diff --git a/mm/migrate.c b/mm/migrate.c
index d4fd680be3b0..8b62a9fecb5c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2121,6 +2121,7 @@ struct migrate_vma {
 
 static int migrate_vma_collect_hole(unsigned long start,
 				    unsigned long end,
+				    __always_unused int depth,
 				    struct mm_walk *walk)
 {
 	struct migrate_vma *migrate = walk->private;
diff --git a/mm/mincore.c b/mm/mincore.c
index 218099b5ed31..c4edbc688241 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -104,6 +104,7 @@ static int __mincore_unmapped_range(unsigned long addr, unsigned long end,
 }
 
 static int mincore_unmapped_range(unsigned long addr, unsigned long end,
+				   __always_unused int depth,
 				   struct mm_walk *walk)
 {
 	walk->private += __mincore_unmapped_range(addr, end,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index dac0c848b458..57946bcd810c 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -4,6 +4,22 @@
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
 
+/*
+ * We want to know the real level where a entry is located ignoring any
+ * folding of levels which may be happening. For example if p4d is folded then
+ * a missing entry found at level 1 (p4d) is actually at level 0 (pgd).
+ */
+static int real_depth(int depth)
+{
+	if (depth == 3 && PTRS_PER_PMD == 1)
+		depth = 2;
+	if (depth == 2 && PTRS_PER_PUD == 1)
+		depth = 1;
+	if (depth == 1 && PTRS_PER_P4D == 1)
+		depth = 0;
+	return depth;
+}
+
 static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
@@ -31,6 +47,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	pmd_t *pmd;
 	unsigned long next;
 	int err = 0;
+	int depth = real_depth(3);
 
 	pmd = pmd_offset(pud, addr);
 	do {
@@ -38,7 +55,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd)) {
 			if (walk->pte_hole)
-				err = walk->pte_hole(addr, next, walk);
+				err = walk->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
 			continue;
@@ -81,6 +98,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	pud_t *pud;
 	unsigned long next;
 	int err = 0;
+	int depth = real_depth(2);
 
 	pud = pud_offset(p4d, addr);
 	do {
@@ -88,7 +106,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		next = pud_addr_end(addr, end);
 		if (pud_none(*pud)) {
 			if (walk->pte_hole)
-				err = walk->pte_hole(addr, next, walk);
+				err = walk->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
 			continue;
@@ -123,13 +141,14 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	p4d_t *p4d;
 	unsigned long next;
 	int err = 0;
+	int depth = real_depth(1);
 
 	p4d = p4d_offset(pgd, addr);
 	do {
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d)) {
 			if (walk->pte_hole)
-				err = walk->pte_hole(addr, next, walk);
+				err = walk->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
 			continue;
@@ -160,7 +179,7 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd)) {
 			if (walk->pte_hole)
-				err = walk->pte_hole(addr, next, walk);
+				err = walk->pte_hole(addr, next, 0, walk);
 			if (err)
 				break;
 			continue;
@@ -206,7 +225,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 		if (pte)
 			err = walk->hugetlb_entry(pte, hmask, addr, next, walk);
 		else if (walk->pte_hole)
-			err = walk->pte_hole(addr, next, walk);
+			err = walk->pte_hole(addr, next, -1, walk);
 
 		if (err)
 			break;
@@ -249,7 +268,7 @@ static int walk_page_test(unsigned long start, unsigned long end,
 	if (vma->vm_flags & VM_PFNMAP) {
 		int err = 1;
 		if (walk->pte_hole)
-			err = walk->pte_hole(start, end, walk);
+			err = walk->pte_hole(start, end, -1, walk);
 		return err ? err : 1;
 	}
 	return 0;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
