Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FDDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:56:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F37420844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u4r16GbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F37420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kQuzviKNOncwzhtsfvmV4rk2NK1iaXuX/HjZoEnMN5w=; b=u4r16GbXCHsCLAlogphFzBgcG
	kxhy5hewdb0o2wL6Fg7v0vkY4db2l5J9CrOsMXaBPtCQScXTfcibkB2NbfjOmywUlHJoRwHeI7n34
	xBnJjVDG1qMYb1VVKq4shitpcATI1yrXp0Q7WEBKXMFiOGwRI79jSocZswybtXFX6tK/RX+5Odagh
	wUNnsQx4gyqyPyBflVDRA47kN0PkeS1KNh95A6d2Qpx5zYIznDnfGeFnLUXRsn2cfOZnf0IrbwLqB
	zrZwIt9wYGnpT6MIESC7Ynkl/l8dspFmZ4EBRTHYMUWyGOEKkLGldrzDiGnNHP+5RkAPj11ix1tKm
	Px4mDzpzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goR3p-0006wc-HA; Tue, 29 Jan 2019 10:56:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goR3m-0006wD-MO
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 10:56:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3787A78;
 Tue, 29 Jan 2019 02:56:05 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 620CB3F589;
 Tue, 29 Jan 2019 02:56:04 -0800 (PST)
Subject: Re: [PATCH 2/4] KVM: arm/arm64: re-create event when setting counter
 value
To: andrew.murray@arm.com
References: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
 <1548154197-5470-3-git-send-email-andrew.murray@arm.com>
 <46fc9476-cff2-fd93-f5bb-237e26a2adc6@arm.com>
 <20190128114714.GA16627@e119886-lin.cambridge.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4d05c50f-49c6-81fd-b41c-bf9460a5d9d6@arm.com>
Date: Tue, 29 Jan 2019 10:56:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128114714.GA16627@e119886-lin.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_025606_734224_6F75397F 
X-CRM114-Status: GOOD (  23.74  )
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

Hi Andrew,

On 28/01/2019 11:47, Andrew Murray wrote:
> On Tue, Jan 22, 2019 at 02:18:17PM +0000, Suzuki K Poulose wrote:
>> Hi Andrew
>>
>> On 01/22/2019 10:49 AM, Andrew Murray wrote:
>>> The perf event sample_period is currently set based upon the current
>>> counter value, when PMXEVTYPER is written to and the perf event is created.
>>> However the user may choose to write the type before the counter value in
>>> which case sample_period will be set incorrectly. Let's instead decouple
>>> event creation from PMXEVTYPER and (re)create the event in either
>>> suitation.
>>>
>>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>>
>> The approach looks fine to me. However this patch seems to introduce a
>> memory leak, see below, which you may be addressing in a later patch in the
>> series. But this will affect bisecting issues.
> 
> See below, I don't think this is true.

You're right. Sorry for the noise.

> 
>>
>>> ---
>>>    virt/kvm/arm/pmu.c | 39 ++++++++++++++++++++++++++++++---------
>>>    1 file changed, 30 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>>> index 531d27f..4464899 100644
>>> --- a/virt/kvm/arm/pmu.c
>>> +++ b/virt/kvm/arm/pmu.c
>>> @@ -24,6 +24,8 @@
>>>    #include <kvm/arm_pmu.h>
>>>    #include <kvm/arm_vgic.h>
>>> +static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
>>> +				      u64 select_idx);
>>
>> Could we just pass the counter index (i.e, select_idx) after updating
>> the event_type/counter value in the respective functions.
> 
> Unless I misunderstand we need the value of 'data' as it is used to
> populate the function local perf_event_attr structure.

Yes, we do program the "data" (which is the event code) in attr.config.
So, since this is now a helper routine, so the name "data" doesn't make any
sense.

> 
> However it is possible to instead read 'data' from __vcpu_sys_reg in
> kvm_pmu_create_perf_event instead of the call site. However
> kvm_pmu_set_counter_event_type would have to set the value of
> __vcpu_sys_reg from its data argument (as __vcpu_sys_reg normally gets
> set after kvm_pmu_set_counter_event_type returns). This is OK as we
> do this in the next patch in this series anyway - so perhaps I can
> bring that forward to this patch?

Yes, please.

Cheers
Suzuki



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
