Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91484C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:34:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBEF20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="njtUgGBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBEF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KVctkDXquD/M5kAywkkRgvz2npgHX7AOdgyLoHfFZTY=; b=njtUgGBdK5eqpyBdsV0pttHEUV
	n9pHQtUBAg62LFMukzsXlS2bW/thcOeSnrq1UZGYlI0fi9L1cDyeiKVirhuSVYmw1atQzbi2LcVbH
	TIUTdmPDvpO8+dZj31wWicJRhl60hLRSnfl2FMk2bvnsoyhgD0rPegHqPTnp2qP0Rh2uqwYyR8Pms
	3sRlEHmk3DxjwB69AIBqfPLwHdhsY6eAtHbVE0ax6pU9aObZ1OlWYUcY1+qZwkKkQLhLfW1uVavAj
	BwoJ0+BlsUnCegMe+0umNfgiiV5QuGS10Fdt+AXBHbnUme0lcEa+8GQwtEeAcad0Hiz1LZDm/G7k6
	jw0JHxhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrXh-00006E-7y; Tue, 11 Dec 2018 23:34:21 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrTw-0004QH-Rl
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5CE980D;
 Tue, 11 Dec 2018 15:30:28 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 082383F614;
 Tue, 11 Dec 2018 15:30:26 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 20/24] KVM: arm: Add support for early vcpu
 configuration ioctls
Date: Tue, 11 Dec 2018 23:28:57 +0000
Message-Id: <1544570941-7377-21-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153029_695109_92217C42 
X-CRM114-Status: GOOD (  14.47  )
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

SVE will require the KVM_ARM_SVE_CONFIG ioctl to be used early to
configure a vcpu before other arch vcpu ioctls will behave in a
consistent way.

To hide these effects from userspace while minimising mess in the
generic code, this patch splits arch vcpu ioctls into two phases:
early configuration ioctls, and normal ioctls.  A new arch helper
vcpu_needs_configuration() reports whether any arch vcpu ioctls
other than early configuration ioctls are allowed.

This entire behaviour will be need to be opt-in for userspace.

There are currently no early configuration ioctls; one will be
added for SVE in a subsequent patch, along with a suitable opt-in
mechanism.

It is assumed that no core vcpu ioctls are affected by any of the
early configuration we want to do.  In any case, most "generic"
vcpu ioctls are stubbed out for arm/arm64 and return -EINVAL.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since RFC v2:

 * New patch.

   **Discussion required**

   This patch splits arch vcpu ioctls into two phases.  We will
   almost certainly need to do something like this for SVE, since
   until the vector lengths are configured we will be in some kind
   of half-initialised state where most ioctls (in particular
   KVM_GET_REG_LIST, KVM_RUN etc.) cannot be used.

   This is a bit inelegant, and does not interact nicely with
   the core KVM core: we have to assume that all the core vcpu
   ioctls are "harmless" while a vcpu is half-initialised, or
   stubbed out (which seems to be the case for many of the core
   vcpu ioctls on arm/arm64).

   The choice of error codes here may not be ideal.  We should
   try to avoid picking anything that could be confused with other
   error situations.
---
 arch/arm/include/asm/kvm_host.h   | 3 +++
 arch/arm64/include/asm/kvm_host.h | 3 +++
 virt/kvm/arm/arm.c                | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 8d385ec..d61077c 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -365,4 +365,7 @@ static inline int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long *type)
 	return 0;
 }
 
+/* Forbid "ordinary" vcpu ioctls if this returns true: */
+#define vcpu_needs_configuration(vcpu) false
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9fd8729..7599c70 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -536,4 +536,7 @@ void kvm_arch_free_vm(struct kvm *kvm);
 
 int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long *type);
 
+/* Forbid "ordinary" vcpu ioctls if this returns true: */
+#define vcpu_needs_configuration(vcpu) false
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index f7bf43a..7bfc06d 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1090,6 +1090,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	struct kvm_device_attr attr;
 	long r;
 
+	/* Early configuration ioctls will be handled here */
+
+	/* Other ioctls require configuration to have been done first: */
+	if (vcpu_needs_configuration(vcpu))
+		return -EBADFD;
+
 	switch (ioctl) {
 	case KVM_ARM_VCPU_INIT: {
 		struct kvm_vcpu_init init;
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
