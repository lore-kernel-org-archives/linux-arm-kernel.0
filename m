Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB36C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:01:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A09217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uQDnqBrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A09217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=anKb5+sYOkHEB6skjzzMp5dSlxn9mXlzcS0wLF7F+Io=; b=uQDnqBrmE/z7K0
	/u20JqPAQPX0eBeZqEMLiBTUkm6cTVwZN4152GMzWP0Zw8pUXuyhu3/cmcYPHWvCQkbs+/1YbJiqH
	TRo5zB46XDsvGF1SoXzCuZ0b5mEbw+UEaVdZWI5RtEIOTOjuu5H+a3EJJe9WZ6vSqoM4bUB/mbHgH
	NR89to8ZDu3Tq2hBR8FzpV4r/CawYDtVpDBaTLuyUBvNZxEhgXkdTk9chuRsKrPWIDzQ9OCDqJ/YZ
	9VvtFteU5+kwl1P1HWy/fuamPbUcJxMAyM4kBZAYyA2PtjIxJ4RVpQXEW2hq9q8POsu8GjBgzflQn
	mNMAuwpBdHFzvgNBZrvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydI7-0002t9-Lz; Tue, 26 Feb 2019 14:01:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydI4-0002sN-2m
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:01:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 246BAA78;
 Tue, 26 Feb 2019 06:00:59 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 141A03F703;
 Tue, 26 Feb 2019 06:00:57 -0800 (PST)
Date: Tue, 26 Feb 2019 14:00:55 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH 1/5] KVM: arm/arm64: Reset the VCPU without preemption
 and vcpu state loaded
Message-ID: <20190226140055.GY3567@e103592.cambridge.arm.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-2-christoffer.dall@arm.com>
 <20190220191450.GT3567@e103592.cambridge.arm.com>
 <20190226123449.GA551@e113682-lin.lund.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190226123449.GA551@e113682-lin.lund.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_060100_138445_95996451 
X-CRM114-Status: GOOD (  37.57  )
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

On Tue, Feb 26, 2019 at 01:34:49PM +0100, Christoffer Dall wrote:
> On Wed, Feb 20, 2019 at 07:14:53PM +0000, Dave Martin wrote:
> > On Fri, Jan 25, 2019 at 10:46:52AM +0100, Christoffer Dall wrote:
> > > Resetting the VCPU state modifies the system register state in memory,
> > > but this may interact with vcpu_load/vcpu_put if running with preemption
> > > disabled, which in turn may lead to corrupted system register state.
> > 
> > Should this be "enabled"?
> > 
> > Too late now, but I want to make sure I understand this right for
> > patches that will go on top.
> > 
> > > Address this by disabling preemption and doing put/load if required
> > > around the reset logic.
> > > 
> > > Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > ---
> > >  arch/arm64/kvm/reset.c | 26 ++++++++++++++++++++++++--
> > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > > index b72a3dd56204..f21a2a575939 100644
> > > --- a/arch/arm64/kvm/reset.c
> > > +++ b/arch/arm64/kvm/reset.c
> > > @@ -105,16 +105,33 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> > >   * This function finds the right table above and sets the registers on
> > >   * the virtual CPU struct to their architecturally defined reset
> > >   * values.
> > > + *
> > > + * Note: This function can be called from two paths: The KVM_ARM_VCPU_INIT
> > > + * ioctl or as part of handling a request issued by another VCPU in the PSCI
> > > + * handling code.  In the first case, the VCPU will not be loaded, and in the
> > > + * second case the VCPU will be loaded.  Because this function operates purely
> > > + * on the memory-backed valus of system registers, we want to do a full put if
> > > + * we were loaded (handling a request) and load the values back at the end of
> > > + * the function.  Otherwise we leave the state alone.  In both cases, we
> > > + * disable preemption around the vcpu reset as we would otherwise race with
> > > + * preempt notifiers which also call put/load.
> > >   */
> > >  int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> > >  {
> > >  	const struct kvm_regs *cpu_reset;
> > > +	int ret = -EINVAL;
> > > +	bool loaded;
> > > +
> > > +	preempt_disable();
> > > +	loaded = (vcpu->cpu != -1);
> > > +	if (loaded)
> > > +		kvm_arch_vcpu_put(vcpu);
> > >  
> > >  	switch (vcpu->arch.target) {
> > >  	default:
> > >  		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
> > >  			if (!cpu_has_32bit_el1())
> > > -				return -EINVAL;
> > > +				goto out;
> > >  			cpu_reset = &default_regs_reset32;
> > >  		} else {
> > >  			cpu_reset = &default_regs_reset;
> > > @@ -137,7 +154,12 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> > >  		vcpu->arch.workaround_flags |= VCPU_WORKAROUND_2_FLAG;
> > >  
> > >  	/* Reset timer */
> > > -	return kvm_timer_vcpu_reset(vcpu);
> > > +	ret = kvm_timer_vcpu_reset(vcpu);
> > > +out:
> > > +	if (loaded)
> > > +		kvm_arch_vcpu_load(vcpu, smp_processor_id());
> > > +	preempt_enable();
> > > +	return ret;
> > >  }
> > >  
> > >  void kvm_set_ipa_limit(void)
> > 
> > I was really confused by this: as far as I can see, we don't really need
> > to disable preemption here once kvm_arch_vcpu_put() is complete -- at
> > least not for the purpose of avoiding corruption of the reg state.  But
> > we _do_ need to disable the preempt notifier so that it doesn't fire
> > before we are ready.
> > 
> > It actually seems a bit surprising for a powered-off CPU to sit with the
> > VM regs live and preempt notifier armed, when the vcpu thread is
> > heading to interruptible sleep anyway until someone turns it on.
> > Perhaps an alternative approach would be to nobble the preempt notifier
> > and stick an explicit vcpu_put()...vcpu_load() around the
> > swait_event_interruptible_exclusive() call in vcpu_req_sleep().  This
> > is not fast path.
> > 
> > 
> 
> I think you've understood the problem correctly, and the thing here is
> that we (sort-of) "abuse" disabling preemption as a way to disable
> preempt notifiers, which I don't think we have.  So we could add that,
> and do something like:
> 
>   preempt_disable();
>   vcpu_put(vcpu);
>   disable_preempt_notifiers(vcpu);
>   preempt_disable();
>   funky_stuff();
>   vcpu_load();
>   preempt_enable();

Did you mean

	preempt_disable();
	disable_preempt_notifiers(vcpu);
	vcpu_put(vcpu);
	preempt_enable();

	funky_stuff();

	preempt_disable();
	vcpu_load(vcpu);
	enable_preempt_notifiers(vcpu);
	preempt_enable();

> But I think that's additional complexity to get a slightly shorter
> section with disabled preemption.

Agreed.

disable/enable_preempt_notifiers() may do little more than toggle a flag
that the preempt notifiers check, but I totally agree that it's unlikely
to be worth it just to be preemptible in this small region.

> We could also re-architect a lot of the vcpu_load/vpcu_put functionality
> more drastically, but that is difficult and requires understanding of
> how the other architectures work, so at the end of the day we just use
> this pattern in multiple places, which is:
> 
>   preempt_disable();
>   vcpu_put();

We still have the anomaly that we save all the state we're about to
reset here.

(i.e., we have no pure "invalidate" operation for the loaded CPU regs;
vcpu_put() is more "clean and invalidate", but we may not care much
about the "clean" part in this particular sequence).

Again, this only makes a difference to a rare slow path, so I don't
see it as a problem.

>   modify_vcpu_state_in_memory();
>   vcpu_load();
>   preempt_enable();
> 
> Does that help?

Yes, I think I've understood correctly what's going on here now.

The code is fine as it is.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
