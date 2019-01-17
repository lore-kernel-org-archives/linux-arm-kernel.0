Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DDBC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:59:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC81520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZI10tJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC81520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JZYmnSybPkEefkMhQIapph6/P1lYj5AzsA60p5r6UCg=; b=ZZI10tJTt6Cv9DQscsfkb0BeU6
	hr4ltH0zU9ND1GpEasfbEs3O0saoGVgvEyyMRtRehod0mc7PIv6ddfv5xrXiiwMf/bY/zX2SV0Qd4
	9M7F/UvkBOgERXK+8LWozfxaB5h2rE1CjnadUnBOnDdkjezvNoNqReikAJFlU2AEPVK/DPpD/Stby
	7hcmDEX502+WRJlilCIpkGhDaZOssthY/8wY5scMgai2OV7oHjaVbeKILtzTXgMevWgKkIKDstPxI
	pD6LHQOhNaRTV3NWCHM3B/mRKd3oLu2JZ54jnae+uC9ZsBv1rBwSiO7n3C3SmW2ivfulY/tCKdhsj
	8l9IAjjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkERh-0005Ka-Ta; Thu, 17 Jan 2019 20:39:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENb-0000A1-W9
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ACBD1650;
 Thu, 17 Jan 2019 12:35:11 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6DD933F819;
 Thu, 17 Jan 2019 12:35:09 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 20/25] KVM: arm/arm64: Add hook to finalize the vcpu
 configuration
Date: Thu, 17 Jan 2019 20:33:34 +0000
Message-Id: <1547757219-19439-21-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_123512_459963_777D092F 
X-CRM114-Status: GOOD (  15.47  )
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
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some aspects of vcpu configuration can't be completed inside
KVM_VCPU_INIT, but still change API behaviour visible to userspace.

Where such configuration choices affect the register list visible
to userspace, we will need to track whether we have made a
commitment to userspace regarding the list of vcpu registers.

This patch adds a new hook kvm_arm_vcpu_finalize() to capture this
commitment, along with a corresponding check
kvm_arm_vcpu_finalized().  We commit to the register list when
userspace reads it via KVM_GET_REG_LIST, or when the vcpu is fired
up via KVM_RUN.

kvm_arm_vcpu_finalize() is currently a no-op, but future patches
will amend this to handle SVE on arm64.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 4 ++++
 arch/arm64/include/asm/kvm_host.h | 4 ++++
 virt/kvm/arm/arm.c                | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ca56537..ab7c76b 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -360,4 +360,8 @@ static inline int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 	return 0;
 }
 
+/* Commit to the set of vcpu registers currently configured: */
+static inline int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu) { return 0; }
+#define kvm_arm_vcpu_finalized(vcpu) true
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 77b6f3e..55bf9d0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -539,4 +539,8 @@ void kvm_arch_free_vm(struct kvm *kvm);
 
 int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type);
 
+/* Commit to the set of vcpu registers currently configured: */
+static inline int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu) { return 0; }
+#define kvm_arm_vcpu_finalized(vcpu) true
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 9e350fd3..12f9dc2 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -560,6 +560,10 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	if (likely(vcpu->arch.has_run_once))
 		return 0;
 
+	ret = kvm_arm_vcpu_finalize(vcpu);
+	if (ret)
+		return ret;
+
 	vcpu->arch.has_run_once = true;
 
 	if (likely(irqchip_in_kernel(kvm))) {
@@ -1121,6 +1125,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (unlikely(!kvm_vcpu_initialized(vcpu)))
 			break;
 
+		r = kvm_arm_vcpu_finalize(vcpu);
+		if (r)
+			break;
+
 		r = -EFAULT;
 		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
 			break;
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
