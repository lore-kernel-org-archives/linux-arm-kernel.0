Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A54C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:42:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3F1214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gRkBKld/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3F1214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2jFV2y054HWht1UB5xdpdJrbnF5X5QUaIj6AVUvZV9s=; b=gRkBKld/nrAFw/
	1X8AB+ixkdM0gA5JxJGnV8FgJBkZ2Zl8IZ1kvnQiIXc67TNKX52Emqnh1mJu6H14wP53i/4eKh/dj
	zEJNGbaXJg01StnCvzIhnXA/Tn/yBiDazH568WWhNJcL7BqEw39na3ccaSUjBjz2qYOzIYHFsila5
	TgbDXoo2yVPSxzU7KhMO2SMrR89ph5/UThiKntUaFLCb2YDOq0xxabF4N8mZZexCqfH+FOD0+DXZR
	42EidK9ibavsfrPog8b6sdSAbIBwpYeI73sQlG8qY0MJpFnjcxjsCGHGiKOSfgfU/iHYOLA608bd5
	GQDgKjo6C4CzcL2LQ07g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwXki-00024f-F5; Wed, 20 Feb 2019 19:41:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwXkf-00024D-Ey
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 19:41:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9327CA78;
 Wed, 20 Feb 2019 11:41:52 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41E533F575;
 Wed, 20 Feb 2019 11:41:51 -0800 (PST)
Date: Wed, 20 Feb 2019 19:41:43 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 1/5] KVM: arm/arm64: Reset the VCPU without preemption
 and vcpu state loaded
Message-ID: <20190220194143.2e1a7d2c@why.wild-wind.fr.eu.org>
In-Reply-To: <20190220191450.GT3567@e103592.cambridge.arm.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-2-christoffer.dall@arm.com>
 <20190220191450.GT3567@e103592.cambridge.arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_114153_515262_A6C3EA65 
X-CRM114-Status: GOOD (  30.89  )
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
Cc: kvm@vger.kernel.org, Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 20 Feb 2019 19:14:53 +0000
Dave Martin <Dave.Martin@arm.com> wrote:

> On Fri, Jan 25, 2019 at 10:46:52AM +0100, Christoffer Dall wrote:
> > Resetting the VCPU state modifies the system register state in memory,
> > but this may interact with vcpu_load/vcpu_put if running with preemption
> > disabled, which in turn may lead to corrupted system register state.  
> 
> Should this be "enabled"?

Yup. Never mind. The patches are firmly in mainline now.

> 
> Too late now, but I want to make sure I understand this right for
> patches that will go on top.
> 
> > Address this by disabling preemption and doing put/load if required
> > around the reset logic.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm64/kvm/reset.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > index b72a3dd56204..f21a2a575939 100644
> > --- a/arch/arm64/kvm/reset.c
> > +++ b/arch/arm64/kvm/reset.c
> > @@ -105,16 +105,33 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >   * This function finds the right table above and sets the registers on
> >   * the virtual CPU struct to their architecturally defined reset
> >   * values.
> > + *
> > + * Note: This function can be called from two paths: The KVM_ARM_VCPU_INIT
> > + * ioctl or as part of handling a request issued by another VCPU in the PSCI
> > + * handling code.  In the first case, the VCPU will not be loaded, and in the
> > + * second case the VCPU will be loaded.  Because this function operates purely
> > + * on the memory-backed valus of system registers, we want to do a full put if
> > + * we were loaded (handling a request) and load the values back at the end of
> > + * the function.  Otherwise we leave the state alone.  In both cases, we
> > + * disable preemption around the vcpu reset as we would otherwise race with
> > + * preempt notifiers which also call put/load.
> >   */
> >  int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> >  {
> >  	const struct kvm_regs *cpu_reset;
> > +	int ret = -EINVAL;
> > +	bool loaded;
> > +
> > +	preempt_disable();
> > +	loaded = (vcpu->cpu != -1);
> > +	if (loaded)
> > +		kvm_arch_vcpu_put(vcpu);
> >  
> >  	switch (vcpu->arch.target) {
> >  	default:
> >  		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
> >  			if (!cpu_has_32bit_el1())
> > -				return -EINVAL;
> > +				goto out;
> >  			cpu_reset = &default_regs_reset32;
> >  		} else {
> >  			cpu_reset = &default_regs_reset;
> > @@ -137,7 +154,12 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> >  		vcpu->arch.workaround_flags |= VCPU_WORKAROUND_2_FLAG;
> >  
> >  	/* Reset timer */
> > -	return kvm_timer_vcpu_reset(vcpu);
> > +	ret = kvm_timer_vcpu_reset(vcpu);
> > +out:
> > +	if (loaded)
> > +		kvm_arch_vcpu_load(vcpu, smp_processor_id());
> > +	preempt_enable();
> > +	return ret;
> >  }
> >  
> >  void kvm_set_ipa_limit(void)  
> 
> I was really confused by this: as far as I can see, we don't really need
> to disable preemption here once kvm_arch_vcpu_put() is complete -- at
> least not for the purpose of avoiding corruption of the reg state.  But
> we _do_ need to disable the preempt notifier so that it doesn't fire
> before we are ready.

Just reading this patch alone won't help. You need to read it in
conjunction with the following patch, which resets the vcpu from a
preemptible section.

> It actually seems a bit surprising for a powered-off CPU to sit with the
> VM regs live and preempt notifier armed, when the vcpu thread is
> heading to interruptible sleep anyway until someone turns it on.

All it takes is a signal for that vcpu to wake up, power-off or not.

> Perhaps an alternative approach would be to nobble the preempt notifier
> and stick an explicit vcpu_put()...vcpu_load() around the
> swait_event_interruptible_exclusive() call in vcpu_req_sleep().  This
> is not fast path.

What does it buy us? The problem we're solving here is a powered-off,
spuriously woken-up vcpu racing against the reset performed from
another vcpu. I don't see what adding more put/load would solve.

> Any, with the code as-is, it looks like the SVE regs resetting should
> go in the preempt_disable() region, after the kvm_arch_vcpu_put() call.

All resets must go there. This is the only safe location.

> Does it sound like I've understood that right?

I'm not sure. Your analysis of what we're trying to achieve with this
series seems a bit off. Or I'm completely misunderstanding what you're
suggesting, which is the most likely explanation.

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
