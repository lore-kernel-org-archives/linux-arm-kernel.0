Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22596C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:04:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3F820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EqfOdHtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3F820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CvV0QYpsKF4xca9maY4/wOlgFvryjJTHIbITzX4/Q+k=; b=EqfOdHtvDe5wv1+Y/Yy94ujnXB
	jWujoOCBYMin/B/I3UTNqw+wds+kWOZpXwIRNsPlJ0Pn5UGi9s7DhcWig/wAU9czDqZ13zv933fXH
	XdDwouAhiAZfoz8/HLj685/JZlnEKZRlqq5UV4ju+v0W8IaGjgulSyMMr7jbOacHGs3kQ6OPZqbk9
	+Uu3fEuH+scecsk8WDlLq2n1Iha0vUpHB5YzkY+eak8IzqkWuxGREKIFL6NHv+Oz0Y7C9gXdmM1rg
	3og9wb/CojkvwCzk0n4wz9UfASkMqzakq4D4NpaI01C7Yb9JMvRgi3BxTiBhzNq/eHv21jJ88Yu46
	+f76vFdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEPw-0003nX-Uh; Thu, 17 Jan 2019 20:37:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENP-0000L4-6c
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEED2EBD;
 Thu, 17 Jan 2019 12:34:58 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F21513F819;
 Thu, 17 Jan 2019 12:34:56 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 14/25] KVM: arm64/sve: Context switch the SVE registers
Date: Thu, 17 Jan 2019 20:33:28 +0000
Message-Id: <1547757219-19439-15-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_123459_883522_C2A7D84A 
X-CRM114-Status: GOOD (  20.82  )
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
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
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

Changes since RFC v3:

 * Ensure guest_has_sve is initialised before use.  Previously the
   order of the code allowed this to be used before initilaisation
   on some paths.  Mysteriously the compiler failed to warn.
---
 arch/arm64/include/asm/kvm_host.h |  6 ++++
 arch/arm64/kvm/fpsimd.c           |  5 +--
 arch/arm64/kvm/hyp/switch.c       | 70 ++++++++++++++++++++++++++++++---------
 3 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index c32f195..77b6f3e 100644
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
index 5ff2d90..9cc57d4 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -87,10 +87,11 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.gp_regs.fp_regs,
-					 NULL, SVE_VL_MIN);
+					 vcpu->arch.sve_state,
+					 vcpu->arch.sve_max_vl);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
-		clear_thread_flag(TIF_SVE);
+		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
 	}
 }
 
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 9f07403..f7a8e3b 100644
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
@@ -313,26 +316,59 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
 	return true;
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
+	guest_has_sve = vcpu_has_sve(vcpu);
+	trap_class = kvm_vcpu_trap_get_class(vcpu);
+
+	if (trap_class == ESR_ELx_EC_FP_ASIMD)
+		goto handle;
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
@@ -345,10 +381,14 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
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
@@ -384,10 +424,10 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
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
