Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B609C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:21:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B70D20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GBZA97sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B70D20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vDLH+aNV5JYcTJoF8DA7JVtdln2l5Snp/Pb9fWYoec0=; b=GBZA97srSyVwvz
	q1TStQFQ/Qrz/HPYJ/JtaRdEISpDjExub7HELe8h1lWI/yeTs4BdSmpE2grQ65HQ3aEWOQ6V/jgNO
	oV8b0UnWuZ3apScK0eS/DcWC2pZMhPJK4TvLVU2LkGzRSf5SAbApkPjMrOAavLrtMkhovyElWV1dV
	JIo2WnbRiwZIr4KRGqJ/l3l+SXafAurb3QSlra9W9sINXLTlc/yum9npEZ65f/Fjlhh8KbBNLYXYe
	5/+qwAchHGZlJH11+Vtn8H7Spc/04hAmCQeIa2zpORdquAmqMj3006FkEblBc4sKkO9W026M4kYfy
	eBNuUVDhXIqLZXMhUmbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqzjJ-0002Q0-0F; Tue, 05 Feb 2019 12:21:33 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqzjF-0002PJ-4w
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:21:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B525380D;
 Tue,  5 Feb 2019 04:21:28 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A19753F7B4;
 Tue,  5 Feb 2019 04:21:27 -0800 (PST)
Subject: Re: [PATCH v2 3/5] KVM: arm/arm64: re-create event when setting
 counter value
To: Andrew Murray <andrew.murray@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <1549299218-44714-1-git-send-email-andrew.murray@arm.com>
 <1549299218-44714-4-git-send-email-andrew.murray@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <00ead646-aec6-deff-2dc3-7cb0e253a57c@arm.com>
Date: Tue, 5 Feb 2019 12:21:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1549299218-44714-4-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_042129_196449_AB7F4618 
X-CRM114-Status: GOOD (  24.93  )
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
 suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On 04/02/2019 16:53, Andrew Murray wrote:
> The perf event sample_period is currently set based upon the current
> counter value, when PMXEVTYPER is written to and the perf event is created.
> However the user may choose to write the type before the counter value in
> which case sample_period will be set incorrectly. Let's instead decouple
> event creation from PMXEVTYPER and (re)create the event in either
> suitation.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  virt/kvm/arm/pmu.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 6e7c179..95d74ec 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -24,6 +24,7 @@
>  #include <kvm/arm_pmu.h>
>  #include <kvm/arm_vgic.h>
>  
> +static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx);
>  /**
>   * kvm_pmu_get_counter_value - get PMU counter value
>   * @vcpu: The vcpu pointer
> @@ -62,6 +63,9 @@ void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
>  	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
>  	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
>  	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
> +
> +	/* Recreate the perf event to reflect the updated sample_period */
> +	kvm_pmu_create_perf_event(vcpu, select_idx);
>  }
>  
>  /**
> @@ -378,23 +382,22 @@ static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
>  }
>  
>  /**
> - * kvm_pmu_set_counter_event_type - set selected counter to monitor some event
> + * kvm_pmu_create_perf_event - create a perf event for a counter
>   * @vcpu: The vcpu pointer
> - * @data: The data guest writes to PMXEVTYPER_EL0
> + * @data: Type of event as per PMXEVTYPER_EL0 format
>   * @select_idx: The number of selected counter
> - *
> - * When OS accesses PMXEVTYPER_EL0, that means it wants to set a PMC to count an
> - * event with given hardware event number. Here we call perf_event API to
> - * emulate this action and create a kernel perf event for it.
>   */
> -void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
> -				    u64 select_idx)
> +static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
>  {
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
>  	struct perf_event *event;
>  	struct perf_event_attr attr;
> -	u64 eventsel, counter;
> +	u64 eventsel, counter, reg, data;
> +
> +	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> +	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
> +	data = __vcpu_sys_reg(vcpu, reg);
>  
>  	kvm_pmu_stop_counter(vcpu, pmc);
>  	eventsel = data & ARMV8_PMU_EVTYPE_EVENT;
> @@ -431,6 +434,25 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
>  	pmc->perf_event = event;
>  }
>  
> +/**
> + * kvm_pmu_set_counter_event_type - set selected counter to monitor some event
> + * @vcpu: The vcpu pointer
> + * @data: The data guest writes to PMXEVTYPER_EL0
> + * @select_idx: The number of selected counter
> + *
> + * When OS accesses PMXEVTYPER_EL0, that means it wants to set a PMC to count an
> + * event with given hardware event number. Here we call perf_event API to
> + * emulate this action and create a kernel perf event for it.
> + */
> +void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
> +				    u64 select_idx)
> +{
> +	u64 event_type = data & ARMV8_PMU_EVTYPE_MASK;
> +> +	__vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + select_idx) = event_type;

I think there has been a wrong split. In the next patch you add the
check for the cycle counter but I believe it should be already present here.

With that fixed:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

> +	kvm_pmu_create_perf_event(vcpu, select_idx);
> +}
> +
>  bool kvm_arm_support_pmu_v3(void)
>  {
>  	/*
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
