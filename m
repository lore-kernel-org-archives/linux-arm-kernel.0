Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F457C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:17:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41A920811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z7zmg3gL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41A920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LnCnH6s9aJxLvxWn8Byhjef7X+Tow3VIEgCLtJUVEGI=; b=Z7zmg3gL9v7J/4
	xIHYZp96J6lS1ZvFSVWxsgKHEOvKk6RV/xlnkhQzmXD3HK/nVoq0op/tSKSzuA9+y+fNTzId872VH
	iJxqIEftPS/CFlki685mesK1A8MewFPyfZ4RbxKMLFxcDKF/x+ZchFB4JR5gyFjFJSHVHmbLvvd12
	Nrre9bvL/SACdI00s5YB6qpKBD2ysKipNVJgSwtqVe+SZUqG3SyzGDWoC4kbc8os/vNeu3il1een9
	kP69bxd9AUPSdwaqGehNP1mP8lR9AVB9Zs33AHq8Hc/D8L6GJAgdi6dJNdP0NC6lxBV+tsWbSwsNs
	518IA/4YakOFIoVsCGUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXkXH-00033w-Hr; Fri, 14 Dec 2018 10:17:35 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXkXE-000325-HE
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 10:17:34 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B09C8A91BF2DF;
 Fri, 14 Dec 2018 18:17:12 +0800 (CST)
Received: from ros.huawei.com (10.143.28.118) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 18:17:10 +0800
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <peter.maydell@linaro.org>, <rkrcmar@redhat.com>, <corbet@lwn.net>,
 <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
 <catalin.marinas@arm.com>, <will.deacon@arm.com>, <kvm@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
Date: Fri, 14 Dec 2018 02:15:37 -0800
Message-ID: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.143.28.118]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_021732_738316_DA56367A 
X-CRM114-Status: UNSURE (   9.97  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When user space do memory recovery, it will check whether KVM and
guest support the error recovery, only when both of them support,
user space will do the error recovery. This patch exports this
capability of KVM to user space.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
User space needs to check this capability of KVM is suggested by Peter[1],
this patch as RFC tag because user space patches are still under review,
so this kernel patch is firstly sent out for review.

[1]: https://patchwork.codeaurora.org/patch/652261/
---
 Documentation/virtual/kvm/api.txt | 9 +++++++++
 arch/arm64/kvm/reset.c            | 1 +
 include/uapi/linux/kvm.h          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index cd209f7..241e2e2 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4895,3 +4895,12 @@ Architectures: x86
 This capability indicates that KVM supports paravirtualized Hyper-V IPI send
 hypercalls:
 HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
+
+8.21 KVM_CAP_ARM_MEMORY_ERROR_RECOVERY
+
+Architectures: arm, arm64
+
+This capability indicates that guest memory error can be detected by the KVM which
+supports the error recovery. When user space do recovery, such as QEMU, it will
+check whether KVM and guest support memory error recovery, only when both of them
+support, user space will do the error recovery.
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index b72a3dd..90d1d9a 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -82,6 +82,7 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = kvm_arm_support_pmu_v3();
 		break;
 	case KVM_CAP_ARM_INJECT_SERROR_ESR:
+	case KVM_CAP_ARM_MEMORY_ERROR_RECOVERY:
 		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2b7a652..3b19580 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -975,6 +975,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
+#define KVM_CAP_ARM_MEMORY_ERROR_RECOVERY 166
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
