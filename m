Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919D5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:27:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6062C214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OBQMSxr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6062C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RKHiPjYOiNAacXiN+7buihND4CeL8fIarjD7DYaf9X8=; b=OBQMSxr37QoCqc
	yuZMqXehI04IRDFsej9BYKYVW+Xbn132KoUM24f2UoFDFgp2NtAkaqOBwuoVMpflyUMoS3OSyJoGB
	ydg8iezfptfif4GJqIxMnMLQTUbToT5yfImdxlnG1lOXefV79czbPfzQxvDBCS3C/+7+CELGPu2FZ
	jiftileFFT8xSfDH7xWzpYPV/vc3BeYI7vVjcYPaffAu5ZYbbUqCjgD4pIFWyz6+gAqReR10MrNcg
	v4FekcCjcTELdhWT77IEeJ7WcIjm0PI68ZGO1XK1GZEFT6gUBVPkJHZDtuBaRfhEy/S2KBjU35inp
	vDrh7LqcXuqtmFg9+FXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWEB-00026C-Br; Tue, 29 Jan 2019 16:27:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWE7-00025U-AU
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:27:08 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95B9490919;
 Tue, 29 Jan 2019 16:27:06 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ADC05D97A;
 Tue, 29 Jan 2019 16:27:05 +0000 (UTC)
Date: Tue, 29 Jan 2019 17:27:02 +0100
From: Andrew Jones <drjones@redhat.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH 4/5] KVM: arm/arm64: Implement PSCI ON_PENDING when
 turning on VCPUs
Message-ID: <20190129162702.dyuy2qyg7p4zv7tj@kamzik.brq.redhat.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-5-christoffer.dall@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125094656.5026-5-christoffer.dall@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 29 Jan 2019 16:27:06 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_082707_401689_C8AF5CA4 
X-CRM114-Status: GOOD (  26.70  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 10:46:55AM +0100, Christoffer Dall wrote:
> We are currently not implementing the PSCI spec completely, as we do not
> take handle the situation where two VCPUs are attempting to turn on a
> third VCPU at the same time.  The PSCI implementation should make sure
> that only one requesting VCPU wins the race and that the other receives
> PSCI_RET_ON_PENDING.
> 
> Implement this by changing the VCPU power state to a tristate enum and
> ensure only a single VCPU can turn on another VCPU at a given time using
> a cmpxchg operation.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   | 10 ++++++++--
>  arch/arm64/include/asm/kvm_host.h | 10 ++++++++--
>  virt/kvm/arm/arm.c                | 24 +++++++++++++++---------
>  virt/kvm/arm/psci.c               | 21 ++++++++++++++-------
>  4 files changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index b1cfae222441..4dc47fea1ac8 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -157,6 +157,12 @@ struct vcpu_reset_state {
>  	bool		reset;
>  };
>  
> +enum vcpu_power_state {
> +	KVM_ARM_VCPU_OFF,
> +	KVM_ARM_VCPU_ON_PENDING,
> +	KVM_ARM_VCPU_ON,
> +};
> +
>  struct kvm_vcpu_arch {
>  	struct kvm_cpu_context ctxt;
>  
> @@ -184,8 +190,8 @@ struct kvm_vcpu_arch {
>  	 * here.
>  	 */
>  
> -	/* vcpu power-off state */
> -	bool power_off;
> +	/* vcpu power state */
> +	enum vcpu_power_state power_state;
>  
>  	 /* Don't run the guest (internal implementation need) */
>  	bool pause;
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index d43b13421987..0647a409657b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -218,6 +218,12 @@ struct vcpu_reset_state {
>  	bool		reset;
>  };
>  
> +enum vcpu_power_state {
> +	KVM_ARM_VCPU_OFF,
> +	KVM_ARM_VCPU_ON_PENDING,
> +	KVM_ARM_VCPU_ON,
> +};
> +
>  struct kvm_vcpu_arch {
>  	struct kvm_cpu_context ctxt;
>  
> @@ -285,8 +291,8 @@ struct kvm_vcpu_arch {
>  		u32	mdscr_el1;
>  	} guest_debug_preserved;
>  
> -	/* vcpu power-off state */
> -	bool power_off;
> +	/* vcpu power state */
> +	enum vcpu_power_state power_state;
>  
>  	/* Don't run the guest (internal implementation need) */
>  	bool pause;
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 785076176814..1e3195155860 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -411,7 +411,7 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> -	if (vcpu->arch.power_off)
> +	if (vcpu->arch.power_state != KVM_ARM_VCPU_ON)
>  		mp_state->mp_state = KVM_MP_STATE_STOPPED;
>  	else
>  		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
> @@ -426,7 +426,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  
>  	switch (mp_state->mp_state) {
>  	case KVM_MP_STATE_RUNNABLE:
> -		vcpu->arch.power_off = false;
> +		vcpu->arch.power_state = KVM_ARM_VCPU_ON;
>  		break;
>  	case KVM_MP_STATE_STOPPED:
>  		vcpu_power_off(vcpu);
> @@ -448,8 +448,9 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
>  {
>  	bool irq_lines = *vcpu_hcr(v) & (HCR_VI | HCR_VF);
> -	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
> -		&& !v->arch.power_off && !v->arch.pause);
> +	return (irq_lines || kvm_vgic_vcpu_pending_irq(v)) &&
> +		v->arch.power_state == KVM_ARM_VCPU_ON &&
> +		!v->arch.pause;
>  }
>  
>  bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
> @@ -614,14 +615,19 @@ void kvm_arm_resume_guest(struct kvm *kvm)
>  	}
>  }
>  
> +static bool vcpu_sleeping(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.power_state != KVM_ARM_VCPU_ON ||
> +		vcpu->arch.pause;
> +}
> +
>  static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
>  {
>  	struct swait_queue_head *wq = kvm_arch_vcpu_wq(vcpu);
>  
> -	swait_event_interruptible_exclusive(*wq, ((!vcpu->arch.power_off) &&
> -				       (!vcpu->arch.pause)));
> +	swait_event_interruptible_exclusive(*wq, !vcpu_sleeping(vcpu));
>  
> -	if (vcpu->arch.power_off || vcpu->arch.pause) {
> +	if (vcpu_sleeping(vcpu)) {
>  		/* Awaken to handle a signal, request we sleep again later. */
>  		kvm_make_request(KVM_REQ_SLEEP, vcpu);
>  	}
> @@ -646,7 +652,7 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
>  			vcpu_req_sleep(vcpu);
>  
>  		if (kvm_check_request(KVM_REQ_VCPU_OFF, vcpu)) {
> -			vcpu->arch.power_off = true;
> +			vcpu->arch.power_state = KVM_ARM_VCPU_OFF;
>  			vcpu_req_sleep(vcpu);
>  		}
>  
> @@ -1016,7 +1022,7 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
>  	if (test_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
>  		vcpu_power_off(vcpu);
>  	else
> -		vcpu->arch.power_off = false;
> +		vcpu->arch.power_state = KVM_ARM_VCPU_ON;
>  
>  	return 0;
>  }
> diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> index 20255319e193..5c2d9eeb810c 100644
> --- a/virt/kvm/arm/psci.c
> +++ b/virt/kvm/arm/psci.c
> @@ -106,6 +106,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  	struct kvm *kvm = source_vcpu->kvm;
>  	struct kvm_vcpu *vcpu = NULL;
>  	unsigned long cpu_id;
> +	enum vcpu_power_state old_power_state;
>  
>  	cpu_id = smccc_get_arg1(source_vcpu) & MPIDR_HWID_BITMASK;
>  	if (vcpu_mode_is_32bit(source_vcpu))
> @@ -119,12 +120,18 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  	 */
>  	if (!vcpu)
>  		return PSCI_RET_INVALID_PARAMS;
> -	if (!vcpu->arch.power_off) {
> -		if (kvm_psci_version(source_vcpu, kvm) != KVM_ARM_PSCI_0_1)
> -			return PSCI_RET_ALREADY_ON;
> -		else
> +	old_power_state = cmpxchg(&vcpu->arch.power_state,
> +				  KVM_ARM_VCPU_OFF,
> +				  KVM_ARM_VCPU_ON_PENDING);
> +
> +	if (old_power_state != KVM_ARM_VCPU_OFF &&
> +	    kvm_psci_version(source_vcpu, kvm) == KVM_ARM_PSCI_0_1)
>  			return PSCI_RET_INVALID_PARAMS;
> -	}
> +
> +	if (old_power_state == KVM_ARM_VCPU_ON_PENDING)
> +			return PSCI_RET_ON_PENDING;
> +	else if (old_power_state == KVM_ARM_VCPU_ON)
> +			return PSCI_RET_ALREADY_ON;
>  
>  	reset_state = &vcpu->arch.reset_state;
>  
> @@ -148,7 +155,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  	 */
>  	smp_wmb();
>  
> -	vcpu->arch.power_off = false;
> +	vcpu->arch.power_state = KVM_ARM_VCPU_ON;
>  	kvm_vcpu_wake_up(vcpu);
>  
>  	return PSCI_RET_SUCCESS;
> @@ -183,7 +190,7 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
>  		mpidr = kvm_vcpu_get_mpidr_aff(tmp);
>  		if ((mpidr & target_affinity_mask) == target_affinity) {
>  			matching_cpus++;
> -			if (!tmp->arch.power_off)
> +			if (tmp->arch.power_state == KVM_ARM_VCPU_ON)
>  				return PSCI_0_2_AFFINITY_LEVEL_ON;
>  		}
>  	}
> -- 
> 2.18.0
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
