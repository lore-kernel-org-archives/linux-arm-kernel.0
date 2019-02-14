Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECB4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:42:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1D421872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HVB4Qu86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1D421872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WaIrX5/663V21nnB8XhoBFXXqza9DgIdAg7SSiflios=; b=HVB4Qu86dlsxu9PSAk99jsW/c
	ZOhQ88e88mAhfsO7lUE0P3U1VWnkJJkNggaLQkmCcOJVnegAW6N2REDI2sW2TmK7lvZaDE9scX2Xu
	HVJTcDj1uGxXmySn7edm9J+3ibFrdjslDAvmOOdzOQwL6qowYM9kqydK+SoTCU6vQO3kLqoVxmMy0
	O9AXFdalOY552yb2uCAoYTwu0bAHjwE6v7RxeW87Am+cMnWkdURktZOUnrJPYiE3u97mHBh2BmcDb
	BI7jd1NeIEpEpGBvdAMOfXvUPwvHCM6t9IN0/DENV5TSHxoGKrvv/LqUdjRQjNZ9xeNDJhuq5pTdf
	2QuFQ9S5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guFPO-00059e-BA; Thu, 14 Feb 2019 11:42:26 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guFPL-00059E-FQ
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 11:42:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F3AD80D;
 Thu, 14 Feb 2019 03:42:23 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 753F33F675;
 Thu, 14 Feb 2019 03:42:21 -0800 (PST)
Subject: Re: [PATCH v2 5/5] KVM: arm/arm64: support chained PMU counters
To: julien.thierry@arm.com, andrew.murray@arm.com, christoffer.dall@arm.com,
 marc.zyngier@arm.com
References: <1549299218-44714-1-git-send-email-andrew.murray@arm.com>
 <1549299218-44714-6-git-send-email-andrew.murray@arm.com>
 <11a8c800-5c1d-08ce-9d85-402ca89727a3@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <236797c3-9f3a-91d4-c859-e8eb4d3eb3ee@arm.com>
Date: Thu, 14 Feb 2019 11:42:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <11a8c800-5c1d-08ce-9d85-402ca89727a3@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_034223_516915_CB712DA1 
X-CRM114-Status: GOOD (  21.34  )
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



On 05/02/2019 14:33, Julien Thierry wrote:
> Hi Andrew,
> 
> On 04/02/2019 16:53, Andrew Murray wrote:
>> Emulate chained PMU counters by creating a single 64 bit event counter
>> for a pair of chained KVM counters.
>>
>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>> ---
>>   include/kvm/arm_pmu.h |   1 +
>>   virt/kvm/arm/pmu.c    | 321 +++++++++++++++++++++++++++++++++++++++++---------
>>   2 files changed, 269 insertions(+), 53 deletions(-)
>>
>> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
>> index b73f31b..8e691ee 100644
>> --- a/include/kvm/arm_pmu.h
>> +++ b/include/kvm/arm_pmu.h
>> @@ -29,6 +29,7 @@ struct kvm_pmc {
>>   	u8 idx;	/* index into the pmu->pmc array */
>>   	struct perf_event *perf_event;
>>   	u64 bitmask;
>> +	u64 overflow_count;
>>   };
>>   
>>   struct kvm_pmu {
>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>> index a64aeb2..9318130 100644
>> --- a/virt/kvm/arm/pmu.c
>> +++ b/virt/kvm/arm/pmu.c
>> @@ -24,9 +24,25 @@
>>   #include <kvm/arm_pmu.h>
>>   #include <kvm/arm_vgic.h>
>>   
>> +#define ARMV8_PMUV3_PERFCTR_CHAIN 0x1E
> 
> I find it a bit awkward to have this redefined here.
> 
> Maybe we could define a helper in kvm_host.h:
> bool kvm_pmu_typer_is_chain(u64 typer);
> 
> That would always return false for arm32?

We don't support ARMv7 host, so that doesn't matter. But
it is a good idea to wrap it in a function here.

>>   		kvm_vcpu_kick(vcpu);
>> @@ -440,6 +632,10 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
>>   	    select_idx != ARMV8_PMU_CYCLE_IDX)
>>   		return;
>>   
>> +	/* Handled by even event */
>> +	if (eventsel == ARMV8_PMUV3_PERFCTR_CHAIN)
>> +		return;
>> +
>>   	memset(&attr, 0, sizeof(struct perf_event_attr));
>>   	attr.type = PERF_TYPE_RAW;
>>   	attr.size = sizeof(attr);
>> @@ -452,6 +648,9 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
>>   	attr.config = (select_idx == ARMV8_PMU_CYCLE_IDX) ?
>>   		ARMV8_PMUV3_PERFCTR_CPU_CYCLES : eventsel;
>>   
>> +	if (kvm_pmu_event_is_chained(vcpu, select_idx))
>> +		attr.config1 |= 0x1;
> 
> I'm not very familiar with the usage of perf attributes configs, but is
> there any chance we could name this flag? Even if only for the local
> file? Something like PERF_ATTR_CFG1_KVM_PMU_CHAINED (unless there is an
> existing naming convention for event attributes).

There is ARPMU_EVT_64BIT in "linux/perf/arm_pmu.h". But in general we don't
specify where the Bit goes in (i.e, CFG1 etc).

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
