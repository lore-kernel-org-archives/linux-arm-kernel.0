Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE063C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB65C20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YLLlMwcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB65C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/pv0X5/Xv0/Xn3wTvyD5OdsEKvd6UJGd8RSRWYIby8I=; b=YLLlMwcXaMruZvI99EkOKsjIXM
	7vh8ffYOLv6lZOXi5dVThDJWBhI+ihZoCzXQLPtc4bgaeOM62dr57x26P4iEx3Z2gZrEfp+++Sx8n
	4U57Nkzd+lBRjQg7ER4ScHHFaLJ6lX9t4pZSH9/0V/XR3Ys3VfoiLdxgRTv9Ru2wskXaQe9viKjzD
	XthhgeXCGqj36q6aUVTGrWUVeFden3Py3oKDpo/nq/ySA3B127i/jTrWMYS1IBEntyVR1xYtJu54B
	f9NyjRnYw+hIAFml0H1/JJIL05ZIWDFgdK4AAchwiV8Jk67j5PLOHtkjdXCxL6qUIh81WK7ms3q/t
	c/yS+wfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrYK-0000kN-5n; Tue, 11 Dec 2018 23:35:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrU0-0005Ln-Pp
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78B6A1684;
 Tue, 11 Dec 2018 15:30:32 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF2443F614;
 Tue, 11 Dec 2018 15:30:30 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 22/24] KVM: arm64/sve: allow KVM_ARM_SVE_CONFIG_QUERY
 on vm fd
Date: Tue, 11 Dec 2018 23:28:59 +0000
Message-Id: <1544570941-7377-23-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153033_209914_C9D530A1 
X-CRM114-Status: GOOD (  14.03  )
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

Since userspace may need to decide on the set of vector lengths for
the guest before setting up a vm, it is onerous to require a vcpu
fd to be available first.  KVM_ARM_SVE_CONFIG_QUERY is not
vcpu-dependent anyway, so this patch wires up KVM_ARM_SVE_CONFIG to
be usable on a vm fd where appropriate.

Subcommands that are vcpu-dependent (currently
KVM_ARM_SVE_CONFIG_SET, KVM_ARM_SVE_CONFIG_GET) will return -EINVAL
if invoked on a vm fd.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since RFC v2:

 * Removed the arch vm ioctl hook in favour of
   kvm_arm_vcpu_sve_config(NULL, ...).
---
 arch/arm64/kvm/guest.c | 7 +++++++
 virt/kvm/arm/arm.c     | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index ffb2a25..85a112c 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -675,6 +675,9 @@ static int kvm_vcpu_set_sve_vls(struct kvm_vcpu *vcpu, struct kvm_sve_vls *vls,
 	unsigned int vq, max_vq;
 	int ret;
 
+	if (!vcpu)
+		return -EINVAL; /* per-vcpu operation on vm fd */
+
 	if (vcpu->arch.has_run_once || vcpu_sve_config_done(vcpu))
 		return -EBADFD; /* too late, or already configured */
 
@@ -769,6 +772,9 @@ static int kvm_vcpu_query_sve_vls(struct kvm_vcpu *vcpu, struct kvm_sve_vls *vls
 static int kvm_vcpu_get_sve_vls(struct kvm_vcpu *vcpu, struct kvm_sve_vls *vls,
 		struct kvm_sve_vls __user *userp)
 {
+	if (!vcpu)
+		return -EINVAL; /* per-vcpu operation on vm fd */
+
 	if (!vcpu_sve_config_done(vcpu))
 		return -EBADFD; /* not configured yet */
 
@@ -778,6 +784,7 @@ static int kvm_vcpu_get_sve_vls(struct kvm_vcpu *vcpu, struct kvm_sve_vls *vls,
 			sve_vq_from_vl(vcpu->arch.sve_max_vl), userp);
 }
 
+/* vcpu may be NULL if this is called via a vm fd */
 int kvm_arm_vcpu_sve_config(struct kvm_vcpu *vcpu,
 			    struct kvm_sve_vls __user *userp)
 {
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index cafd701..0f92d54 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1286,6 +1286,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
 		return 0;
 	}
+	case KVM_ARM_SVE_CONFIG:
+		return kvm_arm_vcpu_sve_config(NULL, argp);
+
 	default:
 		return -EINVAL;
 	}
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
