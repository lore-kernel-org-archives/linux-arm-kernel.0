Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740C5C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:48:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E8120811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ccra9Lbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E8120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=/AyJ94FJrdfOxv6rBOdGnNPWDycC1qiwJ2r4G075sNk=; b=Ccr
	a9Lbe7mhYAyfKTFmBdzXfB+gjncybNI6yHkyBj8+RAQ95Ha9P0NhHq8W5jdaQyvC5q1caivFsC73I
	CtazIuk4T/ApKreu/7LxTlLnImb8TkLFihg8MQ9X2hfktQcOeVKYSVNeBg5UjpbOSLB3eMN/WaIKV
	bKsPzC2ojZg8yMLDfUfc2CTvZSF6AoYmjOigjVAXWmdLGd0X/qXZa6ZJRHYhU0Lid6FpWFxoD0MRs
	Adr1qNh/dU4oh6PGQNOoJkL3cbGUCzXvNa9K/VvHwNZfbj3T1yh6qMi4XG+mDWw9wuwTMMvB9NASQ
	1NXluudmrYqeTB+WPKGxO+XIuAucBOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWn5D-0007G8-E1; Tue, 11 Dec 2018 18:48:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWn5A-0007Ea-Er
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 18:48:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A384EBD;
 Tue, 11 Dec 2018 10:48:23 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C83C3F6A8;
 Tue, 11 Dec 2018 10:48:22 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH REPOST] KVM: arm64: Treat FPEXC32_EL2 as a regular guest
 system register
Date: Tue, 11 Dec 2018 18:48:16 +0000
Message-Id: <1544554096-23451-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_104836_506030_DC44D6EE 
X-CRM114-Status: GOOD (  19.47  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently FPEXC32_EL2 is handled specially when context-switching.

However, FPEXC has no architectural effect when running in AArch64.
The only case where an arm64 host may execute in AArch32 is when
running compat user code at EL0: the architecture explicitly
documents FPEXC as having no effect in this case either when the
kernel (EL2 in the VHE case; otherwise EL1) is AArch64.

So, we can just handle FPEXC32_EL2 (which is the AArch64 alias for
this register) as a regular AArch32-only system register and switch
it without any special handling or synchronisation.

This allows some gnarly special-case code to be eliminated from
hyp.  The extra isb() in __activate_traps_fpsimd32() is dropped
too: for the reasons explained above arm64 never required this
anyway.

Note that the comment in the deleted __activate_traps_fpsimd32()
function about the need to inhibit traps to EL1 is only meaningful
if the guest's value for FPEXC is not restored (thus potentially
causing an unexpected trap to EL1 in the guest unless we're careful
to set the EN bit).  This arises from the treatment of FPEXC32_EL2
as if it were part of the the FPSIMD state to be switched lazily,
whereas it is really more natural to consider it as part of the EL1
system register state to be switched eagerly at the appropriate
times.

In fact, we explicitly don't care about seeing any trap until the
guest accesses the FPSIMD registers for real, provided that the
guest sees the behaviour it expects.  So ensuring that the guest's
view of FPEXC is alawys up to date (as implemented by this patch)
should be sufficient.  Since we always had to write FPEXC32_EL2
anyway (in order to work around the possibility of not restoring it
properly for the guest) this should not add significant cost.  In
any case, this patch moves any cost off the hyp switch critical
path, to vcpu_load/put().

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Alexander Graf <agraf@suse.de>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

**Build-tested only**

This is a repost of an otherwise unmodified patch discussed previously
[1].  It turned out that I had confused myself: I planned to move the
FPEXC32_EL2 save/restore to the vcpu_load/put() path, but this was
precisely what the patch already implemented.

Changes since RFC:

 * Removed inaccurate comment concerning the historical reason for the
   current FPEXC32_EL2 handling behaviour from the commit message.

 * Added the paragraphs about the implications of making the FPEXC
   restore non-lazy, to the commit message.


[1] [RFC PATCH] KVM: arm64: Treat FPEXC32_EL2 as a regular guest system register
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-September/599985.html

---
 arch/arm64/kvm/hyp/switch.c    | 45 ++----------------------------------------
 arch/arm64/kvm/hyp/sysreg-sr.c |  2 ++
 2 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 7cc175c..583fcd7 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -43,32 +43,6 @@ static bool __hyp_text update_fp_enabled(struct kvm_vcpu *vcpu)
 	return !!(vcpu->arch.flags & KVM_ARM64_FP_ENABLED);
 }
 
-/* Save the 32-bit only FPSIMD system register state */
-static void __hyp_text __fpsimd_save_fpexc32(struct kvm_vcpu *vcpu)
-{
-	if (!vcpu_el1_is_32bit(vcpu))
-		return;
-
-	vcpu->arch.ctxt.sys_regs[FPEXC32_EL2] = read_sysreg(fpexc32_el2);
-}
-
-static void __hyp_text __activate_traps_fpsimd32(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * We are about to set CPTR_EL2.TFP to trap all floating point
-	 * register accesses to EL2, however, the ARM ARM clearly states that
-	 * traps are only taken to EL2 if the operation would not otherwise
-	 * trap to EL1.  Therefore, always make sure that for 32-bit guests,
-	 * we set FPEXC.EN to prevent traps to EL1, when setting the TFP bit.
-	 * If FP/ASIMD is not implemented, FPEXC is UNDEFINED and any access to
-	 * it will cause an exception.
-	 */
-	if (vcpu_el1_is_32bit(vcpu) && system_supports_fpsimd()) {
-		write_sysreg(1 << 30, fpexc32_el2);
-		isb();
-	}
-}
-
 static void __hyp_text __activate_traps_common(struct kvm_vcpu *vcpu)
 {
 	/* Trap on AArch32 cp15 c15 (impdef sysregs) accesses (EL1 or EL0) */
@@ -98,10 +72,8 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
 	val = read_sysreg(cpacr_el1);
 	val |= CPACR_EL1_TTA;
 	val &= ~CPACR_EL1_ZEN;
-	if (!update_fp_enabled(vcpu)) {
+	if (!update_fp_enabled(vcpu))
 		val &= ~CPACR_EL1_FPEN;
-		__activate_traps_fpsimd32(vcpu);
-	}
 
 	write_sysreg(val, cpacr_el1);
 
@@ -116,10 +88,8 @@ static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
 
 	val = CPTR_EL2_DEFAULT;
 	val |= CPTR_EL2_TTA | CPTR_EL2_TZ;
-	if (!update_fp_enabled(vcpu)) {
+	if (!update_fp_enabled(vcpu))
 		val |= CPTR_EL2_TFP;
-		__activate_traps_fpsimd32(vcpu);
-	}
 
 	write_sysreg(val, cptr_el2);
 }
@@ -366,11 +336,6 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
 
 	__fpsimd_restore_state(&vcpu->arch.ctxt.gp_regs.fp_regs);
 
-	/* Skip restoring fpexc32 for AArch64 guests */
-	if (!(read_sysreg(hcr_el2) & HCR_RW))
-		write_sysreg(vcpu->arch.ctxt.sys_regs[FPEXC32_EL2],
-			     fpexc32_el2);
-
 	vcpu->arch.flags |= KVM_ARM64_FP_ENABLED;
 
 	return true;
@@ -522,9 +487,6 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_restore_host_state_vhe(host_ctxt);
 
-	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED)
-		__fpsimd_save_fpexc32(vcpu);
-
 	__debug_switch_to_host(vcpu);
 
 	return exit_code;
@@ -580,9 +542,6 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
 
 	__sysreg_restore_state_nvhe(host_ctxt);
 
-	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED)
-		__fpsimd_save_fpexc32(vcpu);
-
 	/*
 	 * This must come after restoring the host sysregs, since a non-VHE
 	 * system may enable SPE here and make use of the TTBRs.
diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 68d6f7c..9eaac8c 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -212,6 +212,7 @@ void __hyp_text __sysreg32_save_state(struct kvm_vcpu *vcpu)
 
 	sysreg[DACR32_EL2] = read_sysreg(dacr32_el2);
 	sysreg[IFSR32_EL2] = read_sysreg(ifsr32_el2);
+	sysreg[FPEXC32_EL2] = read_sysreg(fpexc32_el2);
 
 	if (has_vhe() || vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY)
 		sysreg[DBGVCR32_EL2] = read_sysreg(dbgvcr32_el2);
@@ -234,6 +235,7 @@ void __hyp_text __sysreg32_restore_state(struct kvm_vcpu *vcpu)
 
 	write_sysreg(sysreg[DACR32_EL2], dacr32_el2);
 	write_sysreg(sysreg[IFSR32_EL2], ifsr32_el2);
+	write_sysreg(sysreg[FPEXC32_EL2], fpexc32_el2);
 
 	if (has_vhe() || vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY)
 		write_sysreg(sysreg[DBGVCR32_EL2], dbgvcr32_el2);
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
