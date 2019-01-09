Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:55:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FFE32075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LZvFZrnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFE32075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cfMsNNMU3Xidgcwm0kUWQ/p4oJYw8Kwd/iwu5FFoeMQ=; b=LZvFZrnVsPGyS1
	Q6mCwYsQHBAFlcAUNbq/+7RDdorF5pG2crr9RnEs3oK+XC+71/lPEFoSEZUbrGurTsvvd50nJXnAT
	qlpUSdyNxXzcCLB/cKei7tgMgKYxYa71ONQk2g2ao2r8R/0RAQsaXHrHe90tOSqR4nN4gfez9qZzn
	jNZmxOtTWp0EBTdLvyRBTrn4J1oukGPhdYD0hUP1vx75RtqHClIwpkDnDVjJQdftOxrkIqdcT9wd9
	K6Uew8ql507UM8PchVGNmVU16oEQCG9mlI2OKTWYS1+fMIm3s2Wycv1uHGZxwVGjNx+Y1Jzi+TWG2
	72L5xMHfQiGqlv8C4QDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEK7-00048n-Rs; Wed, 09 Jan 2019 13:55:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEJr-0003Yp-3l
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:54:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 987D41596;
 Wed,  9 Jan 2019 05:54:53 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A98683F6CF;
 Wed,  9 Jan 2019 05:54:52 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] arm/arm64: KVM: Introduce kvm_call_hyp_ret()
Date: Wed,  9 Jan 2019 13:54:33 +0000
Message-Id: <20190109135435.178664-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109135435.178664-1-marc.zyngier@arm.com>
References: <20190109135435.178664-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_055455_173574_E6365BCC 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: Christoffer Dall <christoffer.dall@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Until now, we haven't differentiated between HYP calls that
have a return value and those who don't. As we're about to
change this, introduce kvm_call_hyp_ret(), and change all
call sites that actually make use of a return value.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 3 +++
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kvm/debug.c            | 2 +-
 virt/kvm/arm/arm.c                | 2 +-
 virt/kvm/arm/vgic/vgic-v3.c       | 4 ++--
 5 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ca56537b61bc..023c9f2b1eea 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -214,7 +214,10 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+
 unsigned long kvm_call_hyp(void *hypfn, ...);
+#define kvm_call_hyp_ret(f, ...) kvm_call_hyp(f, ##__VA_ARGS__)
+
 void force_vm_exit(const cpumask_t *mask);
 int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7732d0ba4e60..e54cb7c88a4e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -371,6 +371,7 @@ void kvm_arm_resume_guest(struct kvm *kvm);
 
 u64 __kvm_call_hyp(void *hypfn, ...);
 #define kvm_call_hyp(f, ...) __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__)
+#define kvm_call_hyp_ret(f, ...) kvm_call_hyp(f, ##__VA_ARGS__)
 
 void force_vm_exit(const cpumask_t *mask);
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index f39801e4136c..fd917d6d12af 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -76,7 +76,7 @@ static void restore_guest_debug_regs(struct kvm_vcpu *vcpu)
 
 void kvm_arm_init_debug(void)
 {
-	__this_cpu_write(mdcr_el2, kvm_call_hyp(__kvm_get_mdcr_el2));
+	__this_cpu_write(mdcr_el2, kvm_call_hyp_ret(__kvm_get_mdcr_el2));
 }
 
 /**
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 9e350fd34504..4d55f98f97f7 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -765,7 +765,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			ret = kvm_vcpu_run_vhe(vcpu);
 			kvm_arm_vhe_guest_exit();
 		} else {
-			ret = kvm_call_hyp(__kvm_vcpu_run_nvhe, vcpu);
+			ret = kvm_call_hyp_ret(__kvm_vcpu_run_nvhe, vcpu);
 		}
 
 		vcpu->mode = OUTSIDE_GUEST_MODE;
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 9c0dd234ebe8..67f98151c88d 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -589,7 +589,7 @@ early_param("kvm-arm.vgic_v4_enable", early_gicv4_enable);
  */
 int vgic_v3_probe(const struct gic_kvm_info *info)
 {
-	u32 ich_vtr_el2 = kvm_call_hyp(__vgic_v3_get_ich_vtr_el2);
+	u32 ich_vtr_el2 = kvm_call_hyp_ret(__vgic_v3_get_ich_vtr_el2);
 	int ret;
 
 	/*
@@ -679,7 +679,7 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
 	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
 
 	if (likely(cpu_if->vgic_sre))
-		cpu_if->vgic_vmcr = kvm_call_hyp(__vgic_v3_read_vmcr);
+		cpu_if->vgic_vmcr = kvm_call_hyp_ret(__vgic_v3_read_vmcr);
 
 	kvm_call_hyp(__vgic_v3_save_aprs, vcpu);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
