Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2ACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:18:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5C32086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jRxx4weu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5C32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Urbmv7egD+VaZ6mDpbNIpcbvrYWlP/ellEZIADIXAyE=; b=jRxx4weuAYau8kQdw5wGFrDm1l
	9CrQCoN4jwiC48sAWtqW0fprUiKr7Bsnx68YgHSQb/DcWoIwjiFDtJXbBaeGk5cUGRlLDPK/8gqWT
	qjyLIFgsqTZWIz7PH+BK+w4zsviAp2RxO9GINvhSKZmlXTpCvnsFKVPYgNYRAZBcUbTl5+p9zaG0M
	dwkmIfwvmZ2pLw9sbA6tRR0YddXfKjeXxt44LlzSW74mTpGnQ3qGi+zPv+RW8o54XBOwLfn+/clJF
	ykmnwkSsswLFu+ZIRF0BBeA7GxN1ZoSbPj3JwGTHlYvw4W5/B1EbotCiLkiYTw98y2bdosLkPJRSC
	qn/Et0Hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWqK-0007ew-Tx; Fri, 18 Jan 2019 16:18:04 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWnz-0005bX-6U
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:15:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD075165C;
 Fri, 18 Jan 2019 08:15:38 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC6C93F557;
 Fri, 18 Jan 2019 08:15:36 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 11/12] arm64: [HACK] FPSIMD/SVE register dumping for lkvm
 debug
Date: Fri, 18 Jan 2019 16:14:20 +0000
Message-Id: <1547828061-20462-12-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
References: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_081539_669186_5B4E71FE 
X-CRM114-Status: GOOD (  14.39  )
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

To assist with debugging, and to exercise the KVM_{GET,SET}_ONE_REG
interface extensions for SVE, this patch adds code to dump the full
contents of the SVE and/or FPSIMD registers when triggered using
lkvm debug -d.

This is a giant ugly hack and also slow (even with hacks to reduce
the number of dprintf() calls).

Due to a lack of buffering on one or both ends of the guest socket
connection, dumping the vcpu that's running on the same CPU as lkvm
debug seems to cause a lot of context switch thrashing also, but no
attempt has been made to address this here, since this patch is
in any case rather abusing the guest socket.  If we want to do
something like this for real, some more careful thought about how
to optimise the protocol is needed.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arm/aarch64/kvm-cpu.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/arm/aarch64/kvm-cpu.c b/arm/aarch64/kvm-cpu.c
index 0aaefaf..28c5010 100644
--- a/arm/aarch64/kvm-cpu.c
+++ b/arm/aarch64/kvm-cpu.c
@@ -2,6 +2,10 @@
 #include "kvm/kvm.h"
 #include "kvm/virtio.h"
 
+#include <assert.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <string.h>
 #include <asm/ptrace.h>
 
 #define COMPAT_PSR_F_BIT	0x00000040
@@ -197,11 +201,128 @@ void kvm_cpu__show_code(struct kvm_cpu *vcpu)
 	kvm__dump_mem(vcpu->kvm, data, 32, debug_fd);
 }
 
+static void sappendf(char **p, size_t *size, char const *format, ...)
+{
+	va_list vl;
+	int n;
+
+	va_start(vl, format);
+	n = vsnprintf(*p, *size, format, vl);
+	va_end(vl);
+
+	if (n < 0 || (unsigned)n >= *size)
+		die("sappendf buffer too small");
+
+	*p += n;
+	*size -= n;
+}
+
+static void sappend_bytes(char **p, size_t *size,
+			   void const *bytes, size_t nbytes)
+{
+	unsigned char const *b = bytes;
+
+	while (nbytes--)
+		sappendf(p, size, "%.2x", *b++);
+}
+
+static void show_sve_zn_slice(int debug_fd, struct kvm_cpu const *vcpu,
+			      unsigned int n, unsigned int i)
+{
+	struct kvm_one_reg reg;
+	char bytes[256];
+	char str[2 * sizeof bytes + 9], *strp;
+	size_t strsz;
+
+	reg.id = KVM_REG_ARM64_SVE_ZREG(n, i);
+
+	assert((size_t)1 << ((reg.id & KVM_REG_SIZE_MASK) >>
+			     KVM_REG_SIZE_SHIFT) ==
+	       sizeof bytes);
+	reg.addr = (__u64)bytes;
+
+	strp = str;
+	strsz = sizeof str;
+
+	sappendf(&strp, &strsz, " Z%.2u/%.2u:", n, i);
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
+		dprintf(debug_fd, "%s(%s)\n", str, strerror(errno));
+		if (vcpu->kvm->cfg.arch.has_sve)
+			die("Z-reg unexpectedly absent on SVE vcpu");
+
+		return;
+	}
+
+	if (!vcpu->kvm->cfg.arch.has_sve)
+		die("Z-reg unexpectedly present on non-SVE vcpu");
+
+	sappend_bytes(&strp, &strsz, bytes, sizeof bytes);
+	dprintf(debug_fd, "%s\n", str);
+}
+
+static void show_sve_zn(int debug_fd, struct kvm_cpu const *vcpu,
+			unsigned int n)
+{
+	show_sve_zn_slice(debug_fd, vcpu, n, 0);
+	show_sve_zn_slice(debug_fd, vcpu, n, 1);
+}
+
+static void show_sve_pn_slice(int debug_fd, struct kvm_cpu const *vcpu,
+			      unsigned int n, unsigned int i)
+{
+	struct kvm_one_reg reg;
+	char bytes[32];
+	char str[2 * sizeof bytes + 9], *strp;
+	size_t strsz;
+
+	reg.id = KVM_REG_ARM64_SVE_PREG(n, i);
+
+	assert((size_t)1 << ((reg.id & KVM_REG_SIZE_MASK) >>
+			     KVM_REG_SIZE_SHIFT) ==
+	       sizeof bytes);
+	reg.addr = (__u64)bytes;
+
+	strp = str;
+	strsz = sizeof str;
+
+	if (reg.id == KVM_REG_ARM64_SVE_FFR(i))
+		sappendf(&strp, &strsz, " FFR/%.2u:", i);
+	else
+		sappendf(&strp, &strsz, " P%.2u/%.2u:", n, i);
+
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
+		dprintf(debug_fd, "%s(%s)\n", str, strerror(errno));
+		if (vcpu->kvm->cfg.arch.has_sve)
+			die("P-reg unexpectedly absent on SVE vcpu");
+
+		return;
+	}
+
+	if (!vcpu->kvm->cfg.arch.has_sve)
+		die("P-reg unexpectedly present on non-SVE vcpu");
+
+	sappend_bytes(&strp, &strsz, bytes, sizeof bytes);
+	dprintf(debug_fd, "%s\n", str);
+}
+
+static void show_sve_pn(int debug_fd, struct kvm_cpu const *vcpu,
+			unsigned int n)
+{
+	show_sve_pn_slice(debug_fd, vcpu, n, 0);
+	show_sve_pn_slice(debug_fd, vcpu, n, 1);
+}
+
 void kvm_cpu__show_registers(struct kvm_cpu *vcpu)
 {
 	struct kvm_one_reg reg;
 	unsigned long data;
+	unsigned int data32;
 	int debug_fd = kvm_cpu__get_debug_fd();
+	unsigned int i;
+	char bytes[16];
+	unsigned long vqs[8];
+	char str[2 * sizeof vqs + 1], *strp;
+	size_t strsz;
 
 	reg.addr = (u64)&data;
 	dprintf(debug_fd, "\n Registers:\n");
@@ -225,4 +346,69 @@ void kvm_cpu__show_registers(struct kvm_cpu *vcpu)
 	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
 		die("KVM_GET_ONE_REG failed (lr)");
 	dprintf(debug_fd, " LR:    0x%lx\n", data);
+
+	reg.addr = (__u64)bytes;
+	for (i = 0; i < 32; ++i) {
+		reg.id = ARM64_CORE_REG(fp_regs.vregs[i]);
+		if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
+			dprintf(debug_fd, " V%.2u:   (%s)\n",
+				i, strerror(errno));
+		else {
+			strp = str;
+			strsz = sizeof str;
+			sappend_bytes(&strp, &strsz, bytes, 16);
+			dprintf(debug_fd, " V%.2u:   %s\n", i, str);
+		}
+	}
+
+	reg.addr = (__u64)&data32;
+
+	reg.id		= ARM64_CORE_REG(fp_regs.fpsr);
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
+		die("KVM_GET_ONE_REG failed (fpsr)");
+	dprintf(debug_fd, " FPSR:  0x%x\n", data32);
+
+	reg.id		= ARM64_CORE_REG(fp_regs.fpcr);
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
+		die("KVM_GET_ONE_REG failed (fpcr)");
+	dprintf(debug_fd, " FPCR:  0x%x\n", data32);
+
+	reg.id		= KVM_REG_ARM64_SVE_VLS;
+	assert((size_t)1 << ((reg.id & KVM_REG_SIZE_MASK) >>
+			     KVM_REG_SIZE_SHIFT) ==
+	       sizeof vqs);
+	reg.addr = (u64)&vqs;
+
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
+		dprintf(debug_fd, " SVE_VLS:(%s)\n", strerror(errno));
+		if (vcpu->kvm->cfg.arch.has_sve)
+			die("SVE vcpu doesn't have KVM_REG_ARM64_SVE_VLS!");
+	} else {
+		if (!vcpu->kvm->cfg.arch.has_sve)
+			die("KVM_REG_ARM64_SVE_VLS present on non-SVE vcpu!");
+
+		strp = str;
+		strsz = sizeof str;
+		sappend_bytes(&strp, &strsz, vqs, sizeof vqs);
+		dprintf(debug_fd, " SVE_VLS:%s\n", str);
+	}
+
+	reg.addr = (__u64)&data;
+	reg.id = ARM64_SYS_REG(3, 0, 1, 2, 0);
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
+		dprintf(debug_fd, " ZCR_EL1:(%s)\n", strerror(errno));
+		if (vcpu->kvm->cfg.arch.has_sve)
+			die("ZCR_EL1 unexpectedly absent on SVE vcpu");
+	} else {
+		if (!vcpu->kvm->cfg.arch.has_sve)
+			die("ZCR_EL1 unexpectedly present on non-SVE vcpu");
+
+		dprintf(debug_fd, " ZCR_EL1:0x%lx\n", data);
+	}
+
+	for (i = 0; i < 32; ++i)
+		show_sve_zn(debug_fd, vcpu, i);
+
+	for (i = 0; i < 16 + 1 /*FFR*/; ++i)
+		show_sve_pn(debug_fd, vcpu, i);
 }
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
