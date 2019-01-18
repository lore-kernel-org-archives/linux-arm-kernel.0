Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C35C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C985320850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WM/ch75a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C985320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=905ovPyXRBAbxuEsVZka9R5Q+uFkx94neL4hVUBNSO4=; b=WM/ch75apkQ0dGjkJTydpbvwsv
	9HBliY+bg0ZTqozaBS+heUVLKgEos5hODqpSk64s4Q07ZHJQclqenELhXhd5RXufaJTGONvvP41vA
	6oVH8X5wDfEFZVqym+D1ZxyFtchDpI0y+LS0K22yjfAtUalWxcKPKpevqAFwa8tz76wr1ghYPZIw/
	qCVQNwfs2qo9WUTrPEeO5KpaOK1NDxeVDjF68tS71eTChMH302lmwMNQlISMvBFwvRWSH5SDQ4gDQ
	Ep3q+Ho4mFHi609KdCdeczWWTOsumuZbjbwBDS6zg/96apCsLxA+JjrxFSm5KfbUpbZ2Z7nI82Szm
	hwIaUGhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWpI-0006bG-0u; Fri, 18 Jan 2019 16:17:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWnr-0005S4-1N
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:15:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B9C41684;
 Fri, 18 Jan 2019 08:15:30 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B9443F557;
 Fri, 18 Jan 2019 08:15:28 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 07/12] arm64: [HACK] Add option to show the kernel's KVM
 register ID list
Date: Fri, 18 Jan 2019 16:14:16 +0000
Message-Id: <1547828061-20462-8-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
References: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_081532_163985_D457CC44 
X-CRM114-Status: GOOD (  13.89  )
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

To assist with testing and debugging the behaviour of
KVM_GET_REG_LIST, this patch adds a crude option --show-reg-list to
print out the list of register IDs reported by the kernel on vcpu
startup.

This is a development hack only and not currently friendly (or
useful) for users.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arm/aarch64/include/kvm/kvm-config-arch.h |  2 ++
 arm/include/arm-common/kvm-config-arch.h  |  1 +
 arm/kvm-cpu.c                             | 50 +++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
index 04be43d..cb3f8bc 100644
--- a/arm/aarch64/include/kvm/kvm-config-arch.h
+++ b/arm/aarch64/include/kvm/kvm-config-arch.h
@@ -6,6 +6,8 @@
 			"Run AArch32 guest"),				\
 	OPT_BOOLEAN('\0', "pmu", &(cfg)->has_pmuv3,			\
 			"Create PMUv3 device"),				\
+	OPT_BOOLEAN('\0', "show-reg-list", &(cfg)->show_reg_list,	\
+		    "Show the list of KVM register IDs on startup"),	\
 	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
 			"Specify random seed for Kernel Address Space "	\
 			"Layout Randomization (KASLR)"),
diff --git a/arm/include/arm-common/kvm-config-arch.h b/arm/include/arm-common/kvm-config-arch.h
index 6a196f1..f18bfd4 100644
--- a/arm/include/arm-common/kvm-config-arch.h
+++ b/arm/include/arm-common/kvm-config-arch.h
@@ -9,6 +9,7 @@ struct kvm_config_arch {
 	bool		virtio_trans_pci;
 	bool		aarch32_guest;
 	bool		has_pmuv3;
+	bool		show_reg_list;
 	u64		kaslr_seed;
 	enum irqchip_type irqchip;
 };
diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
index 7780251..38a071b 100644
--- a/arm/kvm-cpu.c
+++ b/arm/kvm-cpu.c
@@ -1,6 +1,53 @@
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+
 #include "kvm/kvm.h"
 #include "kvm/kvm-cpu.h"
 
+static int kvm_show_reg_list(struct kvm_cpu const *vcpu)
+{
+	int ret = -1;
+	struct kvm_reg_list regs, *pregs = NULL;
+	u64 i;
+
+	regs.n = 0;
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_REG_LIST, &regs) && errno != E2BIG) {
+		perror("KVM_GET_REG_LIST");
+		goto error;
+	}
+
+	pregs = malloc(((char *)&pregs->reg[0] - (char *)pregs) +
+		       regs.n * sizeof(pregs->reg[0]));
+	if (!pregs) {
+		errno = ENOMEM;
+		perror(NULL);
+		goto error;
+	}
+
+	pregs->n = regs.n;
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_REG_LIST, pregs)) {
+		perror("KVM_GET_REG_LIST");
+		goto error;
+	}
+
+	fflush(stdout);
+
+	printf("Register list for cpu 0x%lx:\n", vcpu->cpu_id);
+
+	for (i = 0; i < pregs->n; ++i)
+		printf("\treg[%lu]:\t0x%.16lx\n",
+		       (unsigned long)i, (unsigned long)pregs->reg[i]);
+
+	putchar('\n');
+
+	fflush(stdout);
+
+error:
+	free(pregs);
+	return ret;
+}
+
 static int debug_fd;
 
 void kvm_cpu__set_debug_fd(int fd)
@@ -109,6 +156,9 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
 	if (err || target->init(vcpu))
 		die("Unable to initialise vcpu");
 
+	if (kvm->cfg.arch.show_reg_list)
+		kvm_show_reg_list(vcpu);
+
 	coalesced_offset = ioctl(kvm->sys_fd, KVM_CHECK_EXTENSION,
 				 KVM_CAP_COALESCED_MMIO);
 	if (coalesced_offset)
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
