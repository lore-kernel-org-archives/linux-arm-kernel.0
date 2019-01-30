Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DDDC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:47:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE970218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IGMZhaAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE970218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EaAJPh5FjWu/IfC9GEwkH/BXUJUAclP4r019Y9KNJT4=; b=IGMZhaAQ/cm5wE
	kHHcBGQZMAsHqpjHkdxFMvwF0f+bffq1bl9IMP98zjzrE983r0uYOCskYlbjEA753HwZd598pP1At
	nc3YFLTdJw29wSfxIIZ2QLE82dkCPyMAcCfyK5sCRfgCenpriolbYoySjB8j+gWmVpqInVS4d7j9p
	KGdj2fLYItBjkuimfBwLkKHBZHkPYyQpScPVAvCCkfvNbhaSjpaIZyPXMTdMpFrsMx3qmdd9vffkF
	7ZsaXO9diLw9GRqG7K4NwoPVJZTS/V9ynpq8w8D+whvxwu6kCYNwKKYy9nlD61l8E7Q6MKJ/O+i1/
	zLE+qSshP06p7QrhQXjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goqCp-0000hn-O8; Wed, 30 Jan 2019 13:47:07 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goqCl-0000hO-BG
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:47:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65B0DEBD;
 Wed, 30 Jan 2019 05:47:02 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77D1F3F59C;
 Wed, 30 Jan 2019 05:47:00 -0800 (PST)
Subject: Re: [PATCH v9 26/26] arm64: Enable the support of pseudo-NMIs
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-27-git-send-email-julien.thierry@arm.com>
 <86o981ueyj.wl-marc.zyngier@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <38589cbc-dbaf-b903-6c56-65e796063680@arm.com>
Date: Wed, 30 Jan 2019 13:46:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <86o981ueyj.wl-marc.zyngier@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_054703_398610_0792083D 
X-CRM114-Status: GOOD (  21.87  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 28/01/2019 12:47, Marc Zyngier wrote:
> On Mon, 21 Jan 2019 15:33:45 +0000,
> Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Add a build option and a command line parameter to build and enable the
>> support of pseudo-NMIs.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>>  arch/arm64/Kconfig                              | 14 ++++++++++++++
>>  arch/arm64/kernel/cpufeature.c                  | 11 ++++++++++-
>>  3 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index b799bcf..173e2cc 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1197,6 +1197,12 @@
>>  			to discrete, to make X server driver able to add WB
>>  			entry later. This parameter enables that.
>>  
>> +	enable_pseudo_nmi [ARM64]
>> +			Enables support for pseudo-NMIs in the kernel. This
>> +			requires both the kernel to be built with
>> +			CONFIG_ARM64_PSEUDO_NMI and to be running on a
>> +			platform with GICv3.
>> +
>>  	enable_timer_pin_1 [X86]
>>  			Enable PIN 1 of APIC timer
>>  			Can be useful to work around chipset bugs
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a4168d3..8d84bfd 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1328,6 +1328,20 @@ config ARM64_MODULE_PLTS
>>  	bool
>>  	select HAVE_MOD_ARCH_SPECIFIC
>>  
>> +config ARM64_PSEUDO_NMI
>> +	bool "Support for NMI-like interrupts"
>> +	select CONFIG_ARM_GIC_V3
>> +	help
>> +	  Adds support for mimicking Non-Maskable Interrupts through the use of
>> +	  GIC interrupt priority. This support requires version 3 or later of
>> +	  Arm GIC.
>> +
>> +	  This high priority configuration for interrupts need to be
> 
> s/need/needs/
> 
>> +	  explicitly enabled through the new kernel parameter
> 
> It won't be new forever... ;-)
> 

Good point!

>> +	  "enable_pseudo_nmi".
> 
> I'm not overly keen on this name. We already have "irqchip.gicv3_nolpi",
> so why not adopt something similar. "irqchip.gicv3_pseudo_nmi", taking a
> boolean value?
> 

Sure, I'm fine with that.

>> +
>> +	  If unsure, say N
>> +
>>  config RELOCATABLE
>>  	bool
>>  	help
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index b530fb24..e66d778 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1207,10 +1207,19 @@ static void cpu_enable_address_auth(struct arm64_cpu_capabilities const *cap)
>>  #endif /* CONFIG_ARM64_PTR_AUTH */
>>  
>>  #ifdef CONFIG_ARM64_PSEUDO_NMI
>> +static bool enable_pseudo_nmi;
>> +
>> +static int __init early_enable_pseudo_nmi(char *p)
>> +{
>> +	enable_pseudo_nmi = true;
> 
> And if you're happy with the above, this becomes:
> 
> 	return strtobool(p, &enable_pseudo_nmi);
> 

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
