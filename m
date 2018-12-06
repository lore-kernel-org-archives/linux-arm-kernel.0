Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D43FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:33:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC0F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oTFjhT2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC0F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WiPO8wzY+nv11dS7zfp9SFeoHywa0byOC+RPqlJHOo0=; b=oTFjhT2EoCzw3p
	431ZA3M+kjakazaYOoSWdBwNJeil8nx4ONrxE/6DlcZyOU99KiBNKAjAWPtRJft1h1/HWqYuPdO+Q
	dKYQIt5vtFuWOlWA2RrE5k1cAKCGxs06tsoQilV9zH6VF3artXaum32+0s5YIVzFbigb8iGjwvfX0
	dUNpLht0qVm0wmGRI8KzI6XXLcBsdqEkw26tvHEQth/m+kb3Mr368kOFGmzVeImzjYtqM0WZo6X6L
	F3HVi8Mwvq826R3ZsO5cZKMXOLxwuhlCW9zBhcZ1MJhT42BSWDtax6J6sECIkB++C3UOXHTcNLBJa
	TRFAXpsrgGW4rJr6rMGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUxWd-0001lP-A0; Thu, 06 Dec 2018 17:33:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUxVF-0000Am-MY
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:32:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B385F1596;
 Thu,  6 Dec 2018 09:31:48 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 163C03F5AF;
 Thu,  6 Dec 2018 09:31:46 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 7/8] arm64: KVM: Handle ARM erratum 1165522 in TLB
 invalidation
Date: Thu,  6 Dec 2018 17:31:25 +0000
Message-Id: <20181206173126.139877-8-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206173126.139877-1-marc.zyngier@arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_093158_490199_3FB6E9FD 
X-CRM114-Status: GOOD (  17.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to avoid TLB corruption whilst invalidating TLBs on CPUs
affected by erratum 1165522, we need to prevent S1 page tables
from being usable.

For this, we set the EL1 S1 MMU on, and also disable the page table
walker (by setting the TCR_EL1.EPD* bits to 1).

This ensures that once we switch to the EL1/EL0 translation regime,
speculated AT instructions won't be able to parse the page tables.

Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/tlb.c | 66 +++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index 7fcc9c1a5f45..ec157543d5a9 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -21,12 +21,36 @@
 #include <asm/kvm_mmu.h>
 #include <asm/tlbflush.h>
 
+struct tlb_inv_context {
+	unsigned long	flags;
+	u64		tcr;
+	u64		sctlr;
+};
+
 static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
-						 unsigned long *flags)
+						 struct tlb_inv_context *cxt)
 {
 	u64 val;
 
-	local_irq_save(*flags);
+	local_irq_save(cxt->flags);
+
+	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
+		/*
+		 * For CPUs that are affected by ARM erratum 1165522, we
+		 * cannot trust stage-1 to be in a correct state at that
+		 * point. Since we do not want to force a full load of the
+		 * vcpu state, we prevent the EL1 page-table walker to
+		 * allocate new TLBs. This is done by setting the EPD bits
+		 * in the TCR_EL1 register. We also need to prevent it to
+		 * allocate IPA->PA walks, so we enable the S1 MMU...
+		 */
+		val = cxt->tcr = read_sysreg_el1(tcr);
+		val |= TCR_EPD1_MASK | TCR_EPD0_MASK;
+		write_sysreg_el1(val, tcr);
+		val = cxt->sctlr = read_sysreg_el1(sctlr);
+		val |= SCTLR_ELx_M;
+		write_sysreg_el1(val, sctlr);
+	}
 
 	/*
 	 * With VHE enabled, we have HCR_EL2.{E2H,TGE} = {1,1}, and
@@ -34,6 +58,11 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 	 * guest TLBs (EL1/EL0), we need to change one of these two
 	 * bits. Changing E2H is impossible (goodbye TTBR1_EL2), so
 	 * let's flip TGE before executing the TLB operation.
+	 *
+	 * ARM erratum 1165522 requires some special handling (again),
+	 * as we need to make sure both stages of translation are in
+	 * place before clearing TGE. __load_guest_stage2() already
+	 * has an ISB in order to deal with this.
 	 */
 	__load_guest_stage2(kvm);
 	val = read_sysreg(hcr_el2);
@@ -43,7 +72,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 }
 
 static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
-						  unsigned long *flags)
+						  struct tlb_inv_context *cxt)
 {
 	__load_guest_stage2(kvm);
 	isb();
@@ -55,7 +84,7 @@ static hyp_alternate_select(__tlb_switch_to_guest,
 			    ARM64_HAS_VIRT_HOST_EXTN);
 
 static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
-						unsigned long flags)
+						struct tlb_inv_context *cxt)
 {
 	/*
 	 * We're done with the TLB operation, let's restore the host's
@@ -64,11 +93,18 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
 	write_sysreg(0, vttbr_el2);
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
 	isb();
-	local_irq_restore(flags);
+
+	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
+		/* Restore the guest's registers to what they were */
+		write_sysreg_el1(cxt->tcr, tcr);
+		write_sysreg_el1(cxt->sctlr, sctlr);
+	}
+
+	local_irq_restore(cxt->flags);
 }
 
 static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm,
-						 unsigned long flags)
+						 struct tlb_inv_context *cxt)
 {
 	write_sysreg(0, vttbr_el2);
 }
@@ -80,13 +116,13 @@ static hyp_alternate_select(__tlb_switch_to_host,
 
 void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
-	unsigned long flags;
+	struct tlb_inv_context cxt;
 
 	dsb(ishst);
 
 	/* Switch to requested VMID */
 	kvm = kern_hyp_va(kvm);
-	__tlb_switch_to_guest()(kvm, &flags);
+	__tlb_switch_to_guest()(kvm, &cxt);
 
 	/*
 	 * We could do so much better if we had the VA as well.
@@ -129,39 +165,39 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 	if (!has_vhe() && icache_is_vpipt())
 		__flush_icache_all();
 
-	__tlb_switch_to_host()(kvm, flags);
+	__tlb_switch_to_host()(kvm, &cxt);
 }
 
 void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
 {
-	unsigned long flags;
+	struct tlb_inv_context cxt;
 
 	dsb(ishst);
 
 	/* Switch to requested VMID */
 	kvm = kern_hyp_va(kvm);
-	__tlb_switch_to_guest()(kvm, &flags);
+	__tlb_switch_to_guest()(kvm, &cxt);
 
 	__tlbi(vmalls12e1is);
 	dsb(ish);
 	isb();
 
-	__tlb_switch_to_host()(kvm, flags);
+	__tlb_switch_to_host()(kvm, &cxt);
 }
 
 void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
-	unsigned long flags;
+	struct tlb_inv_context cxt;
 
 	/* Switch to requested VMID */
-	__tlb_switch_to_guest()(kvm, &flags);
+	__tlb_switch_to_guest()(kvm, &cxt);
 
 	__tlbi(vmalle1);
 	dsb(nsh);
 	isb();
 
-	__tlb_switch_to_host()(kvm, flags);
+	__tlb_switch_to_host()(kvm, &cxt);
 }
 
 void __hyp_text __kvm_flush_vm_context(void)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
