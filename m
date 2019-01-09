Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:04:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEE9206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pr3m6Fjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEE9206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Zwn/ZX5NRzjQVV9cyFa7aToGVFc+DeMIPpNIJrwtkg=; b=Pr3m6Fjm0Hr1w+
	vnSuJzfrVpmV3lv1Q+T44KO21OFfkf+VGk4JVgdAL9NKztbQ+ShLXWHkn/LV2YRpD1kgvodpkSk3s
	JRAMjr9JnQ+9hvF2xr/KdoG7DfThay6wgff7B2DIPCZsOObJYiAX0B+ToND7yZHasC/MEQm1dxPrB
	bfAVW9u4pqy6pfJ+FWDveUl2o8KKoSU5SUrSVnQdoa0XnmZiDfRRxzm1WwbuNWYnyRjL6e5hT1C8H
	XjdGxIPRJWu4ZT5abS2KM+0QA1qzLkaJVkWerIPolE/R41KoI9tl3bFGW+qXTe9IWln2OLMCj12BI
	E6tTAIBYir0iraiG/kIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghGKw-00015s-OG; Wed, 09 Jan 2019 16:04:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghGKu-00015X-8M
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 16:04:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 605E7A78;
 Wed,  9 Jan 2019 08:04:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E76373F5AF;
 Wed,  9 Jan 2019 08:04:06 -0800 (PST)
Date: Wed, 9 Jan 2019 16:04:05 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 2/3] arm64: KVM: Allow for direct call of HYP functions
 when using VHE
Message-ID: <20190109160404.GI56789@e119886-lin.cambridge.arm.com>
References: <20190109135435.178664-1-marc.zyngier@arm.com>
 <20190109135435.178664-3-marc.zyngier@arm.com>
 <20190109142407.GH56789@e119886-lin.cambridge.arm.com>
 <a4f68a4c-5e5c-a60e-2f24-712028689422@arm.com>
 <e09db09d-e781-00d7-5247-525969413e44@arm.com>
 <c64d0652-3a29-4393-86d5-2e453e218d22@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c64d0652-3a29-4393-86d5-2e453e218d22@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_080408_308244_DA8B1617 
X-CRM114-Status: GOOD (  25.85  )
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
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Julien Thierry <julien.thierry@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 04:01:56PM +0000, Marc Zyngier wrote:
> On 09/01/2019 14:51, Julien Thierry wrote:
> > 
> > 
> > On 09/01/2019 14:45, Marc Zyngier wrote:
> >> Hi Andrew,
> >>
> >> On 09/01/2019 14:24, Andrew Murray wrote:
> >>> On Wed, Jan 09, 2019 at 01:54:34PM +0000, Marc Zyngier wrote:
> >>>> When running VHE, there is no need to jump via some stub to perform
> >>>> a "HYP" function call, as there is a single address space.
> >>>>
> >>>> Let's thus change kvm_call_hyp() and co to perform a direct call
> >>>> in this case. Although this results in a bit of code expansion,
> >>>> it allows the compiler to check for type compatibility, something
> >>>> that we are missing so far.
> >>>>
> >>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >>>> ---
> >>>>  arch/arm64/include/asm/kvm_host.h | 32 +++++++++++++++++++++++++++++--
> >>>>  1 file changed, 30 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> >>>> index e54cb7c88a4e..df32edbadd69 100644
> >>>> --- a/arch/arm64/include/asm/kvm_host.h
> >>>> +++ b/arch/arm64/include/asm/kvm_host.h
> >>>> @@ -370,8 +370,36 @@ void kvm_arm_halt_guest(struct kvm *kvm);
> >>>>  void kvm_arm_resume_guest(struct kvm *kvm);
> >>>>  
> >>>>  u64 __kvm_call_hyp(void *hypfn, ...);
> >>>> -#define kvm_call_hyp(f, ...) __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__)
> >>>> -#define kvm_call_hyp_ret(f, ...) kvm_call_hyp(f, ##__VA_ARGS__)
> >>>> +
> >>>> +/*
> >>>> + * The couple of isb() below are there to guarantee the same behaviour
> >>>> + * on VHE as on !VHE, where the eret to EL1 acts as a context
> >>>> + * synchronization event.
> >>>> + */
> >>>> +#define kvm_call_hyp(f, ...)						\
> >>>> +	do {								\
> >>>> +		if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN)) {	\
> >>>> +			f(__VA_ARGS__);					\
> >>>> +			isb();						\
> >>>> +		} else {						\
> >>>> +			__kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__); \
> >>>> +		}							\
> >>>> +	} while(0)
> >>>> +
> >>>> +#define kvm_call_hyp_ret(f, ...)					\
> >>>> +	({								\
> >>>> +		u64 ret;						\
> >>>> +									\
> >>>> +		if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN)) {	\
> >>>> +			ret = f(__VA_ARGS__);				\
> >>>
> >>> __kvm_get_mdcr_el2 and __kvm_vcpu_run_nvhe don't return u64 type, they
> >>> return a smaller type. I guess any issues would be picked up when compiling,
> >>> but should the name of the macro be clearer as to the assumptions it makes?
> >>> Or perhaps take an argument which is the type of ret?
> >>
> >> kvm_call_hyp has always returned a u64, so no semantic has changed here.

Ah I missed that!

> >>
> >> Otherwise, your suggestion of specifying a return type is interesting,
> >> but it also gives the programmer another chance to shoot itself in the
> >> foot by not providing the return type corresponding to the function that
> >> is called.
> >>
> >> Unless we can extract the return type by pure magic, I'm not sure we
> >> gain much.
> >>
> > 
> > Would the following work?
> > 
> > 	typeof(f(__VA_ARGS__)) ret;
> > 
> > If typeof works anything like sizeof, I'd expect it would evaluate stuff
> > passed as argument and we'd have the return type of the function.
> And it actually works! Thanks for the awful tip! ;-)

Awesome.

Thanks,

Andrew Murray

> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
