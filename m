Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135B1C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:42:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D453521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hvy59l+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D453521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iYXfjNJFUnYLcv4p4hrzWHuNEfZckuU208t2SpZ35hQ=; b=hvy59l+3HEIClI
	pFZ9cy2OOLAXNmooHtxG/6GwAgSpZW7XNCFrO+iYcql0rhs9L7881HjPoOLWgxdDCRVysYR3q2GUN
	Mv+TlxBQWDzuYpRortC4dK5qNKRXHP7AulyXEjKWH8wUcVqFOUSu1SXQuc0pNsu+Kqorg3mJHunkE
	l2vOiWL1pNvGyeAdDU8XkFizIbo4NkkGOPrYlpdjAf2W7ldMDJEBgYLb+qQ6JwaWofVhvpn4qT80R
	cgiGoOiV/1lirGJVjoUA15ZAQy5zt+p796LeN54Ox7jy2r+C9AkqcCObVU83Mjq/oDE8hwJgUqFTa
	8qxMGAnr+NhNcmqGKm7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glvNZ-00083m-OZ; Tue, 22 Jan 2019 12:42:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glvNW-00083H-6j
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 12:42:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36DE4EBD;
 Tue, 22 Jan 2019 04:42:05 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 975EA3F614;
 Tue, 22 Jan 2019 04:42:04 -0800 (PST)
Date: Tue, 22 Jan 2019 12:42:02 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH 2/4] KVM: arm/arm64: re-create event when setting counter
 value
Message-ID: <20190122124202.GD8120@e119886-lin.cambridge.arm.com>
References: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
 <1548154197-5470-3-git-send-email-andrew.murray@arm.com>
 <a53b470c-f82c-0070-b2b9-61f30d7d01bb@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a53b470c-f82c-0070-b2b9-61f30d7d01bb@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_044206_262819_73B752E9 
X-CRM114-Status: GOOD (  20.25  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 12:12:51PM +0000, Julien Thierry wrote:
> Hi Andrew,
> 
> On 22/01/2019 10:49, Andrew Murray wrote:
> > The perf event sample_period is currently set based upon the current
> > counter value, when PMXEVTYPER is written to and the perf event is created.
> > However the user may choose to write the type before the counter value in
> > which case sample_period will be set incorrectly. Let's instead decouple
> > event creation from PMXEVTYPER and (re)create the event in either
> > suitation.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  virt/kvm/arm/pmu.c | 39 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 30 insertions(+), 9 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> > index 531d27f..4464899 100644
> > --- a/virt/kvm/arm/pmu.c
> > +++ b/virt/kvm/arm/pmu.c
> > @@ -24,6 +24,8 @@
> >  #include <kvm/arm_pmu.h>
> >  #include <kvm/arm_vgic.h>
> >  
> > +static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
> > +				      u64 select_idx);
> >  /**
> >   * kvm_pmu_get_counter_value - get PMU counter value
> >   * @vcpu: The vcpu pointer
> > @@ -57,11 +59,18 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
> >   */
> >  void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
> >  {
> > -	u64 reg;
> > +	u64 reg, data;
> >  
> >  	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> >  	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
> >  	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
> > +
> > +	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> > +	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
> > +	data = __vcpu_sys_reg(vcpu, reg + select_idx);
> 
> I think this should be just "reg" instead of "reg + select_idx".

Yes, good catch.

Thanks,

Andrew Murray

> 
> Cheers,
> 
> -- 
> Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
