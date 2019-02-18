Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E18C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:55:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138E4204EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iCa+1W0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138E4204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5vRaw9Phv73GhPiYjvUdl2V7jMj7HlfIuLZNy7Z7P4s=; b=iCa+1W0Ujz8LMGt8AaV6mTHr/L
	ioVLabh3YhASNf69CJUoLICFpXEw0dYg+1EcishfXWMSiH04NtK3qg1MdgUp/yD3mKywbH/5HJ/R6
	hoIU2P963Dcr45/sHELhqAcyqRx3xd3gkyhcAFkNpAAHwXsb7KGBm16+R+LuFU6jAqnkjuavGpN1l
	ZgFqDHaDIGnjIxHtxFdRghknhAcym4f6upE0QxfvBG1RgQpplTO42zVNXM+jtyCGN+SiIZCytbtfE
	DrRpdLSgI04kjZQL1BiJS24g9PYbfbd8gvKhxdX/KxoJB96kJPaSTYRSMtUOsRJcOrIggSGbGqEC5
	SRYW5rcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp0g-0007Cl-Pu; Mon, 18 Feb 2019 19:55:26 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozV-0004c0-Lf
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:54:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B962D19BF;
 Mon, 18 Feb 2019 11:54:01 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C46BB3F77D;
 Mon, 18 Feb 2019 11:53:54 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 13/26] KVM: arm64/sve: System register context switch and
 access support
Date: Mon, 18 Feb 2019 19:52:26 +0000
Message-Id: <1550519559-15915-14-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_115414_195454_15E3C5C0 
X-CRM114-Status: GOOD (  22.61  )
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
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Julien Grall <julien.grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds the necessary support for context switching ZCR_EL1
for each vcpu.

ZCR_EL1 is trapped alongside the FPSIMD/SVE registers, so it makes
sense for it to be handled as part of the guest FPSIMD/SVE context
for context switch purposes instead of handling it as a general
system register.  This means that it can be switched in lazily at
the appropriate time.  No effort is made to track host context for
this register, since SVE requires VHE: thus the hosts's value for
this register lives permanently in ZCR_EL2 and does not alias the
guest's value at any time.

The Hyp switch and fpsimd context handling code is extended
appropriately.

Accessors are added in sys_regs.c to expose the SVE system
registers and ID register fields.  Because these need to be
conditionally visible based on the guest configuration, they are
implemented separately for now rather than by use of the generic
system register helpers.  This may be abstracted better later on
when/if there are more features requiring this model.

ID_AA64ZFR0_EL1 is RO-RAZ for MRS/MSR when SVE is disabled for the
guest, but for compatibility with non-SVE aware KVM implementations
the register should not be enumerated at all for KVM_GET_REG_LIST
in this case.  For consistency we also reject ioctl access to the
register.  This ensures that a non-SVE-enabled guest looks the same
to userspace, irrespective of whether the kernel KVM implementation
supports SVE.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since v4:

 * Remove annoying linebreak in assignment.

 * Remove #ifdef clutter and migrate to using the new sysreg
   restrictions() framework to control register visibility.
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/include/asm/sysreg.h   |  3 ++
 arch/arm64/kvm/fpsimd.c           |  9 +++-
 arch/arm64/kvm/hyp/switch.c       |  3 ++
 arch/arm64/kvm/sys_regs.c         | 97 +++++++++++++++++++++++++++++++++++++--
 5 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index af625a8..c32f195 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -112,6 +112,7 @@ enum vcpu_sysreg {
 	SCTLR_EL1,	/* System Control Register */
 	ACTLR_EL1,	/* Auxiliary Control Register */
 	CPACR_EL1,	/* Coprocessor Access Control */
+	ZCR_EL1,	/* SVE Control */
 	TTBR0_EL1,	/* Translation Table Base Register 0 */
 	TTBR1_EL1,	/* Translation Table Base Register 1 */
 	TCR_EL1,	/* Translation Control Register */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 72dc4c0..da38491 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -449,6 +449,9 @@
 #define SYS_ICH_LR14_EL2		__SYS__LR8_EL2(6)
 #define SYS_ICH_LR15_EL2		__SYS__LR8_EL2(7)
 
+/* VHE encodings for architectural EL0/1 system registers */
+#define SYS_ZCR_EL12			sys_reg(3, 5, 1, 2, 0)
+
 /* Common SCTLR_ELx flags. */
 #define SCTLR_ELx_DSSBS	(_BITUL(44))
 #define SCTLR_ELx_ENIA	(_BITUL(31))
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 1cf4f02..7053bf4 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -103,14 +103,21 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
+	bool host_has_sve = system_supports_sve();
+	bool guest_has_sve = vcpu_has_sve(vcpu);
 
 	local_irq_save(flags);
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
+		u64 *guest_zcr = &vcpu->arch.ctxt.sys_regs[ZCR_EL1];
+
 		/* Clean guest FP state to memory and invalidate cpu view */
 		fpsimd_save();
 		fpsimd_flush_cpu_state();
-	} else if (system_supports_sve()) {
+
+		if (guest_has_sve)
+			*guest_zcr = read_sysreg_s(SYS_ZCR_EL12);
+	} else if (host_has_sve) {
 		/*
 		 * The FPSIMD/SVE state in the CPU has not been touched, and we
 		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index b0b1478..9f07403 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -347,6 +347,9 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
 
 	__fpsimd_restore_state(&vcpu->arch.ctxt.gp_regs.fp_regs);
 
+	if (vcpu_has_sve(vcpu))
+		write_sysreg_s(vcpu->arch.ctxt.sys_regs[ZCR_EL1], SYS_ZCR_EL12);
+
 	/* Skip restoring fpexc32 for AArch64 guests */
 	if (!(read_sysreg(hcr_el2) & HCR_RW))
 		write_sysreg(vcpu->arch.ctxt.sys_regs[FPEXC32_EL2],
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3f1243e..28b1bad 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1036,10 +1036,7 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
 	u64 val = raz ? 0 : read_sanitised_ftr_reg(id);
 
-	if (id == SYS_ID_AA64PFR0_EL1) {
-		if (val & (0xfUL << ID_AA64PFR0_SVE_SHIFT))
-			kvm_debug("SVE unsupported for guests, suppressing\n");
-
+	if (id == SYS_ID_AA64PFR0_EL1 && !vcpu_has_sve(vcpu)) {
 		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
 	} else if (id == SYS_ID_AA64ISAR1_EL1) {
 		const u64 ptrauth_mask = (0xfUL << ID_AA64ISAR1_APA_SHIFT) |
@@ -1091,6 +1088,95 @@ static int reg_from_user(u64 *val, const void __user *uaddr, u64 id);
 static int reg_to_user(void __user *uaddr, const u64 *val, u64 id);
 static u64 sys_reg_to_index(const struct sys_reg_desc *reg);
 
+static unsigned int sve_restrictions(const struct kvm_vcpu *vcpu,
+				     const struct sys_reg_desc *rd)
+{
+	return vcpu_has_sve(vcpu) ? 0 : REG_NO_USER | REG_NO_GUEST;
+}
+
+static unsigned int sve_id_restrictions(const struct kvm_vcpu *vcpu,
+					const struct sys_reg_desc *rd)
+{
+	return vcpu_has_sve(vcpu) ? 0 : REG_NO_USER;
+}
+
+static int get_zcr_el1(struct kvm_vcpu *vcpu,
+		       const struct sys_reg_desc *rd,
+		       const struct kvm_one_reg *reg, void __user *uaddr)
+{
+	if (WARN_ON(!vcpu_has_sve(vcpu)))
+		return -ENOENT;
+
+	return reg_to_user(uaddr, &vcpu->arch.ctxt.sys_regs[ZCR_EL1],
+			   reg->id);
+}
+
+static int set_zcr_el1(struct kvm_vcpu *vcpu,
+		       const struct sys_reg_desc *rd,
+		       const struct kvm_one_reg *reg, void __user *uaddr)
+{
+	if (WARN_ON(!vcpu_has_sve(vcpu)))
+		return -ENOENT;
+
+	return reg_from_user(&vcpu->arch.ctxt.sys_regs[ZCR_EL1], uaddr,
+			     reg->id);
+}
+
+/* Generate the emulated ID_AA64ZFR0_EL1 value exposed to the guest */
+static u64 guest_id_aa64zfr0_el1(const struct kvm_vcpu *vcpu)
+{
+	if (!vcpu_has_sve(vcpu))
+		return 0;
+
+	return read_sanitised_ftr_reg(SYS_ID_AA64ZFR0_EL1);
+}
+
+static bool access_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
+				   struct sys_reg_params *p,
+				   const struct sys_reg_desc *rd)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, rd);
+
+	p->regval = guest_id_aa64zfr0_el1(vcpu);
+	return true;
+}
+
+static int get_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
+		const struct sys_reg_desc *rd,
+		const struct kvm_one_reg *reg, void __user *uaddr)
+{
+	u64 val;
+
+	if (!vcpu_has_sve(vcpu))
+		return -ENOENT;
+
+	val = guest_id_aa64zfr0_el1(vcpu);
+	return reg_to_user(uaddr, &val, reg->id);
+}
+
+static int set_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
+		const struct sys_reg_desc *rd,
+		const struct kvm_one_reg *reg, void __user *uaddr)
+{
+	const u64 id = sys_reg_to_index(rd);
+	int err;
+	u64 val;
+
+	if (!vcpu_has_sve(vcpu))
+		return -ENOENT;
+
+	err = reg_from_user(&val, uaddr, id);
+	if (err)
+		return err;
+
+	/* This is what we mean by invariant: you can't change it. */
+	if (val != guest_id_aa64zfr0_el1(vcpu))
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * cpufeature ID register user accessors
  *
@@ -1278,7 +1364,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_SANITISED(ID_AA64PFR1_EL1),
 	ID_UNALLOCATED(4,2),
 	ID_UNALLOCATED(4,3),
-	ID_UNALLOCATED(4,4),
+	{ SYS_DESC(SYS_ID_AA64ZFR0_EL1), access_id_aa64zfr0_el1, .get_user = get_id_aa64zfr0_el1, .set_user = set_id_aa64zfr0_el1, .restrictions = sve_id_restrictions },
 	ID_UNALLOCATED(4,5),
 	ID_UNALLOCATED(4,6),
 	ID_UNALLOCATED(4,7),
@@ -1315,6 +1401,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
 	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
+	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_unknown, ZCR_EL1, ~0xfUL, .get_user = get_zcr_el1, .set_user = set_zcr_el1, .restrictions = sve_restrictions },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
