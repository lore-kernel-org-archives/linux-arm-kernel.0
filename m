Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F5C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:02:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1174821855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EyvwfgDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1174821855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bDMZpz/5GxgGRVfghU2SHJWlX0KKAepLEuov8bGUSVE=; b=EyvwfgDpTEYCJ/GGj+FBxNNbEJ
	dK8NBqGkM1De4NkDHOgczrO+WsBrjWgS00hSnfUQQtCy7udblKbbUrrkasw5eIwieCo/kioqoRtdo
	qCdUlVB5CmqLxVQMNXnAcXfjgQMWd0nX/BPjvCq1SMDZr0ajG2306qu5GPj8QtsyYFjQ5hj3nz/K1
	2fbLtJDs3/731F+H692vQ+ldTXvdfu/lM/eLiRpDi77AOglrZltLgwJRK1ODJJA3DKQxFVHPcP+Rr
	LDkYn7VsJIxi3PyjrRqOLfpkc5wVokFmBPSxBYu9wKwfRZ9PXLmJbewx6zZCqZtmoYHOa5rjChljD
	/nXTE/0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmfal-0004eb-K6; Thu, 24 Jan 2019 14:02:51 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmfYq-0002zZ-58
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 14:00:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AF611650;
 Thu, 24 Jan 2019 06:00:48 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0C8C3F5C1;
 Thu, 24 Jan 2019 06:00:47 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/14] arm/arm64: KVM: Statically configure the host's view of
 MPIDR
Date: Thu, 24 Jan 2019 15:00:23 +0100
Message-Id: <20190124140032.8588-6-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190124140032.8588-1-christoffer.dall@arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_060052_788871_A456DD8B 
X-CRM114-Status: GOOD (  14.51  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We currently eagerly save/restore MPIDR. It turns out to be
slightly pointless:
- On the host, this value is known as soon as we're scheduled on a
  physical CPU
- In the guest, this value cannot change, as it is set by KVM
  (and this is a read-only register)

The result of the above is that we can perfectly avoid the eager
saving of MPIDR_EL1, and only keep the restore. We just have
to setup the host contexts appropriately at boot time.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 8 ++++++++
 arch/arm/kvm/hyp/cp15-sr.c        | 1 -
 arch/arm64/include/asm/kvm_host.h | 8 ++++++++
 arch/arm64/kvm/hyp/sysreg-sr.c    | 1 -
 virt/kvm/arm/arm.c                | 1 +
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 4b6193f2f0f6..43e343e00fb8 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -26,6 +26,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
 #include <asm/fpstate.h>
+#include <asm/smp_plat.h>
 #include <kvm/arm_arch_timer.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -147,6 +148,13 @@ struct kvm_cpu_context {
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
 
+static inline void kvm_init_host_cpu_context(kvm_cpu_context_t *cpu_ctxt,
+					     int cpu)
+{
+	/* The host's MPIDR is immutable, so let's set it up at boot time */
+	cpu_ctxt->cp15[c0_MPIDR] = cpu_logical_map(cpu);
+}
+
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
 
diff --git a/arch/arm/kvm/hyp/cp15-sr.c b/arch/arm/kvm/hyp/cp15-sr.c
index c4782812714c..8bf895ec6e04 100644
--- a/arch/arm/kvm/hyp/cp15-sr.c
+++ b/arch/arm/kvm/hyp/cp15-sr.c
@@ -27,7 +27,6 @@ static u64 *cp15_64(struct kvm_cpu_context *ctxt, int idx)
 
 void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
 {
-	ctxt->cp15[c0_MPIDR]		= read_sysreg(VMPIDR);
 	ctxt->cp15[c0_CSSELR]		= read_sysreg(CSSELR);
 	ctxt->cp15[c1_SCTLR]		= read_sysreg(SCTLR);
 	ctxt->cp15[c1_CPACR]		= read_sysreg(CPACR);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8b7702bdb219..f497bb31031f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -30,6 +30,7 @@
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
+#include <asm/smp_plat.h>
 #include <asm/thread_info.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -418,6 +419,13 @@ struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
 DECLARE_PER_CPU(kvm_cpu_context_t, kvm_host_cpu_state);
 
+static inline void kvm_init_host_cpu_context(kvm_cpu_context_t *cpu_ctxt,
+					     int cpu)
+{
+	/* The host's MPIDR is immutable, so let's set it up at boot time */
+	cpu_ctxt->sys_regs[MPIDR_EL1] = cpu_logical_map(cpu);
+}
+
 void __kvm_enable_ssbs(void);
 
 static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 68d6f7c3b237..2498f86defcb 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -52,7 +52,6 @@ static void __hyp_text __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 
 static void __hyp_text __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 {
-	ctxt->sys_regs[MPIDR_EL1]	= read_sysreg(vmpidr_el2);
 	ctxt->sys_regs[CSSELR_EL1]	= read_sysreg(csselr_el1);
 	ctxt->sys_regs[SCTLR_EL1]	= read_sysreg_el1(sctlr);
 	ctxt->sys_regs[ACTLR_EL1]	= read_sysreg(actlr_el1);
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 4d55f98f97f7..3dd240ea9e76 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1561,6 +1561,7 @@ static int init_hyp_mode(void)
 		kvm_cpu_context_t *cpu_ctxt;
 
 		cpu_ctxt = per_cpu_ptr(&kvm_host_cpu_state, cpu);
+		kvm_init_host_cpu_context(cpu_ctxt, cpu);
 		err = create_hyp_mappings(cpu_ctxt, cpu_ctxt + 1, PAGE_HYP);
 
 		if (err) {
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
