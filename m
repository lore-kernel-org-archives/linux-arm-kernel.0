Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BEDC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:34:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A7C20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TU8TR3Ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A7C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=WRNUYhzkkn3WC5AUbgXQXorWcbmJPYpQTAjH917f+fk=; b=TU8TR3Ly/6DD9bDaQkI0W/4uzM
	xAezIeMQopaYBwsN6MRtaWsvZyI1p3TdIkcWMPTe5J3pZ5VAziaUIHylNBByL3T2qNrXvpvIDxqNZ
	qFbCHk+FNKy2YJEedf/XuVRkw8N7rRUtvlSMswJd7zuDkfHZtHd6D+2a6Upbw3uN42Zp0k1SS/SyQ
	d0VI9t84EjnFOpa9IWEgwzxTCiergwSrXHY+sESLw405uZYKOwjPAlBtE81xY/ZFHRppcMKwM1P/i
	Y3VLu9q7Zv3mvRSGMU9OuP0AnTJa4Wp3/73OuhdW7OVQvro6bCcxWhFrqlzTNuGf/qi1kYd/N0X+P
	Oth755FA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrXr-0000FJ-CD; Tue, 11 Dec 2018 23:34:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrTt-0004yl-Fp
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D3DD16A3;
 Tue, 11 Dec 2018 15:30:15 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83CD63F614;
 Tue, 11 Dec 2018 15:30:13 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 13/24] KVM: arm64/sve: Context switch the SVE registers
Date: Tue, 11 Dec 2018 23:28:50 +0000
Message-Id: <1544570941-7377-14-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153026_594105_A9C0B051 
X-CRM114-Status: GOOD (  19.95  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to give each vcpu its own view of the SVE registers, this
patch adds context storage via a new sve_state pointer in struct
vcpu_arch.  An additional member sve_max_vl is also added for each
vcpu, to determine the maximum vector length visible to the guest
and thus the value to be configured in ZCR_EL2.LEN while the is
active.  This also determines the layout and size of the storage in
sve_state, which is read and written by the same backend functions
that are used for context-switching the SVE state for host tasks.

On SVE-enabled vcpus, SVE access traps are now handled by switching
in the vcpu's SVE context and disabling the trap before returning
to the guest.  On other vcpus, the trap is not handled and an exit
back to the host occurs, where the handle_sve() fallback path
reflects an undefined instruction exception back to the guest,
consistently with the behaviour of non-SVE-capable hardware (as was
done unconditionally prior to this patch).

No SVE handling is added on non-VHE-only paths, since VHE is an
architectural and Kconfig prerequisite of SVE.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since RFC v2:

 * Remove pointless return value from __hyp_switch_fpsimd().

   This function cannot fail, so it may as well return void.

 * Roll __hyp_trap_is_fpsimd() and __hyp_switch_fpsimd() together into
   a single __hyp_handle_fpsimd().  Splitting these served no real
   purpose.
---
 arch/arm64/include/asm/kvm_host.h |  6 ++++
 arch/arm64/kvm/fpsimd.c           |  5 +--
 arch/arm64/kvm/hyp/switch.c       | 71 ++++++++++++++++++++++++++++++---------
 3 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 35aabaf..f36cfc0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -212,6 +212,8 @@ typedef struct kvm_cpu_context kvm_cpu_context_t;
 
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
+	void *sve_state;
+	unsigned int sve_max_vl;
 
 	/* HYP configuration */
 	u64 hcr_el2;
@@ -304,6 +306,10 @@ struct kvm_vcpu_arch {
 	bool sysregs_loaded_on_cpu;
 };
 
+/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
+#define vcpu_sve_pffr(vcpu) ((void *)((char *)((vcpu)->arch.sve_state) + \
+				      sve_ffr_offset((vcpu)->arch.sve_max_vl)))
+
 /* vcpu_arch flags field values: */
 #define KVM_ARM64_DEBUG_DIRTY		(1 << 0)
 #define KVM_ARM64_FP_ENABLED		(1 << 1) /* guest FP regs loaded */
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 887c9d7..40f49e2 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -86,10 +86,11 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.gp_regs.fp_regs,
-					 NULL, sve_max_vl);
+					 vcpu->arch.sve_state,
+					 vcpu->arch.sve_max_vl);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
-		clear_thread_flag(TIF_SVE);
+		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
 	}
 }
 
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 815a34f..14abc8a 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -98,7 +98,10 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
 	val = read_sysreg(cpacr_el1);
 	val |= CPACR_EL1_TTA;
 	val &= ~CPACR_EL1_ZEN;
-	if (!update_fp_enabled(vcpu)) {
+	if (update_fp_enabled(vcpu)) {
+		if (vcpu_has_sve(vcpu))
+			val |= CPACR_EL1_ZEN;
+	} else {
 		val &= ~CPACR_EL1_FPEN;
 		__activate_traps_fpsimd32(vcpu);
 	}
@@ -332,26 +335,60 @@ static bool __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
 	}
 }
 
-static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
+/*
+ * if () with a gating check for SVE support to minimise branch
+ * mispredictions in non-SVE systems.
+ * (system_supports_sve() is resolved at build time or via a static key.)
+ */
+#define if_sve(cond) if (system_supports_sve() && (cond))
+
+/* Check for an FPSIMD/SVE trap and handle as appropriate */
+static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 {
-	struct user_fpsimd_state *host_fpsimd = vcpu->arch.host_fpsimd_state;
+	u8 trap_class;
+	bool guest_has_sve;
 
-	if (has_vhe())
-		write_sysreg(read_sysreg(cpacr_el1) | CPACR_EL1_FPEN,
-			     cpacr_el1);
-	else
+	if (!system_supports_fpsimd())
+		return false;
+
+	trap_class = kvm_vcpu_trap_get_class(vcpu);
+
+	if (trap_class == ESR_ELx_EC_FP_ASIMD)
+		goto handle;
+
+	guest_has_sve = vcpu_has_sve(vcpu);
+
+	if_sve (guest_has_sve && trap_class == ESR_ELx_EC_SVE)
+		goto handle;
+
+	return false;
+
+handle:
+	/* The trap is an FPSIMD/SVE trap: switch the context */
+
+	if (has_vhe()) {
+		u64 reg = read_sysreg(cpacr_el1) | CPACR_EL1_FPEN;
+
+		if_sve (guest_has_sve)
+			reg |= CPACR_EL1_ZEN;
+
+		write_sysreg(reg, cpacr_el1);
+	} else {
 		write_sysreg(read_sysreg(cptr_el2) & ~(u64)CPTR_EL2_TFP,
 			     cptr_el2);
+	}
 
 	isb();
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_HOST) {
+		struct user_fpsimd_state *host_fpsimd =
+			vcpu->arch.host_fpsimd_state;
+
 		/*
 		 * In the SVE case, VHE is assumed: it is enforced by
 		 * Kconfig and kvm_arch_init().
 		 */
-		if (system_supports_sve() &&
-		    (vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE)) {
+		if_sve (vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE) {
 			struct thread_struct *thread = container_of(
 				host_fpsimd,
 				struct thread_struct, uw.fpsimd_state);
@@ -364,10 +401,14 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
 		vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
 	}
 
-	__fpsimd_restore_state(&vcpu->arch.ctxt.gp_regs.fp_regs);
-
-	if (vcpu_has_sve(vcpu))
+	if_sve (guest_has_sve) {
+		sve_load_state(vcpu_sve_pffr(vcpu),
+			       &vcpu->arch.ctxt.gp_regs.fp_regs.fpsr,
+			       sve_vq_from_vl(vcpu->arch.sve_max_vl) - 1);
 		write_sysreg_s(vcpu->arch.ctxt.sys_regs[ZCR_EL1], SYS_ZCR_EL12);
+	} else {
+		__fpsimd_restore_state(&vcpu->arch.ctxt.gp_regs.fp_regs);
+	}
 
 	/* Skip restoring fpexc32 for AArch64 guests */
 	if (!(read_sysreg(hcr_el2) & HCR_RW))
@@ -403,10 +444,10 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 	 * and restore the guest context lazily.
 	 * If FP/SIMD is not implemented, handle the trap and inject an
 	 * undefined instruction exception to the guest.
+	 * Similarly for trapped SVE accesses.
 	 */
-	if (system_supports_fpsimd() &&
-	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_FP_ASIMD)
-		return __hyp_switch_fpsimd(vcpu);
+	if (__hyp_handle_fpsimd(vcpu))
+		return true;
 
 	if (!__populate_fault_info(vcpu))
 		return true;
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
