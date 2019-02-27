Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC38C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:11:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A925620842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XX+cPhip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A925620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t8rZUKo74RtwGe4163GiQLIu21qmDa2anmkxVMLOCYk=; b=XX+cPhipIew+mf
	rtGf/TSg/Y1fIVhswjOa1EnZEF5NuylY66KtjhsWWhG2AONgijYxbi2dY/gc2t9f1Spy1nepRjPE2
	IDszMFfFDPqV1PZ2G0g6PFdYHEXWydF/CxWa8wLxnLzWN9r42szJrKXcxWu1CS/8yfme9LUw5gV0U
	t7K4E0O+VrkXGr9o8+NOjp2sM7VNI/EmS90vKw8tgfMzRHF+EtmwGlipj09d6jVl769ptrclQH/6U
	F9WArL/JBx5II5XgTn/8SEyraskhMKeN8gU42+VbjT9mNI9OKFNRwTQvOiOW5luFGPhIip9ivH96O
	awZndRSROxDJXiSkucwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz2jz-0005fL-D1; Wed, 27 Feb 2019 17:11:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2gs-0000s7-9P
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:08:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E9FE19BF;
 Wed, 27 Feb 2019 09:08:18 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7C103F738;
 Wed, 27 Feb 2019 09:08:14 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v3 29/34] arm64: mm: Convert mm/dump.c to use walk_page_range()
Date: Wed, 27 Feb 2019 17:06:03 +0000
Message-Id: <20190227170608.27963-30-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_090818_607062_353D94D1 
X-CRM114-Status: GOOD (  13.78  )
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

Now walk_page_range() can walk kernel page tables, we can switch the
arm64 ptdump code over to using it, simplifying the code.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/mm/dump.c | 108 +++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 55 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 99bb8facb5cb..ee0bc1441dd0 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -286,73 +286,71 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
 
 }
 
-static void walk_pte(struct pg_state *st, pmd_t *pmdp, unsigned long start,
-		     unsigned long end)
+static int pud_entry(pud_t *pud, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
 {
-	unsigned long addr = start;
-	pte_t *ptep = pte_offset_kernel(pmdp, start);
+	struct pg_state *st = walk->private;
+	pud_t val = READ_ONCE(*pud);
 
-	do {
-		note_page(st, addr, 4, READ_ONCE(pte_val(*ptep)));
-	} while (ptep++, addr += PAGE_SIZE, addr != end);
+	if (pud_table(val))
+		return 0;
+
+	note_page(st, addr, 2, pud_val(val));
+
+	return 0;
 }
 
-static void walk_pmd(struct pg_state *st, pud_t *pudp, unsigned long start,
-		     unsigned long end)
+static int pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
 {
-	unsigned long next, addr = start;
-	pmd_t *pmdp = pmd_offset(pudp, start);
-
-	do {
-		pmd_t pmd = READ_ONCE(*pmdp);
-		next = pmd_addr_end(addr, end);
-
-		if (pmd_none(pmd) || pmd_sect(pmd)) {
-			note_page(st, addr, 3, pmd_val(pmd));
-		} else {
-			BUG_ON(pmd_bad(pmd));
-			walk_pte(st, pmdp, addr, next);
-		}
-	} while (pmdp++, addr = next, addr != end);
+	struct pg_state *st = walk->private;
+	pmd_t val = READ_ONCE(*pmd);
+
+	if (pmd_table(val))
+		return 0;
+
+	note_page(st, addr, 3, pmd_val(val));
+
+	return 0;
 }
 
-static void walk_pud(struct pg_state *st, pgd_t *pgdp, unsigned long start,
-		     unsigned long end)
+static int pte_entry(pte_t *pte, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
 {
-	unsigned long next, addr = start;
-	pud_t *pudp = pud_offset(pgdp, start);
-
-	do {
-		pud_t pud = READ_ONCE(*pudp);
-		next = pud_addr_end(addr, end);
-
-		if (pud_none(pud) || pud_sect(pud)) {
-			note_page(st, addr, 2, pud_val(pud));
-		} else {
-			BUG_ON(pud_bad(pud));
-			walk_pmd(st, pudp, addr, next);
-		}
-	} while (pudp++, addr = next, addr != end);
+	struct pg_state *st = walk->private;
+	pte_t val = READ_ONCE(*pte);
+
+	note_page(st, addr, 4, pte_val(val));
+
+	return 0;
+}
+
+static int pte_hole(unsigned long addr, unsigned long next, int depth,
+		struct mm_walk *walk)
+{
+	struct pg_state *st = walk->private;
+
+	note_page(st, addr, depth+1, 0);
+
+	return 0;
 }
 
 static void walk_pgd(struct pg_state *st, struct mm_struct *mm,
-		     unsigned long start)
+		unsigned long start)
 {
-	unsigned long end = (start < TASK_SIZE_64) ? TASK_SIZE_64 : 0;
-	unsigned long next, addr = start;
-	pgd_t *pgdp = pgd_offset(mm, start);
-
-	do {
-		pgd_t pgd = READ_ONCE(*pgdp);
-		next = pgd_addr_end(addr, end);
-
-		if (pgd_none(pgd)) {
-			note_page(st, addr, 1, pgd_val(pgd));
-		} else {
-			BUG_ON(pgd_bad(pgd));
-			walk_pud(st, pgdp, addr, next);
-		}
-	} while (pgdp++, addr = next, addr != end);
+	struct mm_walk walk = {
+		.mm = mm,
+		.private = st,
+		.pud_entry = pud_entry,
+		.pmd_entry = pmd_entry,
+		.pte_entry = pte_entry,
+		.pte_hole = pte_hole
+	};
+	down_read(&mm->mmap_sem);
+	walk_page_range(start, start | (((unsigned long)PTRS_PER_PGD <<
+					 PGDIR_SHIFT) - 1),
+			&walk);
+	up_read(&mm->mmap_sem);
 }
 
 void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
