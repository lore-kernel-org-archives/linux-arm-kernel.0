Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB80C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:57:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB6320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JSo9adJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB6320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XIi55+J0mfHbw1SpE0/+m313sfZgQZNkYfJVgCapTxM=; b=JSo9adJgCd/iHXSkh+qiNJh9j4
	UG+X1wxJcD/Q0YlbNmsNIBFBHaaPmeIctHho+FR5mKqIUpw0/yx9V/mxC7GA/41w4w24na9Lzw5zr
	2KYDnFcTl9hDJc7IEdN1vY3uBsfH9gu+APdxU+qZFgfEDklMb92k7EbfSkrJgyHGlSCm8GF/K8cBO
	h1FiRI3T1XOOxrCQk+XXUKSeToTX2LCf6AzL/nJ7uHj3hiTYui1gO2TTI64hvT3RtHIokxpxQZA1E
	Tc7Wi+dU09u74DrjSHLUFedabHzl6PEsLJRr78lWot1p0GYbPscSGFxFldiF0nlkVNxibLzZqYnl1
	hbFW6Rag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEQQ-0004JK-G1; Thu, 17 Jan 2019 20:38:06 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENT-0000Pf-JY
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D57B1684;
 Thu, 17 Jan 2019 12:35:03 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40B333F819;
 Thu, 17 Jan 2019 12:35:01 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 16/25] KVM: arm64: Reject ioctl access to FPSIMD V-regs on
 SVE vcpus
Date: Thu, 17 Jan 2019 20:33:30 +0000
Message-Id: <1547757219-19439-17-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_123504_871491_05222029 
X-CRM114-Status: GOOD (  14.54  )
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

In order to avoid the pointless complexity of maintaining two ioctl
register access views of the same data, this patch blocks ioctl
access to the FPSIMD V-registers on vcpus that support SVE.

This will make it more straightforward to add SVE register access
support.

Since SVE is an opt-in feature for userspace, this will not affect
existing users.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kvm/guest.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 65f4338..ffa38d4 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -94,7 +94,14 @@ static int core_reg_size_from_offset(u64 off)
 	return -EINVAL;
 }
 
-static int validate_core_offset(const struct kvm_one_reg *reg)
+static bool core_reg_offset_is_vreg(u64 off)
+{
+	return off >= KVM_REG_ARM_CORE_REG(fp_regs.vregs) &&
+		off < KVM_REG_ARM_CORE_REG(fp_regs.fpsr);
+}
+
+static int validate_core_offset(const struct kvm_vcpu *vcpu,
+				const struct kvm_one_reg *reg)
 {
 	u64 off = core_reg_offset_from_id(reg->id);
 	int size = core_reg_size_from_offset(off);
@@ -102,10 +109,18 @@ static int validate_core_offset(const struct kvm_one_reg *reg)
 	if (size < 0)
 		return -EINVAL;
 
-	if (KVM_REG_SIZE(reg->id) == size)
-		return 0;
+	if (KVM_REG_SIZE(reg->id) != size)
+		return -EINVAL;
 
-	return -EINVAL;
+	/*
+	 * The KVM_REG_ARM64_SVE regs must be used instead of
+	 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
+	 * SVE-enabled vcpus:
+	 */
+	if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(off))
+		return -EINVAL;
+
+	return 0;
 }
 
 static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
@@ -127,7 +142,7 @@ static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
 		return -ENOENT;
 
-	if (validate_core_offset(reg))
+	if (validate_core_offset(vcpu, reg))
 		return -EINVAL;
 
 	if (copy_to_user(uaddr, ((u32 *)regs) + off, KVM_REG_SIZE(reg->id)))
@@ -152,7 +167,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
 		return -ENOENT;
 
-	if (validate_core_offset(reg))
+	if (validate_core_offset(vcpu, reg))
 		return -EINVAL;
 
 	if (KVM_REG_SIZE(reg->id) > sizeof(tmp))
@@ -205,7 +220,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return -EINVAL;
 }
 
-static int copy_core_reg_indices(u64 __user **uind)
+static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
+				 u64 __user **uind)
 {
 	unsigned int i;
 	int n = 0;
@@ -247,9 +263,9 @@ static int copy_core_reg_indices(u64 __user **uind)
 	return n;
 }
 
-static unsigned long num_core_regs(void)
+static unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
 {
-	return copy_core_reg_indices(NULL);
+	return copy_core_reg_indices(vcpu, NULL);
 }
 
 /**
@@ -314,7 +330,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 {
 	unsigned long res = 0;
 
-	res += num_core_regs();
+	res += num_core_regs(vcpu);
 	res += kvm_arm_num_sys_reg_descs(vcpu);
 	res += kvm_arm_get_fw_num_regs(vcpu);
 	res += NUM_TIMER_REGS;
@@ -331,7 +347,7 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
 	int ret;
 
-	ret = copy_core_reg_indices(&uindices);
+	ret = copy_core_reg_indices(vcpu, &uindices);
 	if (ret < 0)
 		return ret;
 
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
