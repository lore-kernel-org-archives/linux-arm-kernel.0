Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E195C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:13:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6115F2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MAfORwc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6115F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zGge2cexIpW65pI55OY2LOo9pIDg6y9gsqzcDSovFV4=; b=MAfORwc1fJj2nmVA1EeHJwQBU7
	mdeDx1Nvkyc04n6bqZeTkkHuYhTemkbWBNuZQPFo5+fhHywvOm9qfEB/x4nvNlz6+Yja32iGh36fk
	aXiwXoGilEeFrnfqycSrO1awnb44YE/y/IsMLHCOUGjqoI4Mt3rqSlQbIcoVXoRVmJsJSkNw5ENzO
	b3KuXqfG2LG8fTHBw62Tv+sTLDUAgJ6J6Z1yzQ4yLfkCRBnVZ2WBue3bbZPkZ6P5JsSIN76aG0ugQ
	kw2xRTq3RMAjl6KpCml6hJO7ii4cKElbSQwO/6Op+ShVWO/OHGDchAiwHJC7L3ExHgKGS1m56ZFP3
	8FUrCCng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlbY-0004Yb-82; Tue, 11 Dec 2018 17:13:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWla9-00037D-Vl
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:12:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F4AC174E;
 Tue, 11 Dec 2018 09:12:18 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 8378F3F6A8; Tue, 11 Dec 2018 09:12:16 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 6/8] KVM: arm64: Support handling access faults for PUD
 hugepages
Date: Tue, 11 Dec 2018 17:10:39 +0000
Message-Id: <1544548241-6417-7-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
References: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_091230_737340_B4118983 
X-CRM114-Status: GOOD (  15.57  )
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
Cc: kvm@vger.kernel.org, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, anshuman.khandual@arm.com, will.deacon@arm.com,
 christoffer.dall@arm.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Punit Agrawal <punit.agrawal@arm.com>

In preparation for creating larger hugepages at Stage 2, extend the
access fault handling at Stage 2 to support PUD hugepages when
encountered.

Provide trivial helpers for arm32 to allow sharing of code.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
[ Replaced BUG() => WARN_ON(1) in PUD helpers ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   |  9 +++++++++
 arch/arm64/include/asm/kvm_mmu.h |  7 +++++++
 arch/arm64/include/asm/pgtable.h |  6 ++++++
 virt/kvm/arm/mmu.c               | 22 +++++++++++-----------
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index a49655f..3a40720 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -85,6 +85,9 @@ void kvm_clear_hyp_idmap(void);
 #define kvm_pfn_pte(pfn, prot)	pfn_pte(pfn, prot)
 #define kvm_pfn_pmd(pfn, prot)	pfn_pmd(pfn, prot)
 
+#define kvm_pud_pfn(pud)	({ WARN_ON(1); 0; })
+
+
 #define kvm_pmd_mkhuge(pmd)	pmd_mkhuge(pmd)
 
 /*
@@ -108,6 +111,12 @@ static inline bool kvm_s2pud_exec(pud_t *pud)
 	return false;
 }
 
+static inline pud_t kvm_s2pud_mkyoung(pud_t pud)
+{
+	BUG();
+	return pud;
+}
+
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
 {
 	pte_val(pte) |= L_PTE_S2_RDWR;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index c755b37..612032b 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -187,6 +187,8 @@ void kvm_clear_hyp_idmap(void);
 #define kvm_pfn_pte(pfn, prot)		pfn_pte(pfn, prot)
 #define kvm_pfn_pmd(pfn, prot)		pfn_pmd(pfn, prot)
 
+#define kvm_pud_pfn(pud)		pud_pfn(pud)
+
 #define kvm_pmd_mkhuge(pmd)		pmd_mkhuge(pmd)
 
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
@@ -266,6 +268,11 @@ static inline bool kvm_s2pud_exec(pud_t *pudp)
 	return !(READ_ONCE(pud_val(*pudp)) & PUD_S2_XN);
 }
 
+static inline pud_t kvm_s2pud_mkyoung(pud_t pud)
+{
+	return pud_mkyoung(pud);
+}
+
 #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
 
 #ifdef __PAGETABLE_PMD_FOLDED
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 50b1ef8..f51e227 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -314,6 +314,11 @@ static inline pte_t pud_pte(pud_t pud)
 	return __pte(pud_val(pud));
 }
 
+static inline pud_t pte_pud(pte_t pte)
+{
+	return __pud(pte_val(pte));
+}
+
 static inline pmd_t pud_pmd(pud_t pud)
 {
 	return __pmd(pud_val(pud));
@@ -381,6 +386,7 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
+#define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
 #define __pud_to_phys(pud)	__pte_to_phys(pud_pte(pud))
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 8e44dcc..bd74960 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1698,6 +1698,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
  */
 static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 {
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	kvm_pfn_t pfn;
@@ -1707,24 +1708,23 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 
 	spin_lock(&vcpu->kvm->mmu_lock);
 
-	pmd = stage2_get_pmd(vcpu->kvm, NULL, fault_ipa);
-	if (!pmd || pmd_none(*pmd))	/* Nothing there */
+	if (!stage2_get_leaf_entry(vcpu->kvm, fault_ipa, &pud, &pmd, &pte))
 		goto out;
 
-	if (pmd_thp_or_huge(*pmd)) {	/* THP, HugeTLB */
+	if (pud) {		/* HugeTLB */
+		*pud = kvm_s2pud_mkyoung(*pud);
+		pfn = kvm_pud_pfn(*pud);
+		pfn_valid = true;
+	} else	if (pmd) {	/* THP, HugeTLB */
 		*pmd = pmd_mkyoung(*pmd);
 		pfn = pmd_pfn(*pmd);
 		pfn_valid = true;
-		goto out;
+	} else {
+		*pte = pte_mkyoung(*pte);	/* Just a page... */
+		pfn = pte_pfn(*pte);
+		pfn_valid = true;
 	}
 
-	pte = pte_offset_kernel(pmd, fault_ipa);
-	if (pte_none(*pte))		/* Nothing there either */
-		goto out;
-
-	*pte = pte_mkyoung(*pte);	/* Just a page... */
-	pfn = pte_pfn(*pte);
-	pfn_valid = true;
 out:
 	spin_unlock(&vcpu->kvm->mmu_lock);
 	if (pfn_valid)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
