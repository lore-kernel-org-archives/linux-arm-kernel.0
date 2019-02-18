Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE7EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:39:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F0C20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YSsbCWK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F0C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OEUs4i4qxe9DGhDX4UVKidJuMOKVD6ODyKZPToV+gGM=; b=YSsbCWK8kycmZO
	9sRz7VR9yx5TacXHzW7TwU/zJwQmVcBJ1Ei8mVI7GCMl9kGYPSYD6AilWf1GXggoEDd6JUMoEGw6n
	DMRPSn9tJdu1eRGgZHKkB6C/ZUFXf3g77NKSKRxk3pKoDPNMu6T2o85WQ80TverveV88B0M4u3PCh
	LSrqqAj5VU3ekI2tjhklPSlciUX32YHoL8zpdn+I3qUXVR39kf1XhOiExP0Pa0FAWhpXJoiQ60SaP
	mHeyg0TAsUg8Is+9m0gZCb8Q2rRMSYhys5TTjc/6SIT8j0vjZsvHJkoeQP8uT8OEAcNUPt/4xtQyN
	dYw/3Tv5I3XoYlkFtrgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfOz-0003yH-Po; Mon, 18 Feb 2019 09:39:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfOv-0003vw-3T
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:39:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE3080D;
 Mon, 18 Feb 2019 01:39:47 -0800 (PST)
Received: from localhost (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81B633F589;
 Mon, 18 Feb 2019 01:39:46 -0800 (PST)
Date: Mon, 18 Feb 2019 09:39:44 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 3/5] KVM: arm/arm64: re-create event when setting
 counter value
Message-ID: <20190218093944.GE54124@e119886-lin.cambridge.arm.com>
References: <1549299218-44714-1-git-send-email-andrew.murray@arm.com>
 <1549299218-44714-4-git-send-email-andrew.murray@arm.com>
 <3adc7d31-9d5a-d66b-21ee-9b4da986d24f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3adc7d31-9d5a-d66b-21ee-9b4da986d24f@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_013949_148154_8A23CDED 
X-CRM114-Status: GOOD (  21.76  )
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

On Wed, Feb 13, 2019 at 02:28:51PM +0000, Suzuki K Poulose wrote:
> Hi Andrew,
> 
> On 04/02/2019 16:53, Andrew Murray wrote:
> > The perf event sample_period is currently set based upon the current
> > counter value, when PMXEVTYPER is written to and the perf event is created.
> > However the user may choose to write the type before the counter value in
> > which case sample_period will be set incorrectly. Let's instead decouple
> > event creation from PMXEVTYPER and (re)create the event in either
> > suitation.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >   virt/kvm/arm/pmu.c | 40 +++++++++++++++++++++++++++++++---------
> >   1 file changed, 31 insertions(+), 9 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> > index 6e7c179..95d74ec 100644
> > --- a/virt/kvm/arm/pmu.c
> > +++ b/virt/kvm/arm/pmu.c
> > @@ -24,6 +24,7 @@
> >   #include <kvm/arm_pmu.h>
> >   #include <kvm/arm_vgic.h>
> > +static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx);
> >   /**
> >    * kvm_pmu_get_counter_value - get PMU counter value
> >    * @vcpu: The vcpu pointer
> > @@ -62,6 +63,9 @@ void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
> >   	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> >   	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
> >   	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
> > +
> > +	/* Recreate the perf event to reflect the updated sample_period */
> > +	kvm_pmu_create_perf_event(vcpu, select_idx);
> >   }
> >   /**
> > @@ -378,23 +382,22 @@ static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
> >   }
> >   /**
> > - * kvm_pmu_set_counter_event_type - set selected counter to monitor some event
> > + * kvm_pmu_create_perf_event - create a perf event for a counter
> >    * @vcpu: The vcpu pointer
> > - * @data: The data guest writes to PMXEVTYPER_EL0
> > + * @data: Type of event as per PMXEVTYPER_EL0 format
> >    * @select_idx: The number of selected counter
> 
> nit: data no longer exists.
> 

Thanks for the review,

Andrew Murray

> 
> > - *
> > - * When OS accesses PMXEVTYPER_EL0, that means it wants to set a PMC to count an
> > - * event with given hardware event number. Here we call perf_event API to
> > - * emulate this action and create a kernel perf event for it.
> >    */
> > -void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
> > -				    u64 select_idx)
> > +static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
> >   {
> 
> With the comment from Julien addressed,
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulse@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
