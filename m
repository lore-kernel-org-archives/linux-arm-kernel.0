Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E65BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:05:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688382087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tElkJiVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688382087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rgsv4IAkvcAUQOqe/Im1xfUsteTrNdX7I1U3dv00FJ8=; b=tElkJiVFIB0f+rkdmSjlGSgmUR
	OM2LhZLU64QDBniEtMHx9F2DPRFO70NuhhTsm1ECn+scOIs83BSQTxRdFRFzOZolsx1hNW1d8ai+E
	OkvMAOOIyy45Z+kqFjD0oNrcBSbgwY8gMmcu1O46M1ScBo28SBkJ0vBOpb1DQwEh9XMfftr4CBt6L
	cnRLomqrwyTlP2vje33Tsx1LSTT5I+tP8YmZALhjaeGVr+8HL/eJcUu1SV+vR+MCOEpU89s6L99Ct
	E2RwXGxfYJoJOvjoBpWIcPLW3rn4gVbz2BZXlh03zuLchTSgLeGQfBiAXITXjLvc+COREFe7/1hkY
	huUhSmAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy8SZ-0000Ol-Gy; Mon, 25 Feb 2019 05:05:47 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy8RC-0006LT-KC
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 05:04:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26CE21596;
 Sun, 24 Feb 2019 21:04:16 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.42.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B94C3F5C1;
 Sun, 24 Feb 2019 21:04:12 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 4/6] arm64/mm: Call pgtable_page_dtor() for both PMD and
 PUD page table pages
Date: Mon, 25 Feb 2019 10:33:57 +0530
Message-Id: <1551071039-20192-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_210423_252702_09FF02A3 
X-CRM114-Status: UNSURE (   9.03  )
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
Cc: mark.rutland@arm.com, yuzhao@google.com, Steve.Capper@arm.com,
 marc.zyngier@arm.com, Catalin.Marinas@arm.com, suzuki.poulose@arm.com,
 will.deacon@arm.com, james.morse@arm.com
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
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlb.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 106fdc951b6e..3ef2d7ffafee 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -62,6 +62,9 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
+	struct page *page = virt_to_page(pmdp);
+
+	pgtable_page_dtor(page);
 	tlb_remove_table(tlb, virt_to_page(pmdp));
 }
 #endif
@@ -70,6 +73,9 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
+	struct page *page = virt_to_page(pudp);
+
+	pgtable_page_dtor(page);
 	tlb_remove_table(tlb, virt_to_page(pudp));
 }
 #endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
