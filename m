Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5D120850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IS8MWLmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5D120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HKVjoJRjsI4btLpkCH59ShA/+xTb3ThiAQVSSvJSEao=; b=IS8MWLmu0/e/McLRsNLCeX9bi3
	7aXH0cLTTXM8k24Dil5/MHsUOqebFxoyGu6Ijn7T2k8eNVMQF0olpL1PyTL0xvU1MfdF3MJL0FIhg
	4sGXZr0j3+IBIjOBEvz1yM5IEjPBtowyQpRm7JPamItXmIMoMjo/3qEFyQ9tlLfHSQmQoIvV07S8R
	iDUI3aA4r15liWaU/oB52rTXbR3i0G76+EN7MI3K5G2E0w6u+NYySzzknOn0Jhq67mmIXh+oG5T5s
	T106JfaLHKumsyhD4ZdZsNnnJNzXt+GspObOWZub03H7Se32bVPWBGz8AD3+83sS9rnneSPgLR7tB
	8sZCxY+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWpp-00079m-9b; Fri, 18 Jan 2019 16:17:33 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWnu-0005X2-Rb
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:15:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C1F21596;
 Fri, 18 Jan 2019 08:15:34 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BD333F557;
 Fri, 18 Jan 2019 08:15:32 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 09/12] arm64: [HACK] Show extra info about SVE with
 --show-reg-list
Date: Fri, 18 Jan 2019 16:14:18 +0000
Message-Id: <1547828061-20462-10-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
References: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_081535_440216_BC89BABF 
X-CRM114-Status: GOOD (  15.89  )
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

This patch prints out some information about the SVE configuration
when --show-reg=list is passed.

This is development hack only (as well as being an abuse of the
purpose of that option).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arm/kvm-cpu.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
index 38a071b..80e7b79 100644
--- a/arm/kvm-cpu.c
+++ b/arm/kvm-cpu.c
@@ -1,3 +1,4 @@
+#include <assert.h>
 #include <errno.h>
 #include <stddef.h>
 #include <stdio.h>
@@ -48,6 +49,112 @@ error:
 	return ret;
 }
 
+static int kvm_show_sve_info(struct kvm_cpu const *vcpu)
+{
+	int ret = 0;
+	u64 val;
+	struct kvm_one_reg r;
+	int have_sve;
+	u64 vls[9];
+	unsigned int i;
+
+	r.addr = (u64)&val;
+
+	r.id = ARM64_SYS_REG(3, 0, 0, 4, 0); /* ID_AA64PFR0_EL1 */
+	assert((r.id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64);
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &r)) {
+		perror("KVM_GET_ONE_REG(ID_AA64PFR0_EL1)");
+		goto error;
+	}
+
+	printf("ID_AA64PFR0_EL1:\t0x%lx\n", (unsigned long)val);
+
+	have_sve = !!((val >> 32) & 0xf);
+
+	r.id = ARM64_SYS_REG(3, 0, 0, 4, 4);
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &r)) {
+		if (errno != ENOENT || have_sve) {
+			perror("KVM_GET_ONE_REG(ID_AA64ZFR0_EL1)");
+			ret = -1;
+		}
+	} else {
+		if (!have_sve) {
+			puts("ID_AA64ZFR0_EL1 unexpectedly present");
+			ret = -1;
+		}
+
+		printf("ID_AA64ZFR0_EL1:\t0x%lx\n", (unsigned long)val);
+	}
+
+	r.id = ARM64_SYS_REG(3, 0, 1, 2, 0);
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &r)) {
+		if (errno != ENOENT || have_sve) {
+			perror("KVM_GET_ONE_REG(ZCR_EL1)");
+			ret = -1;
+		}
+	} else {
+		if (!have_sve) {
+			puts("ZCR_EL1 unexpectedly present");
+			ret = -1;
+		}
+
+		printf("ZCR_EL1:\t0x%lx\n", (unsigned long)val);
+	}
+
+	r.addr = (u64)&vls;
+	r.id = KVM_REG_ARM64_SVE_VLS;
+	assert(8 * (sizeof(vls) - sizeof(*vls)) == 512 &&
+	       (r.id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U512);
+
+	/*
+	 * Write some canary data so we can see that the kernel writes
+	 * the expected amount:
+	 */
+	for (i = 0; i < sizeof(vls) / sizeof(*vls); ++i)
+		vls[i] = -7;
+
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &r)) {
+		if (errno != ENOENT || have_sve) {
+			perror("KVM_GET_ONE_REG(KVM_REG_ARM64_SVE_VLS)");
+			ret = -1;
+		}
+	} else {
+		char const *prefix = "";
+
+		if (!have_sve) {
+			puts("KVM_REG_ARM64_SVE_VLS unexpectedly present");
+			ret = -1;
+		}
+
+		if (vls[7] == (u64)-7) {
+			puts("KVM_REG_ARM64_SVE_VLS short read?");
+			ret = -1;
+		}
+
+		if (vls[8] != (u64)-7) {
+			puts("KVM_REG_ARM64_SVE_VLS overrun?");
+			ret = -1;
+		}
+
+		fputs("SVE VQs: ", stdout);
+
+		for (i = 0; i < 512; ++i)
+			if ((vls[i / 64] >> (i % 64)) & 1) {
+				printf("%s%lu", prefix, (unsigned long)i + 1);
+				prefix = ",";
+			}
+
+		putchar('\n');
+	}
+
+	fflush(stdout);
+
+	return ret;
+
+error:
+	return -1;
+}
+
 static int debug_fd;
 
 void kvm_cpu__set_debug_fd(int fd)
@@ -156,8 +263,10 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
 	if (err || target->init(vcpu))
 		die("Unable to initialise vcpu");
 
-	if (kvm->cfg.arch.show_reg_list)
+	if (kvm->cfg.arch.show_reg_list) {
+		kvm_show_sve_info(vcpu);
 		kvm_show_reg_list(vcpu);
+	}
 
 	coalesced_offset = ioctl(kvm->sys_fd, KVM_CHECK_EXTENSION,
 				 KVM_CAP_COALESCED_MMIO);
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
