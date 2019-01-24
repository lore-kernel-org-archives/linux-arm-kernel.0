Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258FEC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:03:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56E821855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hjY8M9Le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56E821855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=a58rshh1WX5kuIHSEPUKwv/rtAmwBjFwfUOnmx14uWU=; b=hjY8M9LeNOmprfAHT8Hho+JSPe
	DZFHThsTEnMdHPkDlyygyiCW5HRpNml2wBniry8FwcMASBaJA938anxeqLUAhYl1Uxi0Z9l1eZK+y
	oOWU3OYuf9jOcXTPmWS9vRIDYnJminDAx4XITxcE9IM5Gdec6HYQthVQznTL4NGMbeHCNAZMr4RGo
	YAdgYxzOoqQfzoVhDAd7BsbNAaKrA66PTcWWT05SdlySDwTK/sXtzcErwe5GMDEHaup7KqbOGqdLg
	kDzqv+bqHRfN7dPP7Iic0CGaaDGv0SnMZTtGzr+ph7Cc3Y3MM/UaUaYzXSYQ0uqN8rRCSzLna9y1e
	5GsPCwZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmfbf-0005ee-Bu; Thu, 24 Jan 2019 14:03:47 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmfYz-00039O-7m
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 14:01:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFA4E1596;
 Thu, 24 Jan 2019 06:01:00 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4104C3F5C1;
 Thu, 24 Jan 2019 06:01:00 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/14] KVM: arm/arm64: consolidate arch timer trap handlers
Date: Thu, 24 Jan 2019 15:00:28 +0100
Message-Id: <20190124140032.8588-11-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190124140032.8588-1-christoffer.dall@arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_060101_626504_03854AFC 
X-CRM114-Status: GOOD (  16.92  )
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
 Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvm@vger.kernel.org
MIME-Version: 1.0
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
 arch/arm64/kvm/sys_regs.c       |  80 +++++++++++---------
 include/kvm/arm_arch_timer.h    |  23 ++++++
 virt/kvm/arm/arch_timer.c       | 129 +++++++++++++++++++++++++++-----
 5 files changed, 196 insertions(+), 63 deletions(-)

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
index 1a5bea4285e4..65ea63366c67 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -990,44 +990,51 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
+	case SYS_CNTP_CTL_EL0:
+	case SYS_CNTP_CVAL_EL0:
+	case SYS_AARCH32_CNTP_TVAL:
+	case SYS_AARCH32_CNTP_CTL:
+	case SYS_AARCH32_CNTP_CVAL:
+		tmr = TIMER_PTIMER;
+		break;
+	default:
+		BUG();
 	}
 
-	return true;
-}
+	switch (reg) {
+	case SYS_CNTP_CVAL_EL0:
+	case SYS_AARCH32_CNTP_CVAL:
+		treg = TIMER_REG_CVAL;
+		break;
 
-static bool access_cntp_ctl(struct kvm_vcpu *vcpu,
-		struct sys_reg_params *p,
-		const struct sys_reg_desc *r)
-{
-	if (p->is_write)
-		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CTL, p->regval);
-	else
-		p->regval = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CTL);
+	case SYS_CNTP_TVAL_EL0:
+	case SYS_AARCH32_CNTP_TVAL:
+		treg = TIMER_REG_TVAL;
+		break;
 
-	return true;
-}
+	case SYS_CNTP_CTL_EL0:
+	case SYS_AARCH32_CNTP_CTL:
+		treg = TIMER_REG_CTL;
+		break;
+
+	default:
+		BUG();
+	}
 
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
@@ -1392,9 +1399,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
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
@@ -1715,10 +1722,9 @@ static const struct sys_reg_desc cp15_regs[] = {
 
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
@@ -1795,7 +1801,7 @@ static const struct sys_reg_desc cp15_64_regs[] = {
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
index 4986028d9829..9502bb91776b 100644
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
@@ -672,26 +681,112 @@ static u64 read_timer_ctl(struct arch_timer_context *timer)
 
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
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
