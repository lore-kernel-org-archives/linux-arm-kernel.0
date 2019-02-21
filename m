Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE99C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:57:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E00D214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dCcfAqKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E00D214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=luv/LzFMiygoc7OGoWtvVOwTwvRhN/u2BPj69W6yeq8=; b=dCcfAqKaERRj6u
	KTx2qTuGkE5NGhKEWkAQRC1fkx7Q5d/JBLSseCAEsoIgSDMTXTJaAjm3yQ9GYyjeo9DZPsAERVRi5
	glyts6udrw3WY3F2ALTJKQ4aEnms14vPTCCGSE1OL11YEPqhzLGTz3ZMb+5fbaOHRydxB9SNuzaj7
	eDvkIUoK69OkzZYvLnp5vZUOkrxrDD5G5iycagr8D5Ci6f/HoTTessSxyeKb0kSS1vp0qQr3aj9Rh
	WhHG9ShQ4JlJSkqNhj3k8+sRNli60h9hUewiWYr5GFu7lMeSBiFjHvteYAdGG6asXUAQkYSh3vNtM
	Ne0Elw2z0pof/+QJBbLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmzD-0001nP-Tp; Thu, 21 Feb 2019 11:57:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmz8-0001k7-Or
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 11:57:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0D0080D;
 Thu, 21 Feb 2019 03:57:50 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1231E3F5C1;
 Thu, 21 Feb 2019 03:57:47 -0800 (PST)
Date: Thu, 21 Feb 2019 11:57:45 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCH v6 2/6] arm64/kvm: preserve host MDCR_EL2 value
Message-ID: <20190221115745.GB33673@lakrids.cambridge.arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-3-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550568271-5319-3-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_035751_019991_AB4F598A 
X-CRM114-Status: GOOD (  24.65  )
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
Cc: Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org,
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 James Morse <james.morse@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 02:54:27PM +0530, Amit Daniel Kachhap wrote:
> Save host MDCR_EL2 value during kvm HYP initialisation and restore
> after every switch from host to guest. There should not be any
> change in functionality due to this.
> 
> The value of mdcr_el2 is now stored in struct kvm_cpu_context as
> both host and guest can now use this field in a common way.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  arch/arm/include/asm/kvm_host.h   |  1 -
>  arch/arm64/include/asm/kvm_host.h |  6 ++----
>  arch/arm64/kvm/debug.c            | 28 ++++++----------------------
>  arch/arm64/kvm/hyp/switch.c       | 17 ++++-------------
>  arch/arm64/kvm/hyp/sysreg-sr.c    |  6 ++++++
>  virt/kvm/arm/arm.c                |  1 -
>  6 files changed, 18 insertions(+), 41 deletions(-)

This looks like a nice cleanup! FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 05706b4..704667e 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -294,7 +294,6 @@ static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
>  static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
>  
> -static inline void kvm_arm_init_debug(void) {}
>  static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arm_clear_debug(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu) {}
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 1b2e05b..2f1bb86 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -205,6 +205,8 @@ struct kvm_cpu_context {
>  
>  	/* HYP host/guest configuration */
>  	u64 hcr_el2;
> +	u32 mdcr_el2;
> +
>  	struct kvm_vcpu *__hyp_running_vcpu;
>  };
>  
> @@ -213,9 +215,6 @@ typedef struct kvm_cpu_context kvm_cpu_context_t;
>  struct kvm_vcpu_arch {
>  	struct kvm_cpu_context ctxt;
>  
> -	/* HYP configuration */
> -	u32 mdcr_el2;
> -
>  	/* Exception Information */
>  	struct kvm_vcpu_fault_info fault;
>  
> @@ -446,7 +445,6 @@ static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
>  static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
>  
> -void kvm_arm_init_debug(void);
>  void kvm_arm_setup_debug(struct kvm_vcpu *vcpu);
>  void kvm_arm_clear_debug(struct kvm_vcpu *vcpu);
>  void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index f39801e..99dc0a4 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -32,8 +32,6 @@
>  				DBG_MDSCR_KDE | \
>  				DBG_MDSCR_MDE)
>  
> -static DEFINE_PER_CPU(u32, mdcr_el2);
> -
>  /**
>   * save/restore_guest_debug_regs
>   *
> @@ -65,21 +63,6 @@ static void restore_guest_debug_regs(struct kvm_vcpu *vcpu)
>  }
>  
>  /**
> - * kvm_arm_init_debug - grab what we need for debug
> - *
> - * Currently the sole task of this function is to retrieve the initial
> - * value of mdcr_el2 so we can preserve MDCR_EL2.HPMN which has
> - * presumably been set-up by some knowledgeable bootcode.
> - *
> - * It is called once per-cpu during CPU hyp initialisation.
> - */
> -
> -void kvm_arm_init_debug(void)
> -{
> -	__this_cpu_write(mdcr_el2, kvm_call_hyp(__kvm_get_mdcr_el2));
> -}
> -
> -/**
>   * kvm_arm_reset_debug_ptr - reset the debug ptr to point to the vcpu state
>   */
>  
> @@ -111,6 +94,7 @@ void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu)
>  
>  void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>  {
> +	kvm_cpu_context_t *host_cxt = this_cpu_ptr(&kvm_host_cpu_state);
>  	bool trap_debug = !(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY);
>  	unsigned long mdscr;
>  
> @@ -120,8 +104,8 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>  	 * This also clears MDCR_EL2_E2PB_MASK to disable guest access
>  	 * to the profiling buffer.
>  	 */
> -	vcpu->arch.mdcr_el2 = __this_cpu_read(mdcr_el2) & MDCR_EL2_HPMN_MASK;
> -	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
> +	vcpu->arch.ctxt.mdcr_el2 = host_cxt->mdcr_el2 & MDCR_EL2_HPMN_MASK;
> +	vcpu->arch.ctxt.mdcr_el2 |= (MDCR_EL2_TPM |
>  				MDCR_EL2_TPMS |
>  				MDCR_EL2_TPMCR |
>  				MDCR_EL2_TDRA |
> @@ -130,7 +114,7 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>  	/* Is Guest debugging in effect? */
>  	if (vcpu->guest_debug) {
>  		/* Route all software debug exceptions to EL2 */
> -		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDE;
> +		vcpu->arch.ctxt.mdcr_el2 |= MDCR_EL2_TDE;
>  
>  		/* Save guest debug state */
>  		save_guest_debug_regs(vcpu);
> @@ -202,13 +186,13 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>  
>  	/* Trap debug register access */
>  	if (trap_debug)
> -		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
> +		vcpu->arch.ctxt.mdcr_el2 |= MDCR_EL2_TDA;
>  
>  	/* If KDE or MDE are set, perform a full save/restore cycle. */
>  	if (vcpu_read_sys_reg(vcpu, MDSCR_EL1) & (DBG_MDSCR_KDE | DBG_MDSCR_MDE))
>  		vcpu->arch.flags |= KVM_ARM64_DEBUG_DIRTY;
>  
> -	trace_kvm_arm_set_dreg32("MDCR_EL2", vcpu->arch.mdcr_el2);
> +	trace_kvm_arm_set_dreg32("MDCR_EL2", vcpu->arch.ctxt.mdcr_el2);
>  	trace_kvm_arm_set_dreg32("MDSCR_EL1", vcpu_read_sys_reg(vcpu, MDSCR_EL1));
>  }
>  
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 006bd33..03b36f1 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -82,7 +82,7 @@ static void __hyp_text __activate_traps_common(struct kvm_vcpu *vcpu)
>  	 */
>  	write_sysreg(0, pmselr_el0);
>  	write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
> -	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
> +	write_sysreg(vcpu->arch.ctxt.mdcr_el2, mdcr_el2);
>  }
>  
>  static void __hyp_text __deactivate_traps_common(void)
> @@ -157,14 +157,9 @@ static void deactivate_traps_vhe(struct kvm_cpu_context *host_ctxt)
>  
>  static void __hyp_text __deactivate_traps_nvhe(struct kvm_cpu_context *host_ctxt)
>  {
> -	u64 mdcr_el2 = read_sysreg(mdcr_el2);
> -
>  	__deactivate_traps_common();
>  
> -	mdcr_el2 &= MDCR_EL2_HPMN_MASK;
> -	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
> -
> -	write_sysreg(mdcr_el2, mdcr_el2);
> +	write_sysreg(host_ctxt->mdcr_el2, mdcr_el2);
>  	write_sysreg(host_ctxt->hcr_el2, hcr_el2);
>  	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
>  }
> @@ -196,13 +191,9 @@ void activate_traps_vhe_load(struct kvm_vcpu *vcpu)
>  
>  void deactivate_traps_vhe_put(struct kvm_vcpu *vcpu)
>  {
> -	u64 mdcr_el2 = read_sysreg(mdcr_el2);
> -
> -	mdcr_el2 &= MDCR_EL2_HPMN_MASK |
> -		    MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT |
> -		    MDCR_EL2_TPMS;
> +	struct kvm_cpu_context *host_ctxt = vcpu->arch.host_cpu_context;
>  
> -	write_sysreg(mdcr_el2, mdcr_el2);
> +	write_sysreg(host_ctxt->mdcr_el2, mdcr_el2);
>  
>  	__deactivate_traps_common();
>  }
> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> index 68ddc0f..42ec50f 100644
> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
> @@ -334,4 +334,10 @@ void __hyp_text __kvm_populate_host_regs(void)
>  		host_ctxt = __hyp_this_cpu_ptr(kvm_host_cpu_state);
>  
>  	host_ctxt->hcr_el2 = read_sysreg(hcr_el2);
> +	/*
> +	 * Retrieve the initial value of mdcr_el2 so we can preserve
> +	 * MDCR_EL2.HPMN which has presumably been set-up by some
> +	 * knowledgeable bootcode.
> +	 */
> +	host_ctxt->mdcr_el2 = read_sysreg(mdcr_el2);
>  }
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 8e18f7f..2032a66 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1327,7 +1327,6 @@ static void cpu_hyp_reinit(void)
>  	else
>  		cpu_init_hyp_mode(NULL);
>  
> -	kvm_arm_init_debug();
>  	__cpu_copy_hyp_conf();
>  
>  	if (vgic_present)
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
