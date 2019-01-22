Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC83C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:59:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F3020879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T9nBY6v7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F3020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lXQn+12oE6RhapUR5elDSIsWstEhgde9RWBXeuYxkaI=; b=T9nBY6v786wEHU
	idg8eut+aWEhRoKy61xT+fchiz/5eX59rNKwKaPkfxYMLYNEKKfGfMsGWoQ+NTAzXpJgDFC3sZbvj
	RJo6iXsno9flkZlGU5ZrAEzYvMLXz+E6qm7Q2uckBD/JvFw8rgvUkQpURS6jfkIG7RKes9B+ciXZJ
	RMB3m9+XJQqLK4fORFky1x6laqlrRd0iekvFETfM+CRij8zHm6/AZCxqaCdy/6PoDAcpNBlOnchGx
	ewvM3DDzO2M9Dbu0TMIV6GOT2ClD2I7wT9VWO4ySzLSYmesnxgn0SN+8+zzqUBHGZ2fNfbZU3soq6
	qDpVYvVYeFAukNJuR3yQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxWw-0000kX-EY; Tue, 22 Jan 2019 14:59:58 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxWr-0000ju-Sc
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:59:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA8EA78;
 Tue, 22 Jan 2019 06:59:51 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C83493F589;
 Tue, 22 Jan 2019 06:59:50 -0800 (PST)
Subject: Re: [PATCH 4/4] KVM: arm/arm64: support chained PMU counters
To: Andrew Murray <andrew.murray@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
 <1548154197-5470-5-git-send-email-andrew.murray@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <75737475-4013-65a5-dc80-af6ec35868f9@arm.com>
Date: Tue, 22 Jan 2019 14:59:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548154197-5470-5-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_065953_939915_FAD7E541 
X-CRM114-Status: GOOD (  29.79  )
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
Cc: kvmarm@lists.cs.columbia.edu, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew

On 22/01/2019 10:49, Andrew Murray wrote:
> Emulate chained PMU counters by creating a single 64 bit event counter
> for a pair of chained KVM counters.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  include/kvm/arm_pmu.h |   2 +
>  virt/kvm/arm/pmu.c    | 308 +++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 258 insertions(+), 52 deletions(-)
> 
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index f87fe20..d4f3b28 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -29,6 +29,8 @@ struct kvm_pmc {
>  	u8 idx;	/* index into the pmu->pmc array */
>  	struct perf_event *perf_event;
>  	u64 bitmask;
> +	u64 sample_period;
> +	u64 left;
>  };
>  
>  struct kvm_pmu {
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 1921ca9..d111d5b 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -24,10 +24,26 @@
>  #include <kvm/arm_pmu.h>
>  #include <kvm/arm_vgic.h>
>  
> +#define ARMV8_PMUV3_PERFCTR_CHAIN 0x1E
> +static void kvm_pmu_stop_release_perf_event_pair(struct kvm_vcpu *vcpu,
> +					    u64 pair_low);
> +static void kvm_pmu_stop_release_perf_event_single(struct kvm_vcpu *vcpu,
> +					      u64 select_idx);
> +static void kvm_pmu_reenable_enabled_pair(struct kvm_vcpu *vcpu, u64 pair_low);
>  static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu, u64 pair);
>  static void kvm_pmu_counter_create_enabled_perf_event(struct kvm_vcpu *vcpu,
>  						      u64 select_idx);
> -static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
> +
> +/**
> + * kvm_pmu_counter_is_high_word - is select_idx high counter of 64bit event
> + * @pmc: The PMU counter pointer
> + * @select_idx: The counter index
> + */
> +static inline bool kvm_pmu_counter_is_high_word(struct kvm_pmc *pmc)
> +{
> +	return ((pmc->perf_event->attr.config1 & 0x1)
> +		&& (pmc->idx % 2));
> +}
>  
>  /**
>   * kvm_pmu_get_counter_value - get PMU counter value
> @@ -36,7 +52,7 @@ static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
>   */
>  u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>  {
> -	u64 counter, reg, enabled, running;
> +	u64 counter, reg, enabled, running, incr;
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
>  
> @@ -47,14 +63,53 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>  	/* The real counter value is equal to the value of counter register plus
>  	 * the value perf event counts.
>  	 */
> -	if (pmc->perf_event)
> -		counter += perf_event_read_value(pmc->perf_event, &enabled,
> +	if (pmc->perf_event) {
> +		incr = perf_event_read_value(pmc->perf_event, &enabled,
>  						 &running);
>  
> +		if (kvm_pmu_counter_is_high_word(pmc))
> +			incr = upper_32_bits(incr);
> +		counter += incr;
> +	}
> +
>  	return counter & pmc->bitmask;
>  }
>  
>  /**
> + * kvm_pmu_counter_is_enabled - is a counter active
> + * @vcpu: The vcpu pointer
> + * @select_idx: The counter index
> + */
> +static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
> +{
> +	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
> +
> +	return (__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) &&
> +	       (__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask & BIT(select_idx));
> +}
> +
> +/**
> + * kvnm_pmu_event_is_chained - is a pair of counters chained and enabled
> + * @vcpu: The vcpu pointer
> + * @select_idx: The low counter index
> + */
> +static bool kvm_pmu_event_is_chained(struct kvm_vcpu *vcpu, u64 pair_low)
> +{
> +	u64 eventsel;
> +
> +	eventsel = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + pair_low + 1) &
> +			ARMV8_PMU_EVTYPE_EVENT;
> +	if (eventsel != ARMV8_PMUV3_PERFCTR_CHAIN)
> +		return false;
> +
> +	if (kvm_pmu_counter_is_enabled(vcpu, pair_low) !=
> +	    kvm_pmu_counter_is_enabled(vcpu, pair_low + 1))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
>   * kvm_pmu_set_counter_value - set PMU counter value
>   * @vcpu: The vcpu pointer
>   * @select_idx: The counter index
> @@ -62,29 +117,45 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>   */
>  void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
>  {
> -	u64 reg;
> -	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> -	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> +	u64 reg, pair_low;
>  
>  	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
>  	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
>  	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
>  
> -	kvm_pmu_stop_counter(vcpu, pmc);
> -	kvm_pmu_reenable_enabled_single(vcpu, select_idx);
> +	pair_low = (select_idx % 2) ? select_idx - 1 : select_idx;

Don't really know if it's better but you can write it as:

	pair_low = select_idx & ~(1ULL);

But the compiler might already optimize it.

> +
> +	/* Recreate the perf event to reflect the updated sample_period */
> +	if (kvm_pmu_event_is_chained(vcpu, pair_low)) {
> +		kvm_pmu_stop_release_perf_event_pair(vcpu, pair_low);
> +		kvm_pmu_reenable_enabled_pair(vcpu, pair_low);
> +	} else {
> +		kvm_pmu_stop_release_perf_event_single(vcpu, select_idx);
> +		kvm_pmu_reenable_enabled_single(vcpu, select_idx);
> +	}
>  }
>  
>  /**
>   * kvm_pmu_release_perf_event - remove the perf event
>   * @pmc: The PMU counter pointer
>   */
> -static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
> +static void kvm_pmu_release_perf_event(struct kvm_vcpu *vcpu,
> +				       struct kvm_pmc *pmc)
>  {
> -	if (pmc->perf_event) {
> -		perf_event_disable(pmc->perf_event);
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc_alt;
> +	u64 pair_alt;
> +
> +	pair_alt = (pmc->idx % 2) ? pmc->idx - 1 : pmc->idx + 1;
> +	pmc_alt = &pmu->pmc[pair_alt];
> +
> +	if (pmc->perf_event)
>  		perf_event_release_kernel(pmc->perf_event);
> -		pmc->perf_event = NULL;
> -	}
> +
> +	if (pmc->perf_event == pmc_alt->perf_event)
> +		pmc_alt->perf_event = NULL;

Shouldn't we release pmc_alt->perf_event before setting it to NULL?

> +
> +	pmc->perf_event = NULL;
>  }
>  
>  /**
> @@ -92,22 +163,60 @@ static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
>   * @vcpu: The vcpu pointer
>   * @pmc: The PMU counter pointer
>   *
> - * If this counter has been configured to monitor some event, release it here.
> + * If this counter has been configured to monitor some event, stop it here.
>   */
>  static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc)
>  {
>  	u64 counter, reg;
>  
>  	if (pmc->perf_event) {
> +		perf_event_disable(pmc->perf_event);
>  		counter = kvm_pmu_get_counter_value(vcpu, pmc->idx);
>  		reg = (pmc->idx == ARMV8_PMU_CYCLE_IDX)
>  		       ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + pmc->idx;
>  		__vcpu_sys_reg(vcpu, reg) = counter;
> -		kvm_pmu_release_perf_event(pmc);
>  	}
>  }
>  
>  /**
> + * kvm_pmu_stop_release_perf_event_pair - stop and release a pair of counters
> + * @vcpu: The vcpu pointer
> + * @pmc_low: The PMU counter pointer for lower word
> + * @pmc_high: The PMU counter pointer for higher word
> + *
> + * As chained counters share the underlying perf event, we stop them
> + * both first before discarding the underlying perf event
> + */
> +static void kvm_pmu_stop_release_perf_event_pair(struct kvm_vcpu *vcpu,
> +					    u64 idx_low)
> +{
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc_low = &pmu->pmc[idx_low];
> +	struct kvm_pmc *pmc_high = &pmu->pmc[idx_low + 1];
> +
> +	kvm_pmu_stop_counter(vcpu, pmc_low);
> +	kvm_pmu_stop_counter(vcpu, pmc_high);
> +
> +	kvm_pmu_release_perf_event(vcpu, pmc_low);
> +	kvm_pmu_release_perf_event(vcpu, pmc_high);

Hmmm, I think there is some confusion between what this function and
kvm_pmu_release_perf_event() should do, at this point
pmc_high->perf_event == NULL and we can't release it.

> +}
> +
> +/**
> + * kvm_pmu_stop_release_perf_event_single - stop and release a counter
> + * @vcpu: The vcpu pointer
> + * @select_idx: The counter index
> + */
> +static void kvm_pmu_stop_release_perf_event_single(struct kvm_vcpu *vcpu,
> +					      u64 select_idx)
> +{
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> +
> +	kvm_pmu_stop_counter(vcpu, pmc);
> +	kvm_pmu_release_perf_event(vcpu, pmc);
> +}
> +
> +/**
>   * kvm_pmu_vcpu_reset - reset pmu state for cpu
>   * @vcpu: The vcpu pointer
>   *
> @@ -118,7 +227,7 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  
>  	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
> -		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
> +		kvm_pmu_stop_release_perf_event_single(vcpu, i);
>  		pmu->pmc[i].idx = i;
>  		pmu->pmc[i].bitmask = 0xffffffffUL;
>  	}
> @@ -136,7 +245,7 @@ void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu)
>  
>  	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
>  		struct kvm_pmc *pmc = &pmu->pmc[i];
> -		kvm_pmu_release_perf_event(pmc);
> +		kvm_pmu_release_perf_event(vcpu, pmc);
>  	}
>  }
>  
> @@ -171,49 +280,81 @@ static void kvm_pmu_enable_counter_single(struct kvm_vcpu *vcpu, u64 select_idx)
>  }
>  
>  /**
> - * kvm_pmu_enable_counter - enable selected PMU counter
> + * kvm_pmu_reenable_enabled_single - reenable a counter if it should be enabled
>   * @vcpu: The vcpu pointer
> - * @val: the value guest writes to PMCNTENSET register
> - *
> - * Call perf_event_enable to start counting the perf event
> + * @select_idx: The counter index
>   */
> -void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
> +static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu,
> +					    u64 select_idx)
>  {
> -	int i;
> +	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
> +	u64 set = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
>  
> -	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) || !val)
> +	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
>  		return;
>  
> -	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
> -		if (!(val & BIT(i)))
> -			continue;
> +	if (set & BIT(select_idx))
> +		kvm_pmu_enable_counter_single(vcpu, select_idx);
> +}
>  
> -		kvm_pmu_enable_counter_single(vcpu, i);
> +/**
> + * kvm_pmu_reenable_enabled_pair - reenable a pair if they should be enabled
> + * @vcpu: The vcpu pointer
> + * @pair_low: The low counter index
> + */
> +static void kvm_pmu_reenable_enabled_pair(struct kvm_vcpu *vcpu, u64 pair_low)
> +{
> +	kvm_pmu_reenable_enabled_single(vcpu, pair_low);
> +	kvm_pmu_reenable_enabled_single(vcpu, pair_low+1);
> +}
> +
> +/**
> + * kvm_pmu_enable_counter_pair - enable counters pair at a time
> + * @vcpu: The vcpu pointer
> + * @val: counters to enable
> + * @pair_low: The low counter index
> + */
> +static void kvm_pmu_enable_counter_pair(struct kvm_vcpu *vcpu, u64 val,
> +					u64 pair_low)
> +{
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc_low = &pmu->pmc[pair_low];
> +	struct kvm_pmc *pmc_high = &pmu->pmc[pair_low + 1];
> +
> +	if (kvm_pmu_event_is_chained(vcpu, pair_low)) {
> +		if (pmc_low->perf_event != pmc_high->perf_event)
> +			kvm_pmu_stop_release_perf_event_pair(vcpu, pair_low);
>  	}
> +
> +	if (val & BIT(pair_low))
> +		kvm_pmu_enable_counter_single(vcpu, pair_low);
> +
> +	if (val & BIT(pair_low+1))
> +		kvm_pmu_enable_counter_single(vcpu, pair_low + 1);
>  }
>  
>  /**
> - * kvm_pmu_reenable_enabled_single - reenable a counter if it should be enabled
> + * kvm_pmu_enable_counter - enable selected PMU counter
>   * @vcpu: The vcpu pointer
> - * @select_idx: The counter index
> + * @val: the value guest writes to PMCNTENSET register
> + *
> + * Call perf_event_enable to start counting the perf event
>   */
> -static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu,
> -					    u64 select_idx)
> +void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
>  {
> -	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
> -	u64 set = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
> +	int i;
>  
> -	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
> +	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) || !val)
>  		return;
>  
> -	if (set & BIT(select_idx))
> -		kvm_pmu_enable_counter_single(vcpu, select_idx);
> +	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i += 2)
> +		kvm_pmu_enable_counter_pair(vcpu, val, i);
>  }
>  
>  /**
>   * kvm_pmu_disable_counter - disable selected PMU counter
>   * @vcpu: The vcpu pointer
> - * @pmc: The counter to dissable
> + * @select_idx: The counter index
>   */
>  static void kvm_pmu_disable_counter_single(struct kvm_vcpu *vcpu,
>  					   u64 select_idx)
> @@ -221,8 +362,40 @@ static void kvm_pmu_disable_counter_single(struct kvm_vcpu *vcpu,
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
>  
> -	if (pmc->perf_event)
> +	if (pmc->perf_event) {
>  		perf_event_disable(pmc->perf_event);
> +		if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
> +			kvm_debug("fail to enable perf event\n");
> +	}
> +}
> +
> +/**
> + * kvm_pmu_disable_counter_pair - disable counters pair at a time
> + * @val: counters to disable
> + * @pair_low: The low counter index
> + */
> +static void kvm_pmu_disable_counter_pair(struct kvm_vcpu *vcpu, u64 val,
> +					 u64 pair_low)
> +{
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc_low = &pmu->pmc[pair_low];
> +	struct kvm_pmc *pmc_high = &pmu->pmc[pair_low + 1];
> +
> +	if (!kvm_pmu_event_is_chained(vcpu, pair_low)) {
> +		if (pmc_low->perf_event == pmc_high->perf_event) {
> +			if (pmc_low->perf_event) {
> +				kvm_pmu_stop_release_perf_event_pair(vcpu,
> +								pair_low);
> +				kvm_pmu_reenable_enabled_pair(vcpu, pair_low);
> +			}
> +		}
> +	}
> +
> +	if (val & BIT(pair_low))
> +		kvm_pmu_disable_counter_single(vcpu, pair_low);
> +
> +	if (val & BIT(pair_low + 1))
> +		kvm_pmu_disable_counter_single(vcpu, pair_low + 1);
>  }
>  
>  /**
> @@ -239,12 +412,8 @@ void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val)
>  	if (!val)
>  		return;
>  
> -	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
> -		if (!(val & BIT(i)))
> -			continue;
> -
> -		kvm_pmu_disable_counter_single(vcpu, i);
> -	}
> +	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i += 2)
> +		kvm_pmu_disable_counter_pair(vcpu, val, i);
>  }
>  
>  static u64 kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
> @@ -355,6 +524,17 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
>  
>  	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(idx);
>  
> +	if (kvm_pmu_event_is_chained(vcpu, idx + 1)) {

Doesn't kvm_pmu_event_is_chained() expect the low part of the counter pair?

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
