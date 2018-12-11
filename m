Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D3CC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:33:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BB020672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oLyNEfQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BB020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=N8P7hf9+tHOWeEjWpVPkbx2VeTg4Qij0oqgGv+D9O6s=; b=oLyNEfQNQCho9IGPGvHLeEL0hS
	vkv5fiXYLUuYHrq1kT8ZRdFgdmvSs7AAmZl7ZHL4yrzdKO3kKqtx8fW6NyZEE5GrU7I4GFWoSFtzC
	7p0yKhN5x/63dL4p1yAJpdRDaMPYdMPxQ18oJRbYIBnKnRrchT3+iAEXQugjyvrwuC5y4sfuLMyTJ
	NdGMVASCakMHAm5Qgta8KfiNO3KsNXH1ca2aQVGqSPmvwJgW8Xs4WVB3qscvIAgAgzMWLT7pJN/GG
	j/erBAAcD9RuAWWz4r/3ut0NbHBSbNUGQTpHs0jTX+YeyUi7DW2djN9P8V9cjqYEXurV+gqiT46f7
	LLAy3WTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrWy-00088q-9W; Tue, 11 Dec 2018 23:33:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrTn-0004gh-BI
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22EA715AB;
 Tue, 11 Dec 2018 15:30:19 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7930B3F614;
 Tue, 11 Dec 2018 15:30:17 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 15/24] KVM: arm64: Reject ioctl access to FPSIMD V-regs
 on SVE vcpus
Date: Tue, 11 Dec 2018 23:28:52 +0000
Message-Id: <1544570941-7377-16-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153019_670983_0C181134 
X-CRM114-Status: GOOD (  16.47  )
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

In order to avoid the pointless complexity of maintaining two ioctl
register access views of the same data, this patch blocks ioctl
access to the FPSIMD V-registers on vcpus that support SVE.

This will make it more straightforward to add SVE register access
support.

Since SVE is an opt-in feature for userspace, this will not affect
existing users.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since RFC v2:

 * New patch

   The initial code was split from "KVM: arm64/sve: Add SVE support to
   register access ioctl interface".  However, some additional
   refactoring makes this change quite noisy: for ease of review,
   I decided it was best to keep the two parts of the change separate.

 * Move core_reg_offset_is_vreg() before validate_core_reg_id()
   (which now makes use of it).

 * Move rejection of KVM_REG_ARM_CORE view of the FPSIMD V-regs on
   SVE-enabled vcpus into validate_core_reg_id(), so that it can be
   applied everywhere appropriate instead of being open-coded.

   This requires vcpu to be pushed down into a few code paths
   (This is the noise alluded to above).
---
 arch/arm64/kvm/guest.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 0bf0ed3..e1ea73e 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -83,7 +83,13 @@ static int core_reg_size_from_offset(u64 off)
 	return -EINVAL;
 }
 
-static int validate_core_reg_id(u64 id)
+static bool core_reg_offset_is_vreg(u64 off)
+{
+	return off >= KVM_REG_ARM_CORE_REG(fp_regs.vregs) &&
+		off < KVM_REG_ARM_CORE_REG(fp_regs.fpsr);
+}
+
+static int validate_core_reg_id(const struct kvm_vcpu *vcpu, u64 id)
 {
 	u64 off = core_reg_offset_from_id(id);
 	int size = core_reg_size_from_offset(off);
@@ -91,10 +97,18 @@ static int validate_core_reg_id(u64 id)
 	if (size < 0)
 		return size;
 
-	if (KVM_REG_SIZE(id) == size && IS_ALIGNED(off, size / sizeof(__u32)))
-		return 0;
+	if (KVM_REG_SIZE(id) != size || !IS_ALIGNED(off, size / sizeof(__u32)))
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
@@ -116,7 +130,7 @@ static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
 		return -ENOENT;
 
-	if (validate_core_reg_id(reg->id))
+	if (validate_core_reg_id(vcpu, reg->id))
 		return -EINVAL;
 
 	if (copy_to_user(uaddr, ((u32 *)regs) + off, KVM_REG_SIZE(reg->id)))
@@ -141,7 +155,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
 		return -ENOENT;
 
-	if (validate_core_reg_id(reg->id))
+	if (validate_core_reg_id(vcpu, reg->id))
 		return -EINVAL;
 
 	if (KVM_REG_SIZE(reg->id) > sizeof(tmp))
@@ -194,7 +208,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return -EINVAL;
 }
 
-static int copy_core_reg_indices(u64 __user **uind)
+static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
+				 u64 __user **uind)
 {
 	unsigned int i;
 	int total = 0;
@@ -228,7 +243,7 @@ static int copy_core_reg_indices(u64 __user **uind)
 			break;
 		}
 
-		if (validate_core_reg_id(id))
+		if (validate_core_reg_id(vcpu, id))
 			continue;
 
 		if (uind) {
@@ -243,9 +258,9 @@ static int copy_core_reg_indices(u64 __user **uind)
 	return total;
 }
 
-static unsigned long num_core_regs(void)
+static unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
 {
-	return copy_core_reg_indices(NULL);
+	return copy_core_reg_indices(vcpu, NULL);
 }
 
 /**
@@ -310,7 +325,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 {
 	unsigned long res = 0;
 
-	res += num_core_regs();
+	res += num_core_regs(vcpu);
 	res += kvm_arm_num_sys_reg_descs(vcpu);
 	res += kvm_arm_get_fw_num_regs(vcpu);
 	res += NUM_TIMER_REGS;
@@ -327,7 +342,7 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
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
