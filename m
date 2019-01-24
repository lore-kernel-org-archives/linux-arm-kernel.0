Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E52C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:21:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E65A218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c1qc/Isn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E65A218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=WSEc1Liu7iAI76eusyw1DISD7+OF43CpWU+immUgxyQ=; b=c1qc/IsnHe4kaUeuAWyQQGUcnu
	vILzck79X42egRFi5ZWa/CuNAtm5Nc1y/fIFhz7w4of0iGiRhT2mG5pjMKvJAmHlAc5cNAAV7IhnD
	0UOMVNrpZ2mV2M7NN7hYcclYGlnxtINQj5YsyR/FN9vKA7o6JCEKpSDNpv85memAO6eZ34szi5b9A
	Zd/32VLzNYOXe4ZKYi58TFJs1eJez7KkMRUEC1Ko75jJTGGD2eZ6rNokoRI6S/DjwF13ctnr18/Vz
	y1lKZSZGdAIxD2jvjoVMbiyWPIEOpP/j+F6j6qIJ7Ts7Pe9FG07TDOeYjMg/9eB0bwvNCfKqbEfFb
	4xTcOvow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmXSb-0003TY-S3; Thu, 24 Jan 2019 05:21:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmXRc-0002Yt-GU
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 05:20:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2552AA78;
 Wed, 23 Jan 2019 21:20:52 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.40.157])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D2133F5C1;
 Wed, 23 Jan 2019 21:20:48 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] arm64/mm: Call pgtable_page_dtor() for both PMD and PUD
 page table pages
Date: Thu, 24 Jan 2019 10:50:19 +0530
Message-Id: <1548307220-19756-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
References: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_212052_635886_79E544A1 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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

TLB flush during PMD and PUD level page table page tear down currently does
not call pgtable_page_dtor() like that for PTE page table pages. Now that
all the page table pages which are allocated from the buddy allocator must
have been initialized through pgtable_page_ctor() they must be freed back
only after being called into pgtable_page_dtor() destructor. Else these
pages might run into bad page state errors while getting freed into buddy
allocator.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/tlb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 106fdc9..de46ba0 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -62,6 +62,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
+	pgtable_page_dtor(virt_to_page(pmdp));
 	tlb_remove_table(tlb, virt_to_page(pmdp));
 }
 #endif
@@ -70,6 +71,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
+	pgtable_page_dtor(virt_to_page(pudp));
 	tlb_remove_table(tlb, virt_to_page(pudp));
 }
 #endif
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
