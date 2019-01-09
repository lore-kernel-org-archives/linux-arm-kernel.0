Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1058C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:51:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFEB206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I0HlRPv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFEB206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hoymuo+mxsdZEbOnat66dKTmHKKo88wqpXannw9z4F0=; b=I0HlRPv1lP8gZL
	L9Jchyr7iPgbLzp9WwxUjplORWNxJeq0DMFZ8fhigjGf8Papr+U98iH4ZrI3PR82b3Fp/fIIMWMIy
	jj01kVGZKu7Lca0Pff3FmvwBpNKHvRxenO+XBwHqpyGQEJOV27AHi21p+dhN5NoSumd3deESSP+Ng
	udc3F+17c0OT1uV+7sDf90KOQfqOK2jEE7jYQjHQIjk6thivHmGtgOrocmv/iG9rF+t22TgdcffCk
	Zxmd9hCVLrFdUN1gnRuhmzamvoAFGl8lRCOXLgJTvSFRN1t8fBsuC97eBOSZDP4++IX6+Y4MzU2M5
	WXDA3ch4l9/i7QiCSZVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghFCH-0005ET-N1; Wed, 09 Jan 2019 14:51:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghFCE-0005Dr-En
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:51:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD73080D;
 Wed,  9 Jan 2019 06:51:05 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2D5D3F6CF;
 Wed,  9 Jan 2019 06:51:04 -0800 (PST)
Subject: Re: [PATCH 2/3] arm64: KVM: Allow for direct call of HYP functions
 when using VHE
To: Marc Zyngier <marc.zyngier@arm.com>, Andrew Murray <andrew.murray@arm.com>
References: <20190109135435.178664-1-marc.zyngier@arm.com>
 <20190109135435.178664-3-marc.zyngier@arm.com>
 <20190109142407.GH56789@e119886-lin.cambridge.arm.com>
 <a4f68a4c-5e5c-a60e-2f24-712028689422@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <e09db09d-e781-00d7-5247-525969413e44@arm.com>
Date: Wed, 9 Jan 2019 14:51:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a4f68a4c-5e5c-a60e-2f24-712028689422@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_065106_507474_7EAA3F5B 
X-CRM114-Status: GOOD (  21.51  )
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
 kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 09/01/2019 14:45, Marc Zyngier wrote:
> Hi Andrew,
> 
> On 09/01/2019 14:24, Andrew Murray wrote:
>> On Wed, Jan 09, 2019 at 01:54:34PM +0000, Marc Zyngier wrote:
>>> When running VHE, there is no need to jump via some stub to perform
>>> a "HYP" function call, as there is a single address space.
>>>
>>> Let's thus change kvm_call_hyp() and co to perform a direct call
>>> in this case. Although this results in a bit of code expansion,
>>> it allows the compiler to check for type compatibility, something
>>> that we are missing so far.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm64/include/asm/kvm_host.h | 32 +++++++++++++++++++++++++++++--
>>>  1 file changed, 30 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>> index e54cb7c88a4e..df32edbadd69 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -370,8 +370,36 @@ void kvm_arm_halt_guest(struct kvm *kvm);
>>>  void kvm_arm_resume_guest(struct kvm *kvm);
>>>  
>>>  u64 __kvm_call_hyp(void *hypfn, ...);
>>> -#define kvm_call_hyp(f, ...) __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__)
>>> -#define kvm_call_hyp_ret(f, ...) kvm_call_hyp(f, ##__VA_ARGS__)
>>> +
>>> +/*
>>> + * The couple of isb() below are there to guarantee the same behaviour
>>> + * on VHE as on !VHE, where the eret to EL1 acts as a context
>>> + * synchronization event.
>>> + */
>>> +#define kvm_call_hyp(f, ...)						\
>>> +	do {								\
>>> +		if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN)) {	\
>>> +			f(__VA_ARGS__);					\
>>> +			isb();						\
>>> +		} else {						\
>>> +			__kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__); \
>>> +		}							\
>>> +	} while(0)
>>> +
>>> +#define kvm_call_hyp_ret(f, ...)					\
>>> +	({								\
>>> +		u64 ret;						\
>>> +									\
>>> +		if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN)) {	\
>>> +			ret = f(__VA_ARGS__);				\
>>
>> __kvm_get_mdcr_el2 and __kvm_vcpu_run_nvhe don't return u64 type, they
>> return a smaller type. I guess any issues would be picked up when compiling,
>> but should the name of the macro be clearer as to the assumptions it makes?
>> Or perhaps take an argument which is the type of ret?
> 
> kvm_call_hyp has always returned a u64, so no semantic has changed here.
> 
> Otherwise, your suggestion of specifying a return type is interesting,
> but it also gives the programmer another chance to shoot itself in the
> foot by not providing the return type corresponding to the function that
> is called.
> 
> Unless we can extract the return type by pure magic, I'm not sure we
> gain much.
> 

Would the following work?

	typeof(f(__VA_ARGS__)) ret;

If typeof works anything like sizeof, I'd expect it would evaluate stuff
passed as argument and we'd have the return type of the function.

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
