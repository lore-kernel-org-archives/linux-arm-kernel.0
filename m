Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E3BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:16:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A47620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gcq4EWV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A47620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zZ4O+CfKaBvJMAkm0it6D5wH64J5uT/wtlGgRPdCLcc=; b=Gcq4EWV/uAsiGq8tahR+XXM/5
	eZY6SeAKX6AHNLG2bQnr2HNwbWQO2FfChnOs8+Ircm46XuhRFdUNKh2oH0moEKCny3O2PvvbVH3Mx
	5yz9PcZGJrdCr7DDwRd4WS0Ma7DZLQmIyDHAfPbVBiBd4K+kYF+qVAqIJMVDEx7fu4VFXrOj2UeMt
	hs+M/gXmYgMizi3sq+TNck+2Q5WQN8JRykAT3T4O/TJheTalb5vk87Nm0wgoKMgODcO0V3xwSQnff
	MbERPo6x3rMaCQsi8dlOhLkih6o4NgoLyzV/9E2DvIZVisEEHaaCEqeR1hPf1CDp+S6IVbllozBsd
	ZgLkRlhIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwqv-0002we-2J; Tue, 22 Jan 2019 14:16:33 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwqr-0002wE-N8
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:16:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4BC0EBD;
 Tue, 22 Jan 2019 06:16:28 -0800 (PST)
Received: from [10.37.10.44] (unknown [10.37.10.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FB853F614;
 Tue, 22 Jan 2019 06:16:27 -0800 (PST)
Subject: Re: [PATCH 2/4] KVM: arm/arm64: re-create event when setting counter
 value
To: andrew.murray@arm.com, christoffer.dall@arm.com, marc.zyngier@arm.com
References: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
 <1548154197-5470-3-git-send-email-andrew.murray@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <46fc9476-cff2-fd93-f5bb-237e26a2adc6@arm.com>
Date: Tue, 22 Jan 2019 14:18:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1548154197-5470-3-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_061629_768967_21C3599B 
X-CRM114-Status: GOOD (  26.34  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew

On 01/22/2019 10:49 AM, Andrew Murray wrote:
> The perf event sample_period is currently set based upon the current
> counter value, when PMXEVTYPER is written to and the perf event is created.
> However the user may choose to write the type before the counter value in
> which case sample_period will be set incorrectly. Let's instead decouple
> event creation from PMXEVTYPER and (re)create the event in either
> suitation.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

The approach looks fine to me. However this patch seems to introduce a
memory leak, see below, which you may be addressing in a later patch in 
the series. But this will affect bisecting issues.

> ---
>   virt/kvm/arm/pmu.c | 39 ++++++++++++++++++++++++++++++---------
>   1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 531d27f..4464899 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -24,6 +24,8 @@
>   #include <kvm/arm_pmu.h>
>   #include <kvm/arm_vgic.h>
>   
> +static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
> +				      u64 select_idx);

Could we just pass the counter index (i.e, select_idx) after updating
the event_type/counter value in the respective functions.

nit: If we decide not to do that, please rename "data" to something more
obvious, event_type.

>   /**
>    * kvm_pmu_get_counter_value - get PMU counter value
>    * @vcpu: The vcpu pointer
> @@ -57,11 +59,18 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>    */
>   void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
>   {
> -	u64 reg;
> +	u64 reg, data;

nit: Same here, data is too generic.

>   
>   	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
>   	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
>   	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
> +
> +	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> +	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
> +	data = __vcpu_sys_reg(vcpu, reg + select_idx);
> +
> +	/* Recreate the perf event to reflect the updated sample_period */
> +	kvm_pmu_create_perf_event(vcpu, data, select_idx);
>   }
>   
>   /**
> @@ -380,17 +389,13 @@ static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
>   }
>   
>   /**
> - * kvm_pmu_set_counter_event_type - set selected counter to monitor some event
> + * kvm_pmu_create_perf_event - create a perf event for a counter
>    * @vcpu: The vcpu pointer
> - * @data: The data guest writes to PMXEVTYPER_EL0
> + * @data: Type of event as per PMXEVTYPER_EL0 format
>    * @select_idx: The number of selected counter
> - *
> - * When OS accesses PMXEVTYPER_EL0, that means it wants to set a PMC to count an
> - * event with given hardware event number. Here we call perf_event API to
> - * emulate this action and create a kernel perf event for it.
>    */
> -void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
> -				    u64 select_idx)
> +static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
> +				      u64 select_idx)
>   {
>   	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>   	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> @@ -433,6 +438,22 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
>   	pmc->perf_event = event;

We should release the existing perf_event to prevent a memory leak and
also a corruption in the data via the overflow handler for the existing
event. Am I missing something here ?

>   }
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
> +	kvm_pmu_create_perf_event(vcpu, data, select_idx);
> +}
> +
>   bool kvm_arm_support_pmu_v3(void)
>   {
>   	/*
> 


Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
