Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A386AC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:06:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5889120849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gW6pI6Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5889120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=49O/HK3bpweH4Apyv4xCfgl1+TnOWFc/bwJpEjOnhCU=; b=gW6pI6Naicv2q2
	EKjZX+d8IasyP4/jPqIHZDpS39qmKnc1vnWE4zQWXfmguEQ947k2KT9R151S/Ua/ajwvQuZk9o8pf
	ELD+IHwye4afehesH+W+l82Hptzbq4lsTNphPJtW7ABCiYUW8i/qxhxfQio/kA7AembzOW9SC4T9a
	mf4a8Lo5nHEu7tehNTHrf2vhCNNpzn6z1XqJ8CxtzFeNjATweS3OrKkDaqS+PcvNMDyv07EFDk0Uc
	LzrF8/rhORKMcrROQP3tT0k6XHmnekDDLWMXKMLH+gygd+UrouXOW9HpOpT4MAFCQf788n+x481/3
	GzaaCnX8+jdaj34uWicQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX65J-0002GC-M7; Wed, 12 Dec 2018 15:06:01 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62e-0006YB-Qq
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:03:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97721165C;
 Wed, 12 Dec 2018 07:03:16 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CD443F59C;
 Wed, 12 Dec 2018 07:03:14 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 10/12] KVM: arm64: Support Live Physical Time reporting
Date: Wed, 12 Dec 2018 15:02:24 +0000
Message-Id: <20181212150226.38051-11-steven.price@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212150226.38051-1-steven.price@arm.com>
References: <20181212150226.38051-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_070318_046102_ACE4BEFF 
X-CRM114-Status: GOOD (  20.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Provide a method for a guest to derive a paravirtualized counter/timer
which isn't dependent on the host's counter frequency. This allows a
guest to be migrated onto a new host which doesn't have the same
frequency without the virtual counter being disturbed.

The host provides a shared structure which contains coefficients that
can be used to map the real counter from the host (the Arm "virtual
counter") to a paravirtualized view of time. On migration the new host
updates the coefficients to ensure that the guests view of time (after
using the coefficients) doesn't change and that the derived counter
progresses at the same real frequency.

The guest can probe the existence of this support using the PV_FEATURES
SMCCC interface provided in a previous patch.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |   4 +
 include/kvm/arm_arch_timer.h      |   2 +
 virt/kvm/arm/arm.c                |   5 ++
 virt/kvm/arm/hypercalls.c         | 141 ++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bab7bc720992..a4efe6699dd3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -85,6 +85,10 @@ struct kvm_arch {
 	struct kvm_arch_pvtime {
 		void *st;
 		gpa_t st_base;
+
+		void *lpt;
+		gpa_t lpt_base;
+		u32 lpt_fpv;
 	} pvtime;
 };
 
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index 6502feb9524b..c8cdd96052e0 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -92,6 +92,8 @@ void kvm_timer_init_vhe(void);
 
 bool kvm_arch_timer_get_input_level(int vintid);
 
+int kvm_arm_update_lpt_sequence(struct kvm *kvm);
+
 #define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.vtimer)
 #define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.ptimer)
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index b347ba38cb11..e347da3ae123 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -150,7 +150,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.max_vcpus = vgic_present ?
 				kvm_vgic_get_max_vcpus() : KVM_MAX_VCPUS;
 
+	/* Set the PV Time addresses to invalid values */
 	kvm->arch.pvtime.st_base = GPA_INVALID;
+	kvm->arch.pvtime.lpt_base = GPA_INVALID;
+
 	return ret;
 out_free_stage2_pgd:
 	kvm_free_stage2_pgd(kvm);
@@ -591,6 +594,8 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 
 	ret = kvm_arm_pmu_v3_enable(vcpu);
 
+	kvm_arm_update_lpt_sequence(kvm);
+
 	return ret;
 }
 
diff --git a/virt/kvm/arm/hypercalls.c b/virt/kvm/arm/hypercalls.c
index 595d1cf3a871..69ce87278f36 100644
--- a/virt/kvm/arm/hypercalls.c
+++ b/virt/kvm/arm/hypercalls.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2018 Arm Ltd.
 
 #include <linux/arm-smccc.h>
+#include <linux/highmem.h>
 #include <linux/kvm_host.h>
 
 #include <asm/kvm_emulate.h>
@@ -74,6 +75,143 @@ static int kvm_hypercall_stolen_time(struct kvm_vcpu *vcpu)
 	smccc_set_retval(vcpu, ret, 0, 0, 0);
 	return 1;
 }
+#include <clocksource/arm_arch_timer.h>
+
+/*
+ * Returns ((u128)dividend << 64) / divisor
+ * Precondition: dividend < divisor
+ */
+static u64 shift64_div(u32 dividend, u32 divisor)
+{
+	u64 high = (u64)dividend << 32;
+	u64 low;
+	u64 rem;
+
+	WARN_ON(dividend >= divisor);
+
+	rem = do_div(high, divisor);
+	low = rem << 32;
+	do_div(low, divisor);
+
+	return (high << 32) | low;
+}
+
+/*
+ * Calculate the relative offset of each vCPU's timer and convert that to the
+ * new timer rate.
+ */
+static void update_vtimer_cval(struct kvm *kvm, u32 previous_rate)
+{
+	u32 current_rate = arch_timer_get_rate();
+	u64 current_time = kvm_phys_timer_read();
+	int i;
+	struct kvm_vcpu *vcpu;
+	u64 rel_cval;
+
+	/* Early out if there's nothing to do */
+	if (previous_rate == current_rate)
+		return;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
+		u64 cntvct;
+		u64 new_cntvct;
+
+		/*
+		 * The vtimer should not be already loaded as this function is
+		 * only called on the first run of the first VCPU before any
+		 * timers are loaded.
+		 */
+		if (WARN_ON(vtimer->loaded))
+			continue;
+
+		cntvct = current_time - vtimer->cntvoff;
+		new_cntvct = mul_u64_u32_div(cntvct, current_rate,
+					     previous_rate);
+		vtimer->cntvoff = current_time - new_cntvct;
+
+		rel_cval = vtimer->cnt_cval - cntvct;
+
+		rel_cval = mul_u64_u32_div(rel_cval, current_rate,
+					   previous_rate);
+
+		vtimer->cnt_cval = new_cntvct + rel_cval;
+	}
+}
+
+int kvm_arm_update_lpt_sequence(struct kvm *kvm)
+{
+	struct pvclock_vm_time_info *pvclock;
+	u64 lpt_ipa = kvm->arch.pvtime.lpt_base;
+	u64 native_freq, pv_freq, scale_mult, div_by_pv_freq_mult;
+	u64 shift = 0;
+	u64 sequence_number = 0;
+
+	if (lpt_ipa == GPA_INVALID)
+		return -EINVAL;
+
+	if (!IS_ALIGNED(lpt_ipa, 64))
+		return -EINVAL;
+
+	pvclock = kvm->arch.pvtime.lpt;
+
+	if (!pvclock)
+		return -EINVAL;
+
+	mutex_lock(&kvm->lock);
+
+	sequence_number = le64_to_cpu(pvclock->sequence_number);
+	native_freq = le64_to_cpu(pvclock->native_freq);
+
+	if (native_freq) {
+		/*
+		 * The VM has been migrated, so update the sequence number
+		 * and correct the compare for the timer if the frequency has
+		 * changed
+		 */
+		sequence_number = sequence_number + 2;
+		update_vtimer_cval(kvm, native_freq);
+	}
+
+	native_freq = arch_timer_get_rate();
+	pv_freq = kvm->arch.pvtime.lpt_fpv;
+
+	if (pv_freq >= native_freq)
+		shift = ilog2(pv_freq / native_freq) + 1;
+
+	WARN_ON(native_freq > U32_MAX);
+	/* scale_mult = (pv_freq << 64) / (native_freq << shift) */
+	scale_mult = shift64_div(pv_freq, native_freq << shift);
+	/* div_by_pv_freq_mult = (1 << 64) / pv_freq */
+	div_by_pv_freq_mult = shift64_div(1, pv_freq);
+
+	pvclock->sequence_number = cpu_to_le64(sequence_number);
+	pvclock->native_freq = cpu_to_le64(native_freq);
+	pvclock->pv_freq = cpu_to_le64(pv_freq);
+	pvclock->shift = cpu_to_le32(shift);
+	pvclock->scale_mult = cpu_to_le64(scale_mult);
+	pvclock->div_by_pv_freq_mult = cpu_to_le64(div_by_pv_freq_mult);
+
+	mutex_unlock(&kvm->lock);
+
+	return 0;
+}
+
+static int kvm_hypercall_time_lpt(struct kvm_vcpu *vcpu)
+{
+	u32 flags;
+	u64 ret = vcpu->kvm->arch.pvtime.lpt_base;
+
+	flags = smccc_get_arg1(vcpu);
+
+	if (flags) {
+		/* Currently no support for any flags */
+		ret = PV_VM_TIME_INVALID_PARAMETERS;
+	}
+
+	smccc_set_retval(vcpu, ret, 0, 0, 0);
+	return 1;
+}
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	u32 func_id = smccc_get_function(vcpu);
@@ -115,12 +253,15 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		switch (feature) {
 		case ARM_SMCCC_HV_PV_FEATURES:
 		case ARM_SMCCC_HV_PV_TIME_ST:
+		case ARM_SMCCC_HV_PV_TIME_LPT:
 			val = SMCCC_RET_SUCCESS;
 			break;
 		}
 		break;
 	case ARM_SMCCC_HV_PV_TIME_ST:
 		return kvm_hypercall_stolen_time(vcpu);
+	case ARM_SMCCC_HV_PV_TIME_LPT:
+		return kvm_hypercall_time_lpt(vcpu);
 	default:
 		return kvm_psci_call(vcpu);
 	}
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
