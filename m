Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C69CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:21:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE94720873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dgGXdetn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE94720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=lBB/sTUSg64P56UBBsT6C9R3VID+gKt1c0JUBaCdf8Q=; b=dgGXdetn5ljnkC0Uxe2stj1PKD
	T2deh1uFFlsznEkS4Hqls0XAoGMjrudnL4SUMzYK8Dny4e5wPxmAkdMwE2d4/4Lgl0/Mew/P69/ld
	kj0U/p3lnTmHwC8vtxKpGWtdg4tj802iWzIaG+iJyBjN4VYJzclCNmZNdnDoMdUnbzN3WDkiqFcku
	ZWWnmeL2V3KK//A0gsu+cajjY3+e1vesXnoYtmVV2BUiPuvBEeYg8TMFTqakuikZyxWj7ewBj4GpC
	HbZPP8DEEwisqTM3LOokIhECEvvzJqytlIDbegVH7Asm8hs+it92SEmWfBobCnK7Bv7iFl6bGHffj
	Ot76h/9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj4yw-0003qX-UT; Mon, 14 Jan 2019 16:20:58 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4qF-0006fT-Im
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:12:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D45480D;
 Mon, 14 Jan 2019 08:11:59 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EC153F5BD;
 Mon, 14 Jan 2019 08:11:57 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v10 2/5] arm64: KVM: encapsulate kvm_cpu_context in
 kvm_host_data
Date: Mon, 14 Jan 2019 16:11:45 +0000
Message-Id: <1547482308-29839-3-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547482308-29839-1-git-send-email-andrew.murray@arm.com>
References: <1547482308-29839-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_081159_839160_9491D6E8 
X-CRM114-Status: GOOD (  15.01  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The virt/arm core allocates a kvm_cpu_context_t percpu, at present this is
a typedef to kvm_cpu_context and is used to store host cpu context. The
kvm_cpu_context structure is also used elsewhere to hold vcpu context.
In order to use the percpu to hold additional future host information we
encapsulate kvm_cpu_context in a new structure and rename the typedef and
percpu to match.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/include/asm/kvm_host.h   |  8 ++++++--
 arch/arm64/include/asm/kvm_asm.h  |  3 ++-
 arch/arm64/include/asm/kvm_host.h | 14 +++++++++-----
 arch/arm64/kernel/asm-offsets.c   |  1 +
 virt/kvm/arm/arm.c                | 12 +++++++-----
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ca56537..6420b40 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -145,7 +145,11 @@ struct kvm_cpu_context {
 	u32 cp15[NR_CP15_REGS];
 };
 
-typedef struct kvm_cpu_context kvm_cpu_context_t;
+struct kvm_host_data {
+	struct kvm_cpu_context host_ctxt;
+};
+
+typedef struct kvm_host_data kvm_host_data_t;
 
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
@@ -163,7 +167,7 @@ struct kvm_vcpu_arch {
 	struct kvm_vcpu_fault_info fault;
 
 	/* Host FP context */
-	kvm_cpu_context_t *host_cpu_context;
+	struct kvm_cpu_context *host_cpu_context;
 
 	/* VGIC state */
 	struct vgic_cpu vgic_cpu;
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index f5b79e9..ff73f54 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -108,7 +108,8 @@ extern u32 __kvm_get_mdcr_el2(void);
 .endm
 
 .macro get_host_ctxt reg, tmp
-	hyp_adr_this_cpu \reg, kvm_host_cpu_state, \tmp
+	hyp_adr_this_cpu \reg, kvm_host_data, \tmp
+	add	\reg, \reg, #HOST_DATA_CONTEXT
 .endm
 
 .macro get_vcpu_ptr vcpu, ctxt
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7732d0b..26fd935 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -206,7 +206,11 @@ struct kvm_cpu_context {
 	struct kvm_vcpu *__hyp_running_vcpu;
 };
 
-typedef struct kvm_cpu_context kvm_cpu_context_t;
+struct kvm_host_data {
+	struct kvm_cpu_context host_ctxt;
+};
+
+typedef struct kvm_host_data kvm_host_data_t;
 
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
@@ -242,7 +246,7 @@ struct kvm_vcpu_arch {
 	struct kvm_guest_debug_arch external_debug_state;
 
 	/* Pointer to host CPU context */
-	kvm_cpu_context_t *host_cpu_context;
+	struct kvm_cpu_context *host_cpu_context;
 
 	struct thread_info *host_thread_info;	/* hyp VA */
 	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
@@ -387,7 +391,7 @@ void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-DECLARE_PER_CPU(kvm_cpu_context_t, kvm_host_cpu_state);
+DECLARE_PER_CPU(kvm_host_data_t, kvm_host_data);
 
 void __kvm_enable_ssbs(void);
 
@@ -400,8 +404,8 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
 	 * so that we can use adr_l to access per-cpu variables in EL2.
 	 */
-	u64 tpidr_el2 = ((u64)this_cpu_ptr(&kvm_host_cpu_state) -
-			 (u64)kvm_ksym_ref(kvm_host_cpu_state));
+	u64 tpidr_el2 = ((u64)this_cpu_ptr(&kvm_host_data) -
+			 (u64)kvm_ksym_ref(kvm_host_data));
 
 	/*
 	 * Call initialization code, and switch to the full blown HYP code.
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 65b8afc..9b03554 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -146,6 +146,7 @@ int main(void)
   DEFINE(VCPU_FPEXC32_EL2,	offsetof(struct kvm_vcpu, arch.ctxt.sys_regs[FPEXC32_EL2]));
   DEFINE(VCPU_HOST_CONTEXT,	offsetof(struct kvm_vcpu, arch.host_cpu_context));
   DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context, __hyp_running_vcpu));
+  DEFINE(HOST_DATA_CONTEXT,	offsetof(struct kvm_host_data, host_ctxt));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_SUSPEND_SZ,	sizeof(struct cpu_suspend_ctx));
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 9e350fd3..89acb7f 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -56,7 +56,7 @@
 __asm__(".arch_extension	virt");
 #endif
 
-DEFINE_PER_CPU(kvm_cpu_context_t, kvm_host_cpu_state);
+DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 
 /* Per-CPU variable containing the currently running vcpu. */
@@ -363,8 +363,10 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	int *last_ran;
+	kvm_host_data_t *cpu_data;
 
 	last_ran = this_cpu_ptr(vcpu->kvm->arch.last_vcpu_ran);
+	cpu_data = this_cpu_ptr(&kvm_host_data);
 
 	/*
 	 * We might get preempted before the vCPU actually runs, but
@@ -376,7 +378,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	}
 
 	vcpu->cpu = cpu;
-	vcpu->arch.host_cpu_context = this_cpu_ptr(&kvm_host_cpu_state);
+	vcpu->arch.host_cpu_context = &cpu_data->host_ctxt;
 
 	kvm_arm_set_running_vcpu(vcpu);
 	kvm_vgic_load(vcpu);
@@ -1558,10 +1560,10 @@ static int init_hyp_mode(void)
 	}
 
 	for_each_possible_cpu(cpu) {
-		kvm_cpu_context_t *cpu_ctxt;
+		kvm_host_data_t *cpu_data;
 
-		cpu_ctxt = per_cpu_ptr(&kvm_host_cpu_state, cpu);
-		err = create_hyp_mappings(cpu_ctxt, cpu_ctxt + 1, PAGE_HYP);
+		cpu_data = per_cpu_ptr(&kvm_host_data, cpu);
+		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
 
 		if (err) {
 			kvm_err("Cannot map host CPU state: %d\n", err);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
