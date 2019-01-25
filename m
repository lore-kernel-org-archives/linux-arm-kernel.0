Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B77C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:47:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9ABC2082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hfy6v1jZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ABC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BpBHv8omnFEMDG9J+3M6nHZ0SAA2QdcXciuWxQTMAYc=; b=Hfy6v1jZibc0xXM9Vb/aJ2FZR1
	15t5u/MlHvNKddwDNCpBVx/gE8vn/fjE8tgKZ82LEiffvzelEqgpkMlKBjuSraZWWoTotTX0+TlaQ
	78nNMjvm42fofRNfHi3cGj+h+jzbgv3JwSyEk/fVrYpKOcMvwOiptEQGOKgUBKw+dOSmjvzK7OGtj
	/weX0LVo19Yo3QhksjEM9vHpmZktpJ7HSWWxlkUgiTQaBEpZLflzmPaGvvjr7RlCk3TO7J4CJfeyv
	lHlzm0I5VebK3C5FlIGLKpX3wW7eAk/w3w+qfpPlnlu5qny3sptj5ZRmBSJvBm/wCw51VX3iaVgC1
	QD8oYZzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmy5O-0003tP-7K; Fri, 25 Jan 2019 09:47:42 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmy4n-0003A2-Q0
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:47:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64F391596;
 Fri, 25 Jan 2019 01:47:05 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F10273F589;
 Fri, 25 Jan 2019 01:47:04 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] arm/arm64: KVM: Allow a VCPU to fully reset itself
Date: Fri, 25 Jan 2019 10:46:53 +0100
Message-Id: <20190125094656.5026-3-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125094656.5026-1-christoffer.dall@arm.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_014706_113815_D413FD2E 
X-CRM114-Status: GOOD (  21.11  )
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
 Christoffer Dall <christoffer.dall@arm.com>, kvm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The current kvm_psci_vcpu_on implementation will directly try to
manipulate the state of the VCPU to reset it.  However, since this is
not done on the thread that runs the VCPU, we can end up in a strangely
corrupted state when the source and target VCPUs are running at the same
time.

Fix this by factoring out all reset logic from the PSCI implementation
and forwarding the required information along with a request to the
target VCPU.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 10 +++++++++
 arch/arm/kvm/reset.c              | 24 +++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h | 11 ++++++++++
 arch/arm64/kvm/reset.c            | 24 +++++++++++++++++++++
 virt/kvm/arm/arm.c                | 10 +++++++++
 virt/kvm/arm/psci.c               | 36 ++++++++++++++-----------------
 6 files changed, 95 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ca56537b61bc..50e89869178a 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -48,6 +48,7 @@
 #define KVM_REQ_SLEEP \
 	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
+#define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
@@ -147,6 +148,13 @@ struct kvm_cpu_context {
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
 
+struct vcpu_reset_state {
+	unsigned long	pc;
+	unsigned long	r0;
+	bool		be;
+	bool		reset;
+};
+
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
 
@@ -186,6 +194,8 @@ struct kvm_vcpu_arch {
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
 
+	struct vcpu_reset_state reset_state;
+
 	/* Detect first run of a vcpu */
 	bool has_run_once;
 };
diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index 5ed0c3ee33d6..de41255eebcd 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -26,6 +26,7 @@
 #include <asm/cputype.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_emulate.h>
 
 #include <kvm/arm_arch_timer.h>
 
@@ -69,6 +70,29 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset CP15 registers */
 	kvm_reset_coprocs(vcpu);
 
+	/*
+	 * Additional reset state handling that PSCI may have imposed on us.
+	 * Must be done after all the sys_reg reset.
+	 */
+	if (vcpu->arch.reset_state.reset) {
+		unsigned long target_pc = vcpu->arch.reset_state.pc;
+
+		/* Gracefully handle Thumb2 entry point */
+		if (target_pc & 1) {
+			target_pc &= ~1UL;
+			vcpu_set_thumb(vcpu);
+		}
+
+		/* Propagate caller endianness */
+		if (vcpu->arch.reset_state.be)
+			kvm_vcpu_set_be(vcpu);
+
+		*vcpu_pc(vcpu) = target_pc;
+		vcpu_set_reg(vcpu, 0, vcpu->arch.reset_state.r0);
+
+		vcpu->arch.reset_state.reset = false;
+	}
+
 	/* Reset arch_timer context */
 	return kvm_timer_vcpu_reset(vcpu);
 }
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7732d0ba4e60..da3fc7324d68 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -48,6 +48,7 @@
 #define KVM_REQ_SLEEP \
 	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
+#define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
@@ -208,6 +209,13 @@ struct kvm_cpu_context {
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
 
+struct vcpu_reset_state {
+	unsigned long	pc;
+	unsigned long	r0;
+	bool		be;
+	bool		reset;
+};
+
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
 
@@ -297,6 +305,9 @@ struct kvm_vcpu_arch {
 	/* Virtual SError ESR to restore when HCR_EL2.VSE is set */
 	u64 vsesr_el2;
 
+	/* Additional reset state */
+	struct vcpu_reset_state	reset_state;
+
 	/* True when deferrable sysregs are loaded on the physical CPU,
 	 * see kvm_vcpu_load_sysregs and kvm_vcpu_put_sysregs. */
 	bool sysregs_loaded_on_cpu;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index f21a2a575939..f16a5f8ff2b4 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -32,6 +32,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 
 /* Maximum phys_shift supported for any VM on this host */
@@ -146,6 +147,29 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);
 
+	/*
+	 * Additional reset state handling that PSCI may have imposed on us.
+	 * Must be done after all the sys_reg reset.
+	 */
+	if (vcpu->arch.reset_state.reset) {
+		unsigned long target_pc = vcpu->arch.reset_state.pc;
+
+		/* Gracefully handle Thumb2 entry point */
+		if (vcpu_mode_is_32bit(vcpu) && (target_pc & 1)) {
+			target_pc &= ~1UL;
+			vcpu_set_thumb(vcpu);
+		}
+
+		/* Propagate caller endianness */
+		if (vcpu->arch.reset_state.be)
+			kvm_vcpu_set_be(vcpu);
+
+		*vcpu_pc(vcpu) = target_pc;
+		vcpu_set_reg(vcpu, 0, vcpu->arch.reset_state.r0);
+
+		vcpu->arch.reset_state.reset = false;
+	}
+
 	/* Reset PMU */
 	kvm_pmu_vcpu_reset(vcpu);
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 9e350fd34504..9c486fad3f9f 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -626,6 +626,13 @@ static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
 		/* Awaken to handle a signal, request we sleep again later. */
 		kvm_make_request(KVM_REQ_SLEEP, vcpu);
 	}
+
+	/*
+	 * Make sure we will observe a potential reset request if we've
+	 * observed a change to the power state. Pairs with the smp_wmb() in
+	 * kvm_psci_vcpu_on().
+	 */
+	smp_rmb();
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
@@ -639,6 +646,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
 			vcpu_req_sleep(vcpu);
 
+		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
+			kvm_reset_vcpu(vcpu);
+
 		/*
 		 * Clear IRQ_PENDING requests that were made to guarantee
 		 * that a VCPU sees new virtual interrupts.
diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index 9b73d3ad918a..b9cff1d4b06d 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -104,12 +104,10 @@ static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
 
 static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 {
+	struct vcpu_reset_state *reset_state;
 	struct kvm *kvm = source_vcpu->kvm;
 	struct kvm_vcpu *vcpu = NULL;
-	struct swait_queue_head *wq;
 	unsigned long cpu_id;
-	unsigned long context_id;
-	phys_addr_t target_pc;
 
 	cpu_id = smccc_get_arg1(source_vcpu) & MPIDR_HWID_BITMASK;
 	if (vcpu_mode_is_32bit(source_vcpu))
@@ -130,32 +128,30 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 			return PSCI_RET_INVALID_PARAMS;
 	}
 
-	target_pc = smccc_get_arg2(source_vcpu);
-	context_id = smccc_get_arg3(source_vcpu);
+	reset_state = &vcpu->arch.reset_state;
 
-	kvm_reset_vcpu(vcpu);
-
-	/* Gracefully handle Thumb2 entry point */
-	if (vcpu_mode_is_32bit(vcpu) && (target_pc & 1)) {
-		target_pc &= ~((phys_addr_t) 1);
-		vcpu_set_thumb(vcpu);
-	}
+	reset_state->pc = smccc_get_arg2(source_vcpu);
 
 	/* Propagate caller endianness */
-	if (kvm_vcpu_is_be(source_vcpu))
-		kvm_vcpu_set_be(vcpu);
+	reset_state->be = kvm_vcpu_is_be(source_vcpu);
 
-	*vcpu_pc(vcpu) = target_pc;
 	/*
 	 * NOTE: We always update r0 (or x0) because for PSCI v0.1
 	 * the general puspose registers are undefined upon CPU_ON.
 	 */
-	smccc_set_retval(vcpu, context_id, 0, 0, 0);
-	vcpu->arch.power_off = false;
-	smp_mb();		/* Make sure the above is visible */
+	reset_state->r0 = smccc_get_arg3(source_vcpu);
+
+	reset_state->reset = true;
+	kvm_make_request(KVM_REQ_VCPU_RESET, vcpu);
 
-	wq = kvm_arch_vcpu_wq(vcpu);
-	swake_up_one(wq);
+	/*
+	 * Make sure the reset request is observed if the change to
+	 * power_state is observed.
+	 */
+	smp_wmb();
+
+	vcpu->arch.power_off = false;
+	kvm_vcpu_wake_up(vcpu);
 
 	return PSCI_RET_SUCCESS;
 }
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
