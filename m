Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC402C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:04:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A390120818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cVfgN10L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A390120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ar9Hv+uBAtK6ibFMIBDP69L+RzAkC70vSdQJYaR6MbM=; b=cVfgN10LjXJ0Cm
	9+g7jF7vPm841bpqFMC64DeNm3KPGDjcZGSXfz7jpT7KfYUdSSpNE7Ll1SoX33fwa6K0ugfdwaCGD
	taEc50E5MItwq/zwXS3HJJDJqk0QbnBxI+te3LD4+AG62njaU+ReQRbGfEaWEJ6mwYS6xbUep+mc3
	k7SSS4BYtuQ+6zBrbjT6HDNdFdc+2OOCamChw/7iUs7UEhd6CetPDGGpRvYEB1wve2ocUPyIu67VX
	Yed6GiJubcQ5wNuj+Mrr8hGTF15QlVyXP3puuyFGI3WttZBd0OWmJAOpdbN6lUtYIQ+vMooJMTRNY
	6NSuNKzZlKm76j6PkdBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guguP-0005Jn-O4; Fri, 15 Feb 2019 17:04:17 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugtS-00048Y-VU
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:03:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4D441596;
 Fri, 15 Feb 2019 09:03:18 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0C343F557;
 Fri, 15 Feb 2019 09:03:15 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH 04/13] mm: pagewalk: Add p4d_entry() and pgd_entry()
Date: Fri, 15 Feb 2019 17:02:25 +0000
Message-Id: <20190215170235.23360-5-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215170235.23360-1-steven.price@arm.com>
References: <20190215170235.23360-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_090319_530603_153146E3 
X-CRM114-Status: GOOD (  16.14  )
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
Cc: x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
no users. We're about to add users so reintroduce them, along with
p4d_entry() as we now have 5 levels of tables.

Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
PUD-sized transparent hugepages") already re-added pud_entry() but with
different semantics to the other callbacks. Since there have never
been upstream users of this, revert the semantics back to match the
other callbacks. This means pud_entry() is called for all entries, not
just transparent huge pages.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 include/linux/mm.h |  9 ++++++---
 mm/pagewalk.c      | 27 ++++++++++++++++-----------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80bb6408fe73..1a4b1615d012 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1412,10 +1412,9 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 
 /**
  * mm_walk - callbacks for walk_page_range
+ * @pgd_entry: if set, called for each non-empty PGD (top-level) entry
+ * @p4d_entry: if set, called for each non-empty P4D (1st-level) entry
  * @pud_entry: if set, called for each non-empty PUD (2nd-level) entry
- *	       this handler should only handle pud_trans_huge() puds.
- *	       the pmd_entry or pte_entry callbacks will be used for
- *	       regular PUDs.
  * @pmd_entry: if set, called for each non-empty PMD (3rd-level) entry
  *	       this handler is required to be able to handle
  *	       pmd_trans_huge() pmds.  They may simply choose to
@@ -1435,6 +1434,10 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
  * (see the comment on walk_page_range() for more details)
  */
 struct mm_walk {
+	int (*pgd_entry)(pgd_t *pgd, unsigned long addr,
+			 unsigned long next, struct mm_walk *walk);
+	int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
+			 unsigned long next, struct mm_walk *walk);
 	int (*pud_entry)(pud_t *pud, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
 	int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index c3084ff2569d..98373a9f88b8 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -90,15 +90,9 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		}
 
 		if (walk->pud_entry) {
-			spinlock_t *ptl = pud_trans_huge_lock(pud, walk->vma);
-
-			if (ptl) {
-				err = walk->pud_entry(pud, addr, next, walk);
-				spin_unlock(ptl);
-				if (err)
-					break;
-				continue;
-			}
+			err = walk->pud_entry(pud, addr, next, walk);
+			if (err)
+				break;
 		}
 
 		split_huge_pud(walk->vma, pud, addr);
@@ -131,7 +125,12 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 				break;
 			continue;
 		}
-		if (walk->pmd_entry || walk->pte_entry)
+		if (walk->p4d_entry) {
+			err = walk->p4d_entry(p4d, addr, next, walk);
+			if (err)
+				break;
+		}
+		if (walk->pud_entry || walk->pmd_entry || walk->pte_entry)
 			err = walk_pud_range(p4d, addr, next, walk);
 		if (err)
 			break;
@@ -157,7 +156,13 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 				break;
 			continue;
 		}
-		if (walk->pmd_entry || walk->pte_entry)
+		if (walk->pgd_entry) {
+			err = walk->pgd_entry(pgd, addr, next, walk);
+			if (err)
+				break;
+		}
+		if (walk->p4d_entry || walk->pud_entry || walk->pmd_entry ||
+				walk->pte_entry)
 			err = walk_p4d_range(pgd, addr, next, walk);
 		if (err)
 			break;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
