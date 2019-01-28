Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BB4C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:47:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1304D21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K3EUGLAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1304D21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ar69T+vUwejr94zeg6ids5VlFKBPf4ER0bL6RonLrg=; b=K3EUGLABBoVzij
	iRR6n9EYEBrDzD2UkD22iQKRfPPXI92zOdWhHFiP4TjlDVH5xGqHu4lQRjvkvTZnp2szdo+M6Bnr1
	/lGnePhZH9Y7UJCBDbdwbgZ4vV9lrUsR5aRVSzdXWy7n0X0W7kEKtzPfOYodx1bVsFQ7Qm4qBdSgP
	W/GHO8vTdEOEjWxJxzmchGaY4aNG7XSpINIZ9th08QzfzC8z8qO3taUZ0PfetmdSuo/jwOOMtBbrC
	SpvHHsnXPONq067+zRE/j3QE27O8/+C7yz/6GlRTuZzN91hypkOeLdvJ2mCnbeYN1OQof3HqjQHGD
	IwTJ04DlvEPX5kOz+U9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5Ns-0005Rh-Ub; Mon, 28 Jan 2019 11:47:24 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5No-0005RO-DS
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 11:47:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3420EBD;
 Mon, 28 Jan 2019 03:47:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7153F59C;
 Mon, 28 Jan 2019 03:47:16 -0800 (PST)
Date: Mon, 28 Jan 2019 11:47:15 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 2/4] KVM: arm/arm64: re-create event when setting counter
 value
Message-ID: <20190128114714.GA16627@e119886-lin.cambridge.arm.com>
References: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
 <1548154197-5470-3-git-send-email-andrew.murray@arm.com>
 <46fc9476-cff2-fd93-f5bb-237e26a2adc6@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46fc9476-cff2-fd93-f5bb-237e26a2adc6@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_034720_465558_530D28C9 
X-CRM114-Status: GOOD (  29.42  )
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
Cc: marc.zyngier@arm.com, christoffer.dall@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 02:18:17PM +0000, Suzuki K Poulose wrote:
> Hi Andrew
> 
> On 01/22/2019 10:49 AM, Andrew Murray wrote:
> > The perf event sample_period is currently set based upon the current
> > counter value, when PMXEVTYPER is written to and the perf event is created.
> > However the user may choose to write the type before the counter value in
> > which case sample_period will be set incorrectly. Let's instead decouple
> > event creation from PMXEVTYPER and (re)create the event in either
> > suitation.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> 
> The approach looks fine to me. However this patch seems to introduce a
> memory leak, see below, which you may be addressing in a later patch in the
> series. But this will affect bisecting issues.

See below, I don't think this is true.

> 
> > ---
> >   virt/kvm/arm/pmu.c | 39 ++++++++++++++++++++++++++++++---------
> >   1 file changed, 30 insertions(+), 9 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> > index 531d27f..4464899 100644
> > --- a/virt/kvm/arm/pmu.c
> > +++ b/virt/kvm/arm/pmu.c
> > @@ -24,6 +24,8 @@
> >   #include <kvm/arm_pmu.h>
> >   #include <kvm/arm_vgic.h>
> > +static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
> > +				      u64 select_idx);
> 
> Could we just pass the counter index (i.e, select_idx) after updating
> the event_type/counter value in the respective functions.

Unless I misunderstand we need the value of 'data' as it is used to
populate the function local perf_event_attr structure.

However it is possible to instead read 'data' from __vcpu_sys_reg in
kvm_pmu_create_perf_event instead of the call site. However
kvm_pmu_set_counter_event_type would have to set the value of
__vcpu_sys_reg from its data argument (as __vcpu_sys_reg normally gets
set after kvm_pmu_set_counter_event_type returns). This is OK as we
do this in the next patch in this series anyway - so perhaps I can
bring that forward to this patch?

> 
> nit: If we decide not to do that, please rename "data" to something more
> obvious, event_type.
> 
> >   /**
> >    * kvm_pmu_get_counter_value - get PMU counter value
> >    * @vcpu: The vcpu pointer
> > @@ -57,11 +59,18 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
> >    */
> >   void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
> >   {
> > -	u64 reg;
> > +	u64 reg, data;
> 
> nit: Same here, data is too generic.
> 
> >   	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> >   	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
> >   	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
> > +
> > +	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> > +	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
> > +	data = __vcpu_sys_reg(vcpu, reg + select_idx);
> > +
> > +	/* Recreate the perf event to reflect the updated sample_period */
> > +	kvm_pmu_create_perf_event(vcpu, data, select_idx);
> >   }
> >   /**
> > @@ -380,17 +389,13 @@ static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
> >   }
> >   /**
> > - * kvm_pmu_set_counter_event_type - set selected counter to monitor some event
> > + * kvm_pmu_create_perf_event - create a perf event for a counter
> >    * @vcpu: The vcpu pointer
> > - * @data: The data guest writes to PMXEVTYPER_EL0
> > + * @data: Type of event as per PMXEVTYPER_EL0 format
> >    * @select_idx: The number of selected counter
> > - *
> > - * When OS accesses PMXEVTYPER_EL0, that means it wants to set a PMC to count an
> > - * event with given hardware event number. Here we call perf_event API to
> > - * emulate this action and create a kernel perf event for it.
> >    */
> > -void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
> > -				    u64 select_idx)
> > +static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
> > +				      u64 select_idx)
> >   {
> >   	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> >   	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> > @@ -433,6 +438,22 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
> >   	pmc->perf_event = event;
> 
> We should release the existing perf_event to prevent a memory leak and
> also a corruption in the data via the overflow handler for the existing
> event. Am I missing something here ?

In kvm_pmu_create_perf_event (formally kvm_pmu_set_counter_event_type) we call
kvm_pmu_stop_counter - this releases the event.

So there is no memory leak here.

Thanks,

Andrew Murray

> 
> >   }
> > +/**
> > + * kvm_pmu_set_counter_event_type - set selected counter to monitor some event
> > + * @vcpu: The vcpu pointer
> > + * @data: The data guest writes to PMXEVTYPER_EL0
> > + * @select_idx: The number of selected counter
> > + *
> > + * When OS accesses PMXEVTYPER_EL0, that means it wants to set a PMC to count an
> > + * event with given hardware event number. Here we call perf_event API to
> > + * emulate this action and create a kernel perf event for it.
> > + */
> > +void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
> > +				    u64 select_idx)
> > +{
> > +	kvm_pmu_create_perf_event(vcpu, data, select_idx);
> > +}
> > +
> >   bool kvm_arm_support_pmu_v3(void)
> >   {
> >   	/*
> > 
> 
> 
> Cheers
> Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
