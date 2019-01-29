Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA242C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:08:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EE32084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sj/3s/sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EE32084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZtXUFlfo/Qak0AYGicbqPp0zv7rjz82Yxfr0hlUjI3w=; b=sj/3s/sVP2xzFC
	fL3it1seWQEW8XTfLIKm7lsgrM1fjC/Xq9pDv5diS3PjPBYLJNt5OmYBdIqk8UqXIizCRQFQ5cQuG
	JaiyV2oy0O5H8qeR0K5EaYKDtfzpNc0GhKdufIFTKCJ5ij8pncXPQTsfStIS2xvW6DE3f7Jx774zy
	nVDNOafBJt+o13r1kTC2CX7K0SeEVLcoFUgbuKWzF44INCR9eIiG29FoBLnq9/EGbAtnoO88Soy+v
	a7dPXSJfQncFy1PLjxM0Co5huhjJno5Bb2tAUbZb+d8w8HgHllQE41y5mQOjZEsTix42RbgnQJpYR
	OAis9Kk6vNnKNQpt9A9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPNc-0003PX-3U; Tue, 29 Jan 2019 09:08:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPND-00033u-4N
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:08:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BADFB80D;
 Tue, 29 Jan 2019 01:08:00 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD5533F7A6;
 Tue, 29 Jan 2019 01:07:59 -0800 (PST)
Subject: Re: [PATCH 4/4] KVM: arm/arm64: support chained PMU counters
To: Andrew Murray <andrew.murray@arm.com>
References: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
 <1548154197-5470-5-git-send-email-andrew.murray@arm.com>
 <75737475-4013-65a5-dc80-af6ec35868f9@arm.com>
 <20190128171331.GD16627@e119886-lin.cambridge.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <63d34a64-0a6a-d6fa-55b4-103fd4ca16e7@arm.com>
Date: Tue, 29 Jan 2019 09:07:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128171331.GD16627@e119886-lin.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_010803_658352_7F781857 
X-CRM114-Status: GOOD (  24.42  )
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
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 28/01/2019 17:13, Andrew Murray wrote:
> On Tue, Jan 22, 2019 at 02:59:48PM +0000, Julien Thierry wrote:
>> Hi Andrew
>>
>> On 22/01/2019 10:49, Andrew Murray wrote:
>>> Emulate chained PMU counters by creating a single 64 bit event counter
>>> for a pair of chained KVM counters.
>>>
>>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>>> ---
>>>  include/kvm/arm_pmu.h |   2 +
>>>  virt/kvm/arm/pmu.c    | 308 +++++++++++++++++++++++++++++++++++++++++---------
>>>  2 files changed, 258 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
>>> index f87fe20..d4f3b28 100644
>>> --- a/include/kvm/arm_pmu.h
>>> +++ b/include/kvm/arm_pmu.h
>>> @@ -29,6 +29,8 @@ struct kvm_pmc {
>>>  	u8 idx;	/* index into the pmu->pmc array */
>>>  	struct perf_event *perf_event;
>>>  	u64 bitmask;
>>> +	u64 sample_period;
>>> +	u64 left;
>>>  };
>>>  
>>>  struct kvm_pmu {
>>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>>> index 1921ca9..d111d5b 100644
>>> --- a/virt/kvm/arm/pmu.c
>>> +++ b/virt/kvm/arm/pmu.c
>>> @@ -24,10 +24,26 @@
>>>  #include <kvm/arm_pmu.h>
>>>  #include <kvm/arm_vgic.h>
>>>  
>>> +#define ARMV8_PMUV3_PERFCTR_CHAIN 0x1E
>>> +static void kvm_pmu_stop_release_perf_event_pair(struct kvm_vcpu *vcpu,
>>> +					    u64 pair_low);
>>> +static void kvm_pmu_stop_release_perf_event_single(struct kvm_vcpu *vcpu,
>>> +					      u64 select_idx);
>>> +static void kvm_pmu_reenable_enabled_pair(struct kvm_vcpu *vcpu, u64 pair_low);
>>>  static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu, u64 pair);
>>>  static void kvm_pmu_counter_create_enabled_perf_event(struct kvm_vcpu *vcpu,
>>>  						      u64 select_idx);
>>> -static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
>>> +
>>> +/**
>>> + * kvm_pmu_counter_is_high_word - is select_idx high counter of 64bit event
>>> + * @pmc: The PMU counter pointer
>>> + * @select_idx: The counter index
>>> + */
>>> +static inline bool kvm_pmu_counter_is_high_word(struct kvm_pmc *pmc)
>>> +{
>>> +	return ((pmc->perf_event->attr.config1 & 0x1)
>>> +		&& (pmc->idx % 2));
>>> +}
>>>  
>>>  /**
>>>   * kvm_pmu_get_counter_value - get PMU counter value
>>> @@ -36,7 +52,7 @@ static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
>>>   */
>>>  u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>>>  {
>>> -	u64 counter, reg, enabled, running;
>>> +	u64 counter, reg, enabled, running, incr;
>>>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>>>  	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
>>>  
>>> @@ -47,14 +63,53 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>>>  	/* The real counter value is equal to the value of counter register plus
>>>  	 * the value perf event counts.
>>>  	 */
>>> -	if (pmc->perf_event)
>>> -		counter += perf_event_read_value(pmc->perf_event, &enabled,
>>> +	if (pmc->perf_event) {
>>> +		incr = perf_event_read_value(pmc->perf_event, &enabled,
>>>  						 &running);
>>>  
>>> +		if (kvm_pmu_counter_is_high_word(pmc))
>>> +			incr = upper_32_bits(incr);
>>> +		counter += incr;
>>> +	}
>>> +
>>>  	return counter & pmc->bitmask;
>>>  }
>>>  
>>>  /**
>>> + * kvm_pmu_counter_is_enabled - is a counter active
>>> + * @vcpu: The vcpu pointer
>>> + * @select_idx: The counter index
>>> + */
>>> +static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
>>> +{
>>> +	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
>>> +
>>> +	return (__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) &&
>>> +	       (__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask & BIT(select_idx));
>>> +}
>>> +
>>> +/**
>>> + * kvnm_pmu_event_is_chained - is a pair of counters chained and enabled
>>> + * @vcpu: The vcpu pointer
>>> + * @select_idx: The low counter index
>>> + */
>>> +static bool kvm_pmu_event_is_chained(struct kvm_vcpu *vcpu, u64 pair_low)
>>> +{
>>> +	u64 eventsel;
>>> +
>>> +	eventsel = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + pair_low + 1) &
>>> +			ARMV8_PMU_EVTYPE_EVENT;
>>> +	if (eventsel != ARMV8_PMUV3_PERFCTR_CHAIN)
>>> +		return false;
>>> +
>>> +	if (kvm_pmu_counter_is_enabled(vcpu, pair_low) !=
>>> +	    kvm_pmu_counter_is_enabled(vcpu, pair_low + 1))
>>> +		return false;
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +/**
>>>   * kvm_pmu_set_counter_value - set PMU counter value
>>>   * @vcpu: The vcpu pointer
>>>   * @select_idx: The counter index
>>> @@ -62,29 +117,45 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>>>   */
>>>  void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
>>>  {
>>> -	u64 reg;
>>> -	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>>> -	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
>>> +	u64 reg, pair_low;
>>>  
>>>  	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
>>>  	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
>>>  	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
>>>  
>>> -	kvm_pmu_stop_counter(vcpu, pmc);
>>> -	kvm_pmu_reenable_enabled_single(vcpu, select_idx);
>>> +	pair_low = (select_idx % 2) ? select_idx - 1 : select_idx;
>>
>> Don't really know if it's better but you can write it as:
>>
>> 	pair_low = select_idx & ~(1ULL);
>>
>> But the compiler might already optimize it.
>>
> 
> That's quite neat, though I'll leave it as it is, that seems clearer to me.
> 
>>> +
>>> +	/* Recreate the perf event to reflect the updated sample_period */
>>> +	if (kvm_pmu_event_is_chained(vcpu, pair_low)) {
>>> +		kvm_pmu_stop_release_perf_event_pair(vcpu, pair_low);
>>> +		kvm_pmu_reenable_enabled_pair(vcpu, pair_low);
>>> +	} else {
>>> +		kvm_pmu_stop_release_perf_event_single(vcpu, select_idx);
>>> +		kvm_pmu_reenable_enabled_single(vcpu, select_idx);
>>> +	}
>>>  }
>>>  
>>>  /**
>>>   * kvm_pmu_release_perf_event - remove the perf event
>>>   * @pmc: The PMU counter pointer
>>>   */
>>> -static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
>>> +static void kvm_pmu_release_perf_event(struct kvm_vcpu *vcpu,
>>> +				       struct kvm_pmc *pmc)
>>>  {
>>> -	if (pmc->perf_event) {
>>> -		perf_event_disable(pmc->perf_event);
>>> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>>> +	struct kvm_pmc *pmc_alt;
>>> +	u64 pair_alt;
>>> +
>>> +	pair_alt = (pmc->idx % 2) ? pmc->idx - 1 : pmc->idx + 1;
>>> +	pmc_alt = &pmu->pmc[pair_alt];
>>> +
>>> +	if (pmc->perf_event)
>>>  		perf_event_release_kernel(pmc->perf_event);
>>> -		pmc->perf_event = NULL;
>>> -	}
>>> +
>>> +	if (pmc->perf_event == pmc_alt->perf_event)
>>> +		pmc_alt->perf_event = NULL;
>>
>> Shouldn't we release pmc_alt->perf_event before setting it to NULL?
> 
> No, becuase these are the same event, we don't want to free the same
> event twice.
> 

Irrefutable logic, I don't know what I was thinking.

>>
>>> +
>>> +	pmc->perf_event = NULL;
>>>  }
>>>  
>>>  /**
>>> @@ -92,22 +163,60 @@ static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
>>>   * @vcpu: The vcpu pointer
>>>   * @pmc: The PMU counter pointer
>>>   *
>>> - * If this counter has been configured to monitor some event, release it here.
>>> + * If this counter has been configured to monitor some event, stop it here.
>>>   */
>>>  static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc)
>>>  {
>>>  	u64 counter, reg;
>>>  
>>>  	if (pmc->perf_event) {
>>> +		perf_event_disable(pmc->perf_event);
>>>  		counter = kvm_pmu_get_counter_value(vcpu, pmc->idx);
>>>  		reg = (pmc->idx == ARMV8_PMU_CYCLE_IDX)
>>>  		       ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + pmc->idx;
>>>  		__vcpu_sys_reg(vcpu, reg) = counter;
>>> -		kvm_pmu_release_perf_event(pmc);
>>>  	}
>>>  }
>>>  
>>>  /**
>>> + * kvm_pmu_stop_release_perf_event_pair - stop and release a pair of counters
>>> + * @vcpu: The vcpu pointer
>>> + * @pmc_low: The PMU counter pointer for lower word
>>> + * @pmc_high: The PMU counter pointer for higher word
>>> + *
>>> + * As chained counters share the underlying perf event, we stop them
>>> + * both first before discarding the underlying perf event
>>> + */
>>> +static void kvm_pmu_stop_release_perf_event_pair(struct kvm_vcpu *vcpu,
>>> +					    u64 idx_low)
>>> +{
>>> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>>> +	struct kvm_pmc *pmc_low = &pmu->pmc[idx_low];
>>> +	struct kvm_pmc *pmc_high = &pmu->pmc[idx_low + 1];
>>> +
>>> +	kvm_pmu_stop_counter(vcpu, pmc_low);
>>> +	kvm_pmu_stop_counter(vcpu, pmc_high);
>>> +
>>> +	kvm_pmu_release_perf_event(vcpu, pmc_low);
>>> +	kvm_pmu_release_perf_event(vcpu, pmc_high);
>>
>> Hmmm, I think there is some confusion between what this function and
>> kvm_pmu_release_perf_event() should do, at this point
>> pmc_high->perf_event == NULL and we can't release it.
>>
> 
> Don't forget that for paired events, both pmc_{low,high} refer to the
> same perf_event. (This is why we stop the counters individually before
> releasing them - so that we can use the event information whilst working
> out the counter value of pmc_high).
> 
> Or is there something I'm missing?
>  

No, I think I'm the one who got confused between chained registers and
the fact that we try to enable counters two by two.

It's probably best to ignore my comments concerning the release event
stuff :) .

Thanks for explaining.

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
