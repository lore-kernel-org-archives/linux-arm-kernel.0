Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D480C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:21:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B82A217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MlOrheee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B82A217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BFq9SxqVUdo4zGjtsIPDres/MzlblXcpflCErNsDkEs=; b=MlOrheeeag2igRk5cnCYENlKw/
	m19WvIY1B0YwA7hsGcieHZ9lSPx53nutbLF0b+te/r2mS/HpKMAeN+d4u3ByAwbQ3GTXQtCVp9J5l
	tMLXqYZmdB7AMzPxo7LSzfiMhFW5SqJbfce0XMH45lwyhgWxNfWQ082SuLWZq0edh/PPmpS56XXFk
	IIdcKc0Ssifn72165FmeICwTiAF756xzRRsFod5Jmivx/0F5tJQoUkVEd78KYILfC3Kr5nZ2CXQwV
	wB0I6VNUt4g6b0pX/5JFL6I9/6teIiwHXOcKKa0K9KepPOeM81nzUvUiCtlrg1ouVjg/72pxEp74L
	5tWZcBtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmXRg-0002c3-JM; Thu, 24 Jan 2019 05:20:56 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmXRQ-0002OZ-98
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 05:20:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CC4D1596;
 Wed, 23 Jan 2019 21:20:38 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.40.157])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75D9C3F5C1;
 Wed, 23 Jan 2019 21:20:35 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] KVM: ARM: Remove pgtable standard functions from stage-2
 page tables
Date: Thu, 24 Jan 2019 10:50:15 +0530
Message-Id: <1548307220-19756-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
References: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_212040_321158_4543844F 
X-CRM114-Status: UNSURE (   9.82  )
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

ARM64 standard pgtable functions are going to use pgtable_page_[ctor|dtor]
constructs. Certain stage-2 page table allocations are multi order which
cannot be allocated through a generic pgtable function as it does not exist
right now. This prevents all pgtable allocations including multi order ones
in stage-2 from moving into new ARM64 (pgtable_page_[ctor|dtor]) pgtable
functions. Hence remove all generic pgtable allocation function dependency
from stage-2 page tables till there is one multi-order allocation function
available.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm/include/asm/stage2_pgtable.h   | 4 ++--
 arch/arm64/include/asm/stage2_pgtable.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/stage2_pgtable.h b/arch/arm/include/asm/stage2_pgtable.h
index c4b1d4f..0895e0b 100644
--- a/arch/arm/include/asm/stage2_pgtable.h
+++ b/arch/arm/include/asm/stage2_pgtable.h
@@ -32,14 +32,14 @@
 #define stage2_pgd_present(kvm, pgd)		pgd_present(pgd)
 #define stage2_pgd_populate(kvm, pgd, pud)	pgd_populate(NULL, pgd, pud)
 #define stage2_pud_offset(kvm, pgd, address)	pud_offset(pgd, address)
-#define stage2_pud_free(kvm, pud)		pud_free(NULL, pud)
+#define stage2_pud_free(kvm, pud)		free_page((unsigned long)pud)
 
 #define stage2_pud_none(kvm, pud)		pud_none(pud)
 #define stage2_pud_clear(kvm, pud)		pud_clear(pud)
 #define stage2_pud_present(kvm, pud)		pud_present(pud)
 #define stage2_pud_populate(kvm, pud, pmd)	pud_populate(NULL, pud, pmd)
 #define stage2_pmd_offset(kvm, pud, address)	pmd_offset(pud, address)
-#define stage2_pmd_free(kvm, pmd)		pmd_free(NULL, pmd)
+#define stage2_pmd_free(kvm, pmd)		free_page((unsigned long)pmd)
 
 #define stage2_pud_huge(kvm, pud)		pud_huge(pud)
 
diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index 5412fa4..915809e 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -119,7 +119,7 @@ static inline pud_t *stage2_pud_offset(struct kvm *kvm,
 static inline void stage2_pud_free(struct kvm *kvm, pud_t *pud)
 {
 	if (kvm_stage2_has_pud(kvm))
-		pud_free(NULL, pud);
+		free_page((unsigned long)pud);
 }
 
 static inline bool stage2_pud_table_empty(struct kvm *kvm, pud_t *pudp)
@@ -192,7 +192,7 @@ static inline pmd_t *stage2_pmd_offset(struct kvm *kvm,
 static inline void stage2_pmd_free(struct kvm *kvm, pmd_t *pmd)
 {
 	if (kvm_stage2_has_pmd(kvm))
-		pmd_free(NULL, pmd);
+		free_page((unsigned long)pmd);
 }
 
 static inline bool stage2_pud_huge(struct kvm *kvm, pud_t pud)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
