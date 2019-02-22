Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4A6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:29:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A362070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gvWzOAIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A362070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gaQKPoQr7Fd2PKk8sx7A0b3Kjv1TMlMvDsD0An/WK8Y=; b=gvWzOAIrZBCK3j
	DbyJbbUlluvxJV5o6nhf2cE82V1PLVHV6Dt3WZhFnyg5k43va+C5bKcK4kW3ylob4z7APtmklFkQo
	XA5w/DXvWqK5PuPG/1fUjAxHQmkw2bZh7vi6Gv0QV3hCSbUyKGu39QlHTacD5eLXBnz6S76AvvjJA
	yGpJG5zoIcjSVKvi0IbjifNfEqa2gJarJ3U+WyO6JslLG1yqnoCpuV2ygOJM+HKxvfgTFxrKEPsRa
	NSVFxj0z5a7DawRw2tiOOAB+FeLJnvJVgItdFkC0bMXWcsxJp8bxJJB4qQ78j/5Md1Dv1rCX63L5C
	SF2TTlsgqJpE3Gq8mo9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDhe-0001HU-Ji; Fri, 22 Feb 2019 16:29:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDg2-0007tV-Qp
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:28:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7025180D;
 Fri, 22 Feb 2019 08:27:54 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 AA8663F5C1; Fri, 22 Feb 2019 08:27:49 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 11/27] KVM: arm/arm64: consolidate arch timer trap handlers
Date: Fri, 22 Feb 2019 16:25:49 +0000
Message-Id: <20190222162605.5054-12-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222162605.5054-1-marc.zyngier@arm.com>
References: <20190222162605.5054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_082755_435248_64C9F8FA 
X-CRM114-Status: GOOD (  17.86  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, kvm@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Zenghui Yu <yuzenghui@huawei.com>, Colin Ian King <colin.king@canonical.com>,
 Dave Martin <Dave.Martin@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

At the moment we have separate system register emulation handlers for
each timer register. Actually they are quite similar, and we rely on
kvm_arm_timer_[gs]et_reg() for the actual emulation anyways, so let's
just merge all of those handlers into one function, which just marshalls
the arguments and then hands off to a set of common accessors.
This makes extending the emulation to include EL2 timers much easier.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
[Fixed 32-bit VM breakage and reduced to reworking existing code]
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
[Fixed 32bit host, general cleanup]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc.c           |  23 +++---
 arch/arm64/include/asm/sysreg.h |   4 +
 arch/arm64/kvm/sys_regs.c       |  73 ++++++++----------
 include/kvm/arm_arch_timer.h    |  23 ++++++
 virt/kvm/arm/arch_timer.c       | 130 +++++++++++++++++++++++++++-----
 5 files changed, 187 insertions(+), 66 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 222c1635bc7a..51863364f8d1 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -293,15 +293,16 @@ static bool access_cntp_tval(struct kvm_vcpu *vcpu,
 			     const struct coproc_params *p,
 			     const struct coproc_reg *r)
 {
-	u64 now = kvm_phys_timer_read();
-	u64 val;
+	u32 val;
 
 	if (p->is_write) {
 		val = *vcpu_reg(vcpu, p->Rt1);
-		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL, val + now);
+		kvm_arm_timer_write_sysreg(vcpu,
+					   TIMER_PTIMER, TIMER_REG_TVAL, val);
 	} else {
-		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
-		*vcpu_reg(vcpu, p->Rt1) = val - now;
+		val = kvm_arm_timer_read_sysreg(vcpu,
+						TIMER_PTIMER, TIMER_REG_TVAL);
+		*vcpu_reg(vcpu, p->Rt1) = val;
 	}
 
 	return true;
@@ -315,9 +316,11 @@ static bool access_cntp_ctl(struct kvm_vcpu *vcpu,
 
 	if (p->is_write) {
 		val = *vcpu_reg(vcpu, p->Rt1);
-		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CTL, val);
+		kvm_arm_timer_write_sysreg(vcpu,
+					   TIMER_PTIMER, TIMER_REG_CTL, val);
 	} else {
-		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CTL);
+		val = kvm_arm_timer_read_sysreg(vcpu,
+						TIMER_PTIMER, TIMER_REG_CTL);
 		*vcpu_reg(vcpu, p->Rt1) = val;
 	}
 
@@ -333,9 +336,11 @@ static bool access_cntp_cval(struct kvm_vcpu *vcpu,
 	if (p->is_write) {
 		val = (u64)*vcpu_reg(vcpu, p->Rt2) << 32;
 		val |= *vcpu_reg(vcpu, p->Rt1);
-		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL, val);
+		kvm_arm_timer_write_sysreg(vcpu,
+					   TIMER_PTIMER, TIMER_REG_CVAL, val);
 	} else {
-		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
+		val = kvm_arm_timer_read_sysreg(vcpu,
+						TIMER_PTIMER, TIMER_REG_CVAL);
 		*vcpu_reg(vcpu, p->Rt1) = val;
 		*vcpu_reg(vcpu, p->Rt2) = val >> 32;
 	}
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 3e5650903d6d..6482e8bcf1b8 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -392,6 +392,10 @@
 #define SYS_CNTP_CTL_EL0		sys_reg(3, 3, 14, 2, 1)
 #define SYS_CNTP_CVAL_EL0		sys_reg(3, 3, 14, 2, 2)
 
+#define SYS_AARCH32_CNTP_TVAL		sys_reg(0, 0, 14, 2, 0)
+#define SYS_AARCH32_CNTP_CTL		sys_reg(0, 0, 14, 2, 1)
+#define SYS_AARCH32_CNTP_CVAL		sys_reg(0, 2, 0, 14, 0)
+
 #define __PMEV_op2(n)			((n) & 0x7)
 #define __CNTR_CRm(n)			(0x8 | (((n) >> 3) & 0x3))
 #define SYS_PMEVCNTRn_EL0(n)		sys_reg(3, 3, 14, __CNTR_CRm(n), __PMEV_op2(n))
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1a5bea4285e4..0d348500b24b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -990,44 +990,38 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	{ SYS_DESC(SYS_PMEVTYPERn_EL0(n)),					\
 	  access_pmu_evtyper, reset_unknown, (PMEVTYPER0_EL0 + n), }
 
-static bool access_cntp_tval(struct kvm_vcpu *vcpu,
-		struct sys_reg_params *p,
-		const struct sys_reg_desc *r)
+static bool access_arch_timer(struct kvm_vcpu *vcpu,
+			      struct sys_reg_params *p,
+			      const struct sys_reg_desc *r)
 {
-	u64 now = kvm_phys_timer_read();
-	u64 cval;
+	enum kvm_arch_timers tmr;
+	enum kvm_arch_timer_regs treg;
+	u64 reg = reg_to_encoding(r);
 
-	if (p->is_write) {
-		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL,
-				      p->regval + now);
-	} else {
-		cval = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
-		p->regval = cval - now;
+	switch (reg) {
+	case SYS_CNTP_TVAL_EL0:
+	case SYS_AARCH32_CNTP_TVAL:
+		tmr = TIMER_PTIMER;
+		treg = TIMER_REG_TVAL;
+		break;
+	case SYS_CNTP_CTL_EL0:
+	case SYS_AARCH32_CNTP_CTL:
+		tmr = TIMER_PTIMER;
+		treg = TIMER_REG_CTL;
+		break;
+	case SYS_CNTP_CVAL_EL0:
+	case SYS_AARCH32_CNTP_CVAL:
+		tmr = TIMER_PTIMER;
+		treg = TIMER_REG_CVAL;
+		break;
+	default:
+		BUG();
 	}
 
-	return true;
-}
-
-static bool access_cntp_ctl(struct kvm_vcpu *vcpu,
-		struct sys_reg_params *p,
-		const struct sys_reg_desc *r)
-{
-	if (p->is_write)
-		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CTL, p->regval);
-	else
-		p->regval = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CTL);
-
-	return true;
-}
-
-static bool access_cntp_cval(struct kvm_vcpu *vcpu,
-		struct sys_reg_params *p,
-		const struct sys_reg_desc *r)
-{
 	if (p->is_write)
-		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL, p->regval);
+		kvm_arm_timer_write_sysreg(vcpu, tmr, treg, p->regval);
 	else
-		p->regval = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
+		p->regval = kvm_arm_timer_read_sysreg(vcpu, tmr, treg);
 
 	return true;
 }
@@ -1392,9 +1386,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
 
-	{ SYS_DESC(SYS_CNTP_TVAL_EL0), access_cntp_tval },
-	{ SYS_DESC(SYS_CNTP_CTL_EL0), access_cntp_ctl },
-	{ SYS_DESC(SYS_CNTP_CVAL_EL0), access_cntp_cval },
+	{ SYS_DESC(SYS_CNTP_TVAL_EL0), access_arch_timer },
+	{ SYS_DESC(SYS_CNTP_CTL_EL0), access_arch_timer },
+	{ SYS_DESC(SYS_CNTP_CVAL_EL0), access_arch_timer },
 
 	/* PMEVCNTRn_EL0 */
 	PMU_PMEVCNTR_EL0(0),
@@ -1715,10 +1709,9 @@ static const struct sys_reg_desc cp15_regs[] = {
 
 	{ Op1( 0), CRn(13), CRm( 0), Op2( 1), access_vm_reg, NULL, c13_CID },
 
-	/* CNTP_TVAL */
-	{ Op1( 0), CRn(14), CRm( 2), Op2( 0), access_cntp_tval },
-	/* CNTP_CTL */
-	{ Op1( 0), CRn(14), CRm( 2), Op2( 1), access_cntp_ctl },
+	/* Arch Tmers */
+	{ SYS_DESC(SYS_AARCH32_CNTP_TVAL), access_arch_timer },
+	{ SYS_DESC(SYS_AARCH32_CNTP_CTL), access_arch_timer },
 
 	/* PMEVCNTRn */
 	PMU_PMEVCNTR(0),
@@ -1795,7 +1788,7 @@ static const struct sys_reg_desc cp15_64_regs[] = {
 	{ Op1( 1), CRn( 0), CRm( 2), Op2( 0), access_vm_reg, NULL, c2_TTBR1 },
 	{ Op1( 1), CRn( 0), CRm(12), Op2( 0), access_gic_sgi }, /* ICC_ASGI1R */
 	{ Op1( 2), CRn( 0), CRm(12), Op2( 0), access_gic_sgi }, /* ICC_SGI0R */
-	{ Op1( 2), CRn( 0), CRm(14), Op2( 0), access_cntp_cval },
+	{ SYS_DESC(SYS_AARCH32_CNTP_CVAL),    access_arch_timer },
 };
 
 /* Target specific emulation tables */
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index d6e6a45d1d24..d26b7fde9935 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -22,6 +22,19 @@
 #include <linux/clocksource.h>
 #include <linux/hrtimer.h>
 
+enum kvm_arch_timers {
+	TIMER_PTIMER,
+	TIMER_VTIMER,
+	NR_KVM_TIMERS
+};
+
+enum kvm_arch_timer_regs {
+	TIMER_REG_CNT,
+	TIMER_REG_CVAL,
+	TIMER_REG_TVAL,
+	TIMER_REG_CTL,
+};
+
 struct arch_timer_context {
 	/* Registers: control register, timer value */
 	u32				cnt_ctl;
@@ -87,5 +100,15 @@ bool kvm_arch_timer_get_input_level(int vintid);
 
 #define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.vtimer)
 #define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.ptimer)
+#define vcpu_get_timer(v,t)					\
+	(t == TIMER_VTIMER ? vcpu_vtimer(v) : vcpu_ptimer(v))
+
+u64 kvm_arm_timer_read_sysreg(struct kvm_vcpu *vcpu,
+			      enum kvm_arch_timers tmr,
+			      enum kvm_arch_timer_regs treg);
+void kvm_arm_timer_write_sysreg(struct kvm_vcpu *vcpu,
+				enum kvm_arch_timers tmr,
+				enum kvm_arch_timer_regs treg,
+				u64 val);
 
 #endif
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 4986028d9829..f7d377448438 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -25,6 +25,7 @@
 
 #include <clocksource/arm_arch_timer.h>
 #include <asm/arch_timer.h>
+#include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 
 #include <kvm/arm_vgic.h>
@@ -52,6 +53,13 @@ static bool kvm_timer_irq_can_fire(struct arch_timer_context *timer_ctx);
 static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
 				 struct arch_timer_context *timer_ctx);
 static bool kvm_timer_should_fire(struct arch_timer_context *timer_ctx);
+static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
+				struct arch_timer_context *timer,
+				enum kvm_arch_timer_regs treg,
+				u64 val);
+static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
+			      struct arch_timer_context *timer,
+			      enum kvm_arch_timer_regs treg);
 
 u64 kvm_phys_timer_read(void)
 {
@@ -628,24 +636,25 @@ static void kvm_timer_init_interrupt(void *info)
 
 int kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu, u64 regid, u64 value)
 {
-	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
-	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
-
 	switch (regid) {
 	case KVM_REG_ARM_TIMER_CTL:
-		vtimer->cnt_ctl = value & ~ARCH_TIMER_CTRL_IT_STAT;
+		kvm_arm_timer_write(vcpu,
+				    vcpu_vtimer(vcpu), TIMER_REG_CTL, value);
 		break;
 	case KVM_REG_ARM_TIMER_CNT:
 		update_vtimer_cntvoff(vcpu, kvm_phys_timer_read() - value);
 		break;
 	case KVM_REG_ARM_TIMER_CVAL:
-		vtimer->cnt_cval = value;
+		kvm_arm_timer_write(vcpu,
+				    vcpu_vtimer(vcpu), TIMER_REG_CVAL, value);
 		break;
 	case KVM_REG_ARM_PTIMER_CTL:
-		ptimer->cnt_ctl = value & ~ARCH_TIMER_CTRL_IT_STAT;
+		kvm_arm_timer_write(vcpu,
+				    vcpu_ptimer(vcpu), TIMER_REG_CTL, value);
 		break;
 	case KVM_REG_ARM_PTIMER_CVAL:
-		ptimer->cnt_cval = value;
+		kvm_arm_timer_write(vcpu,
+				    vcpu_ptimer(vcpu), TIMER_REG_CVAL, value);
 		break;
 
 	default:
@@ -672,26 +681,113 @@ static u64 read_timer_ctl(struct arch_timer_context *timer)
 
 u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
 {
-	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
-	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
-
 	switch (regid) {
 	case KVM_REG_ARM_TIMER_CTL:
-		return read_timer_ctl(vtimer);
+		return kvm_arm_timer_read(vcpu,
+					  vcpu_vtimer(vcpu), TIMER_REG_CTL);
 	case KVM_REG_ARM_TIMER_CNT:
-		return kvm_phys_timer_read() - vtimer->cntvoff;
+		return kvm_arm_timer_read(vcpu,
+					  vcpu_vtimer(vcpu), TIMER_REG_CNT);
 	case KVM_REG_ARM_TIMER_CVAL:
-		return vtimer->cnt_cval;
+		return kvm_arm_timer_read(vcpu,
+					  vcpu_vtimer(vcpu), TIMER_REG_CVAL);
 	case KVM_REG_ARM_PTIMER_CTL:
-		return read_timer_ctl(ptimer);
-	case KVM_REG_ARM_PTIMER_CVAL:
-		return ptimer->cnt_cval;
+		return kvm_arm_timer_read(vcpu,
+					  vcpu_ptimer(vcpu), TIMER_REG_CTL);
 	case KVM_REG_ARM_PTIMER_CNT:
-		return kvm_phys_timer_read();
+		return kvm_arm_timer_read(vcpu,
+					  vcpu_vtimer(vcpu), TIMER_REG_CNT);
+	case KVM_REG_ARM_PTIMER_CVAL:
+		return kvm_arm_timer_read(vcpu,
+					  vcpu_ptimer(vcpu), TIMER_REG_CVAL);
 	}
 	return (u64)-1;
 }
 
+static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
+			      struct arch_timer_context *timer,
+			      enum kvm_arch_timer_regs treg)
+{
+	u64 val;
+
+	switch (treg) {
+	case TIMER_REG_TVAL:
+		val = kvm_phys_timer_read() - timer->cntvoff - timer->cnt_cval;
+		break;
+
+	case TIMER_REG_CTL:
+		val = read_timer_ctl(timer);
+		break;
+
+	case TIMER_REG_CVAL:
+		val = timer->cnt_cval;
+		break;
+
+	case TIMER_REG_CNT:
+		val = kvm_phys_timer_read() - timer->cntvoff;
+		break;
+
+	default:
+		BUG();
+	}
+
+	return val;
+}
+
+u64 kvm_arm_timer_read_sysreg(struct kvm_vcpu *vcpu,
+			      enum kvm_arch_timers tmr,
+			      enum kvm_arch_timer_regs treg)
+{
+	u64 val;
+
+	preempt_disable();
+	kvm_timer_vcpu_put(vcpu);
+
+	val = kvm_arm_timer_read(vcpu, vcpu_get_timer(vcpu, tmr), treg);
+
+	kvm_timer_vcpu_load(vcpu);
+	preempt_enable();
+
+	return val;
+}
+
+static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
+				struct arch_timer_context *timer,
+				enum kvm_arch_timer_regs treg,
+				u64 val)
+{
+	switch (treg) {
+	case TIMER_REG_TVAL:
+		timer->cnt_cval = val - kvm_phys_timer_read() - timer->cntvoff;
+		break;
+
+	case TIMER_REG_CTL:
+		timer->cnt_ctl = val & ~ARCH_TIMER_CTRL_IT_STAT;
+		break;
+
+	case TIMER_REG_CVAL:
+		timer->cnt_cval = val;
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+void kvm_arm_timer_write_sysreg(struct kvm_vcpu *vcpu,
+				enum kvm_arch_timers tmr,
+				enum kvm_arch_timer_regs treg,
+				u64 val)
+{
+	preempt_disable();
+	kvm_timer_vcpu_put(vcpu);
+
+	kvm_arm_timer_write(vcpu, vcpu_get_timer(vcpu, tmr), treg, val);
+
+	kvm_timer_vcpu_load(vcpu);
+	preempt_enable();
+}
+
 static int kvm_timer_starting_cpu(unsigned int cpu)
 {
 	kvm_timer_init_interrupt(NULL);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
