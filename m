Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B12C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:38:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F6420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A2D5Jb88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F6420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TdWrqybS2r9MdRh4bXPOEJLMtTr7YV0CWFZm542qSi4=; b=A2D5Jb88q9nx8uda8PTCvXD8E
	k7Ymj9N9iQNdrWLB+SZIkFRvKLVF31GdEg2wvtlnJdi0G+OFxp1CBtKfxk2Rzj27bczsx4GN0E2zb
	TJNkg/SPdahf8IBsTU14LnrXXhBgqZwPSjFuNzJgWmwpbBZSJpj6blBB76gqanl4VUYAd+plGiDjU
	5WG2jCeWPhntxx8P2nt8qtLl7jNdzs2I8vyzYKASnAlaNYjuiAknTOzDDElTOF1p9ks3eRTVY+3DW
	ViU2meVK9XSwsbwc/MLAS6zTRYSOxHL/V7uCWgPRd+9da3yIRWD7V30oMh48BJvBoqNXBe3V4cG0U
	IS8sJDynw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVBeY-0002k1-19; Fri, 07 Dec 2018 08:38:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVBeV-0002iu-34
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 08:38:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 547861596;
 Fri,  7 Dec 2018 00:38:14 -0800 (PST)
Received: from [10.37.9.129] (unknown [10.37.9.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B24393F59C;
 Fri,  7 Dec 2018 00:38:12 -0800 (PST)
Subject: Re: [PATCH v2 2/2] arm64: uaccess: Implement unsafe accessors
To: Catalin Marinas <catalin.marinas@arm.com>
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
 <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
 <20181206182551.GB37411@arrakis.emea.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <6424e0f6-7755-c19a-5bc4-a70be5839644@arm.com>
Date: Fri, 7 Dec 2018 08:38:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181206182551.GB37411@arrakis.emea.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_003827_132300_9C9C7ED1 
X-CRM114-Status: GOOD (  18.12  )
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



On 12/06/2018 06:25 PM, Catalin Marinas wrote:
> On Mon, Dec 03, 2018 at 01:55:18PM +0000, Julien Thierry wrote:
>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>> index 07c3408..cabfcae 100644
>> --- a/arch/arm64/include/asm/uaccess.h
>> +++ b/arch/arm64/include/asm/uaccess.h
>> @@ -233,6 +233,23 @@ static inline void uaccess_enable_not_uao(void)
>>   	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
>>   }
>>   
>> +#define unsafe_user_region_active	uaccess_region_active
>> +static inline bool uaccess_region_active(void)
>> +{
>> +	if (system_uses_ttbr0_pan()) {
>> +		u64 ttbr;
>> +
>> +		ttbr = read_sysreg(ttbr1_el1);
>> +		return ttbr & TTBR_ASID_MASK;
> 
> Nitpick: could write this in 1-2 lines.
> 

True, I can do that in 1 line.

>> +	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO)) {
>> +		return (read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN) ?
>> +				false :
>> +				!read_sysreg_s(SYS_PSTATE_PAN);
>> +	}
> 
> ARM64_ALT_PAN_NOT_UAO implies ARM64_HAS_PAN which implies SCTLR_EL1.SPAN
> is 0 at run-time. Is this to cope with the case of being called prior to
> cpu_enable_pan()?
> 

Yes, the issue I can into is that for cpufeatures, .cpu_enable() 
callbacks are called inside stop_machine() which obviously might_sleep 
and so attempts to check whether user_access is on. But for features 
that get enabled before PAN, the PAN bit will be set.

Thanks,

Julien

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
