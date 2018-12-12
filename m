Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0919FC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:05:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7E120849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lp+rWqj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7E120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+mJVQEqaYtIcFdtWnQcAwTwInO70U3xJL+TLbTfO910=; b=lp+rWqj84DuoHm
	DTQDZJRyVT2sebKaY9pPql/QzJxPduqQ9PqPfiWqSidC5M+vG1ObAZmB3oCCvqkvgP2RqT/pfg22G
	n04pOyV0n3UoAv/OCRtGnUpLjYFJFM+yEIuNblJKg3UrJkkPwnpf7r87luFwmQ/OAavVQyR8w7ByO
	N15qH9TWz2X9AtpjV+o7TYyI/1XqZl8DzLwJ210jAn6sdxoKY5DiCCw3Dmlm+IsYyUpzq4c1sBkze
	1s/hlMYOhmf7YRxPXAnTs3QQ9E8LqChMHCxk/NPJd5+gs9QtnzUmelEd6ghem5AKAiaYlm+0bNr22
	9iqACpaZlSctnugum6JQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX64m-0001dY-MV; Wed, 12 Dec 2018 15:05:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62e-0006QK-FR
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:03:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB6D80D;
 Wed, 12 Dec 2018 07:03:09 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 157063F59C;
 Wed, 12 Dec 2018 07:03:07 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 06/12] KVM: arm64: Support stolen time reporting via
 shared structure
Date: Wed, 12 Dec 2018 15:02:20 +0000
Message-Id: <20181212150226.38051-7-steven.price@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212150226.38051-1-steven.price@arm.com>
References: <20181212150226.38051-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_070317_211012_13982398 
X-CRM114-Status: GOOD (  21.22  )
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

Implement the service call for configuring a shared structre between a
VCPU and the hypervisor in which the hypervisor can write the time
stolen from the VCPU's execution time by other tasks on the host.

The hypervisor allocates memory which is placed at an IPA chosen by user
space. The hypervisor then uses WRITE_ONCE() to update the shared
structre ensuring single copy atomicity of the 64-bit unsigned value
that reports stolen time in nanoseconds.

Whenever stolen time is enabled by the guest, the stolen time counter is
reset.

The stolen time itself is retrieved from the sched_info structure
maintained by the Linux scheduler code. We enable SCHEDSTATS when
selecting KVM Kconfig to ensure this value is meaningful.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 12 ++++++
 arch/arm64/kvm/Kconfig            |  1 +
 include/kvm/arm_hypercalls.h      |  1 +
 include/linux/kvm_types.h         |  2 +
 virt/kvm/arm/arm.c                | 20 ++++++++-
 virt/kvm/arm/hypercalls.c         | 70 +++++++++++++++++++++++++++++++
 6 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 52fbc823ff8c..bab7bc720992 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -48,6 +48,7 @@
 #define KVM_REQ_SLEEP \
 	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
+#define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(2)
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
@@ -80,6 +81,11 @@ struct kvm_arch {
 
 	/* Mandated version of PSCI */
 	u32 psci_version;
+
+	struct kvm_arch_pvtime {
+		void *st;
+		gpa_t st_base;
+	} pvtime;
 };
 
 #define KVM_NR_MEM_OBJS     40
@@ -300,6 +306,12 @@ struct kvm_vcpu_arch {
 	/* True when deferrable sysregs are loaded on the physical CPU,
 	 * see kvm_vcpu_load_sysregs and kvm_vcpu_put_sysregs. */
 	bool sysregs_loaded_on_cpu;
+
+	/* Guest PV state */
+	struct {
+		u64 steal;
+		u64 last_steal;
+	} steal;
 };
 
 /* vcpu_arch flags field values: */
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 47b23bf617c7..92676920d671 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -40,6 +40,7 @@ config KVM
 	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_VCPU_RUN_PID_CHANGE
+	select SCHEDSTATS
 	---help---
 	  Support hosting virtualized guest machines.
 	  We don't support KVM with 16K page tables yet, due to the multiple
diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index e5f7f81196b6..2e03e993ad64 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -7,6 +7,7 @@
 #include <asm/kvm_emulate.h>
 
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
+int kvm_update_stolen_time(struct kvm_vcpu *vcpu);
 
 static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
 {
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index 8bf259dae9f6..ff0e314c7dcd 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -49,6 +49,8 @@ typedef unsigned long  gva_t;
 typedef u64            gpa_t;
 typedef u64            gfn_t;
 
+#define GPA_INVALID	(~(gpa_t)0)
+
 typedef unsigned long  hva_t;
 typedef u64            hpa_t;
 typedef u64            hfn_t;
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 23774970c9df..b347ba38cb11 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -32,8 +32,6 @@
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
 #include <trace/events/kvm.h>
-#include <kvm/arm_pmu.h>
-#include <kvm/arm_psci.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -52,6 +50,10 @@
 #include <asm/kvm_coproc.h>
 #include <asm/sections.h>
 
+#include <kvm/arm_hypercalls.h>
+#include <kvm/arm_pmu.h>
+#include <kvm/arm_psci.h>
+
 #ifdef REQUIRES_VIRT
 __asm__(".arch_extension	virt");
 #endif
@@ -148,6 +150,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.max_vcpus = vgic_present ?
 				kvm_vgic_get_max_vcpus() : KVM_MAX_VCPUS;
 
+	kvm->arch.pvtime.st_base = GPA_INVALID;
 	return ret;
 out_free_stage2_pgd:
 	kvm_free_stage2_pgd(kvm);
@@ -383,6 +386,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_timer_vcpu_load(vcpu);
 	kvm_vcpu_load_sysregs(vcpu);
 	kvm_arch_vcpu_load_fp(vcpu);
+	kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
 
 	if (single_task_running())
 		vcpu_clear_wfe_traps(vcpu);
@@ -629,6 +633,15 @@ static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void vcpu_req_record_steal(struct kvm_vcpu *vcpu)
+{
+	int idx;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	kvm_update_stolen_time(vcpu);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+}
+
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.target >= 0;
@@ -645,6 +658,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 		 * that a VCPU sees new virtual interrupts.
 		 */
 		kvm_check_request(KVM_REQ_IRQ_PENDING, vcpu);
+
+		if (kvm_check_request(KVM_REQ_RECORD_STEAL, vcpu))
+			vcpu_req_record_steal(vcpu);
 	}
 }
 
diff --git a/virt/kvm/arm/hypercalls.c b/virt/kvm/arm/hypercalls.c
index ba13b798f0f8..595d1cf3a871 100644
--- a/virt/kvm/arm/hypercalls.c
+++ b/virt/kvm/arm/hypercalls.c
@@ -10,6 +10,70 @@
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_psci.h>
 
+
+static struct pvclock_vcpu_stolen_time_info *pvtime_get_st(
+		struct kvm_vcpu *vcpu)
+{
+	struct pvclock_vcpu_stolen_time_info *st = vcpu->kvm->arch.pvtime.st;
+
+	if (!st)
+		return NULL;
+
+	return &st[kvm_vcpu_get_idx(vcpu)];
+}
+
+int kvm_update_stolen_time(struct kvm_vcpu *vcpu)
+{
+	u64 steal;
+	struct pvclock_vcpu_stolen_time_info *kaddr;
+
+	if (vcpu->kvm->arch.pvtime.st_base == GPA_INVALID)
+		return -ENOTSUPP;
+
+	kaddr = pvtime_get_st(vcpu);
+
+	if (!kaddr)
+		return -ENOTSUPP;
+
+	kaddr->revision = 0;
+	kaddr->attributes = 0;
+
+	/* Let's do the local bookkeeping */
+	steal = vcpu->arch.steal.steal;
+	steal += current->sched_info.run_delay - vcpu->arch.steal.last_steal;
+	vcpu->arch.steal.last_steal = current->sched_info.run_delay;
+	vcpu->arch.steal.steal = steal;
+
+	/* Now write out the value to the shared page */
+	WRITE_ONCE(kaddr->stolen_time, cpu_to_le64(steal));
+
+	return 0;
+}
+
+static int kvm_hypercall_stolen_time(struct kvm_vcpu *vcpu)
+{
+	u64 ret;
+	int err;
+
+	/*
+	 * Start counting stolen time from the time the guest requests
+	 * the feature enabled.
+	 */
+	vcpu->arch.steal.steal = 0;
+	vcpu->arch.steal.last_steal = current->sched_info.run_delay;
+
+	err = kvm_update_stolen_time(vcpu);
+
+	if (err)
+		ret = SMCCC_RET_NOT_SUPPORTED;
+	else
+		ret = vcpu->kvm->arch.pvtime.st_base +
+			(sizeof(struct pvclock_vcpu_stolen_time_info) *
+			 kvm_vcpu_get_idx(vcpu));
+
+	smccc_set_retval(vcpu, ret, 0, 0, 0);
+	return 1;
+}
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	u32 func_id = smccc_get_function(vcpu);
@@ -49,8 +113,14 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	case ARM_SMCCC_HV_PV_FEATURES:
 		feature = smccc_get_arg1(vcpu);
 		switch (feature) {
+		case ARM_SMCCC_HV_PV_FEATURES:
+		case ARM_SMCCC_HV_PV_TIME_ST:
+			val = SMCCC_RET_SUCCESS;
+			break;
 		}
 		break;
+	case ARM_SMCCC_HV_PV_TIME_ST:
+		return kvm_hypercall_stolen_time(vcpu);
 	default:
 		return kvm_psci_call(vcpu);
 	}
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
