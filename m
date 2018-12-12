Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2657C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:39:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D49F208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rrh/ITuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D49F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=54QPgTY3qPHeAdc9yrDVatgUvKxklEmeH1G70kc20l0=; b=Rrh/ITuwQjJ3N3dCAiKxrDf0O
	MevxNXXKTviFA44Sq9OltO6dud+VapLGob88JQcMyYykQQB1GWWW9HHFbrqg8wRuvXfPiHSoIgWq4
	MA27y3j1VqfH5QTexIw12QEtX7UhTeh2kbshSBSoeKjm3gFbH8EGZ5QLokJB3FEMFwd5WbT1CEiNw
	MwNeqmAX9lLJIcEUUlZFw6Gzd4fsliED3WM2Ru3GvJzLLgbu9RU9GHtc+v91kK7JVX2ZxNp3/Ly8z
	aRTY49har387rX+n3PBLjRdfFdPmFVBqtFBLqeMKbQ+Gxe+vSiyToVe5YlSKVHvLwZItzjz7IX+pp
	5hzEIxOZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8Ts-0004Ab-RE; Wed, 12 Dec 2018 17:39:32 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8Tp-0004AD-5m
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:39:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71C2E80D;
 Wed, 12 Dec 2018 09:39:17 -0800 (PST)
Received: from [10.37.8.254] (unknown [10.37.8.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F94F3F575;
 Wed, 12 Dec 2018 09:39:15 -0800 (PST)
Subject: Re: [PATCH v2 2/2] arm64: uaccess: Implement unsafe accessors
To: Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
 <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
 <20181206182551.GB37411@arrakis.emea.arm.com>
 <6424e0f6-7755-c19a-5bc4-a70be5839644@arm.com>
 <20181210145931.GE4048@arrakis.emea.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3e9a5867-c33a-7e6e-90f2-723488de094d@arm.com>
Date: Wed, 12 Dec 2018 17:40:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181210145931.GE4048@arrakis.emea.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_093929_220450_536DBB6B 
X-CRM114-Status: GOOD (  19.42  )
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
Cc: peterz@infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, james.morse@arm.com, hpa@zytor.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/10/2018 02:59 PM, Catalin Marinas wrote:
> On Fri, Dec 07, 2018 at 08:38:11AM +0000, Julien Thierry wrote:
>>
>>
>> On 12/06/2018 06:25 PM, Catalin Marinas wrote:
>>> On Mon, Dec 03, 2018 at 01:55:18PM +0000, Julien Thierry wrote:
>>>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>>>> index 07c3408..cabfcae 100644
>>>> --- a/arch/arm64/include/asm/uaccess.h
>>>> +++ b/arch/arm64/include/asm/uaccess.h
>>>> @@ -233,6 +233,23 @@ static inline void uaccess_enable_not_uao(void)
>>>>    	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
>>>>    }
>>>> +#define unsafe_user_region_active	uaccess_region_active
>>>> +static inline bool uaccess_region_active(void)
>>>> +{
>>>> +	if (system_uses_ttbr0_pan()) {
>>>> +		u64 ttbr;
>>>> +
>>>> +		ttbr = read_sysreg(ttbr1_el1);
>>>> +		return ttbr & TTBR_ASID_MASK;
>>>
>>> Nitpick: could write this in 1-2 lines.
>>
>> True, I can do that in 1 line.
>>
>>>> +	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO)) {
>>>> +		return (read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN) ?
>>>> +				false :
>>>> +				!read_sysreg_s(SYS_PSTATE_PAN);
>>>> +	}
>>>
>>> ARM64_ALT_PAN_NOT_UAO implies ARM64_HAS_PAN which implies SCTLR_EL1.SPAN
>>> is 0 at run-time. Is this to cope with the case of being called prior to
>>> cpu_enable_pan()?
>>>
>>
>> Yes, the issue I can into is that for cpufeatures, .cpu_enable() callbacks
>> are called inside stop_machine() which obviously might_sleep and so attempts
>> to check whether user_access is on. But for features that get enabled before
>> PAN, the PAN bit will be set.
> 
> OK, so the PSTATE.PAN bit only makes sense when SCTLR_EL1.SPAN is 0, IOW
> the PAN hardware feature has been enabled. Maybe you could write it
> (together with some comment):
> 
> 	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO) &&
> 		 !(read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN)) {
> 		 /* only if PAN is present and enabled */
> 		return !read_sysreg_s(SYS_PSTATE_PAN)
> 	}
> 
> On the cpufeature.c side of things, it seems that we enable the
> static_branch before calling the cpu_enable. I wonder whether changing
> the order here would help with avoid the SCTLR_EL1 read (not sure what
> else it would break; cc'ing Suzuki).
> 


I doubt if we would gain anything by moving it around. 
cpus_have_const_cap() would fall back to test_bit() until we mark that
the static_branches have been updated explicitly, which happens after
we have issued the stop_machine(). So, even if we move the static branch
per capability, we don't gain much.

Is that what you were looking for ?

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
