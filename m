Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A5FC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:49:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088A62084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u9hAg9By"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088A62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hpCIYei++ja25jBmzXELtNUKcOfXXkqiYrvbc+6BlH8=; b=u9hAg9ByGBOegd
	GiDmfTzBweOdkysiEm8S68d03mYeL++Ck8L1jpJU/8VlGSh6ffL6QHpauWDB0fDRGWcQbVaON1GvF
	izfx3dr6AlsJ73AdzKoF1I+N7kp/rW9M20Aj5qUt6Z1NQrbGlcPDH/08hvoqThBYAA1hXVnWvrij9
	eNRQwxPwGszHPEqMkIWfxd7LOfc186HN+lsgxyV/ezWl++fOYt/NpQuwqhZiYIzVE/r65P9kVDErq
	XnnrchAm+7rhGKRA4mKsXrunA4C/FNzVXOo7RrT1r+t7/6G61pW7WjtxsshXUFCiOgFXH6/hYYqFF
	dT4602VbvEtT/p2bK4Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZBf-0007oy-2Y; Fri, 01 Feb 2019 13:48:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZBc-0007oU-0m
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 13:48:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3107480D;
 Fri,  1 Feb 2019 05:48:51 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4520C3F59C;
 Fri,  1 Feb 2019 05:48:50 -0800 (PST)
Date: Fri, 1 Feb 2019 13:48:47 +0000
From: Will Deacon <will.deacon@arm.com>
To: Qian Cai <cai@lca.pw>
Subject: Re: kernel_page_tables issue with CONFIG_ARM64_USER_VA_BITS_52=y
Message-ID: <20190201134847.GC29903@fuggles.cambridge.arm.com>
References: <fe7fa86a-42ed-ee58-be26-4d8ae45fadab@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fe7fa86a-42ed-ee58-be26-4d8ae45fadab@lca.pw>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_054852_067601_8C933101 
X-CRM114-Status: GOOD (  13.54  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, steve.capper@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Qian Cai,

Thanks for reporting this.

On Thu, Jan 31, 2019 at 11:01:50PM -0500, Qian Cai wrote:
> On this ThunderX2 server with both,
> CONFIG_ARM64_USER_VA_BITS_52=y
> CONFIG_ARM64_PTDUMP_DEBUGFS=y
> 
> kernel_page_tables could only print out linear mappings.

I think this is because the ptdump code is abusing both PTRS_PER_PGD and
pgd_offset(mm, 0UL) for walking kernel (TTBR1) page tables. That's not going
to work, because those are still configured as 48-bit.

Please can you try the diff below? (Steve -- can you have a look as well,
please?).

Thanks,

Will

--->8

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index fcb1f2a6d7c6..00ca2adeb5ef 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -286,74 +286,72 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
 
 }
 
-static void walk_pte(struct pg_state *st, pmd_t *pmdp, unsigned long start)
+static void walk_pte(struct pg_state *st, pmd_t *pmdp, unsigned long start,
+		     unsigned long end)
 {
-	pte_t *ptep = pte_offset_kernel(pmdp, 0UL);
-	unsigned long addr;
-	unsigned i;
+	unsigned long addr = start;
+	pte_t *ptep = pte_offset_kernel(pmdp, start);
 
-	for (i = 0; i < PTRS_PER_PTE; i++, ptep++) {
-		addr = start + i * PAGE_SIZE;
+	do {
 		note_page(st, addr, 4, READ_ONCE(pte_val(*ptep)));
-	}
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
 }
 
-static void walk_pmd(struct pg_state *st, pud_t *pudp, unsigned long start)
+static void walk_pmd(struct pg_state *st, pud_t *pudp, unsigned long start,
+		     unsigned long end)
 {
-	pmd_t *pmdp = pmd_offset(pudp, 0UL);
-	unsigned long addr;
-	unsigned i;
+	unsigned long next, addr = start;
+	pmd_t *pmdp = pmd_offset(pudp, start);
 
-	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
+	do {
 		pmd_t pmd = READ_ONCE(*pmdp);
+		next = pmd_addr_end(addr, end);
 
-		addr = start + i * PMD_SIZE;
 		if (pmd_none(pmd) || pmd_sect(pmd)) {
 			note_page(st, addr, 3, pmd_val(pmd));
 		} else {
 			BUG_ON(pmd_bad(pmd));
-			walk_pte(st, pmdp, addr);
+			walk_pte(st, pmdp, addr, next);
 		}
-	}
+	} while (pmdp++, addr = next, addr != end);
 }
 
-static void walk_pud(struct pg_state *st, pgd_t *pgdp, unsigned long start)
+static void walk_pud(struct pg_state *st, pgd_t *pgdp, unsigned long start,
+		     unsigned long end)
 {
-	pud_t *pudp = pud_offset(pgdp, 0UL);
-	unsigned long addr;
-	unsigned i;
+	unsigned long next, addr = start;
+	pud_t *pudp = pud_offset(pgdp, start);
 
-	for (i = 0; i < PTRS_PER_PUD; i++, pudp++) {
+	do {
 		pud_t pud = READ_ONCE(*pudp);
+		next = pud_addr_end(addr, end);
 
-		addr = start + i * PUD_SIZE;
 		if (pud_none(pud) || pud_sect(pud)) {
 			note_page(st, addr, 2, pud_val(pud));
 		} else {
 			BUG_ON(pud_bad(pud));
-			walk_pmd(st, pudp, addr);
+			walk_pmd(st, pudp, addr, next);
 		}
-	}
+	} while (pudp++, addr = next, addr != end);
 }
 
 static void walk_pgd(struct pg_state *st, struct mm_struct *mm,
 		     unsigned long start)
 {
-	pgd_t *pgdp = pgd_offset(mm, 0UL);
-	unsigned i;
-	unsigned long addr;
+	unsigned long next, addr = start;
+	pgd_t *pgdp = pgd_offset(mm, addr);
 
-	for (i = 0; i < PTRS_PER_PGD; i++, pgdp++) {
+	do {
 		pgd_t pgd = READ_ONCE(*pgdp);
+		next = pgd_addr_end(addr, 0);
 
-		addr = start + i * PGDIR_SIZE;
 		if (pgd_none(pgd)) {
 			note_page(st, addr, 1, pgd_val(pgd));
 		} else {
 			BUG_ON(pgd_bad(pgd));
-			walk_pud(st, pgdp, addr);
+			walk_pud(st, pgdp, addr, next);
 		}
-	}
+	} while (pgdp++, addr = next, addr);
 }
 
 void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
