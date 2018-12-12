Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F5C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:18:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5A92080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j62cey/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5A92080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CL2xVSIanacKbs76Ma+9G9HlBRNM8Uc/Fo63i3mddis=; b=j62cey/UY9WFgW72kO8YSuU08f
	RCCYpWKqwVQxuI2y7X76I5hGK6fnuFl0UixIgfwXOdtWJahgeY/ipeyuZrIDAN+MxcR5lU4X0PczQ
	8bCX+Ar6kH0Q2YWFY1+GQTXB3T3dILGT/Q3JSVp+SsDlXm6mEDFYLHMlSM9nEDTv/Eqjf6wv8LqEk
	M6VFPsWrd/xQvoYlg80lzcsNPm2TMEmVNN6hy/4TxbnDfH0l9hWjWXBUQjIFRaOb9V5bKBPSt8DGu
	Dx9qsbbk7TnESsQkZiOD4ZYpbfoviDkxfFeIQGFyxOQ6nMoYctna2aR5gJL++/BhPCe83ZdFzOIOC
	c+R29jhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXAxa-00041y-8j; Wed, 12 Dec 2018 20:18:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXAxL-0003oV-JN
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 20:18:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8277D15AD;
 Wed, 12 Dec 2018 12:17:57 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 96D7E3F59C;
 Wed, 12 Dec 2018 12:17:56 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 2/2] KVM: arm64: Factor out KVM_GET_REG_LIST core register
 enumeration
Date: Wed, 12 Dec 2018 20:17:04 +0000
Message-Id: <1544645824-16461-3-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544645824-16461-1-git-send-email-Dave.Martin@arm.com>
References: <1544645824-16461-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_121807_638788_E1176E77 
X-CRM114-Status: GOOD (  14.61  )
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
 Peter Maydell <peter.maydell@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, enumeration of the core register IDs for
KVM_GET_REG_LIST is open-coded in kvm_arm_copy_reg_indices().

This will become cumbersome as the enumeration logic becomes more
complex.  In preparation for future patches, this patch factors the
code out into a separate function copy_core_reg_indices(),
consistently with the way other classes of registers are handled.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kvm/guest.c | 65 ++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index cbe423b..46eb867 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -205,23 +205,53 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return -EINVAL;
 }
 
-static unsigned long num_core_regs(void)
+static int copy_core_reg_indices(u64 __user **uind)
 {
 	unsigned int i;
 	int n = 0;
 
 	for (i = 0; i < sizeof(struct kvm_regs) / sizeof(__u32); i++) {
+		u64 reg = KVM_REG_ARM64 | KVM_REG_ARM_CORE | i;
 		int size = core_reg_size_from_offset(i);
 
 		if (size < 0)
 			continue;
 
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
+		if (uind) {
+			if (put_user(reg, *uind))
+				return -EFAULT;
+			++*uind;
+		}
+
 		n++;
 	}
 
 	return n;
 }
 
+static unsigned long num_core_regs(void)
+{
+	return copy_core_reg_indices(NULL);
+}
+
 /**
  * ARM64 versions of the TIMER registers, always available on arm64
  */
@@ -293,38 +323,11 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
  */
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
-	unsigned int i;
 	int ret;
 
-	for (i = 0; i < sizeof(struct kvm_regs) / sizeof(__u32); i++) {
-		u64 reg = KVM_REG_ARM64 | KVM_REG_ARM_CORE | i;
-		int size = core_reg_size_from_offset(i);
-
-		if (size < 0)
-			continue;
-
-		switch (size) {
-		case sizeof(__u32):
-			reg |= KVM_REG_SIZE_U32;
-			break;
-
-		case sizeof(__u64):
-			reg |= KVM_REG_SIZE_U64;
-			break;
-
-		case sizeof(__uint128_t):
-			reg |= KVM_REG_SIZE_U128;
-			break;
-
-		default:
-			WARN_ON(1);
-			continue;
-		}
-
-		if (put_user(reg, uindices))
-			return -EFAULT;
-		uindices++;
-	}
+	ret = copy_core_reg_indices(&uindices);
+	if (ret < 0)
+		return ret;
 
 	ret = kvm_arm_copy_fw_reg_indices(vcpu, uindices);
 	if (ret)
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
