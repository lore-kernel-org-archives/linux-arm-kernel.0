Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0207F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e7RiZrWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0207F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5nUrB8bt7IjlWde/P1AxCMd4VC7a+VUHri5ZOj99X14=; b=e7RiZrWzcudA8h/I/NprU/Z5rT
	wm/ZWGiy/irW1Ugvd9vmKo+at3bX19JZIlx4Y+bU198UN2eDyh1jB6iblV8AydlaBbFJZEPhKRzaO
	h+42NR22yjmnzcFlFC4kufTjl8+goAwRA4BU2IcEOfGvK43VUoQtoSTpclYqOXm2RsxIUQyVRV2mi
	BcLKVHWQ/5jx2yimZDoY4rgH0uFb9gtwPrs9CCSQVvJYVWol5MVM4gW4telpF+cmw+4JUyk+78F7+
	FPCJ/r/B11zka0ClCPxKT66NYjwl4LMUXfTIFqmuNrk3pw2qWhSkIoneKvhrekmfE1QboWgNJZVk4
	oWpKyeIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWq5-0007Ps-02; Fri, 18 Jan 2019 16:17:49 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWnx-0005ZN-8A
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:15:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC62D1650;
 Fri, 18 Jan 2019 08:15:36 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC4CA3F557;
 Fri, 18 Jan 2019 08:15:34 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 10/12] arm64: [HACK] Allow configuration of the guest's
 set of SVE vector lengths
Date: Fri, 18 Jan 2019 16:14:19 +0000
Message-Id: <1547828061-20462-11-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
References: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_081537_554395_C53CB13E 
X-CRM114-Status: GOOD (  15.98  )
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
 Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

By default, for each vcpu KVM enabled the same set of SVE vector
as supported by the host.

In order to allow a different set of vector lengths permitted (to
the extent supported by the SVE architecture), an option --sve-vqs
is added, which accepts a comma-separated list of vector lengths to
enable.

This options follows the "vq" convention, describing the vector
length as a multiple of 128-bit quadwords.  This is largely for
developer convenience and may be confusing for users.

Although KVM supports a different set of vector lengths to be
enabled on each vcpu, this patch provides no means to request such
a configuration for now.  Support could be added later, if desired.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arm/aarch64/include/kvm/kvm-config-arch.h |  5 ++
 arm/kvm-cpu.c                             | 80 +++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
index 7710f14..f0a7934 100644
--- a/arm/aarch64/include/kvm/kvm-config-arch.h
+++ b/arm/aarch64/include/kvm/kvm-config-arch.h
@@ -1,6 +1,8 @@
 #ifndef KVM__KVM_CONFIG_ARCH_H
 #define KVM__KVM_CONFIG_ARCH_H
 
+int sve_vls_parser(const struct option *opt, const char *arg, int unset);
+
 #define ARM_OPT_ARCH_RUN(cfg)						\
 	OPT_BOOLEAN('\0', "aarch32", &(cfg)->aarch32_guest,		\
 			"Run AArch32 guest"),				\
@@ -10,6 +12,9 @@
 		    "Enable SVE for the guest"),			\
 	OPT_BOOLEAN('\0', "show-reg-list", &(cfg)->show_reg_list,	\
 		    "Show the list of KVM register IDs on startup"),	\
+	OPT_CALLBACK('\0', "sve-vqs", NULL, "comma-separated list",	\
+		     "Override the SVE vector lengths supported",	\
+		     sve_vls_parser, NULL),				\
 	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
 			"Specify random seed for Kernel Address Space "	\
 			"Layout Randomization (KASLR)"),
diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
index 80e7b79..d3dfe2d 100644
--- a/arm/kvm-cpu.c
+++ b/arm/kvm-cpu.c
@@ -6,6 +6,72 @@
 #include "kvm/kvm.h"
 #include "kvm/kvm-cpu.h"
 
+static int vqs_set;
+static u64 sve_vq_map[8];
+
+static int add_vq(int vq)
+{
+	if (vq < 1 || vq > 512) {
+		fprintf(stderr, "%d: VQ out of range\n", vq);
+		return -1;
+	}
+
+	--vq;
+	sve_vq_map[vq / 64] |= (u64)1 << vq;
+	return 0;
+}
+
+int sve_vls_parser(const struct option *opt, const char *arg, int unset)
+{
+	int n = -1, val;
+	size_t offset = 0;
+
+	if (sscanf(arg + offset, "%i%n", &val, &n) < 1 || n < 0)
+		goto mismatch;
+
+	if (add_vq(val))
+		return -1;
+
+	offset += n;
+	while (1) {
+		n = -1;
+		if (sscanf(arg + offset, ",%i%n", &val, &n) < 1 && n < 0)
+			break;
+
+		if (add_vq(val))
+			return -1;
+
+		offset += n;
+	}
+
+mismatch:
+	if (arg[offset]) {
+		fprintf(stderr, "Bad set of vector lengths: %s\n", arg);
+		return -1;
+	}
+
+	vqs_set = -1;
+
+	return 0;
+}
+
+static int try_to_set_vqs(struct kvm_cpu const *vcpu)
+{
+	struct kvm_one_reg reg;
+
+	if (!vqs_set)
+		return 0; /* nothing to do */
+
+	reg.addr = (u64)&sve_vq_map;
+	reg.id = KVM_REG_ARM64_SVE_VLS;
+	if (ioctl(vcpu->vcpu_fd, KVM_SET_ONE_REG, &reg)) {
+		perror("KVM_SET_ONE_REG(KVM_REG_ARM64_SVE_VLS)");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int kvm_show_reg_list(struct kvm_cpu const *vcpu)
 {
 	int ret = -1;
@@ -263,9 +329,23 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
 	if (err || target->init(vcpu))
 		die("Unable to initialise vcpu");
 
+	if (kvm->cfg.arch.show_reg_list)
+		kvm_show_sve_info(vcpu);
+
+	if (try_to_set_vqs(vcpu))
+		die("SVE vector length configuration failed");
+
 	if (kvm->cfg.arch.show_reg_list) {
+		puts("After setting SVE vector lengths:");
 		kvm_show_sve_info(vcpu);
+
 		kvm_show_reg_list(vcpu);
+
+		if (!try_to_set_vqs(vcpu)) {
+			if (vqs_set)
+				die("SVE vector length configuration after KVM_GET_REG_LIST succeeded unexpectedly");
+		} else
+			puts("(as expected)");
 	}
 
 	coalesced_offset = ioctl(kvm->sys_fd, KVM_CHECK_EXTENSION,
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
