Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC165C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:16:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA90C2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TQq3yA6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA90C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KmTHKRxC4KK8LUFs6s3vj/P69l+y3XsNcOQ+95jbvYk=; b=TQq3yA6/gvRJ9w
	9VeuUQpn1U/k0t+0jeTCwDUS/NOuaEKnUpklOIKgvWQaLzOdLo8Xc9GxW9OtIV8ZTFH1bZDeU2Szi
	BdW1O6Ntjtdxc40Q9nkQ20qlE8FtlVgEHnGxhNRL2AF6BfZilzvCDjqK1rFLmhKWNWuFhCnc8o6Rr
	12apgDEBovifVYoKvBnLgfDEPbkVMQmF7BB3b4mdOSVepcYh6PKE+gnV37Yu1BhBdBhsYdyvV4VSU
	r01tc0pW4k3cVdbjnuydzTP/rF5L3H/d2H8Q0bnW/aS4odIpWyt/ljy965A3Y+/Y7WUhsX2dNR5ET
	MlA3IlHGZqP8F6dE/23Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goW4B-0006bs-I1; Tue, 29 Jan 2019 16:16:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goW48-0006bR-Cd
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:16:49 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4189C0528BD;
 Tue, 29 Jan 2019 16:16:47 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA711226F4;
 Tue, 29 Jan 2019 16:16:46 +0000 (UTC)
Date: Tue, 29 Jan 2019 17:16:44 +0100
From: Andrew Jones <drjones@redhat.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH 3/5] KVM: arm/arm64: Require VCPU threads to turn them
 self off
Message-ID: <20190129161644.v4ncrcgvukkd7d5w@kamzik.brq.redhat.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-4-christoffer.dall@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125094656.5026-4-christoffer.dall@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 29 Jan 2019 16:16:47 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_081648_473143_E6A08968 
X-CRM114-Status: GOOD (  22.10  )
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


Summary edit

> KVM: arm/arm64: Require VCPU threads to turn them self off

themselves

On Fri, Jan 25, 2019 at 10:46:54AM +0100, Christoffer Dall wrote:
> To avoid a race between turning VCPUs off and turning them on, make sure
> that only the VCPU threat itself turns off the VCPU.  When other threads
> want to turn of a VCPU, they now do this via a request.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   |  2 ++
>  arch/arm64/include/asm/kvm_host.h |  2 ++
>  virt/kvm/arm/arm.c                |  8 ++++++--
>  virt/kvm/arm/psci.c               | 11 ++---------
>  4 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 50e89869178a..b1cfae222441 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -49,6 +49,8 @@
>  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
>  #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
> +#define KVM_REQ_VCPU_OFF \
> +	KVM_ARCH_REQ_FLAGS(3, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  
>  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
>  
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index da3fc7324d68..d43b13421987 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -49,6 +49,8 @@
>  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
>  #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
> +#define KVM_REQ_VCPU_OFF \
> +	KVM_ARCH_REQ_FLAGS(3, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  
>  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
>  
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 9c486fad3f9f..785076176814 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -404,8 +404,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  
>  static void vcpu_power_off(struct kvm_vcpu *vcpu)
>  {
> -	vcpu->arch.power_off = true;
> -	kvm_make_request(KVM_REQ_SLEEP, vcpu);
> +	kvm_make_request(KVM_REQ_VCPU_OFF, vcpu);
>  	kvm_vcpu_kick(vcpu);
>  }

I think we should leave this function alone. Otherwise if userspace sets
the MP state to STOPPED and then queries the state before the vcpu
has a chance to manage its vcpu requests, the state will still indicate
RUNNBLE. The same goes for a query right after doing a vcpu init.

>  
> @@ -646,6 +645,11 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
>  		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
>  			vcpu_req_sleep(vcpu);
>  
> +		if (kvm_check_request(KVM_REQ_VCPU_OFF, vcpu)) {
> +			vcpu->arch.power_off = true;
> +			vcpu_req_sleep(vcpu);
> +		}
> +
>  		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
>  			kvm_reset_vcpu(vcpu);
>  
> diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> index b9cff1d4b06d..20255319e193 100644
> --- a/virt/kvm/arm/psci.c
> +++ b/virt/kvm/arm/psci.c
> @@ -97,9 +97,7 @@ static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
>  
>  static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
>  {
> -	vcpu->arch.power_off = true;
> -	kvm_make_request(KVM_REQ_SLEEP, vcpu);
> -	kvm_vcpu_kick(vcpu);
> +	kvm_make_request(KVM_REQ_VCPU_OFF, vcpu);
>  }

This was currently fine since it implements CPU_OFF which only applies to
the calling vcpu, but there's also no reason not to change it to be
consistent with the below change

>  
>  static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
> @@ -198,9 +196,6 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
>  
>  static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
>  {
> -	int i;
> -	struct kvm_vcpu *tmp;
> -
>  	/*
>  	 * The KVM ABI specifies that a system event exit may call KVM_RUN
>  	 * again and may perform shutdown/reboot at a later time that when the
> @@ -210,9 +205,7 @@ static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
>  	 * after this call is handled and before the VCPUs have been
>  	 * re-initialized.
>  	 */
> -	kvm_for_each_vcpu(i, tmp, vcpu->kvm)
> -		tmp->arch.power_off = true;
> -	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
> +	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_VCPU_OFF);
>  
>  	memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));
>  	vcpu->run->system_event.type = type;
> -- 
> 2.18.0
>

Thanks,
drew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
