Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:08:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B067E2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G+fKmF8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B067E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aKg2zNsa5AHyml9apWFCTW+iO1/x2g8e4OteGOEbRFE=; b=G+fKmF8TEAB+bmX7m027PuOSO
	8wsGPYLhQKQHhG+BldPo0Rmi36nZFS6AzoRmfuAQatVZ6GeK/23vFB57s7RyL53g7A3pU0XBzIyWn
	6b2mgPfvqlZbG9n5fZMCgioFT7iG+Q2dW0RnCsV2fo6k8pyQurplhTmM8l0KnBwIDNpVMcgK5G6jp
	gl827Ly/MkpwO//0pXHdYids/B5adAeVhlvPJzPMzYex3dHeYYiTYWiqLR+Kh3TfX3qQJsf2xqO/U
	46jYgwCrS0t7RH9S8KZvjTomdq9WEo7IOkOQ7TycmYA6mZGhiwreEknCI1vhaT1H9oc7Y4wyMpGIs
	UvrJF+fNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGno-0005KI-QY; Fri, 07 Dec 2018 14:08:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGng-0005Jh-Rm
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:08:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20FE515AB;
 Fri,  7 Dec 2018 06:08:06 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD5833F5AF;
 Fri,  7 Dec 2018 06:08:03 -0800 (PST)
Subject: Re: [PATCH v5 2/4] arm64: KVM: add accessors to track guest/host only
 counters
To: Andrew Murray <andrew.murray@arm.com>
References: <1544023815-16958-1-git-send-email-andrew.murray@arm.com>
 <1544023815-16958-3-git-send-email-andrew.murray@arm.com>
 <97301473-69d0-9a0b-b957-5568a43a6551@arm.com>
 <fefadc01-05dd-f714-667e-71c3589083e7@arm.com>
 <20181206192108.GA51311@e119886-lin.cambridge.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <441d603e-eb30-821b-a59b-eec1bd6c8e22@arm.com>
Date: Fri, 7 Dec 2018 14:08:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206192108.GA51311@e119886-lin.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_060816_910589_6B731654 
X-CRM114-Status: GOOD (  16.73  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 06/12/2018 19:21, Andrew Murray wrote:
> On Thu, Dec 06, 2018 at 06:51:37PM +0000, Suzuki K Poulose wrote:
>>
>>
>> On 06/12/2018 17:21, Suzuki K Poulose wrote:
>>> Hi Andrew,
>>>
>>> On 05/12/2018 15:30, Andrew Murray wrote:
>>>> In order to effeciently enable/disable guest/host only perf counters
>>>> at guest entry/exit we add bitfields to kvm_cpu_context for guest and
>>>> host events as well as accessors for updating them.
>>>>
>>>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>>>> ---
>>>>     arch/arm64/include/asm/kvm_host.h | 24 ++++++++++++++++++++++++
>>>>     1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>>> index 1550192..800c87b 100644
>>>> --- a/arch/arm64/include/asm/kvm_host.h
>>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>>> @@ -203,6 +203,8 @@ struct kvm_cpu_context {
>>>>     	};
>>>>     	struct kvm_vcpu *__hyp_running_vcpu;
>>>> +	u32 events_host;
>>>> +	u32 events_guest;
>>>>     };
>>>>     typedef struct kvm_cpu_context kvm_cpu_context_t;
>>>> @@ -467,11 +469,33 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
>>>>     void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
>>>>     void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
>>>> +#define KVM_PMU_EVENTS_HOST	1
>>>> +#define KVM_PMU_EVENTS_GUEST	2
>>>> +
>>>>     #ifdef CONFIG_KVM /* Avoid conflicts with core headers if CONFIG_KVM=n */
>>>>     static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
>>>>     {
>>>>     	return kvm_arch_vcpu_run_map_fp(vcpu);
>>>>     }
>>>> +static inline void kvm_set_pmu_events(u32 set, int flags)
>>>> +{
>>>> +	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
>>>> +
>>>> +	if (flags & KVM_PMU_EVENTS_HOST)
>>>> +		ctx->events_host |= set;
>>>> +	if (flags & KVM_PMU_EVENTS_GUEST)
>>>> +		ctx->events_guest |= set;
>>>
>>> You seem to be passing a single flag at a time ever, in the next patch.
>>> Either we can batch the calls in the next patch, or make this a real number and
>>> not a flag. g.g, enum { HOST,  GUEST } or even a bool.
>>>
>>> I think the former sounds better.
>>
>> Having another look at patch-3, we can never club set() calls for host &
>> guest events, we should go for the latter.
> 
> Well we could always do this..
> 
>          u32 flags = 0;
>          if (!attr->exclude_host)
>                  flags |= KVM_PMU_EVENTS_HOST;
>          if (!attr->exclude_guest)
>                  flags |= KVM_PMU_EVENTS_GUEST;
> 
>          kvm_set_pmu_events(counter_bits, flags);

Yes, I think this should be fine.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
