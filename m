Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C969C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:29:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BE42070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bR0OG6k8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BE42070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O5qSzaHkEJ9oE9Jwab/TR9YAsitxqWic6S/WiMrgx28=; b=bR0OG6k8bfRg5F
	Wk5XVE/ON4dutoHa1eiE9SpydOBWeLUdiO8QCON3WvHN7sH5pzpHSrYM1/4kTOA5HiBSDuVTdRq5W
	1vxr2rCUsxtPccEP0jSxxyNoti/W34MtKV6cxFeXA1dRrnJ6uQsbxaqP2fau0GYYpGHIjJucMq8OX
	ed8WbZHEHtE9IsYS8bzz+7az9brPWTM/gqOoBIOHWsorvLy65yTU8AvTyzGlrGV1LxbRvGwmC2BO+
	WteWxjd2G2wOlcMSl575b5u++6bHUF58anXpmPxbO45fC3cGUzLSOrPxxV/P3bEbQEh/M867m6Nah
	uC9mQa1LMsQDtgug64ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDhp-0001Vv-Ej; Fri, 22 Feb 2019 16:29:45 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDg7-000813-I6
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:28:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59238165C;
 Fri, 22 Feb 2019 08:27:59 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 0472C3F5C1; Fri, 22 Feb 2019 08:27:54 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 12/27] KVM: arm/arm64: timer: Rework data structures for
 multiple timers
Date: Fri, 22 Feb 2019 16:25:50 +0000
Message-Id: <20190222162605.5054-13-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222162605.5054-1-marc.zyngier@arm.com>
References: <20190222162605.5054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_082759_978339_386FAC9B 
X-CRM114-Status: GOOD (  18.09  )
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

From: Christoffer Dall <christoffer.dall@arm.com>

Prepare for having 4 timer data structures (2 for now).

Move loaded to the cpu data structure and not the individual timer
structure, in preparation for assigning the EL1 phys timer as well.

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_arch_timer.h | 41 ++++++++++++-------------
 virt/kvm/arm/arch_timer.c    | 58 +++++++++++++++++++-----------------
 2 files changed, 51 insertions(+), 48 deletions(-)

diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index d26b7fde9935..ab835112204d 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -36,6 +36,8 @@ enum kvm_arch_timer_regs {
 };
 
 struct arch_timer_context {
+	struct kvm_vcpu			*vcpu;
+
 	/* Registers: control register, timer value */
 	u32				cnt_ctl;
 	u64				cnt_cval;
@@ -43,32 +45,31 @@ struct arch_timer_context {
 	/* Timer IRQ */
 	struct kvm_irq_level		irq;
 
-	/*
-	 * We have multiple paths which can save/restore the timer state
-	 * onto the hardware, so we need some way of keeping track of
-	 * where the latest state is.
-	 *
-	 * loaded == true:  State is loaded on the hardware registers.
-	 * loaded == false: State is stored in memory.
-	 */
-	bool			loaded;
-
 	/* Virtual offset */
-	u64			cntvoff;
+	u64				cntvoff;
+
+	/* Emulated Timer (may be unused) */
+	struct hrtimer			hrtimer;
 };
 
 struct arch_timer_cpu {
-	struct arch_timer_context	vtimer;
-	struct arch_timer_context	ptimer;
+	struct arch_timer_context timers[NR_KVM_TIMERS];
 
 	/* Background timer used when the guest is not running */
 	struct hrtimer			bg_timer;
 
-	/* Physical timer emulation */
-	struct hrtimer			phys_timer;
-
 	/* Is the timer enabled */
 	bool			enabled;
+
+	/*
+	 * We have multiple paths which can save/restore the timer state
+	 * onto the hardware, so we need some way of keeping track of
+	 * where the latest state is.
+	 *
+	 * loaded == true:  State is loaded on the hardware registers.
+	 * loaded == false: State is stored in memory.
+	 */
+	bool			loaded;
 };
 
 int kvm_timer_hyp_init(bool);
@@ -98,10 +99,10 @@ void kvm_timer_init_vhe(void);
 
 bool kvm_arch_timer_get_input_level(int vintid);
 
-#define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.vtimer)
-#define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.ptimer)
-#define vcpu_get_timer(v,t)					\
-	(t == TIMER_VTIMER ? vcpu_vtimer(v) : vcpu_ptimer(v))
+#define vcpu_timer(v)	(&(v)->arch.timer_cpu)
+#define vcpu_get_timer(v,t)	(&vcpu_timer(v)->timers[(t)])
+#define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.timers[TIMER_VTIMER])
+#define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.timers[TIMER_PTIMER])
 
 u64 kvm_arm_timer_read_sysreg(struct kvm_vcpu *vcpu,
 			      enum kvm_arch_timers tmr,
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index f7d377448438..471f9fd004c9 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -184,13 +184,11 @@ static enum hrtimer_restart kvm_bg_timer_expire(struct hrtimer *hrt)
 static enum hrtimer_restart kvm_phys_timer_expire(struct hrtimer *hrt)
 {
 	struct arch_timer_context *ptimer;
-	struct arch_timer_cpu *timer;
 	struct kvm_vcpu *vcpu;
 	u64 ns;
 
-	timer = container_of(hrt, struct arch_timer_cpu, phys_timer);
-	vcpu = container_of(timer, struct kvm_vcpu, arch.timer_cpu);
-	ptimer = vcpu_ptimer(vcpu);
+	ptimer = container_of(hrt, struct arch_timer_context, hrtimer);
+	vcpu = ptimer->vcpu;
 
 	/*
 	 * Check that the timer has really expired from the guest's
@@ -209,9 +207,10 @@ static enum hrtimer_restart kvm_phys_timer_expire(struct hrtimer *hrt)
 
 static bool kvm_timer_should_fire(struct arch_timer_context *timer_ctx)
 {
+	struct arch_timer_cpu *timer = vcpu_timer(timer_ctx->vcpu);
 	u64 cval, now;
 
-	if (timer_ctx->loaded) {
+	if (timer->loaded) {
 		u32 cnt_ctl;
 
 		/* Only the virtual timer can be loaded so far */
@@ -280,7 +279,6 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
 /* Schedule the background timer for the emulated timer. */
 static void phys_timer_emulate(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
 	/*
@@ -289,11 +287,11 @@ static void phys_timer_emulate(struct kvm_vcpu *vcpu)
 	 * then we also don't need a soft timer.
 	 */
 	if (kvm_timer_should_fire(ptimer) || !kvm_timer_irq_can_fire(ptimer)) {
-		soft_timer_cancel(&timer->phys_timer);
+		soft_timer_cancel(&ptimer->hrtimer);
 		return;
 	}
 
-	soft_timer_start(&timer->phys_timer, kvm_timer_compute_delta(ptimer));
+	soft_timer_start(&ptimer->hrtimer, kvm_timer_compute_delta(ptimer));
 }
 
 /*
@@ -303,7 +301,7 @@ static void phys_timer_emulate(struct kvm_vcpu *vcpu)
  */
 static void kvm_timer_update_state(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 	bool level;
@@ -329,13 +327,13 @@ static void kvm_timer_update_state(struct kvm_vcpu *vcpu)
 
 static void vtimer_save_state(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	unsigned long flags;
 
 	local_irq_save(flags);
 
-	if (!vtimer->loaded)
+	if (!timer->loaded)
 		goto out;
 
 	if (timer->enabled) {
@@ -347,7 +345,7 @@ static void vtimer_save_state(struct kvm_vcpu *vcpu)
 	write_sysreg_el0(0, cntv_ctl);
 	isb();
 
-	vtimer->loaded = false;
+	timer->loaded = false;
 out:
 	local_irq_restore(flags);
 }
@@ -359,7 +357,7 @@ static void vtimer_save_state(struct kvm_vcpu *vcpu)
  */
 static void kvm_timer_blocking(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
@@ -379,20 +377,20 @@ static void kvm_timer_blocking(struct kvm_vcpu *vcpu)
 
 static void kvm_timer_unblocking(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 
 	soft_timer_cancel(&timer->bg_timer);
 }
 
 static void vtimer_restore_state(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	unsigned long flags;
 
 	local_irq_save(flags);
 
-	if (vtimer->loaded)
+	if (timer->loaded)
 		goto out;
 
 	if (timer->enabled) {
@@ -401,7 +399,7 @@ static void vtimer_restore_state(struct kvm_vcpu *vcpu)
 		write_sysreg_el0(vtimer->cnt_ctl, cntv_ctl);
 	}
 
-	vtimer->loaded = true;
+	timer->loaded = true;
 out:
 	local_irq_restore(flags);
 }
@@ -462,7 +460,7 @@ static void kvm_timer_vcpu_load_nogic(struct kvm_vcpu *vcpu)
 
 void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
@@ -507,7 +505,8 @@ bool kvm_timer_should_notify_user(struct kvm_vcpu *vcpu)
 
 void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
+	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
 	if (unlikely(!timer->enabled))
 		return;
@@ -523,7 +522,7 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
 	 * In any case, we re-schedule the hrtimer for the physical timer when
 	 * coming back to the VCPU thread in kvm_timer_vcpu_load().
 	 */
-	soft_timer_cancel(&timer->phys_timer);
+	soft_timer_cancel(&ptimer->hrtimer);
 
 	if (swait_active(kvm_arch_vcpu_wq(vcpu)))
 		kvm_timer_blocking(vcpu);
@@ -559,7 +558,7 @@ static void unmask_vtimer_irq_user(struct kvm_vcpu *vcpu)
 
 void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 
 	if (unlikely(!timer->enabled))
 		return;
@@ -570,7 +569,7 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
 
 int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
@@ -611,22 +610,25 @@ static void update_vtimer_cntvoff(struct kvm_vcpu *vcpu, u64 cntvoff)
 
 void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
 	/* Synchronize cntvoff across all vtimers of a VM. */
 	update_vtimer_cntvoff(vcpu, kvm_phys_timer_read());
-	vcpu_ptimer(vcpu)->cntvoff = 0;
+	ptimer->cntvoff = 0;
 
 	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	timer->bg_timer.function = kvm_bg_timer_expire;
 
-	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	timer->phys_timer.function = kvm_phys_timer_expire;
+	hrtimer_init(&ptimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	ptimer->hrtimer.function = kvm_phys_timer_expire;
 
 	vtimer->irq.irq = default_vtimer_irq.irq;
 	ptimer->irq.irq = default_ptimer_irq.irq;
+
+	vtimer->vcpu = vcpu;
+	ptimer->vcpu = vcpu;
 }
 
 static void kvm_timer_init_interrupt(void *info)
@@ -860,7 +862,7 @@ int kvm_timer_hyp_init(bool has_gic)
 
 void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 
 	soft_timer_cancel(&timer->bg_timer);
 }
@@ -904,7 +906,7 @@ bool kvm_arch_timer_get_input_level(int vintid)
 
 int kvm_timer_enable(struct kvm_vcpu *vcpu)
 {
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	int ret;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
