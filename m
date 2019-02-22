Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD25C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:28:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A702075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RkSS6V/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A702075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iHB5C5qTaAt5Akx1WoBxU7X4LzLOPmOTsqNNEAqMgAA=; b=RkSS6V/jTjFPCS
	IfBJIvnY/BlJ8cqONnuiFNzv8rI0fVJrKkmSf2K6lfDb0bi+b3tZrgpWvXF+Qd+Ek0tc0tGz56Pkd
	B9LgufEBj1Fr2Q2dgo2l0FFWvZZljKlKgSrqiVrK5RhQyyg7UwpUqLcqIcrhi0L5AlQcD0rpqX+aG
	DSYWiMbbVJjfrURFSkdKeRAwtRLQ7FwLzDC2y8z2v+K5/kkU25XH/0yb+8FIbaKoHnxqQWWSZ/ahU
	AO8Yd8+MdNLZh/fk872HZ3EJYsaHPDKPLHOeflQ/mRGzFfQewEOwnEULLZXCVRUoiF+0X7qQlxOTM
	O46Q6bv7w3fzl57T84xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDgN-0008Ly-5W; Fri, 22 Feb 2019 16:28:15 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDfa-0007Pm-Gn
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:27:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3736780D;
 Fri, 22 Feb 2019 08:27:26 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 0617C3F5C1; Fri, 22 Feb 2019 08:27:19 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 06/27] arm/arm64: KVM: Statically configure the host's view of
 MPIDR
Date: Fri, 22 Feb 2019 16:25:44 +0000
Message-Id: <20190222162605.5054-7-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222162605.5054-1-marc.zyngier@arm.com>
References: <20190222162605.5054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_082727_276222_73A597EF 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, kvm@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Zenghui Yu <yuzenghui@huawei.com>, Colin Ian King <colin.king@canonical.com>,
 Dave Martin <Dave.Martin@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

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
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
