Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF87C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:57:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFE6217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t4PGnkwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFE6217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2v4afn66RyEG65pB/yEJf6JriM4W00oY2xYq7N7Mp8Q=; b=t4PGnkwGnHOHtbS3QpW84X98AX
	r1MVynchVYhPQ78qZhI4eYwB5NDJkmev4MRMGNrRbPxcUuR2FIajsQlyNCx8mGQz1xT4SzeVXhAuW
	JsYcFsotMINUBrgVu+Yr14qLmVPSkfMA2HT3ZKeQYo3QVEGWRlpeeOKcTN34OnnQiLyZYLsE1gWXI
	fqPr1sBjeYXg3bpTsTepHM2UOgSiou/WN6unI0pOxfFvWLC2Fxqd4BnBN5Bd1zGG77utustcvNOaI
	yYZxv2WTYoEg8ZCIwA6ptPvfqQj+X59NCgxxUOwsiba/u0eqYrU0tJdymOP5umcjA+0tjyjYH7e1E
	gnDpZJwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp2N-0000SJ-R4; Mon, 18 Feb 2019 19:57:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozs-00055H-9h
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:54:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 372C11DC8;
 Mon, 18 Feb 2019 11:54:30 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 440253F740;
 Mon, 18 Feb 2019 11:54:08 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 19/26] KVM: arm64: Enumerate SVE register indices for
 KVM_GET_REG_LIST
Date: Mon, 18 Feb 2019 19:52:32 +0000
Message-Id: <1550519559-15915-20-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_115436_363360_40B1A695 
X-CRM114-Status: GOOD (  16.17  )
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
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Julien Grall <julien.grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch includes the SVE register IDs in the list returned by
KVM_GET_REG_LIST, as appropriate.

On a non-SVE-enabled vcpu, no new IDs are added.

On an SVE-enabled vcpu, IDs for the FPSIMD V-registers are removed
from the list, since userspace is required to access the Z-
registers instead to access their context.  For the variably-sized
SVE registers, the appropriate set of slice IDs are enumerated,
depending on the maximum vector length for the vcpu.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since v4:

 * Drop KVM_SVE_SLICES(), which is no longer used due to the dropping of
   register multi-slice support from the series.

 * Drop register multi-slice support.
---
 arch/arm64/kvm/guest.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 8cfa889..4a2ad60 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -366,6 +366,14 @@ static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
 			continue;
 		}
 
+		/*
+		 * The KVM_REG_ARM64_SVE regs must be used instead of
+		 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
+		 * SVE-enabled vcpus:
+		 */
+		if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(i))
+			continue;
+
 		if (uind) {
 			if (put_user(reg, *uind))
 				return -EFAULT;
@@ -436,6 +444,44 @@ static int get_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)) ? -EFAULT : 0;
 }
 
+static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
+{
+	/* Only the first slice ever exists, for now */
+	const unsigned int slices = 1;
+
+	if (!vcpu_has_sve(vcpu))
+		return 0;
+
+	return slices * (SVE_NUM_PREGS + SVE_NUM_ZREGS + 1 /* FFR */);
+}
+
+static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu, u64 __user **uind)
+{
+	/* Only the first slice ever exists, for now */
+	const unsigned int slices = 1;
+	unsigned int i, n;
+
+	if (!vcpu_has_sve(vcpu))
+		return 0;
+
+	for (i = 0; i < slices; i++) {
+		for (n = 0; n < SVE_NUM_ZREGS; n++) {
+			if (put_user(KVM_REG_ARM64_SVE_ZREG(n, i), (*uind)++))
+				return -EFAULT;
+		}
+
+		for (n = 0; n < SVE_NUM_PREGS; n++) {
+			if (put_user(KVM_REG_ARM64_SVE_PREG(n, i), (*uind)++))
+				return -EFAULT;
+		}
+
+		if (put_user(KVM_REG_ARM64_SVE_FFR(i), (*uind)++))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 /**
  * kvm_arm_num_regs - how many registers do we present via KVM_GET_ONE_REG
  *
@@ -446,6 +492,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 	unsigned long res = 0;
 
 	res += num_core_regs(vcpu);
+	res += num_sve_regs(vcpu);
 	res += kvm_arm_num_sys_reg_descs(vcpu);
 	res += kvm_arm_get_fw_num_regs(vcpu);
 	res += NUM_TIMER_REGS;
@@ -466,6 +513,10 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 	if (ret < 0)
 		return ret;
 
+	ret = copy_sve_reg_indices(vcpu, &uindices);
+	if (ret)
+		return ret;
+
 	ret = kvm_arm_copy_fw_reg_indices(vcpu, uindices);
 	if (ret)
 		return ret;
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
