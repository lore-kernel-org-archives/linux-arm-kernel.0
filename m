Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A5FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:40:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9962086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QCLAJ2rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9962086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FCRUORdVsqxVFyujCtNriKlEAlw5Oafky6FaDrH6xQo=; b=QCLAJ2rSEyTJ9E
	fzNxP0wkQFHgPy5ZeKg4fd9v9Psa6xY9jIZ4r52rNFUEH/DsKeZBi94bVSIjWzOxfGWU9oIoubSkf
	scCl0kqhXANLmHS0uSAr1jyrHexIJ+iiHBNH1CETjiL/LhQHXMRcIMIM4h2q3sZAFHX9Y6zPcoVFI
	yZoInGNXWnv47lbz7UMXKYRVG+PL9LoWjWKw2JP8ukMa61jAxWmKYn6nYaGNyrvR/Om+5jtNKRfp6
	dHn090btcLxYjXloOa/zZpEkPTv9aLk7Z8dmXd1vTas1eyrFhFg16lF9QsPPfxorg5ZrOuhiT0dfO
	ay8aIkEAAkXZ4FbTawpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw3l0-0006nJ-Cy; Tue, 19 Feb 2019 11:40:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw3kr-0005bA-Sw
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 11:40:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00E92EBD;
 Tue, 19 Feb 2019 03:40:01 -0800 (PST)
Received: from [10.1.215.12] (e121566-lin.cambridge.arm.com [10.1.215.12])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB92C3F720;
 Tue, 19 Feb 2019 03:39:54 -0800 (PST)
Subject: Re: [PATCH 12/14] KVM: arm/arm64: arch_timer: Assign the phys timer
 on VHE systems
To: Christoffer Dall <christoffer.dall@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20190124140032.8588-1-christoffer.dall@arm.com>
 <20190124140032.8588-13-christoffer.dall@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <a89e8767-e297-a1a4-eaf5-ddcdee4604ac@arm.com>
Date: Tue, 19 Feb 2019 11:39:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124140032.8588-13-christoffer.dall@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_034005_958163_54412DDA 
X-CRM114-Status: GOOD (  28.73  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 1/24/19 2:00 PM, Christoffer Dall wrote:
> VHE systems don't have to emulate the physical timer, we can simply
> assigne the EL1 physical timer directly to the VM as the host always
> uses the EL2 timers.
>
> In order to minimize the amount of cruft, AArch32 gets definitions for
> the physical timer too, but is should be generally unused on this
> architecture.
>
> Co-written with Marc Zyngier <marc.zyngier@arm.com>
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  arch/arm/include/asm/kvm_hyp.h |   4 +
>  include/kvm/arm_arch_timer.h   |   6 +
>  virt/kvm/arm/arch_timer.c      | 206 ++++++++++++++++++++++++++-------
>  3 files changed, 171 insertions(+), 45 deletions(-)
>
> diff --git a/arch/arm/include/asm/kvm_hyp.h b/arch/arm/include/asm/kvm_hyp.h
> index e93a0cac9add..87bcd18df8d5 100644
> --- a/arch/arm/include/asm/kvm_hyp.h
> +++ b/arch/arm/include/asm/kvm_hyp.h
> @@ -40,6 +40,7 @@
>  #define TTBR1		__ACCESS_CP15_64(1, c2)
>  #define VTTBR		__ACCESS_CP15_64(6, c2)
>  #define PAR		__ACCESS_CP15_64(0, c7)
> +#define CNTP_CVAL	__ACCESS_CP15_64(2, c14)
>  #define CNTV_CVAL	__ACCESS_CP15_64(3, c14)
>  #define CNTVOFF		__ACCESS_CP15_64(4, c14)
>  
> @@ -85,6 +86,7 @@
>  #define TID_PRIV	__ACCESS_CP15(c13, 0, c0, 4)
>  #define HTPIDR		__ACCESS_CP15(c13, 4, c0, 2)
>  #define CNTKCTL		__ACCESS_CP15(c14, 0, c1, 0)
> +#define CNTP_CTL	__ACCESS_CP15(c14, 0, c2, 1)
>  #define CNTV_CTL	__ACCESS_CP15(c14, 0, c3, 1)
>  #define CNTHCTL		__ACCESS_CP15(c14, 4, c1, 0)
>  
> @@ -94,6 +96,8 @@
>  #define read_sysreg_el0(r)		read_sysreg(r##_el0)
>  #define write_sysreg_el0(v, r)		write_sysreg(v, r##_el0)
>  
> +#define cntp_ctl_el0			CNTP_CTL
> +#define cntp_cval_el0			CNTP_CVAL
>  #define cntv_ctl_el0			CNTV_CTL
>  #define cntv_cval_el0			CNTV_CVAL
>  #define cntvoff_el2			CNTVOFF
> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
> index d40fe57a2d0d..722e0481f310 100644
> --- a/include/kvm/arm_arch_timer.h
> +++ b/include/kvm/arm_arch_timer.h
> @@ -50,6 +50,10 @@ struct arch_timer_context {
>  
>  	/* Emulated Timer (may be unused) */
>  	struct hrtimer			hrtimer;
> +
> +	/* Duplicated state from arch_timer.c for convenience */
> +	u32				host_timer_irq;
> +	u32				host_timer_irq_flags;
>  };
>  
>  enum loaded_timer_state {
> @@ -107,6 +111,8 @@ bool kvm_arch_timer_get_input_level(int vintid);
>  #define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.timers[TIMER_VTIMER])
>  #define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.timers[TIMER_PTIMER])
>  
> +#define arch_timer_ctx_index(ctx)	((ctx) - vcpu_timer((ctx)->vcpu)->timers)
> +
>  u64 kvm_arm_timer_read_sysreg(struct kvm_vcpu *vcpu,
>  			      enum kvm_arch_timers tmr,
>  			      enum kvm_arch_timer_regs treg);
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 8b0eca5fbad1..eed8f48fbf9b 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -35,7 +35,9 @@
>  
>  static struct timecounter *timecounter;
>  static unsigned int host_vtimer_irq;
> +static unsigned int host_ptimer_irq;
>  static u32 host_vtimer_irq_flags;
> +static u32 host_ptimer_irq_flags;
>  
>  static DEFINE_STATIC_KEY_FALSE(has_gic_active_state);
>  
> @@ -86,20 +88,24 @@ static void soft_timer_cancel(struct hrtimer *hrt)
>  static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
>  {
>  	struct kvm_vcpu *vcpu = *(struct kvm_vcpu **)dev_id;
> -	struct arch_timer_context *vtimer;
> +	struct arch_timer_context *ctx;
>  
>  	/*
>  	 * We may see a timer interrupt after vcpu_put() has been called which
>  	 * sets the CPU's vcpu pointer to NULL, because even though the timer
> -	 * has been disabled in vtimer_save_state(), the hardware interrupt
> +	 * has been disabled in timer_save_state(), the hardware interrupt
>  	 * signal may not have been retired from the interrupt controller yet.
>  	 */
>  	if (!vcpu)
>  		return IRQ_HANDLED;
>  
> -	vtimer = vcpu_vtimer(vcpu);
> -	if (kvm_timer_should_fire(vtimer))
> -		kvm_timer_update_irq(vcpu, true, vtimer);
> +	if (irq == host_vtimer_irq)
> +		ctx = vcpu_vtimer(vcpu);
> +	else
> +		ctx = vcpu_ptimer(vcpu);
> +
> +	if (kvm_timer_should_fire(ctx))
> +		kvm_timer_update_irq(vcpu, true, ctx);
>  
>  	if (userspace_irqchip(vcpu->kvm) &&
>  	    !static_branch_unlikely(&has_gic_active_state))
> @@ -208,13 +214,25 @@ static enum hrtimer_restart kvm_phys_timer_expire(struct hrtimer *hrt)
>  static bool kvm_timer_should_fire(struct arch_timer_context *timer_ctx)
>  {
>  	struct arch_timer_cpu *timer = vcpu_timer(timer_ctx->vcpu);
> +	enum kvm_arch_timers index = arch_timer_ctx_index(timer_ctx);
>  	u64 cval, now;
>  
>  	if (timer->loaded == TIMER_EL1_LOADED) {
> -		u32 cnt_ctl;
> +		u32 cnt_ctl = 0;
> +
> +		switch (index) {
> +		case TIMER_VTIMER:
> +			cnt_ctl = read_sysreg_el0(cntv_ctl);
> +			break;
> +		case TIMER_PTIMER:
> +			cnt_ctl = read_sysreg_el0(cntp_ctl);
> +			break;
> +		case NR_KVM_TIMERS:
> +			/* GCC is braindead */
> +			cnt_ctl = 0;
> +			break;
> +		}
>  
> -		/* Only the virtual timer can be loaded so far */
> -		cnt_ctl = read_sysreg_el0(cntv_ctl);
>  		return  (cnt_ctl & ARCH_TIMER_CTRL_ENABLE) &&
>  		        (cnt_ctl & ARCH_TIMER_CTRL_IT_STAT) &&
>  		       !(cnt_ctl & ARCH_TIMER_CTRL_IT_MASK);
> @@ -310,7 +328,7 @@ static void kvm_timer_update_state(struct kvm_vcpu *vcpu)
>  		return;
>  
>  	/*
> -	 * The vtimer virtual interrupt is a 'mapped' interrupt, meaning part
> +	 * If the timer virtual interrupt is a 'mapped' interrupt, part
>  	 * of its lifecycle is offloaded to the hardware, and we therefore may
>  	 * not have lowered the irq.level value before having to signal a new
>  	 * interrupt, but have to signal an interrupt every time the level is
> @@ -319,31 +337,55 @@ static void kvm_timer_update_state(struct kvm_vcpu *vcpu)
>  	level = kvm_timer_should_fire(vtimer);
>  	kvm_timer_update_irq(vcpu, level, vtimer);
>  
> +	if (has_vhe()) {
> +		level = kvm_timer_should_fire(ptimer);
> +		kvm_timer_update_irq(vcpu, level, ptimer);
> +
> +		return;
> +	}
> +
>  	phys_timer_emulate(vcpu);
>  
>  	if (kvm_timer_should_fire(ptimer) != ptimer->irq.level)
>  		kvm_timer_update_irq(vcpu, !ptimer->irq.level, ptimer);
>  }
>  
> -static void vtimer_save_state(struct kvm_vcpu *vcpu)
> +static void timer_save_state(struct arch_timer_context *ctx)
>  {
> -	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
> -	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
> +	struct arch_timer_cpu *timer = vcpu_timer(ctx->vcpu);
> +	enum kvm_arch_timers index = arch_timer_ctx_index(ctx);
>  	unsigned long flags;
>  
> +	if (!timer->enabled)
> +		return;
> +
>  	local_irq_save(flags);
>  
>  	if (timer->loaded == TIMER_NOT_LOADED)
>  		goto out;
>  
> -	if (timer->enabled) {
> -		vtimer->cnt_ctl = read_sysreg_el0(cntv_ctl);
> -		vtimer->cnt_cval = read_sysreg_el0(cntv_cval);
> -	}
> +	switch (index) {
> +	case TIMER_VTIMER:
> +		ctx->cnt_ctl = read_sysreg_el0(cntv_ctl);
> +		ctx->cnt_cval = read_sysreg_el0(cntv_cval);
>  
> -	/* Disable the virtual timer */
> -	write_sysreg_el0(0, cntv_ctl);
> -	isb();
> +		/* Disable the timer */
> +		write_sysreg_el0(0, cntv_ctl);
> +		isb();
> +
> +		break;
> +	case TIMER_PTIMER:
> +		ctx->cnt_ctl = read_sysreg_el0(cntp_ctl);
> +		ctx->cnt_cval = read_sysreg_el0(cntp_cval);
> +
> +		/* Disable the timer */
> +		write_sysreg_el0(0, cntp_ctl);
> +		isb();
> +
> +		break;
> +	case NR_KVM_TIMERS:
> +		break; /* GCC is braindead */
> +	}
>  
>  	timer->loaded = TIMER_NOT_LOADED;
>  out:
> @@ -382,21 +424,33 @@ static void kvm_timer_unblocking(struct kvm_vcpu *vcpu)
>  	soft_timer_cancel(&timer->bg_timer);
>  }
>  
> -static void vtimer_restore_state(struct kvm_vcpu *vcpu)
> +static void timer_restore_state(struct arch_timer_context *ctx)
>  {
> -	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
> -	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
> +	struct arch_timer_cpu *timer = vcpu_timer(ctx->vcpu);
> +	enum kvm_arch_timers index = arch_timer_ctx_index(ctx);
>  	unsigned long flags;
>  
> +	if (!timer->enabled)
> +		return;
> +
>  	local_irq_save(flags);
>  
>  	if (timer->loaded == TIMER_EL1_LOADED)
>  		goto out;
>  
> -	if (timer->enabled) {
> -		write_sysreg_el0(vtimer->cnt_cval, cntv_cval);
> +	switch (index) {
> +	case TIMER_VTIMER:
> +		write_sysreg_el0(ctx->cnt_cval, cntv_cval);
> +		isb();
> +		write_sysreg_el0(ctx->cnt_ctl, cntv_ctl);
> +		break;
> +	case TIMER_PTIMER:
> +		write_sysreg_el0(ctx->cnt_cval, cntp_cval);
>  		isb();
> -		write_sysreg_el0(vtimer->cnt_ctl, cntv_ctl);
> +		write_sysreg_el0(ctx->cnt_ctl, cntp_ctl);
> +		break;
> +	case NR_KVM_TIMERS:
> +		break; /* GCC is braindead */
>  	}
>  
>  	timer->loaded = TIMER_EL1_LOADED;
> @@ -419,23 +473,23 @@ static void set_cntvoff(u64 cntvoff)
>  	kvm_call_hyp(__kvm_timer_set_cntvoff, low, high);
>  }
>  
> -static inline void set_vtimer_irq_phys_active(struct kvm_vcpu *vcpu, bool active)
> +static inline void set_timer_irq_phys_active(struct arch_timer_context *ctx, bool active)
>  {
>  	int r;
> -	r = irq_set_irqchip_state(host_vtimer_irq, IRQCHIP_STATE_ACTIVE, active);
> +	r = irq_set_irqchip_state(ctx->host_timer_irq, IRQCHIP_STATE_ACTIVE, active);
>  	WARN_ON(r);
>  }
>  
> -static void kvm_timer_vcpu_load_gic(struct kvm_vcpu *vcpu)
> +static void kvm_timer_vcpu_load_gic(struct arch_timer_context *ctx)
>  {
> -	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
> +	struct kvm_vcpu *vcpu = ctx->vcpu;
>  	bool phys_active;
>  
>  	if (irqchip_in_kernel(vcpu->kvm))
> -		phys_active = kvm_vgic_map_is_active(vcpu, vtimer->irq.irq);
> +		phys_active = kvm_vgic_map_is_active(vcpu, ctx->irq.irq);
>  	else
> -		phys_active = vtimer->irq.level;
> -	set_vtimer_irq_phys_active(vcpu, phys_active);
> +		phys_active = ctx->irq.level;
> +	set_timer_irq_phys_active(ctx, phys_active);
>  }
>  
>  static void kvm_timer_vcpu_load_nogic(struct kvm_vcpu *vcpu)
> @@ -467,14 +521,22 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
>  	if (unlikely(!timer->enabled))
>  		return;
>  
> -	if (static_branch_likely(&has_gic_active_state))
> -		kvm_timer_vcpu_load_gic(vcpu);
> -	else
> +	if (static_branch_likely(&has_gic_active_state)) {
> +		kvm_timer_vcpu_load_gic(vtimer);
> +		if (has_vhe())
> +			kvm_timer_vcpu_load_gic(ptimer);
> +	} else {
>  		kvm_timer_vcpu_load_nogic(vcpu);
> +	}
>  
>  	set_cntvoff(vtimer->cntvoff);
>  
> -	vtimer_restore_state(vcpu);
> +	timer_restore_state(vtimer);
> +
> +	if (has_vhe()) {
> +		timer_restore_state(ptimer);
> +		return;
> +	}
>  
>  	/* Set the background timer for the physical timer emulation. */
>  	phys_timer_emulate(vcpu);
> @@ -506,12 +568,17 @@ bool kvm_timer_should_notify_user(struct kvm_vcpu *vcpu)
>  void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
>  {
>  	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
> +	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
>  
>  	if (unlikely(!timer->enabled))
>  		return;
>  
> -	vtimer_save_state(vcpu);
> +	timer_save_state(vtimer);
> +	if (has_vhe()) {
> +		timer_save_state(ptimer);
> +		return;
> +	}
>  
>  	/*
>  	 * Cancel the physical timer emulation, because the only case where we
> @@ -534,8 +601,7 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
>  	 * counter of non-VHE case. For VHE, the virtual counter uses a fixed
>  	 * virtual offset of zero, so no need to zero CNTVOFF_EL2 register.
>  	 */
> -	if (!has_vhe())
> -		set_cntvoff(0);
> +	set_cntvoff(0);
>  }
>  
>  /*
> @@ -550,7 +616,7 @@ static void unmask_vtimer_irq_user(struct kvm_vcpu *vcpu)
>  	if (!kvm_timer_should_fire(vtimer)) {
>  		kvm_timer_update_irq(vcpu, false, vtimer);
>  		if (static_branch_likely(&has_gic_active_state))
> -			set_vtimer_irq_phys_active(vcpu, false);
> +			set_timer_irq_phys_active(vtimer, false);
>  		else
>  			enable_percpu_irq(host_vtimer_irq, host_vtimer_irq_flags);
>  	}
> @@ -625,7 +691,12 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  	ptimer->hrtimer.function = kvm_phys_timer_expire;
>  
>  	vtimer->irq.irq = default_vtimer_irq.irq;
> +	vtimer->host_timer_irq = host_vtimer_irq;
> +	vtimer->host_timer_irq_flags = host_vtimer_irq_flags;
> +
>  	ptimer->irq.irq = default_ptimer_irq.irq;
> +	ptimer->host_timer_irq = host_ptimer_irq;
> +	ptimer->host_timer_irq_flags = host_ptimer_irq_flags;
>  
>  	vtimer->vcpu = vcpu;
>  	ptimer->vcpu = vcpu;
> @@ -634,6 +705,7 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  static void kvm_timer_init_interrupt(void *info)
>  {
>  	enable_percpu_irq(host_vtimer_irq, host_vtimer_irq_flags);
> +	enable_percpu_irq(host_ptimer_irq, host_ptimer_irq_flags);
>  }
>  
>  int kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu, u64 regid, u64 value)
> @@ -814,6 +886,8 @@ int kvm_timer_hyp_init(bool has_gic)
>  		return -ENODEV;
>  	}
>  
> +	/* First, do the virtual EL1 timer irq */
> +
>  	if (info->virtual_irq <= 0) {
>  		kvm_err("kvm_arch_timer: invalid virtual timer IRQ: %d\n",
>  			info->virtual_irq);
> @@ -824,15 +898,15 @@ int kvm_timer_hyp_init(bool has_gic)
>  	host_vtimer_irq_flags = irq_get_trigger_type(host_vtimer_irq);
>  	if (host_vtimer_irq_flags != IRQF_TRIGGER_HIGH &&
>  	    host_vtimer_irq_flags != IRQF_TRIGGER_LOW) {
> -		kvm_err("Invalid trigger for IRQ%d, assuming level low\n",
> +		kvm_err("Invalid trigger for vtimer IRQ%d, assuming level low\n",
>  			host_vtimer_irq);
>  		host_vtimer_irq_flags = IRQF_TRIGGER_LOW;
>  	}
>  
>  	err = request_percpu_irq(host_vtimer_irq, kvm_arch_timer_handler,
> -				 "kvm guest timer", kvm_get_running_vcpus());
> +				 "kvm guest vtimer", kvm_get_running_vcpus());
>  	if (err) {
> -		kvm_err("kvm_arch_timer: can't request interrupt %d (%d)\n",
> +		kvm_err("kvm_arch_timer: can't request vtimer interrupt %d (%d)\n",
>  			host_vtimer_irq, err);
>  		return err;
>  	}
> @@ -850,6 +924,38 @@ int kvm_timer_hyp_init(bool has_gic)
>  
>  	kvm_debug("virtual timer IRQ%d\n", host_vtimer_irq);
>  
> +	/* Now let's do the physical EL1 timer irq */
> +
> +	if (info->physical_irq > 0) {
> +		host_ptimer_irq = info->physical_irq;
> +		host_ptimer_irq_flags = irq_get_trigger_type(host_ptimer_irq);
> +		if (host_ptimer_irq_flags != IRQF_TRIGGER_HIGH &&
> +		    host_ptimer_irq_flags != IRQF_TRIGGER_LOW) {
> +			kvm_err("Invalid trigger for ptimer IRQ%d, assuming level low\n",
> +				host_ptimer_irq);
> +			host_ptimer_irq_flags = IRQF_TRIGGER_LOW;
> +		}
> +
> +		err = request_percpu_irq(host_ptimer_irq, kvm_arch_timer_handler,
> +					 "kvm guest ptimer", kvm_get_running_vcpus());
> +		if (err) {
> +			kvm_err("kvm_arch_timer: can't request ptimer interrupt %d (%d)\n",
> +				host_ptimer_irq, err);
> +			return err;
> +		}
> +
> +		if (has_gic) {
> +			err = irq_set_vcpu_affinity(host_ptimer_irq,
> +						    kvm_get_running_vcpus());
> +			if (err) {
> +				kvm_err("kvm_arch_timer: error setting vcpu affinity\n");
> +				goto out_free_irq;
> +			}
> +		}
> +
> +		kvm_debug("physical timer IRQ%d\n", host_ptimer_irq);
> +	}
> +
>  	cpuhp_setup_state(CPUHP_AP_KVM_ARM_TIMER_STARTING,
>  			  "kvm/arm/timer:starting", kvm_timer_starting_cpu,
>  			  kvm_timer_dying_cpu);
> @@ -897,8 +1003,10 @@ bool kvm_arch_timer_get_input_level(int vintid)
>  
>  	if (vintid == vcpu_vtimer(vcpu)->irq.irq)
>  		timer = vcpu_vtimer(vcpu);
> +	else if (vintid == vcpu_ptimer(vcpu)->irq.irq)
> +		timer = vcpu_ptimer(vcpu);
>  	else
> -		BUG(); /* We only map the vtimer so far */
> +		BUG();
>  
>  	return kvm_timer_should_fire(timer);
>  }
> @@ -907,6 +1015,7 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
>  {
>  	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
> +	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
>  	int ret;
>  
>  	if (timer->enabled)
> @@ -929,6 +1038,13 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
>  	if (ret)
>  		return ret;
>  
> +	if (has_vhe()) {
> +		ret = kvm_vgic_map_phys_irq(vcpu, host_ptimer_irq, ptimer->irq.irq,
> +					    kvm_arch_timer_get_input_level);
> +		if (ret)
> +			return ret;
> +	}
> +
>  no_vgic:
>  	timer->enabled = 1;
>  	return 0;
> @@ -951,7 +1067,7 @@ void kvm_timer_init_vhe(void)
>  	 * Physical counter access is allowed.
>  	 */
This trimmed comment and the comment for the function still state that physical
timer access is trapped from the guest. I think both comments should be updated
to reflect that that isn't the case anymore.
>  	val = read_sysreg(cnthctl_el2);
> -	val &= ~(CNTHCTL_EL1PCEN << cnthctl_shift);
> +	val |= (CNTHCTL_EL1PCEN << cnthctl_shift);
>  	val |= (CNTHCTL_EL1PCTEN << cnthctl_shift);
>  	write_sysreg(val, cnthctl_el2);
>  }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
