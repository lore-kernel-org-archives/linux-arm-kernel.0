Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A41C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:57:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A1C20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ffypQ9BA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A1C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+L5jAQA9LxUJ0JQqXaGQuN8pLVKWBuEi/Bt0hgtKDoQ=; b=ffypQ9BAETGcuh
	TWpZ7QcCAfRMR71TFUY12aZZcHJRw2XURskPo5YPEeOsILQ5JQUOLIxSwlqfbVNwdmjh1JTcpVWnx
	fcgUnaxrYrdiFP29BQa1rNLsXzjgz+nS/NEkl1JmkeuSv9PP2lpW4+2BudRTq8z5VZt1JemdduKWg
	YRlFma8WsSl9/5DTz1ZpG2hixPiWZ8Q3F505kd69OGsJutUqkKyCtXUFcVJ6riBHS5ek0pnrGngGm
	ErZE9qd8EhmABRRLjW2QeS1zrip2i0Uhbvfy+4ipaWgnRqxkG1mYExGj3k8wV8o8ygDOnXEEH9uGu
	IJVEmssQTUM44upC7Ysw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfg9-0007px-5b; Mon, 18 Feb 2019 09:57:37 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfg6-0007pd-CG
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:57:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C375E80D;
 Mon, 18 Feb 2019 01:57:33 -0800 (PST)
Received: from localhost (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A8AF3F589;
 Mon, 18 Feb 2019 01:57:33 -0800 (PST)
Date: Mon, 18 Feb 2019 09:57:31 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 4/5] KVM: arm/arm64: lazily create perf events on enable
Message-ID: <20190218095731.GF54124@e119886-lin.cambridge.arm.com>
References: <1549299218-44714-1-git-send-email-andrew.murray@arm.com>
 <1549299218-44714-5-git-send-email-andrew.murray@arm.com>
 <bd21facb-4245-f583-e4a0-23399017579d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bd21facb-4245-f583-e4a0-23399017579d@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_015734_429540_2368F6AF 
X-CRM114-Status: GOOD (  32.10  )
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
Cc: marc.zyngier@arm.com, julien.thierry@arm.com, christoffer.dall@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 11:36:02AM +0000, Suzuki K Poulose wrote:
> Hi Andrew,
> 
> On 04/02/2019 16:53, Andrew Murray wrote:
> > To prevent re-creating perf events everytime the counter registers
> > are changed, let's instead lazily create the event when the event
> > is first enabled and destroy it when it changes.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >   virt/kvm/arm/pmu.c | 96 ++++++++++++++++++++++++++++++++++++++----------------
> >   1 file changed, 68 insertions(+), 28 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> > index 95d74ec..a64aeb2 100644
> > --- a/virt/kvm/arm/pmu.c
> > +++ b/virt/kvm/arm/pmu.c
> > @@ -24,7 +24,10 @@
> >   #include <kvm/arm_pmu.h>
> >   #include <kvm/arm_vgic.h>
> > +static void kvm_pmu_sync_counter_enable(struct kvm_vcpu *vcpu, u64 select_idx);
> >   static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx);
> > +static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
> > +
> >   /**
> >    * kvm_pmu_get_counter_value - get PMU counter value
> >    * @vcpu: The vcpu pointer
> > @@ -59,13 +62,15 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
> >   void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
> >   {
> >   	u64 reg;
> > +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> > +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> >   	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> >   	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
> >   	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
> > -	/* Recreate the perf event to reflect the updated sample_period */
> > -	kvm_pmu_create_perf_event(vcpu, select_idx);
> > +	kvm_pmu_stop_counter(vcpu, pmc);
> > +	kvm_pmu_sync_counter_enable(vcpu, select_idx);
> >   }
> >   /**
> > @@ -83,6 +88,7 @@ static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
> >   /**
> >    * kvm_pmu_stop_counter - stop PMU counter
> > + * @vcpu: The vcpu pointer
> >    * @pmc: The PMU counter pointer
> >    *
> >    * If this counter has been configured to monitor some event, release it here.
> > @@ -143,6 +149,24 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
> >   }
> >   /**
> > + * kvm_pmu_enable_counter - create/enable a counter
> > + * @vcpu: The vcpu pointer
> > + * @select_idx: The counter index
> > + */
> > +static void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 select_idx)
> > +{
> > +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> > +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> > +
> > +	if (!pmc->perf_event)
> > +		kvm_pmu_create_perf_event(vcpu, select_idx);
> > +
> > +	perf_event_enable(pmc->perf_event);
> > +	if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
> > +		kvm_debug("failed to enable perf event\n");
> > +}
> > +
> > +/**
> >    * kvm_pmu_enable_counter_mask - enable selected PMU counters
> >    * @vcpu: The vcpu pointer
> >    * @val: the value guest writes to PMCNTENSET register
> > @@ -152,8 +176,6 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
> >   void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
> >   {
> >   	int i;
> > -	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> > -	struct kvm_pmc *pmc;
> >   	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) || !val)
> >   		return;
> > @@ -162,16 +184,39 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
> >   		if (!(val & BIT(i)))
> >   			continue;
> > -		pmc = &pmu->pmc[i];
> > -		if (pmc->perf_event) {
> > -			perf_event_enable(pmc->perf_event);
> > -			if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
> > -				kvm_debug("fail to enable perf event\n");
> > -		}
> > +		kvm_pmu_enable_counter(vcpu, i);
> >   	}
> >   }
> >   /**
> > + * kvm_pmu_sync_counter_enable - reenable a counter if it should be enabled
> > + * @vcpu: The vcpu pointer
> > + * @select_idx: The counter index
> > + */
> > +static void kvm_pmu_sync_counter_enable(struct kvm_vcpu *vcpu,
> > +					    u64 select_idx)
> > +{
> > +	u64 set = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> > +
> > +	if (set & BIT(select_idx))
> > +		kvm_pmu_enable_counter_mask(vcpu, BIT(select_idx));
> 
> I think there is a problem here. We could be creating an event for a
> counter beyond what is supported by the CPU. i.e, we don't
> seem to validate that the mask we are creating is within the
> kvm_pmu_valid_counter_mask(). The other callers seem to verify this.
> I guess it may be better to add a check for this in the
> kvm_pmu_enable_counter_mask().

Actually I think this is OK. This function is only called by
kvm_pmu_set_counter_event_type and kvm_pmu_set_counter_value - both these
functions are called from arch/arm64/kvm/sys_regs.c which ensures that
pmu_counter_idx_valid is true (which is same as kvm_pmu_valid_counter_mask).

This does become a problem in the next patch when we add chained counters
however we then add the check against kvm_pmu_valid_counter_mask (see
kvm_pmu_enable_counter_mask).

> 
> minor nit: Feel free to ignore. If we move the check for PMCNTENSET_EL0 to
> pmu_enable_counter_mask() we could get rid of the above function. Anyways,
> we should only be enabling the counters set in PMCNTENSET_EL0.
> 

This does seem acceptable, however the next patch adds a
kvm_pmu_sync_counter_pair function, which does add some additional value. So
whilst kvm_pmu_sync_counter_enable may seem redundant here it is built upon
later.

> 
> > +}
> > +
> > +/**
> > + * kvm_pmu_disable_counter - disable selected PMU counter
> > + * @vcpu: The vcpu pointer
> > + * @pmc: The counter to disable
> > + */
> > +static void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 select_idx)
> > +{
> > +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> > +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> > +
> > +	if (pmc->perf_event)
> > +		perf_event_disable(pmc->perf_event);
> > +}
> > +
> > +/**
> >    * kvm_pmu_disable_counter_mask - disable selected PMU counters
> >    * @vcpu: The vcpu pointer
> >    * @val: the value guest writes to PMCNTENCLR register
> > @@ -181,8 +226,6 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
> >   void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
> >   {
> >   	int i;
> > -	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> > -	struct kvm_pmc *pmc;
> >   	if (!val)
> >   		return;
> > @@ -191,9 +234,7 @@ void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
> >   		if (!(val & BIT(i)))
> >   			continue;
> > -		pmc = &pmu->pmc[i];
> > -		if (pmc->perf_event)
> > -			perf_event_disable(pmc->perf_event);
> > +		kvm_pmu_disable_counter(vcpu, i);
> >   	}
> >   }
> > @@ -375,16 +416,9 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
> >   	}
> >   }
> > -static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
> > -{
> > -	return (__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) &&
> > -	       (__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & BIT(select_idx));
> > -}
> > -
> >   /**
> > - * kvm_pmu_create_perf_event - create a perf event for a counter
> > + * kvm_pmu_counter_create_enabled_perf_event - create a perf event for a counter
> 
> nit: Name hasn't changed. Also, please could update that, the events are always
> created disabled and they are only enabled lazily.

Thanks,

Andrew Murray

> 
> Reset looks fines.
> 
> Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
