Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68526C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:58:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6542133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dkL3ckwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6542133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=U897+w11u1ovvOVduwY9mw9Q2qSJcbkY0uV0rwHSfR0=; b=dkL3ckwl0/+mkZLgLpNDRKp8ut
	mhjoPZHEQIEjq6jFNmVBIbhdAP8O1/itjSvI1iXvhgxmHnZmE+Ma4vhUGeAqDtpxRFRcAtbB7P08y
	7zCLgnA33x2FWbnzy1EBLL9CKcAUHK52j2NgSBRYa6uKBv2ZEE5511gpUr9ru4qif8O/dwGgrXvP3
	BtsHLZaV2U8lvMjJZzCAHvjoeS3mOQpUleEvZW3NYkbbK391q8IgaCPKhsMbx3BmMBndDMGHCcYVh
	SDrSeTabOBBCrxgQTIXzJp6LYA+U+f0S4SqbyrEGbuXjwDXyBFJlOBYGicWwgf/MrHq34xUnL7oo6
	sGfvgghw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAGR-00023y-BC; Tue, 18 Dec 2018 07:58:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAFp-0001Qp-FO
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 07:57:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C2F115AB;
 Mon, 17 Dec 2018 23:57:17 -0800 (PST)
Received: from a75553-lin.blr.arm.com (a75553-lin.blr.arm.com [10.162.0.175])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 C80FA3F575; Mon, 17 Dec 2018 23:57:13 -0800 (PST)
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/6] arm64/kvm: preserve host HCR_EL2 value
Date: Tue, 18 Dec 2018 13:26:45 +0530
Message-Id: <1545119810-12182-2-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_235725_759601_09253458 
X-CRM114-Status: GOOD (  19.31  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When restoring HCR_EL2 for the host, KVM uses HCR_HOST_VHE_FLAGS, which
is a constant value. This works today, as the host HCR_EL2 value is
always the same, but this will get in the way of supporting extensions
that require HCR_EL2 bits to be set conditionally for the host.

To allow such features to work without KVM having to explicitly handle
every possible host feature combination, this patch has KVM save/restore
the host HCR when switching to/from a guest HCR. The saving of the
register is done once during cpu hypervisor initialization state and is
just restored after switch from guest.

For fetching HCR_EL2 during kvm initilisation, a hyp call is made using
kvm_call_hyp and is helpful in NHVE case.

For the hyp TLB maintenance code, __tlb_switch_to_host_vhe() is updated
to toggle the TGE bit with a RMW sequence, as we already do in
__tlb_switch_to_guest_vhe().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
 arch/arm/include/asm/kvm_host.h   |  2 ++
 arch/arm64/include/asm/kvm_asm.h  |  2 ++
 arch/arm64/include/asm/kvm_host.h | 14 ++++++++++++--
 arch/arm64/kvm/hyp/switch.c       | 15 +++++++++------
 arch/arm64/kvm/hyp/sysreg-sr.c    | 11 +++++++++++
 arch/arm64/kvm/hyp/tlb.c          |  6 +++++-
 virt/kvm/arm/arm.c                |  2 ++
 7 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 5ca5d9a..0f012c8 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -273,6 +273,8 @@ static inline void __cpu_init_stage2(void)
 	kvm_call_hyp(__init_stage2_translation);
 }
 
+static inline void __cpu_copy_host_registers(void) {}
+
 static inline int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	return 0;
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index aea01a0..25ac9fa 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -73,6 +73,8 @@ extern void __vgic_v3_init_lrs(void);
 
 extern u32 __kvm_get_mdcr_el2(void);
 
+extern u64 __read_hyp_hcr_el2(void);
+
 /* Home-grown __this_cpu_{ptr,read} variants that always work at HYP */
 #define __hyp_this_cpu_ptr(sym)						\
 	({								\
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 52fbc82..1b9eed9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -196,13 +196,17 @@ enum vcpu_sysreg {
 
 #define NR_COPRO_REGS	(NR_SYS_REGS * 2)
 
+struct kvm_cpu_init_host_regs {
+	u64 hcr_el2;
+};
+
 struct kvm_cpu_context {
 	struct kvm_regs	gp_regs;
 	union {
 		u64 sys_regs[NR_SYS_REGS];
 		u32 copro[NR_COPRO_REGS];
 	};
-
+	struct kvm_cpu_init_host_regs init_regs;
 	struct kvm_vcpu *__hyp_running_vcpu;
 };
 
@@ -211,7 +215,7 @@ typedef struct kvm_cpu_context kvm_cpu_context_t;
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
 
-	/* HYP configuration */
+	/* Guest HYP configuration */
 	u64 hcr_el2;
 	u32 mdcr_el2;
 
@@ -455,6 +459,12 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 
 static inline void __cpu_init_stage2(void) {}
 
+static inline void __cpu_copy_host_registers(void)
+{
+	kvm_cpu_context_t *host_cxt = this_cpu_ptr(&kvm_host_cpu_state);
+	host_cxt->init_regs.hcr_el2 = kvm_call_hyp(__read_hyp_hcr_el2);
+}
+
 /* Guest/host FPSIMD coordination helpers */
 int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index f6e02cc..85a2a5c 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -139,15 +139,15 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 		__activate_traps_nvhe(vcpu);
 }
 
-static void deactivate_traps_vhe(void)
+static void deactivate_traps_vhe(struct kvm_cpu_context *host_ctxt)
 {
 	extern char vectors[];	/* kernel exception vectors */
-	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
+	write_sysreg(host_ctxt->init_regs.hcr_el2, hcr_el2);
 	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
 	write_sysreg(vectors, vbar_el1);
 }
 
-static void __hyp_text __deactivate_traps_nvhe(void)
+static void __hyp_text __deactivate_traps_nvhe(struct kvm_cpu_context *host_ctxt)
 {
 	u64 mdcr_el2 = read_sysreg(mdcr_el2);
 
@@ -157,12 +157,15 @@ static void __hyp_text __deactivate_traps_nvhe(void)
 	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
 
 	write_sysreg(mdcr_el2, mdcr_el2);
-	write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
+	write_sysreg(host_ctxt->init_regs.hcr_el2, hcr_el2);
 	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
 }
 
 static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
 {
+	struct kvm_cpu_context *host_ctxt;
+
+	host_ctxt = vcpu->arch.host_cpu_context;
 	/*
 	 * If we pended a virtual abort, preserve it until it gets
 	 * cleared. See D1.14.3 (Virtual Interrupts) for details, but
@@ -173,9 +176,9 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
 		vcpu->arch.hcr_el2 = read_sysreg(hcr_el2);
 
 	if (has_vhe())
-		deactivate_traps_vhe();
+		deactivate_traps_vhe(host_ctxt);
 	else
-		__deactivate_traps_nvhe();
+		__deactivate_traps_nvhe(host_ctxt);
 }
 
 void activate_traps_vhe_load(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 68d6f7c..29ef34d 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -316,3 +316,14 @@ void __hyp_text __kvm_enable_ssbs(void)
 	"msr	sctlr_el2, %0"
 	: "=&r" (tmp) : "L" (SCTLR_ELx_DSSBS));
 }
+
+/**
+ * __read_hyp_hcr_el2 - Returns hcr_el2 register value
+ *
+ * This function acts as a function handler parameter for kvm_call_hyp and
+ * may be called from EL1 exception level to fetch the register value.
+ */
+u64 __hyp_text __read_hyp_hcr_el2(void)
+{
+	return read_sysreg(hcr_el2);
+}
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index 4dbd9c6..ad6282d 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -50,12 +50,16 @@ static hyp_alternate_select(__tlb_switch_to_guest,
 
 static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm)
 {
+	u64 val;
+
 	/*
 	 * We're done with the TLB operation, let's restore the host's
 	 * view of HCR_EL2.
 	 */
 	write_sysreg(0, vttbr_el2);
-	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
+	val = read_sysreg(hcr_el2);
+	val |= HCR_TGE;
+	write_sysreg(val, hcr_el2);
 }
 
 static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm)
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 2377497..feda456 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1318,6 +1318,8 @@ static void cpu_hyp_reinit(void)
 
 	if (vgic_present)
 		kvm_vgic_init_cpu_hardware();
+
+	__cpu_copy_host_registers();
 }
 
 static void _kvm_arch_hardware_enable(void *discard)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
