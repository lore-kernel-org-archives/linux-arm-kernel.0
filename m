Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA2FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:00:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D145221A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VMD3Ys8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D145221A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UedHVeP/wgUivqvxk7O7XCUFKJqc+XPeU7UfkQpJopE=; b=VMD3Ys8SLf+7ws0wVDlKql2Nh
	GdEY5CK51aoM49Atoz/f4gUH9vX2FZaGiHblNPDm4+iIIcpNoGE9qc7NqZKidDY25rE0ZHK+8JdkT
	ogJzWEXRRk0k41gJqqgflP0HlQLpXI4cFFEuUrxblj4Ji2x1fjDp1WU+XPB9UhppkDmboAqcKD2/i
	PN0kjQmfHIKXyselbkWeisbsaWh7IEpR3f/w4UpXCG21Iot9GziskWGp+t9HO+SiwMIoRtPipMds2
	pPwmyrwH6g+WC+Z8CzN7eOrzECBL6xfL5G5dVTXNwvYgrAksHXbpqXZ39ykYkgAROrj3+pfcKD4hP
	l8t/ZEC3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guUg6-0007Mm-Sx; Fri, 15 Feb 2019 04:00:42 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guUg2-0007MN-1m
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 04:00:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47382A78;
 Thu, 14 Feb 2019 20:00:36 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72D183F557;
 Thu, 14 Feb 2019 20:00:33 -0800 (PST)
Subject: Re: [PATCH v5 3/5] arm64/kvm: context-switch ptrauth register
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 James Morse <james.morse@arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-4-git-send-email-amit.kachhap@arm.com>
 <d862316b-5b2e-8187-04e0-c0be350c1624@arm.com>
 <9d4b5ac7-9d89-b6a0-cfa2-4eab81ff157a@arm.com>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <7a7f0b78-19b6-3953-fdce-4d173b2d69b9@arm.com>
Date: Fri, 15 Feb 2019 09:30:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9d4b5ac7-9d89-b6a0-cfa2-4eab81ff157a@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_200038_103660_C1F7DEF0 
X-CRM114-Status: GOOD (  30.71  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2/13/19 11:05 PM, Kristina Martsenko wrote:
> On 31/01/2019 16:25, James Morse wrote:
>> Hi Amit,
>>
>> On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
>>> When pointer authentication is supported, a guest may wish to use it.
>>> This patch adds the necessary KVM infrastructure for this to work, with
>>> a semi-lazy context switch of the pointer auth state.
> 
> [...]
> 
>>> +void __no_ptrauth __hyp_text __ptrauth_switch_to_guest(struct kvm_vcpu *vcpu,
>>> +					  struct kvm_cpu_context *host_ctxt,
>>> +					  struct kvm_cpu_context *guest_ctxt)
>>> +{
>>> +	if (!__ptrauth_is_enabled(vcpu))
>>> +		return;
>>> +
>>
>>> +	ptrauth_keys_store((struct ptrauth_keys *) &host_ctxt->sys_regs[APIAKEYLO_EL1]);
>>
>> We can't cast part of an array to a structure like this. What happens if the
>> compiler inserts padding in struct-ptrauth_keys, or the struct randomization
>> thing gets hold of it: https://lwn.net/Articles/722293/
>>
>> If we want to use the helpers that take a struct-ptrauth_keys, we need to keep
>> the keys in a struct-ptrauth_keys. To do this we'd need to provide accessors so
>> that GET_ONE_REG() of APIAKEYLO_EL1 comes from the struct-ptrauth_keys, instead
>> of the sys_reg array.
> 
> If I've understood correctly, the idea is to have a struct ptrauth_keys
> in struct kvm_vcpu_arch, instead of having the keys in the
> kvm_cpu_context->sys_regs array. This is to avoid having similar code in
> __ptrauth_key_install/ptrauth_keys_switch and
> __ptrauth_restore_key/__ptrauth_restore_state, and so that future
> patches (that add pointer auth in the kernel) would only need to update
> one place instead of two.
Yes your observation is correct.
> 
> But it also means we'll have to special case pointer auth in
> kvm_arm_sys_reg_set_reg/kvm_arm_sys_reg_get_reg and kvm_vcpu_arch. Is it
> worth it? I'd prefer to keep the slight code duplication but avoid the
> special casing.
In my local implementation I implemented above by separating ptrauth 
registers from sys registers but if I use the new way suggested by Dave
[1] then those things are not possible as reg ID is used for matching 
entries.

So I will stick to the single sys_reg list for next iteration using [1].

[1]: 
https://lore.kernel.org/linux-arm-kernel/1547757219-19439-11-git-send-email-Dave.Martin@arm.com/
> 
>>
>>
>> Wouldn't the host keys be available somewhere else? (they must get transfer to
>> secondary CPUs somehow). Can we skip the save step when switching from the host?
>>
>>
>>> +	ptrauth_keys_switch((struct ptrauth_keys *) &guest_ctxt->sys_regs[APIAKEYLO_EL1]);
>>> +}
>>
> 
> [...]
> 
>>
>>> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>>> index 03b36f1..301d332 100644
>>> --- a/arch/arm64/kvm/hyp/switch.c
>>> +++ b/arch/arm64/kvm/hyp/switch.c
>>> @@ -483,6 +483,8 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>>>   	sysreg_restore_guest_state_vhe(guest_ctxt);
>>>   	__debug_switch_to_guest(vcpu);
>>>   
>>> +	__ptrauth_switch_to_guest(vcpu, host_ctxt, guest_ctxt);
>>> +
>>>   	__set_guest_arch_workaround_state(vcpu);
>>>   
>>>   	do {
>>> @@ -494,6 +496,8 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>>>   
>>>   	__set_host_arch_workaround_state(vcpu);
>>>   
>>> +	__ptrauth_switch_to_host(vcpu, host_ctxt, guest_ctxt);
>>> +
>>>   	sysreg_save_guest_state_vhe(guest_ctxt);
>>>   
>>>   	__deactivate_traps(vcpu);
>>
>> ...This makes me nervous...
>>
>> __guest_enter() is a function that (might) change the keys, then we change them
>> again here. We can't have any signed return address between these two points. I
>> don't trust the compiler not to generate any.
>>
>> ~
>>
>> I had a chat with some friendly compiler folk... because there are two identical
>> sequences in kvm_vcpu_run_vhe() and __kvm_vcpu_run_nvhe(), the compiler could
>> move the common code to a function it then calls. Apparently this is called
>> 'function outlining'.
>>
>> If the compiler does this, and the guest changes the keys, I think we would fail
>> the return address check.
>>
>> Painting the whole thing with no_prauth would solve this, but this code then
>> becomes a target.
>> Because the compiler can't anticipate the keys changing, we ought to treat them
>> the same way we do the callee saved registers, stack-pointer etc, and
>> save/restore them in the __guest_enter() assembly code.
>>
>> (we can still keep the save/restore in C, but call it from assembly so we know
>> nothing new is going on the stack).
> 
> I agree that this should be called from assembly if we were building the
> kernel with pointer auth. But as we are not doing that yet in this
> series, can't we keep the calls in kvm_vcpu_run_vhe for now?
Well if we keep them in kvm_vcpu_run_vhe then there is not much issue 
also in calling those C functions from assembly guest_enter/guest_exit. 
It works fine in my local implementation. This will also save code 
churning again when kernel ptrauth support is added. The only extra 
change required to be done is to assign attribute _noptrauth to those 
functions. I will add these comments properly in function description.
> 
> In general I would prefer if the keys were switched in
> kvm_arch_vcpu_load/put for now, since the keys are currently only used
> in userspace. Once in-kernel pointer auth support comes along, it can
> move the switch into kvm_vcpu_run_vhe or __guest_enter/__guest_exit as
> required.
Yes it is possible but then there are other benefits in doing this way. 
It will be always ptrauth registers save/restore if inside 
kvm_arch_vcpu_load/put even if userspace does not use it. The current 
way does save/restore dynamically when userspace uses ptrauth 
instructions by trapping first time.
Some discussion happened on it earlier between Mark and Cristopher and 
they seem to agree on it [2].

[2]: https://lore.kernel.org/lkml/20180409125818.GE10904@cbox/

Thanks,
Amit D
> 
> Thanks,
> Kristina
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
