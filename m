Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23777C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:11:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90D920856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GBdrXh93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90D920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5/N8aaRClBuKyO3lE3NU8hPfIDf/yA+2jZYRt+xAGFM=; b=GBdrXh93KBvkOBAQP0xRoPNFt
	piyK85PVMGmnQ/3zOsMzYrQ8HGMn39FPVnYxrkn8dpkk+fK2UMCjErjRTV52s90ihAivuu1xRUspF
	c71u4qAtM5gFHa5wF4ps0FO9UVD8dzaAzxhLVrFP3I9x1vVQWCPTXqxB8hEReOD/VBC/I5SOXyFVe
	sBvM68YYhHjzO96Re9bXvDRL5gpeGjBkFiHc5tb4uYXftim84VCZ6lnWZ4LFni8TXD20kl2AF+SzK
	HPrppFrR5sdBZsKx81x9PpeaORp5sBQwtiX9RkRwFRg45dLy4DZHe25cmE9fmiig2Q6CrSdqzeoy9
	DEpKl1OIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRJ5-0007GQ-C6; Tue, 29 Jan 2019 11:11:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRIk-00072a-Hx
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 11:11:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB3D3A78;
 Tue, 29 Jan 2019 03:11:32 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7AD23F7B4;
 Tue, 29 Jan 2019 03:11:31 -0800 (PST)
Subject: Re: [PATCH 3/4] KVM: arm/arm64: lazily create perf events on enable
To: andrew.murray@arm.com
References: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
 <1548154197-5470-4-git-send-email-andrew.murray@arm.com>
 <82bb5635-0bca-8326-03e1-084792dd939d@arm.com>
 <20190128142838.GB16627@e119886-lin.cambridge.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <51e6a06a-f6f0-866b-4eca-183e2f42cad8@arm.com>
Date: Tue, 29 Jan 2019 11:11:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128142838.GB16627@e119886-lin.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_031136_222588_2BA049A2 
X-CRM114-Status: GOOD (  26.03  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28/01/2019 14:28, Andrew Murray wrote:
> On Tue, Jan 22, 2019 at 10:12:22PM +0000, Suzuki K Poulose wrote:
>> Hi Andrew,
>>
>> On 01/22/2019 10:49 AM, Andrew Murray wrote:
>>> To prevent re-creating perf events everytime the counter registers
>>> are changed, let's instead lazily create the event when the event
>>> is first enabled and destroy it when it changes.
>>>
>>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>>
>>
>>> ---
>>>    virt/kvm/arm/pmu.c | 114 ++++++++++++++++++++++++++++++++++++-----------------
>>>    1 file changed, 78 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>>> index 4464899..1921ca9 100644
>>> --- a/virt/kvm/arm/pmu.c
>>> +++ b/virt/kvm/arm/pmu.c
>>> @@ -24,8 +24,11 @@
>>>    #include <kvm/arm_pmu.h>
>>>    #include <kvm/arm_vgic.h>
>>> -static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
>>> -				      u64 select_idx);
>>> +static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu, u64 pair);
>>
>> I find the approach good. However the function names are a bit odd and
>> it makes the code read a bit difficult.
> 
> Thanks - the odd naming probably came about as I started with a patch that
> added chained PMU support and worked backward to split it into smaller patches
> that each made individual sense. The _single suffix was the counterpart of
> _pair.
> 
>>
>> I think we could :
>>
>> 1) Rename the existing
>>   kvm_pmu_{enable/disable}_counter => kvm_pmu_{enable/disable}_[mask or
>> counters ]
>> as they operate on a set of counters (as a mask) instead of a single
>> counter.
>> And then you may be able to drop "_single" from
>> kvm_pmu_{enable/disable}_counter"_single() functions below, which makes
>> better sense for what they do.
> 
> Thanks for this suggestion. I like this.
> 
>>
>>> +static void kvm_pmu_counter_create_enabled_perf_event(struct kvm_vcpu *vcpu,
>>> +						      u64 select_idx);
>>
>> Could we simply keep kvm_pmu_counter_create_event() and add a comment above
>> the function explaining that the events are enabled as they are
>> created lazily ?
> 
> OK.
> 



>>> + * kvm_pmu_reenable_enabled_single - reenable a counter if it should be enabled
>>> + * @vcpu: The vcpu pointer
>>> + * @select_idx: The counter index
>>> + */
>>> +static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu,
>>> +					    u64 select_idx)
>>> +{
>>> +	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
>>> +	u64 set = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
>>> +
>>> +	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
>>> +		return;
>>> +
>>> +	if (set & BIT(select_idx))
>>> +		kvm_pmu_enable_counter_single(vcpu, select_idx);
>>
>> Could we not reuse kvm_pmu_enable_counter() here :
>> 	i.e,
>> static inline void kvm_pmu_reenable_counter(struct kvm_vcpu *vcpu, u64
>> 						select_idx)
>> {
>> 	kvm_pmu_enable_counter(vcpu, BIT(select_idx));
>> }
>>
> 
> Not quite - when we call kvm_pmu_reenable_enabled_single the individual
> counter may or may not be enabled. We only want to recreate the perf event
> if it was previously enabled.
> 
> But we can do better, e.g.
> 
> static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu,
>                                              u64 select_idx)

nit: could we use the name kvm_pmu_reenable_counter() ?

> {
>          u64 set = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> 
>          if (set & BIT(select_idx))
>                  kvm_pmu_enable_counter_mask(vcpu, BIT(select_idx));
> }

Yep, thats correct. Alternatively, you could move the CNTENSET check
into the kvm_pmu_enable_counter_mask().

Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
