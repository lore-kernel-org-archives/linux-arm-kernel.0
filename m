Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB552C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BD32084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o+NsVHJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BD32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=w6gfb2EfbhW8wM9hrtUnOgdPFHTUqVx4lOHrzZj70Q4=; b=o+NsVHJDMxn9Ntwlh2hNAuiOTX
	R4iAFJQC99wAga26Z/XteATzcNWtlXMCCab4r9rbvmJsx+Tty1IaG5yVeig1UN6xyGUYYPLYwbrIQ
	w6KkHScZ/MSazoINqWYw6BkK630rmvXTUzia+uaCEIVxQVqrKZqSVddpxApEXJ5OOw1wBmEJW37Cb
	jCJwwqrVAbh86UYwTiCxW/reHzqQZpV/XvC0OVh4QChu4RME0g4Kkd4OI+H2dtO4xPcO/0wF0SDcK
	cZ4pbMKGqFNEom831MhpC6mxR/OqA/gzcVuCWixyrwqQH/q2GXJeyjJ6EDXpD2wh5WdcZZ5a+Cz0h
	r7yYnrPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrYz-0002fV-UZ; Tue, 11 Dec 2018 23:35:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrU5-0005RO-33
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCC2B165C;
 Tue, 11 Dec 2018 15:30:26 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EEE03F614;
 Tue, 11 Dec 2018 15:30:24 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 19/24] KVM: arm: Move detection of invalid VM type bits
 to generic code
Date: Tue, 11 Dec 2018 23:28:56 +0000
Message-Id: <1544570941-7377-20-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153037_385239_5C63F6B3 
X-CRM114-Status: GOOD (  16.95  )
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
 Will Deacon <will.deacon@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, the detection of invalid bits in the KVM_CREATE_VM type
argument is done in the kvm_arm_setup_stage2() backend.

In order to make it easier to add type flags with independent
meanings, this patch moves the logic for rejecting invalid bits to
kvm_arch_init_vm().  Backend functions are now responsible for
clearing bits they know about from type, so that if any remain
after all such functions are called, we know they are invalid.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since RFC v2:

 * New patch.

   **Discussion required**

   This change facilitates the addition of special-purpose flags in the
   KVM_CREATE_VM type argument, which may be used to control API
   features at VM granularity.

   This is currently one of two main options I can see for
   controlling the sequencing of the KVM_ARM_VCPU_INIT ioctl, since
   KVM_CREATE_VCPU has no spare argument bits and there is no obvious
   place to hook in.  (The other, perhaps better option is to alter
   KVM_ARM_VCPU_INIT's behaviour with a feature flag in struct
   kvm_vcpu_init.)

   If API behaviour does not need to diverge before KVM_VCPU_INIT,
   then we can get away without this patch.

   The API presented in this series _does_ require divergence however:
   it requires KVM_ARM_SVE_CONFIG_SET before KVM_VCPU_INIT.

   It remains up for discussion whether this change is appropriate/
   needed.
---
 arch/arm/include/asm/kvm_host.h   | 6 +++---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kvm/reset.c            | 8 +++-----
 virt/kvm/arm/arm.c                | 6 +++++-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 5ca5d9a..8d385ec 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -354,13 +354,13 @@ static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
 struct kvm *kvm_arch_alloc_vm(void);
 void kvm_arch_free_vm(struct kvm *kvm);
 
-static inline int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
+static inline int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long *type)
 {
 	/*
 	 * On 32bit ARM, VMs get a static 40bit IPA stage2 setup,
-	 * so any non-zero value used as type is illegal.
+	 * so any non-zero value used in the IPA size field is illegal.
 	 */
-	if (type)
+	if (*type & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 		return -EINVAL;
 	return 0;
 }
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f36cfc0..9fd8729 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -534,6 +534,6 @@ void kvm_set_ipa_limit(void);
 struct kvm *kvm_arch_alloc_vm(void);
 void kvm_arch_free_vm(struct kvm *kvm);
 
-int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type);
+int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long *type);
 
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index b72a3dd..9503fec 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -188,16 +188,14 @@ void kvm_set_ipa_limit(void)
  * all CPUs, as it is safe to run with or without the feature and
  * the bit is RES0 on CPUs that don't support it.
  */
-int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
+int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long *type)
 {
 	u64 vtcr = VTCR_EL2_FLAGS;
 	u32 parange, phys_shift;
 	u8 lvls;
 
-	if (type & ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
-		return -EINVAL;
-
-	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
+	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(*type);
+	*type &= ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK;
 	if (phys_shift) {
 		if (phys_shift > kvm_ipa_limit ||
 		    phys_shift < 32)
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 2377497..f7bf43a 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -120,10 +120,14 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int ret, cpu;
 
-	ret = kvm_arm_setup_stage2(kvm, type);
+	ret = kvm_arm_setup_stage2(kvm, &type);
 	if (ret)
 		return ret;
 
+	/* Fail if there are type bits that nobody understood: */
+	if (type)
+		return -EINVAL;
+
 	kvm->arch.last_vcpu_ran = alloc_percpu(typeof(*kvm->arch.last_vcpu_ran));
 	if (!kvm->arch.last_vcpu_ran)
 		return -ENOMEM;
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
