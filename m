Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2118DC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:31:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDFC205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dA+eO4uQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDFC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=udkQvRrY8bgXlpw6fgLzgu2f0INdpGm4wt7dFWR7GFY=; b=dA+eO4uQFjicAv
	NZ/N8A23Ao00yESrZe4mMcNpzNuBjReOUfPoF/IveZRPj5pVp5wVbjoFeWHfxB89JFxo2tdbpz/by
	t2zfbE03in4X7iRqMjiWN+H1gxm9olfpv0SD89AxmNlwTe/5Ms9UXPT/MIPi24fnLwYK3vUt4Tk9f
	Flgak2SraPUuKz58bBJq7jrWhROe4gjNFpgh1aTiicQKvdDMazbLqNJd9AV5Tehkp1oZlb0DzdJaw
	e+/fC3OAB0GeAzM9wQDIyv/mlsTS5YxVZMrwMqULv1++orB1nS7Ov4aLU9DZWdZY0AtXZeu5gpYJL
	B5WbeCNdprLCqDdTALqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorq2-0005CX-VP; Wed, 30 Jan 2019 15:31:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorpz-0005CC-MZ
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 15:31:41 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F30B83D15;
 Wed, 30 Jan 2019 15:31:37 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB41E6266C;
 Wed, 30 Jan 2019 15:31:36 +0000 (UTC)
Date: Wed, 30 Jan 2019 16:31:34 +0100
From: Andrew Jones <drjones@redhat.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH 3/5] KVM: arm/arm64: Require VCPU threads to turn them
 self off
Message-ID: <20190130153134.bqxqknn6t75cea5t@kamzik.brq.redhat.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-4-christoffer.dall@arm.com>
 <20190129161644.v4ncrcgvukkd7d5w@kamzik.brq.redhat.com>
 <20190130094909.GF13482@e113682-lin.lund.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130094909.GF13482@e113682-lin.lund.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 30 Jan 2019 15:31:39 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_073139_780367_484B9FFD 
X-CRM114-Status: GOOD (  30.50  )
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

On Wed, Jan 30, 2019 at 10:49:09AM +0100, Christoffer Dall wrote:
> On Tue, Jan 29, 2019 at 05:16:44PM +0100, Andrew Jones wrote:
> > 
> > Summary edit
> > 
> > > KVM: arm/arm64: Require VCPU threads to turn them self off
> > 
> > themselves
> > 
> > On Fri, Jan 25, 2019 at 10:46:54AM +0100, Christoffer Dall wrote:
> > > To avoid a race between turning VCPUs off and turning them on, make sure
> > > that only the VCPU threat itself turns off the VCPU.  When other threads
> > > want to turn of a VCPU, they now do this via a request.
> > > 
> > > Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> > > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > > ---
> > >  arch/arm/include/asm/kvm_host.h   |  2 ++
> > >  arch/arm64/include/asm/kvm_host.h |  2 ++
> > >  virt/kvm/arm/arm.c                |  8 ++++++--
> > >  virt/kvm/arm/psci.c               | 11 ++---------
> > >  4 files changed, 12 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> > > index 50e89869178a..b1cfae222441 100644
> > > --- a/arch/arm/include/asm/kvm_host.h
> > > +++ b/arch/arm/include/asm/kvm_host.h
> > > @@ -49,6 +49,8 @@
> > >  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> > >  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
> > >  #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
> > > +#define KVM_REQ_VCPU_OFF \
> > > +	KVM_ARCH_REQ_FLAGS(3, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> > >  
> > >  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
> > >  
> > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > index da3fc7324d68..d43b13421987 100644
> > > --- a/arch/arm64/include/asm/kvm_host.h
> > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > @@ -49,6 +49,8 @@
> > >  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> > >  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
> > >  #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
> > > +#define KVM_REQ_VCPU_OFF \
> > > +	KVM_ARCH_REQ_FLAGS(3, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> > >  
> > >  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
> > >  
> > > diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> > > index 9c486fad3f9f..785076176814 100644
> > > --- a/virt/kvm/arm/arm.c
> > > +++ b/virt/kvm/arm/arm.c
> > > @@ -404,8 +404,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> > >  
> > >  static void vcpu_power_off(struct kvm_vcpu *vcpu)
> > >  {
> > > -	vcpu->arch.power_off = true;
> > > -	kvm_make_request(KVM_REQ_SLEEP, vcpu);
> > > +	kvm_make_request(KVM_REQ_VCPU_OFF, vcpu);
> > >  	kvm_vcpu_kick(vcpu);
> > >  }
> > 
> > I think we should leave this function alone. Otherwise if userspace sets
> > the MP state to STOPPED and then queries the state before the vcpu
> > has a chance to manage its vcpu requests, the state will still indicate
> > RUNNBLE. The same goes for a query right after doing a vcpu init.
> > 
> 
> We can't leave this alone, because that could lead to userspace racing
> with two PSCI_VCPU_ON requests which could then both enter the critical
> section gated only by the cmpxchg in kvm_psci_vcpu_on.

Right. I keep forgetting about that race.

> 
> But we could do something like this (completely untested):
> 
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 1e3195155860..538b5eb9d920 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -404,6 +404,17 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  
>  static void vcpu_power_off(struct kvm_vcpu *vcpu)
>  {
> +	enum vcpu_power_state old_power_state;
> +
> +	/*
> +	 * Set power_state directly to reflect the power state back to user
> +	 * space even when the VCPU thread has not had a chance to run, but
> +	 * only if this doesn't accidentally allow interleaved PSCI_VCPU_ON
> +	 * requests.
> +	 */
> +	old_power_state = cmpxchg(&vcpu->arch.power_state,
> +				  KVM_ARM_VCPU_ON,
> +				  KVM_ARM_VCPU_OFF);
>  	kvm_make_request(KVM_REQ_VCPU_OFF, vcpu);
>  	kvm_vcpu_kick(vcpu);
>  }

Something like that sounds good to me.

> 
> 
> > >  
> > > @@ -646,6 +645,11 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
> > >  		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
> > >  			vcpu_req_sleep(vcpu);
> > >  
> > > +		if (kvm_check_request(KVM_REQ_VCPU_OFF, vcpu)) {
> > > +			vcpu->arch.power_off = true;
> > > +			vcpu_req_sleep(vcpu);
> > > +		}
> > > +
> > >  		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
> > >  			kvm_reset_vcpu(vcpu);
> > >  
> > > diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> > > index b9cff1d4b06d..20255319e193 100644
> > > --- a/virt/kvm/arm/psci.c
> > > +++ b/virt/kvm/arm/psci.c
> > > @@ -97,9 +97,7 @@ static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
> > >  
> > >  static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
> > >  {
> > > -	vcpu->arch.power_off = true;
> > > -	kvm_make_request(KVM_REQ_SLEEP, vcpu);
> > > -	kvm_vcpu_kick(vcpu);
> > > +	kvm_make_request(KVM_REQ_VCPU_OFF, vcpu);
> > >  }
> > 
> > This was currently fine since it implements CPU_OFF which only applies to
> > the calling vcpu, but there's also no reason not to change it to be
> > consistent with the below change
> > 
> 
> Same problem as above, we don't want two VCPUs to be messing with a
> target VCPU state at the same time.
>

Yup

Thanks,
drew 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
