Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B656C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:58:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A8C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sh6obWR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A8C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=In6eTy4brawK+3r9k9zNvvE9oFUHXdDUqJrEhmr5uvA=; b=Sh6obWR2i6yRMaZaIw5Q287e01
	kp7KNrZFZ2Zg7wkiJW+tnmK6k+8HFAfb6Lp+U4J9fpYdYph+ZgiSO/1VezNRVEl4/bKosSJmYGdqs
	nCPfNgeNWac6ko16ZM5KxAHAnfS1clQ1bcnEZuU3MJnFMjZzyRCCsfVX1AMIPX3irMBZxEU5rvWwH
	GA0dAk0GS3/ZAI9Y9za1oIxfmY/2KY+qDqpqAoYeWoSE5uPqeUfE3CqOP44euVcN7pg1JceDpWgzp
	Nz9obIU7L4WDDz0fLTYUrPAGniL8nCViMTQz6jlqr8UJLzJhk5GB62Ch4VgbH3UAlrbaB/wy/q129
	w/AJvbjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkERU-00058C-IF; Thu, 17 Jan 2019 20:39:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENV-0000Wt-9V
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1825E168F;
 Thu, 17 Jan 2019 12:35:05 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B7A53F819;
 Thu, 17 Jan 2019 12:35:03 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 17/25] KVM: arm64/sve: Add SVE support to register access
 ioctl interface
Date: Thu, 17 Jan 2019 20:33:31 +0000
Message-Id: <1547757219-19439-18-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_123505_795108_BDC274ED 
X-CRM114-Status: GOOD (  19.15  )
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds the following registers for access via the
KVM_{GET,SET}_ONE_REG interface:

 * KVM_REG_ARM64_SVE_ZREG(n, i) (n = 0..31) (in 2048-bit slices)
 * KVM_REG_ARM64_SVE_PREG(n, i) (n = 0..15) (in 256-bit slices)
 * KVM_REG_ARM64_SVE_FFR(i) (in 256-bit slices)

In order to adapt gracefully to future architectural extensions,
the registers are divided up into slices as noted above:  the i
parameter denotes the slice index.

For simplicity, bits or slices that exceed the maximum vector
length supported for the vcpu are ignored for KVM_SET_ONE_REG, and
read as zero for KVM_GET_ONE_REG.

For the current architecture, only slice i = 0 is significant.  The
interface design allows i to increase to up to 31 in the future if
required by future architectural amendments.

The registers are only visible for vcpus that have SVE enabled.
They are not enumerated by KVM_GET_REG_LIST on vcpus that do not
have SVE.  In all cases, surplus slices are not enumerated by
KVM_GET_REG_LIST.

Accesses to the FPSIMD registers via KVM_REG_ARM_CORE is not
allowed for SVE-enabled vcpus: SVE-aware userspace can use the
KVM_REG_ARM64_SVE_ZREG() interface instead to access the same
register state.  This avoids some complex and pointless emluation
in the kernel.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/uapi/asm/kvm.h |  10 +++
 arch/arm64/kvm/guest.c            | 131 ++++++++++++++++++++++++++++++++++----
 2 files changed, 129 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 97c3478..1ff68fa 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -226,6 +226,16 @@ struct kvm_vcpu_events {
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
 
+/* SVE registers */
+#define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM64_SVE_ZREG(n, i)	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
+					 KVM_REG_SIZE_U2048 |		\
+					 ((n) << 5) | (i))
+#define KVM_REG_ARM64_SVE_PREG(n, i)	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
+					 KVM_REG_SIZE_U256 |		\
+					 ((n) << 5) | (i) | 0x400)
+#define KVM_REG_ARM64_SVE_FFR(i)	KVM_REG_ARM64_SVE_PREG(16, i)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index ffa38d4..b8f9c1e 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -19,8 +19,10 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/bits.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
 #include <linux/kvm_host.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
@@ -28,9 +30,12 @@
 #include <kvm/arm_psci.h>
 #include <asm/cputype.h>
 #include <linux/uaccess.h>
+#include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_host.h>
+#include <asm/sigcontext.h>
 
 #include "trace.h"
 
@@ -210,6 +215,108 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return err;
 }
 
+struct kreg_region {
+	char *kptr;
+	size_t size;
+	size_t zeropad;
+};
+
+#define SVE_REG_SLICE_SHIFT	0
+#define SVE_REG_SLICE_BITS	5
+#define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
+#define SVE_REG_ID_BITS		5
+
+#define SVE_REG_SLICE_MASK					\
+	GENMASK(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS - 1,	\
+		SVE_REG_SLICE_SHIFT)
+#define SVE_REG_ID_MASK							\
+	GENMASK(SVE_REG_ID_SHIFT + SVE_REG_ID_BITS - 1, SVE_REG_ID_SHIFT)
+
+#define SVE_NUM_SLICES (1 << SVE_REG_SLICE_BITS)
+
+static int sve_reg_region(struct kreg_region *b,
+			  const struct kvm_vcpu *vcpu,
+			  const struct kvm_one_reg *reg)
+{
+	const unsigned int vl = vcpu->arch.sve_max_vl;
+	const unsigned int vq = sve_vq_from_vl(vl);
+
+	const unsigned int reg_num =
+		(reg->id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
+	const unsigned int slice_num =
+		(reg->id & SVE_REG_SLICE_MASK) >> SVE_REG_SLICE_SHIFT;
+
+	unsigned int slice_size, offset, limit;
+
+	if (reg->id >= KVM_REG_ARM64_SVE_ZREG(0, 0) &&
+	    reg->id <= KVM_REG_ARM64_SVE_ZREG(SVE_NUM_ZREGS - 1,
+					      SVE_NUM_SLICES - 1)) {
+		slice_size = KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0));
+
+		/* Compute start and end of the register: */
+		offset = SVE_SIG_ZREG_OFFSET(vq, reg_num) - SVE_SIG_REGS_OFFSET;
+		limit = offset + SVE_SIG_ZREG_SIZE(vq);
+
+		offset += slice_size * slice_num; /* start of requested slice */
+
+	} else if (reg->id >= KVM_REG_ARM64_SVE_PREG(0, 0) &&
+		   reg->id <= KVM_REG_ARM64_SVE_FFR(SVE_NUM_SLICES - 1)) {
+		/* (FFR is P16 for our purposes) */
+
+		slice_size = KVM_REG_SIZE(KVM_REG_ARM64_SVE_PREG(0, 0));
+
+		/* Compute start and end of the register: */
+		offset = SVE_SIG_PREG_OFFSET(vq, reg_num) - SVE_SIG_REGS_OFFSET;
+		limit = offset + SVE_SIG_PREG_SIZE(vq);
+
+		offset += slice_size * slice_num; /* start of requested slice */
+
+	} else {
+		return -ENOENT;
+	}
+
+	b->kptr = (char *)vcpu->arch.sve_state + offset;
+
+	/*
+	 * If the slice starts after the end of the reg, just pad.
+	 * Otherwise, copy as much as possible up to slice_size and pad
+	 * the remainder:
+	 */
+	b->size = offset >= limit ? 0 : min(limit - offset, slice_size);
+	b->zeropad = slice_size - b->size;
+
+	return 0;
+}
+
+static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	struct kreg_region kreg;
+	char __user *uptr = (char __user *)reg->addr;
+
+	if (!vcpu_has_sve(vcpu) || sve_reg_region(&kreg, vcpu, reg))
+		return -ENOENT;
+
+	if (copy_to_user(uptr, kreg.kptr, kreg.size) ||
+	    clear_user(uptr + kreg.size, kreg.zeropad))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	struct kreg_region kreg;
+	char __user *uptr = (char __user *)reg->addr;
+
+	if (!vcpu_has_sve(vcpu) || sve_reg_region(&kreg, vcpu, reg))
+		return -ENOENT;
+
+	if (copy_from_user(kreg.kptr, uptr, kreg.size))
+		return -EFAULT;
+
+	return 0;
+}
+
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	return -EINVAL;
@@ -370,12 +477,12 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
 		return -EINVAL;
 
-	/* Register group 16 means we want a core register. */
-	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
-		return get_core_reg(vcpu, reg);
-
-	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
-		return kvm_arm_get_fw_reg(vcpu, reg);
+	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
+	case KVM_REG_ARM_CORE:	return get_core_reg(vcpu, reg);
+	case KVM_REG_ARM_FW:	return kvm_arm_get_fw_reg(vcpu, reg);
+	case KVM_REG_ARM64_SVE:	return get_sve_reg(vcpu, reg);
+	default: break; /* fall through */
+	}
 
 	if (is_timer_reg(reg->id))
 		return get_timer_reg(vcpu, reg);
@@ -389,12 +496,12 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
 		return -EINVAL;
 
-	/* Register group 16 means we set a core register. */
-	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
-		return set_core_reg(vcpu, reg);
-
-	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
-		return kvm_arm_set_fw_reg(vcpu, reg);
+	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
+	case KVM_REG_ARM_CORE:	return set_core_reg(vcpu, reg);
+	case KVM_REG_ARM_FW:	return kvm_arm_set_fw_reg(vcpu, reg);
+	case KVM_REG_ARM64_SVE:	return set_sve_reg(vcpu, reg);
+	default: break; /* fall through */
+	}
 
 	if (is_timer_reg(reg->id))
 		return set_timer_reg(vcpu, reg);
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
