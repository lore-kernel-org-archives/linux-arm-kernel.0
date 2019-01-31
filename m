Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C825C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1A52087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ikU3GF6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1A52087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ckv5Wh2F7qaeB2YnBLh3Jt+7GaRQ7BZ8e64kjA41eQw=; b=ikU3GF6ea9zeZE
	ML76ySebMs/URPcuxFK16Ka7TbTBm6y9SiFaFizd5GEO7L5bhU2wm5OgLOUXSMwlK6e6M3D2gxaYi
	HqEFxUFc7GvNnjpdyX7cJ4/5DXTbFwnNqTEY5CwWiDLkEeXBCoDMnqlA4B6OdNqKzEfBRLXVltKGE
	OwhWjIBNWJgTHpm24FFDdzHgnO168lN6Vd5Ww2r47FBpIIQ4K4+0LawMLrXARkutOR8LnVU1RSN2Y
	F9sJyMChiDeE+koAlFp7lWxERcDqzAJlM8VHKBOGbeqznIiR34AaEeOR8dCyoL4NQRTb0qG1+ZKqE
	P3AqO4zPJctjMYXXTLtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpAti-0004vy-4h; Thu, 31 Jan 2019 11:52:46 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpAsy-0004Ga-0r
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 11:52:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E752D80D;
 Thu, 31 Jan 2019 03:51:58 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 809A23F557;
 Thu, 31 Jan 2019 03:51:58 -0800 (PST)
Date: Thu, 31 Jan 2019 12:51:56 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 2/5] arm/arm64: KVM: Allow a VCPU to fully reset itself
Message-ID: <20190131115156.GP13482@e113682-lin.lund.arm.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-3-christoffer.dall@arm.com>
 <20190129160347.fcbry76igwyatqzx@kamzik.brq.redhat.com>
 <20190130093431.GE13482@e113682-lin.lund.arm.com>
 <20190130152721.7fbiza3glifvzlqk@kamzik.brq.redhat.com>
 <20190131074353.GI13482@e113682-lin.lund.arm.com>
 <20190131101254.rh23ntvwxtq3yqsz@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131101254.rh23ntvwxtq3yqsz@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_035200_480890_FE9E8CDC 
X-CRM114-Status: GOOD (  38.54  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 11:12:54AM +0100, Andrew Jones wrote:
> On Thu, Jan 31, 2019 at 08:43:53AM +0100, Christoffer Dall wrote:
> > On Wed, Jan 30, 2019 at 04:27:21PM +0100, Andrew Jones wrote:
> > > On Wed, Jan 30, 2019 at 10:34:31AM +0100, Christoffer Dall wrote:
> > > > On Tue, Jan 29, 2019 at 05:03:47PM +0100, Andrew Jones wrote:
> > > > > On Fri, Jan 25, 2019 at 10:46:53AM +0100, Christoffer Dall wrote:
> > > > > > From: Marc Zyngier <marc.zyngier@arm.com>
> > > > > > 
> > > > > > The current kvm_psci_vcpu_on implementation will directly try to
> > > > > > manipulate the state of the VCPU to reset it.  However, since this is
> > > > > > not done on the thread that runs the VCPU, we can end up in a strangely
> > > > > > corrupted state when the source and target VCPUs are running at the same
> > > > > > time.
> > > > > > 
> > > > > > Fix this by factoring out all reset logic from the PSCI implementation
> > > > > > and forwarding the required information along with a request to the
> > > > > > target VCPU.
> > > > > 
> > > > > The last patch makes more sense, now that I see this one. I guess their
> > > > > order should be swapped.
> > > > > 
> > > > > > 
> > > > > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > > > > Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> > > > > > ---
> > > > > >  arch/arm/include/asm/kvm_host.h   | 10 +++++++++
> > > > > >  arch/arm/kvm/reset.c              | 24 +++++++++++++++++++++
> > > > > >  arch/arm64/include/asm/kvm_host.h | 11 ++++++++++
> > > > > >  arch/arm64/kvm/reset.c            | 24 +++++++++++++++++++++
> > > > > >  virt/kvm/arm/arm.c                | 10 +++++++++
> > > > > >  virt/kvm/arm/psci.c               | 36 ++++++++++++++-----------------
> > > > > >  6 files changed, 95 insertions(+), 20 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> > > > > > index ca56537b61bc..50e89869178a 100644
> > > > > > --- a/arch/arm/include/asm/kvm_host.h
> > > > > > +++ b/arch/arm/include/asm/kvm_host.h
> > > > > > @@ -48,6 +48,7 @@
> > > > > >  #define KVM_REQ_SLEEP \
> > > > > >  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> > > > > >  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
> > > > > > +#define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
> > > > > >  
> > > > > >  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
> > > > > >  
> > > > > > @@ -147,6 +148,13 @@ struct kvm_cpu_context {
> > > > > >  
> > > > > >  typedef struct kvm_cpu_context kvm_cpu_context_t;
> > > > > >  
> > > > > > +struct vcpu_reset_state {
> > > > > > +	unsigned long	pc;
> > > > > > +	unsigned long	r0;
> > > > > > +	bool		be;
> > > > > > +	bool		reset;
> > > > > > +};
> > > > > > +
> > > > > >  struct kvm_vcpu_arch {
> > > > > >  	struct kvm_cpu_context ctxt;
> > > > > >  
> > > > > > @@ -186,6 +194,8 @@ struct kvm_vcpu_arch {
> > > > > >  	/* Cache some mmu pages needed inside spinlock regions */
> > > > > >  	struct kvm_mmu_memory_cache mmu_page_cache;
> > > > > >  
> > > > > > +	struct vcpu_reset_state reset_state;
> > > > > > +
> > > > > >  	/* Detect first run of a vcpu */
> > > > > >  	bool has_run_once;
> > > > > >  };
> > > > > > diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
> > > > > > index 5ed0c3ee33d6..de41255eebcd 100644
> > > > > > --- a/arch/arm/kvm/reset.c
> > > > > > +++ b/arch/arm/kvm/reset.c
> > > > > > @@ -26,6 +26,7 @@
> > > > > >  #include <asm/cputype.h>
> > > > > >  #include <asm/kvm_arm.h>
> > > > > >  #include <asm/kvm_coproc.h>
> > > > > > +#include <asm/kvm_emulate.h>
> > > > > >  
> > > > > >  #include <kvm/arm_arch_timer.h>
> > > > > >  
> > > > > > @@ -69,6 +70,29 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> > > > > >  	/* Reset CP15 registers */
> > > > > >  	kvm_reset_coprocs(vcpu);
> > > > > >  
> > > > > > +	/*
> > > > > > +	 * Additional reset state handling that PSCI may have imposed on us.
> > > > > > +	 * Must be done after all the sys_reg reset.
> > > > > > +	 */
> > > > > > +	if (vcpu->arch.reset_state.reset) {
> > > > > > +		unsigned long target_pc = vcpu->arch.reset_state.pc;
> > > > > > +
> > > > > > +		/* Gracefully handle Thumb2 entry point */
> > > > > > +		if (target_pc & 1) {
> > > > > > +			target_pc &= ~1UL;
> > > > > > +			vcpu_set_thumb(vcpu);
> > > > > > +		}
> > > > > > +
> > > > > > +		/* Propagate caller endianness */
> > > > > > +		if (vcpu->arch.reset_state.be)
> > > > > > +			kvm_vcpu_set_be(vcpu);
> > > > > > +
> > > > > > +		*vcpu_pc(vcpu) = target_pc;
> > > > > > +		vcpu_set_reg(vcpu, 0, vcpu->arch.reset_state.r0);
> > > > > > +
> > > > > > +		vcpu->arch.reset_state.reset = false;
> > > > > > +	}
> > > > > > +
> > > > > >  	/* Reset arch_timer context */
> > > > > >  	return kvm_timer_vcpu_reset(vcpu);
> > > > > >  }
> > > > > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > > > > index 7732d0ba4e60..da3fc7324d68 100644
> > > > > > --- a/arch/arm64/include/asm/kvm_host.h
> > > > > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > > > > @@ -48,6 +48,7 @@
> > > > > >  #define KVM_REQ_SLEEP \
> > > > > >  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> > > > > >  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
> > > > > > +#define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
> > > > > >  
> > > > > >  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
> > > > > >  
> > > > > > @@ -208,6 +209,13 @@ struct kvm_cpu_context {
> > > > > >  
> > > > > >  typedef struct kvm_cpu_context kvm_cpu_context_t;
> > > > > >  
> > > > > > +struct vcpu_reset_state {
> > > > > > +	unsigned long	pc;
> > > > > > +	unsigned long	r0;
> > > > > > +	bool		be;
> > > > > > +	bool		reset;
> > > > > > +};
> > > > > > +
> > > > > >  struct kvm_vcpu_arch {
> > > > > >  	struct kvm_cpu_context ctxt;
> > > > > >  
> > > > > > @@ -297,6 +305,9 @@ struct kvm_vcpu_arch {
> > > > > >  	/* Virtual SError ESR to restore when HCR_EL2.VSE is set */
> > > > > >  	u64 vsesr_el2;
> > > > > >  
> > > > > > +	/* Additional reset state */
> > > > > > +	struct vcpu_reset_state	reset_state;
> > > > > > +
> > > > > >  	/* True when deferrable sysregs are loaded on the physical CPU,
> > > > > >  	 * see kvm_vcpu_load_sysregs and kvm_vcpu_put_sysregs. */
> > > > > >  	bool sysregs_loaded_on_cpu;
> > > > > > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > > > > > index f21a2a575939..f16a5f8ff2b4 100644
> > > > > > --- a/arch/arm64/kvm/reset.c
> > > > > > +++ b/arch/arm64/kvm/reset.c
> > > > > > @@ -32,6 +32,7 @@
> > > > > >  #include <asm/kvm_arm.h>
> > > > > >  #include <asm/kvm_asm.h>
> > > > > >  #include <asm/kvm_coproc.h>
> > > > > > +#include <asm/kvm_emulate.h>
> > > > > >  #include <asm/kvm_mmu.h>
> > > > > >  
> > > > > >  /* Maximum phys_shift supported for any VM on this host */
> > > > > > @@ -146,6 +147,29 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> > > > > >  	/* Reset system registers */
> > > > > >  	kvm_reset_sys_regs(vcpu);
> > > > > >  
> > > > > > +	/*
> > > > > > +	 * Additional reset state handling that PSCI may have imposed on us.
> > > > > > +	 * Must be done after all the sys_reg reset.
> > > > > > +	 */
> > > > > > +	if (vcpu->arch.reset_state.reset) {
> > > > > > +		unsigned long target_pc = vcpu->arch.reset_state.pc;
> > > > > > +
> > > > > > +		/* Gracefully handle Thumb2 entry point */
> > > > > > +		if (vcpu_mode_is_32bit(vcpu) && (target_pc & 1)) {
> > > > > > +			target_pc &= ~1UL;
> > > > > > +			vcpu_set_thumb(vcpu);
> > > > > > +		}
> > > > > > +
> > > > > > +		/* Propagate caller endianness */
> > > > > > +		if (vcpu->arch.reset_state.be)
> > > > > > +			kvm_vcpu_set_be(vcpu);
> > > > > > +
> > > > > > +		*vcpu_pc(vcpu) = target_pc;
> > > > > > +		vcpu_set_reg(vcpu, 0, vcpu->arch.reset_state.r0);
> > > > > > +
> > > > > > +		vcpu->arch.reset_state.reset = false;
> > > > > > +	}
> > > > > > +
> > > > > >  	/* Reset PMU */
> > > > > >  	kvm_pmu_vcpu_reset(vcpu);
> > > > > >  
> > > > > > diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> > > > > > index 9e350fd34504..9c486fad3f9f 100644
> > > > > > --- a/virt/kvm/arm/arm.c
> > > > > > +++ b/virt/kvm/arm/arm.c
> > > > > > @@ -626,6 +626,13 @@ static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
> > > > > >  		/* Awaken to handle a signal, request we sleep again later. */
> > > > > >  		kvm_make_request(KVM_REQ_SLEEP, vcpu);
> > > > > >  	}
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Make sure we will observe a potential reset request if we've
> > > > > > +	 * observed a change to the power state. Pairs with the smp_wmb() in
> > > > > > +	 * kvm_psci_vcpu_on().
> > > > > > +	 */
> > > > > > +	smp_rmb();
> > > > > 
> > > > > I don't believe this should be necessary, because...
> > > > > 
> > > > > >  }
> > > > > >  
> > > > > >  static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
> > > > > > @@ -639,6 +646,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
> > > > > >  		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
> > > > > >  			vcpu_req_sleep(vcpu);
> > > > > >  
> > > > > > +		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
> > > > > > +			kvm_reset_vcpu(vcpu);
> > > > > 
> > > > > ... we do kvm_check_request here before using the reset data, and we do...
> > > > > 
> > > > > > +
> > > > > >  		/*
> > > > > >  		 * Clear IRQ_PENDING requests that were made to guarantee
> > > > > >  		 * that a VCPU sees new virtual interrupts.
> > > > > > diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> > > > > > index 9b73d3ad918a..b9cff1d4b06d 100644
> > > > > > --- a/virt/kvm/arm/psci.c
> > > > > > +++ b/virt/kvm/arm/psci.c
> > > > > > @@ -104,12 +104,10 @@ static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
> > > > > >  
> > > > > >  static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
> > > > > >  {
> > > > > > +	struct vcpu_reset_state *reset_state;
> > > > > >  	struct kvm *kvm = source_vcpu->kvm;
> > > > > >  	struct kvm_vcpu *vcpu = NULL;
> > > > > > -	struct swait_queue_head *wq;
> > > > > >  	unsigned long cpu_id;
> > > > > > -	unsigned long context_id;
> > > > > > -	phys_addr_t target_pc;
> > > > > >  
> > > > > >  	cpu_id = smccc_get_arg1(source_vcpu) & MPIDR_HWID_BITMASK;
> > > > > >  	if (vcpu_mode_is_32bit(source_vcpu))
> > > > > > @@ -130,32 +128,30 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
> > > > > >  			return PSCI_RET_INVALID_PARAMS;
> > > > > >  	}
> > > > > >  
> > > > > > -	target_pc = smccc_get_arg2(source_vcpu);
> > > > > > -	context_id = smccc_get_arg3(source_vcpu);
> > > > > > +	reset_state = &vcpu->arch.reset_state;
> > > > > >  
> > > > > > -	kvm_reset_vcpu(vcpu);
> > > > > > -
> > > > > > -	/* Gracefully handle Thumb2 entry point */
> > > > > > -	if (vcpu_mode_is_32bit(vcpu) && (target_pc & 1)) {
> > > > > > -		target_pc &= ~((phys_addr_t) 1);
> > > > > > -		vcpu_set_thumb(vcpu);
> > > > > > -	}
> > > > > > +	reset_state->pc = smccc_get_arg2(source_vcpu);
> > > > > >  
> > > > > >  	/* Propagate caller endianness */
> > > > > > -	if (kvm_vcpu_is_be(source_vcpu))
> > > > > > -		kvm_vcpu_set_be(vcpu);
> > > > > > +	reset_state->be = kvm_vcpu_is_be(source_vcpu);
> > > > > >  
> > > > > > -	*vcpu_pc(vcpu) = target_pc;
> > > > > >  	/*
> > > > > >  	 * NOTE: We always update r0 (or x0) because for PSCI v0.1
> > > > > >  	 * the general puspose registers are undefined upon CPU_ON.
> > > > > >  	 */
> > > > > > -	smccc_set_retval(vcpu, context_id, 0, 0, 0);
> > > > > > -	vcpu->arch.power_off = false;
> > > > > > -	smp_mb();		/* Make sure the above is visible */
> > > > > > +	reset_state->r0 = smccc_get_arg3(source_vcpu);
> > > > > > +
> > > > > > +	reset_state->reset = true;
> > > > > > +	kvm_make_request(KVM_REQ_VCPU_RESET, vcpu);
> > > > > 
> > > > > ... this kvm_make_request() after writing the reset data. The
> > > > > kvm_make_request/kvm_check_request embeds the necessary barriers.
> > > > > 
> > > > > >  
> > > > > > -	wq = kvm_arch_vcpu_wq(vcpu);
> > > > > > -	swake_up_one(wq);
> > > > > > +	/*
> > > > > > +	 * Make sure the reset request is observed if the change to
> > > > > > +	 * power_state is observed.
> > > > > > +	 */
> > > > > > +	smp_wmb();
> > > > > > +
> > > > > > +	vcpu->arch.power_off = false;
> > > > > 
> > > > > Or you want to tie the reset data to the observability of the power_off
> > > > > state? Why not just tie it to the KVM_REQ_VCPU_RESET request?
> > > > > 
> > > > 
> > > > The barrier in kvm_make_request is *before* the write to vcpu->requests,
> > > > so doesn't enforce any ordering of stores occurring *after* that write.
> > > > 
> > > > We don't want to wake up the target VCPU thread, have it observe that it
> > > > is powered on, yet not observe the reset request (my comment above
> > > > inversed).
> > > > 
> > > > I wrote this Litmus test (which is probably so appalingly obvious to
> > > > memory ordering folks that it is unnecessary) to convince myself the
> > > > barrier is needed:
> > > > 
> > > > ----<8----
> > > > C vcpu-reset
> > > > 
> > > > {}
> > > > 
> > > > P0(int *power, int *reset)
> > > > {
> > > > 	smp_wmb(); // from kvm_make_request
> > > > 	WRITE_ONCE(*reset, 1); // kvm_psci_vcpu_on: kvm_make_request(KVM_REQ_RESET, vcpu);
> > > > 	smp_wmb();
> > > > 	WRITE_ONCE(*power, 1); // kvm_psci_vcpu_on: vcpu->arch.power_state = KVM_ARM_VCPU_ON;
> > > > }
> > > > 
> > > > P1(int *power, int *reset, spinlock_t *wqlock)
> > > > {
> > > > 	int r0;
> > > > 	int r1;
> > > > 
> > > > 	spin_lock(wqlock);
> > > > 	smp_mb(); // from prepare_to_wait -> set_current_state
> > > > 	spin_unlock(wqlock);
> > > > 	r0 = READ_ONCE(*power); // vcpu_req_sleep: if (vcpu_sleeping(vcpu))
> > > > 	smp_rmb();
> > > > 	r1 = READ_ONCE(*reset); // check_vcpu_requests: if (kvm_check_request(KVM_REQ_RESET, vcpu))
> > > > }
> > > > 
> > > > exists (1:r0=1 /\ 1:r1=0)
> > > > ----<8----
> > > > 
> > > > 
> > > > Hope this helps,
> > > 
> > > It certainly does, mostly because I didn't review closely enough and
> > > thought the pair we were interested in was vcpu_reset_state and the
> > > RESET vcpu request, which the vcpu request API handles. Now it's
> > > clear we're worried about the pair power_off and the RESET vcpu
> > > request. And we've reversed the usual "if we observe a request, then
> > > we can observe its accompanying data" to "if we observe a change in
> > > some data (power_off), then we need to also observe a request". I
> > > agree the barriers are necessary to ensure that in the direct
> > > sequence, but now I'm wondering if we need to care about the
> > > direct sequence.
> > > 
> > > If we remove the barriers then the vcpu could have these possible
> > > sequences
> > > 
> > > 1)
> > >   - wake up
> > >   - observe power_off is false
> > >   - observe the RESET vcpu request - do the reset
> > >   - enter guest
> > > 
> > > That's the one this patch ensures, so it's definitely correct.
> > > 
> > > 2)
> > >   - wake up
> > >   - the change to power_off not observed - the vcpu makes the
> > >     SLEEP vcpu request on itself
> > >   - observe the RESET vcpu request - do the reset
> > >   - observe the SLEEP vcpu request (with or without the need for
> > >     an IPI), attempt to sleep again, but now observe power_off
> > >     is false
> > >   - enter guest
> > > 
> > > I think that should be correct as well, even if less efficient.
> > > 
> > > 3)
> > >   - wake up
> > >   - observe power_off is false
> > >   - don't observe the RESET request yet, get closer to entering
> > >     the guest
> > >   - observe the RESET request a bit later (with or without the
> > >     need for an IPI) - do the reset
> > >   - enter guest
> > > 
> > > This is the same as (1), but we rely on the kvm_request_pending
> > > stuff to make sure the vcpu request is seen before entering the
> > > guest.
> > > 
> > > 4)
> > >   - wake up
> > >   - the change to power_off not observed - the vcpu makes the
> > >     SLEEP vcpu request on itself
> > >   - don't observe the RESET request yet, get closer to entering
> > >     the guest
> > >   - observe the SLEEP vcpu request (with or without the need for
> > >     an IPI), attempt to sleep again, but now observe power_off
> > >     is false
> > >   - observe the RESET request a bit later (with or without the
> > >     need for an IPI) - do the reset
> > >   - enter guest
> > > 
> > > The least efficient one, but should still be correct.
> > > 
> > > If you agree with this, then we get to remove the barriers,
> > > simplifying things, and also we don't introduce the ordering
> > > dependency in check_vcpu_requests(), where the vcpu_req_sleep()
> > > calls must now come before checking the RESET request.
> > > 
> > 
> > I'm sorry, I'm not following what you want to achieve here?
> > 
> > Somehow delivering a series of possible interleaved executions doesn't
> > exactly convey anything meaningful to me.
> >
> 
> This patch introduces an unconventional use of vcpu requests, which is
> to ensure a change to vcpu->requests is observed if a change to
> arch.power_off is observed. That unconventional use requires additional
> barriers and an ordering requirement in check_vcpu_requests(), i.e.
> anything that calls vcpu_req_sleep() must come before the check for
> the RESET vcpu request. I'm stating, and attempting to prove with the
> list of possible executions, that those barriers and ordering requirements
> are not necessary.
> 
> Assuming the objective is to ensure a vcpu reset is done before entering
> guest mode after a vcpu power on, then the RESET vcpu request is
> sufficient by itself. vcpu requests are guaranteed to be seen by a vcpu
> before entering guest mode.
> 
> Additionally, I'm pretty sure that even leaving this patch as it is,
> all the above execution scenarios are possible except (3), depending on
> the timing of a signal delivery.
> 
> Is there a problem with (3) that I'm missing? Or am I missing something
> else?

There's not a problem with (3), but the question is flawed; you've shown
me a benign execution sequence and somehow you're arguing that the
execution sequence is always correct?

I don't think there's anything very unconventional here.

Let's try this:  If you have a better way of implementing this, how
about you write a patch?


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
