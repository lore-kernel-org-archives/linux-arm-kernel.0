Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:07:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFE9218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y9hnBHW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFE9218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kr89QXcWCPMzrXj3ddXFQPLZC5/HyCjbf2GPOPVJp1A=; b=Y9hnBHW65q4N8L
	2m6PkZxipB/BMgJg2kBTGIqPzud0DBh/qIceSnLCVSsDvrxr+fARt1IzOPnpwI0DtTB4R4W3Sg90O
	SzjAq9n/c6OK7Bqg/FKyVOXauw/CSpz6U98jBo1jbcZA3G7dbOK0FHLUd3LXC6fbk56/i8V91zlyQ
	f/u/H7ampA5gWGU4VBVRlfNxjf2Ae4uBOCHYYM/N/vjDpEzUCadgZM4fmBiHExysJXe5LMWXwk94x
	M4ph/b4VrSnslkmfxk3e+zAFPBfB/yUgsY4cvmfZIWHGVRMPJswDZdq2ZECKWYJeDaTL1SupBxj3F
	FonCXiXCwG+Ln7jm9YuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgFD-0000vS-3U; Wed, 19 Dec 2018 18:06:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgCx-0005vR-Nr
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:04:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CEF715AB;
 Wed, 19 Dec 2018 10:04:29 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8243A3F675;
 Wed, 19 Dec 2018 10:04:26 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 07/28] KVM: arm/arm64: Re-factor setting the Stage 2 entry to
 exec on fault
Date: Wed, 19 Dec 2018 18:03:28 +0000
Message-Id: <20181219180349.242681-8-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_100435_911066_E67C430B 
X-CRM114-Status: GOOD (  16.91  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, punitagrawal@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Suzuki Poulose <suzuki.poulose@arm.com>,
 Lukas Braun <koomi@moshbit.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Punit Agrawal <punit.agrawal@arm.com>

Stage 2 fault handler marks a page as executable if it is handling an
execution fault or if it was a permission fault in which case the
executable bit needs to be preserved.

The logic to decide if the page should be marked executable is
duplicated for PMD and PTE entries. To avoid creating another copy
when support for PUD hugepages is introduced refactor the code to
share the checks needed to mark a page table entry as executable.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 59595207c5e1..6912529946fb 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1475,7 +1475,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  unsigned long fault_status)
 {
 	int ret;
-	bool write_fault, exec_fault, writable, force_pte = false;
+	bool write_fault, writable, force_pte = false;
+	bool exec_fault, needs_exec;
 	unsigned long mmu_seq;
 	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
 	struct kvm *kvm = vcpu->kvm;
@@ -1598,19 +1599,25 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (exec_fault)
 		invalidate_icache_guest_page(pfn, vma_pagesize);
 
+	/*
+	 * If we took an execution fault we have made the
+	 * icache/dcache coherent above and should now let the s2
+	 * mapping be executable.
+	 *
+	 * Write faults (!exec_fault && FSC_PERM) are orthogonal to
+	 * execute permissions, and we preserve whatever we have.
+	 */
+	needs_exec = exec_fault ||
+		(fault_status == FSC_PERM && stage2_is_exec(kvm, fault_ipa));
+
 	if (vma_pagesize == PMD_SIZE) {
 		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
 		new_pmd = pmd_mkhuge(new_pmd);
 		if (writable)
 			new_pmd = kvm_s2pmd_mkwrite(new_pmd);
 
-		if (exec_fault) {
+		if (needs_exec)
 			new_pmd = kvm_s2pmd_mkexec(new_pmd);
-		} else if (fault_status == FSC_PERM) {
-			/* Preserve execute if XN was already cleared */
-			if (stage2_is_exec(kvm, fault_ipa))
-				new_pmd = kvm_s2pmd_mkexec(new_pmd);
-		}
 
 		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
 	} else {
@@ -1621,13 +1628,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			mark_page_dirty(kvm, gfn);
 		}
 
-		if (exec_fault) {
+		if (needs_exec)
 			new_pte = kvm_s2pte_mkexec(new_pte);
-		} else if (fault_status == FSC_PERM) {
-			/* Preserve execute if XN was already cleared */
-			if (stage2_is_exec(kvm, fault_ipa))
-				new_pte = kvm_s2pte_mkexec(new_pte);
-		}
 
 		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, flags);
 	}
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
