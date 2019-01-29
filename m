Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0527DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:04:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30E22087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LJDFy4tU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30E22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pt0RV8Y6+qlNvmAsCTz/7HzkRWdKk76Nq42XgwFKLUQ=; b=LJDFy4tURFVnGk
	5TOvjHX+UQgJTvsgqBRq+w0mZcD19LBVMa/sMky0rH/o3s7aH4Y1hcT3Ca9PTS+J6LQSaA55Pa+xB
	O6KqT3PXz4KpkfK+rNnJLhx1KEQ76QOrPm88gM1ea/QkFeFz3CnWgpwXKsnrtUIQJE57BnO8B53ez
	rbSS7bxcuUtqiDAdW15+ETX5kxzrjs4g4972jq+PxDjdKPIZYjwD/6DIioakX1Zhd59l3+C1o5+PV
	6e+N9ArYohV08oj76k3GFBOO+EHunnaiMS/UCVaDXHhCk+kGfLyv38PeFRPk6ngxYHlb859gQ4/2k
	Wu5dwEy/NAWGwh5K63kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVrg-0007kq-4n; Tue, 29 Jan 2019 16:03:56 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVrc-0007kM-LQ
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:03:54 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09AD8A909;
 Tue, 29 Jan 2019 16:03:52 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7090845F01;
 Tue, 29 Jan 2019 16:03:50 +0000 (UTC)
Date: Tue, 29 Jan 2019 17:03:47 +0100
From: Andrew Jones <drjones@redhat.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH 2/5] arm/arm64: KVM: Allow a VCPU to fully reset itself
Message-ID: <20190129160347.fcbry76igwyatqzx@kamzik.brq.redhat.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-3-christoffer.dall@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125094656.5026-3-christoffer.dall@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 29 Jan 2019 16:03:52 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_080352_744526_C47F3752 
X-CRM114-Status: GOOD (  32.20  )
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

On Fri, Jan 25, 2019 at 10:46:53AM +0100, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> The current kvm_psci_vcpu_on implementation will directly try to
> manipulate the state of the VCPU to reset it.  However, since this is
> not done on the thread that runs the VCPU, we can end up in a strangely
> corrupted state when the source and target VCPUs are running at the same
> time.
> 
> Fix this by factoring out all reset logic from the PSCI implementation
> and forwarding the required information along with a request to the
> target VCPU.

The last patch makes more sense, now that I see this one. I guess their
order should be swapped.

> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   | 10 +++++++++
>  arch/arm/kvm/reset.c              | 24 +++++++++++++++++++++
>  arch/arm64/include/asm/kvm_host.h | 11 ++++++++++
>  arch/arm64/kvm/reset.c            | 24 +++++++++++++++++++++
>  virt/kvm/arm/arm.c                | 10 +++++++++
>  virt/kvm/arm/psci.c               | 36 ++++++++++++++-----------------
>  6 files changed, 95 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index ca56537b61bc..50e89869178a 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -48,6 +48,7 @@
>  #define KVM_REQ_SLEEP \
>  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
> +#define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
>  
>  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
>  
> @@ -147,6 +148,13 @@ struct kvm_cpu_context {
>  
>  typedef struct kvm_cpu_context kvm_cpu_context_t;
>  
> +struct vcpu_reset_state {
> +	unsigned long	pc;
> +	unsigned long	r0;
> +	bool		be;
> +	bool		reset;
> +};
> +
>  struct kvm_vcpu_arch {
>  	struct kvm_cpu_context ctxt;
>  
> @@ -186,6 +194,8 @@ struct kvm_vcpu_arch {
>  	/* Cache some mmu pages needed inside spinlock regions */
>  	struct kvm_mmu_memory_cache mmu_page_cache;
>  
> +	struct vcpu_reset_state reset_state;
> +
>  	/* Detect first run of a vcpu */
>  	bool has_run_once;
>  };
> diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
> index 5ed0c3ee33d6..de41255eebcd 100644
> --- a/arch/arm/kvm/reset.c
> +++ b/arch/arm/kvm/reset.c
> @@ -26,6 +26,7 @@
>  #include <asm/cputype.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_coproc.h>
> +#include <asm/kvm_emulate.h>
>  
>  #include <kvm/arm_arch_timer.h>
>  
> @@ -69,6 +70,29 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  	/* Reset CP15 registers */
>  	kvm_reset_coprocs(vcpu);
>  
> +	/*
> +	 * Additional reset state handling that PSCI may have imposed on us.
> +	 * Must be done after all the sys_reg reset.
> +	 */
> +	if (vcpu->arch.reset_state.reset) {
> +		unsigned long target_pc = vcpu->arch.reset_state.pc;
> +
> +		/* Gracefully handle Thumb2 entry point */
> +		if (target_pc & 1) {
> +			target_pc &= ~1UL;
> +			vcpu_set_thumb(vcpu);
> +		}
> +
> +		/* Propagate caller endianness */
> +		if (vcpu->arch.reset_state.be)
> +			kvm_vcpu_set_be(vcpu);
> +
> +		*vcpu_pc(vcpu) = target_pc;
> +		vcpu_set_reg(vcpu, 0, vcpu->arch.reset_state.r0);
> +
> +		vcpu->arch.reset_state.reset = false;
> +	}
> +
>  	/* Reset arch_timer context */
>  	return kvm_timer_vcpu_reset(vcpu);
>  }
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 7732d0ba4e60..da3fc7324d68 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -48,6 +48,7 @@
>  #define KVM_REQ_SLEEP \
>  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
> +#define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
>  
>  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
>  
> @@ -208,6 +209,13 @@ struct kvm_cpu_context {
>  
>  typedef struct kvm_cpu_context kvm_cpu_context_t;
>  
> +struct vcpu_reset_state {
> +	unsigned long	pc;
> +	unsigned long	r0;
> +	bool		be;
> +	bool		reset;
> +};
> +
>  struct kvm_vcpu_arch {
>  	struct kvm_cpu_context ctxt;
>  
> @@ -297,6 +305,9 @@ struct kvm_vcpu_arch {
>  	/* Virtual SError ESR to restore when HCR_EL2.VSE is set */
>  	u64 vsesr_el2;
>  
> +	/* Additional reset state */
> +	struct vcpu_reset_state	reset_state;
> +
>  	/* True when deferrable sysregs are loaded on the physical CPU,
>  	 * see kvm_vcpu_load_sysregs and kvm_vcpu_put_sysregs. */
>  	bool sysregs_loaded_on_cpu;
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index f21a2a575939..f16a5f8ff2b4 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -32,6 +32,7 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_coproc.h>
> +#include <asm/kvm_emulate.h>
>  #include <asm/kvm_mmu.h>
>  
>  /* Maximum phys_shift supported for any VM on this host */
> @@ -146,6 +147,29 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  	/* Reset system registers */
>  	kvm_reset_sys_regs(vcpu);
>  
> +	/*
> +	 * Additional reset state handling that PSCI may have imposed on us.
> +	 * Must be done after all the sys_reg reset.
> +	 */
> +	if (vcpu->arch.reset_state.reset) {
> +		unsigned long target_pc = vcpu->arch.reset_state.pc;
> +
> +		/* Gracefully handle Thumb2 entry point */
> +		if (vcpu_mode_is_32bit(vcpu) && (target_pc & 1)) {
> +			target_pc &= ~1UL;
> +			vcpu_set_thumb(vcpu);
> +		}
> +
> +		/* Propagate caller endianness */
> +		if (vcpu->arch.reset_state.be)
> +			kvm_vcpu_set_be(vcpu);
> +
> +		*vcpu_pc(vcpu) = target_pc;
> +		vcpu_set_reg(vcpu, 0, vcpu->arch.reset_state.r0);
> +
> +		vcpu->arch.reset_state.reset = false;
> +	}
> +
>  	/* Reset PMU */
>  	kvm_pmu_vcpu_reset(vcpu);
>  
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 9e350fd34504..9c486fad3f9f 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -626,6 +626,13 @@ static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
>  		/* Awaken to handle a signal, request we sleep again later. */
>  		kvm_make_request(KVM_REQ_SLEEP, vcpu);
>  	}
> +
> +	/*
> +	 * Make sure we will observe a potential reset request if we've
> +	 * observed a change to the power state. Pairs with the smp_wmb() in
> +	 * kvm_psci_vcpu_on().
> +	 */
> +	smp_rmb();

I don't believe this should be necessary, because...

>  }
>  
>  static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
> @@ -639,6 +646,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
>  		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
>  			vcpu_req_sleep(vcpu);
>  
> +		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
> +			kvm_reset_vcpu(vcpu);

... we do kvm_check_request here before using the reset data, and we do...

> +
>  		/*
>  		 * Clear IRQ_PENDING requests that were made to guarantee
>  		 * that a VCPU sees new virtual interrupts.
> diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> index 9b73d3ad918a..b9cff1d4b06d 100644
> --- a/virt/kvm/arm/psci.c
> +++ b/virt/kvm/arm/psci.c
> @@ -104,12 +104,10 @@ static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
>  
>  static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  {
> +	struct vcpu_reset_state *reset_state;
>  	struct kvm *kvm = source_vcpu->kvm;
>  	struct kvm_vcpu *vcpu = NULL;
> -	struct swait_queue_head *wq;
>  	unsigned long cpu_id;
> -	unsigned long context_id;
> -	phys_addr_t target_pc;
>  
>  	cpu_id = smccc_get_arg1(source_vcpu) & MPIDR_HWID_BITMASK;
>  	if (vcpu_mode_is_32bit(source_vcpu))
> @@ -130,32 +128,30 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  			return PSCI_RET_INVALID_PARAMS;
>  	}
>  
> -	target_pc = smccc_get_arg2(source_vcpu);
> -	context_id = smccc_get_arg3(source_vcpu);
> +	reset_state = &vcpu->arch.reset_state;
>  
> -	kvm_reset_vcpu(vcpu);
> -
> -	/* Gracefully handle Thumb2 entry point */
> -	if (vcpu_mode_is_32bit(vcpu) && (target_pc & 1)) {
> -		target_pc &= ~((phys_addr_t) 1);
> -		vcpu_set_thumb(vcpu);
> -	}
> +	reset_state->pc = smccc_get_arg2(source_vcpu);
>  
>  	/* Propagate caller endianness */
> -	if (kvm_vcpu_is_be(source_vcpu))
> -		kvm_vcpu_set_be(vcpu);
> +	reset_state->be = kvm_vcpu_is_be(source_vcpu);
>  
> -	*vcpu_pc(vcpu) = target_pc;
>  	/*
>  	 * NOTE: We always update r0 (or x0) because for PSCI v0.1
>  	 * the general puspose registers are undefined upon CPU_ON.
>  	 */
> -	smccc_set_retval(vcpu, context_id, 0, 0, 0);
> -	vcpu->arch.power_off = false;
> -	smp_mb();		/* Make sure the above is visible */
> +	reset_state->r0 = smccc_get_arg3(source_vcpu);
> +
> +	reset_state->reset = true;
> +	kvm_make_request(KVM_REQ_VCPU_RESET, vcpu);

... this kvm_make_request() after writing the reset data. The
kvm_make_request/kvm_check_request embeds the necessary barriers.

>  
> -	wq = kvm_arch_vcpu_wq(vcpu);
> -	swake_up_one(wq);
> +	/*
> +	 * Make sure the reset request is observed if the change to
> +	 * power_state is observed.
> +	 */
> +	smp_wmb();
> +
> +	vcpu->arch.power_off = false;

Or you want to tie the reset data to the observability of the power_off
state? Why not just tie it to the KVM_REQ_VCPU_RESET request?

> +	kvm_vcpu_wake_up(vcpu);
>  
>  	return PSCI_RET_SUCCESS;
>  }
> -- 
> 2.18.0
> 

Thanks,
drew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
