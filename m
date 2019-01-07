Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40811C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:06:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006EF21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HYPs/EnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006EF21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yuP6Iw4ltAG+urzC85dKd35gjEl0M8BETQoOFgkeXvM=; b=HYPs/EnBcg7yWcrXp+3PwD6D0j
	YFcsOlNRTHIYhUvmGAZn8ZM4HBLyIivu7ZD7YuYEhpVDirjNTNFNQOMQ7b08d6FAbH4Q8oG+2gvSv
	G/yL97yPKRD0VUa9XHhrF3Mk3/dO+G3IAAFzkFfeDKSyHx/2z6i68I0TQITkKUYpHWNfRWkFmus1a
	yU7wQcF+g+BnA6PKzX/z70AFrUFZE9SHbIBPVIrJuA+8uK3aekk3JaHmuIyDRC7ut9/eCJvwa4n5H
	5jK741WgnWfttO8QkHoDmznWCWyUPnUIz+myvpbH3C+Hdw42R9+nt6XnnUgBTRLrpzcyk2vKoS9HU
	CU4Ztd2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggTfp-0001E2-JT; Mon, 07 Jan 2019 12:06:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggTfO-0000pQ-M4
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 12:06:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBA4915AB;
 Mon,  7 Jan 2019 04:05:57 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F4923F5A0;
 Mon,  7 Jan 2019 04:05:56 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH 1/2] KVM: arm/arm64: Add save/restore support for firmware
 workaround state
Date: Mon,  7 Jan 2019 12:05:36 +0000
Message-Id: <20190107120537.184252-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107120537.184252-1-andre.przywara@arm.com>
References: <20190107120537.184252-1-andre.przywara@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_040602_729611_916CF4BF 
X-CRM114-Status: GOOD (  18.50  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Peter Maydell <peter.maydell@linaro.org>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

KVM implements the firmware interface for mitigating cache speculation
vulnerabilities. Guests may use this interface to ensure mitigation is
active.
If we want to migrate such a guest to a host with a different support
level for those workarounds, migration might need to fail, to ensure that
critical guests don't loose their protection.

Introduce a way for userland to save and restore the workarounds state.
On restoring we do checks that make sure we don't downgrade our
mitigation level.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h   |  10 ++
 arch/arm/include/uapi/asm/kvm.h      |   9 ++
 arch/arm64/include/asm/kvm_emulate.h |  14 +++
 arch/arm64/include/uapi/asm/kvm.h    |   9 ++
 virt/kvm/arm/psci.c                  | 138 ++++++++++++++++++++++++++-
 5 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 77121b713bef..2255c50debab 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -275,6 +275,16 @@ static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 	return vcpu_cp15(vcpu, c0_MPIDR) & MPIDR_HWID_BITMASK;
 }
 
+static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline void kvm_arm_set_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu,
+						      bool flag)
+{
+}
+
 static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
 {
 	*vcpu_cpsr(vcpu) |= PSR_E_BIT;
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 4602464ebdfb..02c93b1d8f6d 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -214,6 +214,15 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_MASK	0x3
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL	0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL	1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED	2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	4
 
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 506386a3edde..a44f07f68da4 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -336,6 +336,20 @@ static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 	return vcpu_read_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
 }
 
+static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.workaround_flags & VCPU_WORKAROUND_2_FLAG;
+}
+
+static inline void kvm_arm_set_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu,
+						      bool flag)
+{
+	if (flag)
+		vcpu->arch.workaround_flags |= VCPU_WORKAROUND_2_FLAG;
+	else
+		vcpu->arch.workaround_flags &= ~VCPU_WORKAROUND_2_FLAG;
+}
+
 static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_mode_is_32bit(vcpu)) {
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 97c3478ee6e7..4a19ef199a99 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -225,6 +225,15 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_MASK	0x3
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL	0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL	1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED	2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	4
 
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index 9b73d3ad918a..4c671908ef62 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -445,12 +445,18 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 
 int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
 {
-	return 1;		/* PSCI version */
+	return 3;		/* PSCI version and two workaround registers */
 }
 
 int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
-	if (put_user(KVM_REG_ARM_PSCI_VERSION, uindices))
+	if (put_user(KVM_REG_ARM_PSCI_VERSION, uindices++))
+		return -EFAULT;
+
+	if (put_user(KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1, uindices++))
+		return -EFAULT;
+
+	if (put_user(KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2, uindices++))
 		return -EFAULT;
 
 	return 0;
@@ -469,6 +475,45 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		return 0;
 	}
 
+	if (reg->id == KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1) {
+		void __user *uaddr = (void __user *)(long)reg->addr;
+		u64 val = 0;
+
+		if (kvm_arm_harden_branch_predictor())
+			val = KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL;
+
+		if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
+			return -EFAULT;
+
+		return 0;
+	}
+
+	if (reg->id == KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2) {
+		void __user *uaddr = (void __user *)(long)reg->addr;
+		u64 val = KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
+
+		switch (kvm_arm_have_ssbd()) {
+		case KVM_SSBD_FORCE_DISABLE:
+		case KVM_SSBD_UNKNOWN:
+			break;
+		case KVM_SSBD_KERNEL:
+			val |= KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL;
+			break;
+		case KVM_SSBD_FORCE_ENABLE:
+		case KVM_SSBD_MITIGATED:
+			val |= KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED;
+			break;
+		}
+
+		if (kvm_arm_get_vcpu_workaround_2_flag(vcpu))
+			val |= KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED;
+
+		if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
+			return -EFAULT;
+
+		return 0;
+	}
+
 	return -EINVAL;
 }
 
@@ -499,5 +544,94 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		}
 	}
 
+	if (reg->id == KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1) {
+		void __user *uaddr = (void __user *)(long)reg->addr;
+		u64 val;
+
+		if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
+			return -EFAULT;
+
+		/* Make sure we support WORKAROUND_1 if userland asks for it. */
+		if ((val & KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL) &&
+		    !kvm_arm_harden_branch_predictor())
+			return -EINVAL;
+
+		/* Any other bit is reserved. */
+		if (val & ~KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL)
+			return -EINVAL;
+
+		return 0;
+	}
+
+	if (reg->id == KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2) {
+		void __user *uaddr = (void __user *)(long)reg->addr;
+		unsigned int wa_state;
+		bool wa_flag;
+		u64 val;
+
+		if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
+			return -EFAULT;
+
+		/* Reject any unknown bits. */
+		if (val & ~(KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_MASK|
+			    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED))
+			return -EINVAL;
+
+		/*
+		 * The value passed from userland has to be compatible with
+		 * our own workaround status. We also have to consider the
+		 * requested per-VCPU state for some combinations:
+		 * --------------+-----------+-----------------+---------------
+		 * \ user value  |           |                 |
+		 *  ------------ | SSBD_NONE |   SSBD_KERNEL   |  SSBD_ALWAYS
+		 *  this kernel \|           |                 |
+		 * --------------+-----------+-----------------+---------------
+		 * UNKNOWN       |     OK    |   -EINVAL       |   -EINVAL
+		 * FORCE_DISABLE |           |                 |
+		 * --------------+-----------+-----------------+---------------
+		 * KERNEL        |     OK    | copy VCPU state | set VCPU state
+		 * --------------+-----------+-----------------+---------------
+		 * FORCE_ENABLE  |     OK    |      OK         |      OK
+		 * MITIGATED     |           |                 |
+		 * --------------+-----------+-----------------+---------------
+		 */
+
+		wa_state = val & KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_MASK;
+		switch (wa_state) {
+		case  KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL:
+			/* We can always support no mitigation (1st column). */
+			return 0;
+		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL:
+		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		switch (kvm_arm_have_ssbd()) {
+		case KVM_SSBD_UNKNOWN:
+		case KVM_SSBD_FORCE_DISABLE:
+		default:
+			/* ... but some mitigation was requested (1st line). */
+			return -EINVAL;
+		case KVM_SSBD_FORCE_ENABLE:
+		case KVM_SSBD_MITIGATED:
+			/* Always-on is always compatible (3rd line). */
+			return 0;
+		case KVM_SSBD_KERNEL:		/* 2nd line */
+			wa_flag = val;
+			wa_flag |= KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_MASK;
+
+			/* Force on when always-on is requested. */
+			if (wa_state == KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED)
+				wa_flag = true;
+			break;
+		}
+
+		kvm_arm_set_vcpu_workaround_2_flag(vcpu, wa_flag);
+
+		return 0;
+	}
+
 	return -EINVAL;
 }
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
