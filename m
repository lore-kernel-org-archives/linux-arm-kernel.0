Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF51C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:18:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF9420879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oMaUxno6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF9420879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bC/aAvJcbmNEofXPBfrNjfVmWriBzviQkNVQnPM0zpU=; b=oMaUxno620R+xsntw6pS3K0nB
	atQZpBkd74bsyr452thuTr+WI7kmOfIqz7TQ+gKJe0Om3NO6DnU8/xoEwT7d+xxZyD1mpJ5kmf0OV
	bEqKbvmVJ/HhNQFsJj8Dfxws+w4KZd26Ir2tXqlf4uW2Q/gYH1F+NbKZpflRnTtOrlS3AlFxqvolX
	PWx6l6FjF5kWrtfwQi6VZVZykWd9MHcSRzAW/U9hYKRBOAZkJ/uJYHjZyXMzbuCA8gDSo4aGERbDP
	dYxSeuHXHayyc20wx9+q4hyzC00RAGHgbt613Rww6Jjf44e3gLNDiEJKpiFVn6z4VrR5pvglZD48a
	15OWGaJaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXTgy-0007B2-0D; Thu, 13 Dec 2018 16:18:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXTgv-00078t-C9
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:18:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5C6280D;
 Thu, 13 Dec 2018 08:18:12 -0800 (PST)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0E533F614;
 Thu, 13 Dec 2018 08:18:11 -0800 (PST)
Subject: Re: [PATCH 1/6] arm64: kpti: move check for non-vulnerable CPUs to a
 function
To: Julien Thierry <julien.thierry@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-2-jeremy.linton@arm.com>
 <1c6081ca-8335-759f-3f49-f8fa60b2fb90@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <672f0f2f-5ebc-ea3d-d3c0-4a2dd253ae09@arm.com>
Date: Wed, 12 Dec 2018 08:36:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1c6081ca-8335-759f-3f49-f8fa60b2fb90@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_081825_419158_DF1D035A 
X-CRM114-Status: GOOD (  19.55  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Julien,

Thanks for looking at this,

On 12/13/2018 03:13 AM, Julien Thierry wrote:
> Hi,
> 
> On 06/12/2018 23:44, Jeremy Linton wrote:
>> From: Mian Yousaf Kaukab <ykaukab@suse.de>
>>
>> Add is_meltdown_safe() which is a whitelist of known safe cores.
>>
>> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
>> [Moved location of function]
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/cpufeature.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index aec5ecb85737..242898395f68 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -908,8 +908,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>>   #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>   static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>>   
>> -static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>> -				int scope)
>> +static bool is_cpu_meltdown_safe(void)
>>   {
>>   	/* List of CPUs that are not vulnerable and don't need KPTI */
>>   	static const struct midr_range kpti_safe_list[] = {
>> @@ -917,6 +916,16 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>>   		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
>>   		{ /* sentinel */ }
>>   	};
>> +	/* Don't force KPTI for CPUs that are not vulnerable */
> 
> This is really a nit, but that comment would make more sense where
> is_cpu_meltdown_safe() is called since unmap_kernel_at_el0 is the one
> deciding whether to apply KPTI, is_cpu_meltdown_safe() just states
> whether the core is safe of not.

That is a good point, thanks.


> 
> Otherwise:
> 
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> 
> Cheers,
> 
> Julien
> 
>> +	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>> +				int scope)
>> +{
>>   	char const *str = "command line option";
>>   
>>   	/*
>> @@ -940,8 +949,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>>   	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>>   		return true;
>>   
>> -	/* Don't force KPTI for CPUs that are not vulnerable */
>> -	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
>> +	if (is_cpu_meltdown_safe())
>>   		return false;
>>   
>>   	/* Defer to CPU feature registers */
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
