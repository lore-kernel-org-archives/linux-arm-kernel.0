Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7004BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:18:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1324A2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kUpRpFg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1324A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=P3fcZeH0Z4XX45Q9mD/lP+o//zukpyP+ys6xuA4IYzI=; b=kUpRpFg1Goxrey0Jb5ZlTdX3Iu
	NUvw9lZ7VDqf0UuhCZZVwCWSo5FQOcg0odV5b0peib37qoxEyJNeyaolood84Oew7w+m5rZQ08qq4
	6B8i8Qw9yH/thytkF3TzMS/GPUxss65D5yOrFxNOu1N9faWxspR+Mb0AmAWmPH0+gbXc7spGWkWLU
	h7qpg174x8kf46HZc09KIacrfzQHfno+ZCbCiTx4wKzhe4hoSrZuJ+6B7s5+IYqNfSLUA5D1IhvyR
	nkWCLp4wiElD3fQp3M1HU10YXoYYR2cRbLL9kczsJ5ZS7zvy282sUGdC1cwCE28Wx6ryibKQZFuPU
	+EulugJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXAxQ-0003pf-MP; Wed, 12 Dec 2018 20:18:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXAxL-0003o8-JM
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 20:18:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5855FA78;
 Wed, 12 Dec 2018 12:17:56 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 486A83F59C;
 Wed, 12 Dec 2018 12:17:55 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 1/2] KVM: arm64: Filter out invalid core register IDs in
 KVM_GET_REG_LIST
Date: Wed, 12 Dec 2018 20:17:03 +0000
Message-Id: <1544645824-16461-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544645824-16461-1-git-send-email-Dave.Martin@arm.com>
References: <1544645824-16461-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_121807_645413_49FA8974 
X-CRM114-Status: GOOD (  16.42  )
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
 Peter Maydell <peter.maydell@linaro.org>, stable@vger.kernel.org,
 Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since commit d26c25a9d19b ("arm64: KVM: Tighten guest core register
access from userspace"), KVM_{GET,SET}_ONE_REG rejects register IDs
that do not correspond to a single underlying architectural register.

KVM_GET_REG_LIST was not changed to match however: instead, it
simply yields a list of 32-bit register IDs that together cover the
whole kvm_regs struct.  This means that if userspace tries to use
the resulting list of IDs directly to drive calls to KVM_*_ONE_REG,
some of those calls will now fail.

This was not the intention.  Instead, iterating KVM_*_ONE_REG over
the list of IDs returned by KVM_GET_REG_LIST should be guaranteed
to work.

This patch fixes the problem by splitting validate_core_reg_id()
into a backend core_reg_size_from_offset() which does all of the
work except for checking that the size field in the register ID
matches, and kvm_arm_copy_reg_indices() and num_core_regs() are
converted to use this to enumerate the valid offsets.

kvm_arm_copy_reg_indices() now also sets the register ID size field
appropriately based on the value returned, so the register ID
supplied to userspace is fully qualified for use with the register
access ioctls.

Cc: stable@vger.kernel.org
Fixes: d26c25a9d19b ("arm64: KVM: Tighten guest core register access from userspace")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kvm/guest.c | 61 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index dd436a5..cbe423b 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -57,9 +57,8 @@ static u64 core_reg_offset_from_id(u64 id)
 	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
 }
 
-static int validate_core_offset(const struct kvm_one_reg *reg)
+static int core_reg_size_from_offset(u64 off)
 {
-	u64 off = core_reg_offset_from_id(reg->id);
 	int size;
 
 	switch (off) {
@@ -89,8 +88,21 @@ static int validate_core_offset(const struct kvm_one_reg *reg)
 		return -EINVAL;
 	}
 
-	if (KVM_REG_SIZE(reg->id) == size &&
-	    IS_ALIGNED(off, size / sizeof(__u32)))
+	if (IS_ALIGNED(off, size / sizeof(__u32)))
+		return size;
+
+	return -EINVAL;
+}
+
+static int validate_core_offset(const struct kvm_one_reg *reg)
+{
+	u64 off = core_reg_offset_from_id(reg->id);
+	int size = core_reg_size_from_offset(off);
+
+	if (size < 0)
+		return -EINVAL;
+
+	if (KVM_REG_SIZE(reg->id) == size)
 		return 0;
 
 	return -EINVAL;
@@ -195,7 +207,19 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 static unsigned long num_core_regs(void)
 {
-	return sizeof(struct kvm_regs) / sizeof(__u32);
+	unsigned int i;
+	int n = 0;
+
+	for (i = 0; i < sizeof(struct kvm_regs) / sizeof(__u32); i++) {
+		int size = core_reg_size_from_offset(i);
+
+		if (size < 0)
+			continue;
+
+		n++;
+	}
+
+	return n;
 }
 
 /**
@@ -270,11 +294,34 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
 	unsigned int i;
-	const u64 core_reg = KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE;
 	int ret;
 
 	for (i = 0; i < sizeof(struct kvm_regs) / sizeof(__u32); i++) {
-		if (put_user(core_reg | i, uindices))
+		u64 reg = KVM_REG_ARM64 | KVM_REG_ARM_CORE | i;
+		int size = core_reg_size_from_offset(i);
+
+		if (size < 0)
+			continue;
+
+		switch (size) {
+		case sizeof(__u32):
+			reg |= KVM_REG_SIZE_U32;
+			break;
+
+		case sizeof(__u64):
+			reg |= KVM_REG_SIZE_U64;
+			break;
+
+		case sizeof(__uint128_t):
+			reg |= KVM_REG_SIZE_U128;
+			break;
+
+		default:
+			WARN_ON(1);
+			continue;
+		}
+
+		if (put_user(reg, uindices))
 			return -EFAULT;
 		uindices++;
 	}
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
