Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:12:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD472081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c/Q5VXsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD472081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l/esQP1cll4rsI78fgcuL4aSsjnjhPcugEB3iDCEJYA=; b=c/Q5VXsQZJkB97
	DrGpLnkdInvgdnWEjvO4fq5KHxDL2s7v/OkAjLPb2qN+0hpgl4EiJlZ3L7HYM63WEXPJR7W/QZAFq
	mHijHF5bH1t+pJU5tlO7h1e78yq7vRMneYBGw/9tMIqWCzuHn5ULKzIIIUUR7Hxs8LqY8zeOcb82C
	2glCajKADUpaTvlEl3OIaveRQ/bLcPKx4gPG8AR9XDrzNdS1/fL8UGQYE+6hStQCxMfJl9VJ6o0HA
	ni/VBGRU7OXIl/LAx0giTOvIhaBaUG4MD2UroBn1A/9xa5h7jCceynHIUjU2xcLn5AjPWswewz3qq
	Y6cV/TTDe7mIlWVz6lwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFB5-0005GJ-EL; Tue, 04 Dec 2018 18:12:11 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFB1-0005Dn-D1
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:12:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD4FA78;
 Tue,  4 Dec 2018 10:11:56 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7DD13F59C;
 Tue,  4 Dec 2018 10:11:54 -0800 (PST)
Subject: Re: [PATCH v6 15/24] arm64: Switch to PMR masking when starting CPUs
To: Catalin Marinas <catalin.marinas@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-16-git-send-email-julien.thierry@arm.com>
 <20181204175142.GD19210@arrakis.emea.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <ffb17cfd-d941-1df6-8b41-2f710948e9b2@arm.com>
Date: Tue, 4 Dec 2018 18:11:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181204175142.GD19210@arrakis.emea.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_101207_439872_9998800E 
X-CRM114-Status: GOOD (  19.90  )
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
Cc: daniel.thompson@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 04/12/18 17:51, Catalin Marinas wrote:
> On Mon, Nov 12, 2018 at 11:57:06AM +0000, Julien Thierry wrote:
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 8dc9dde..e495360 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/smp.h>
>>  #include <linux/seq_file.h>
>>  #include <linux/irq.h>
>> +#include <linux/irqchip/arm-gic-v3.h>
>>  #include <linux/percpu.h>
>>  #include <linux/clockchips.h>
>>  #include <linux/completion.h>
>> @@ -175,6 +176,25 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>  	return ret;
>>  }
>>  
>> +static void init_gic_priority_masking(void)
>> +{
>> +	u32 gic_sre = gic_read_sre();
>> +	u32 cpuflags;
>> +
>> +	if (WARN_ON(!(gic_sre & ICC_SRE_EL1_SRE)))
>> +		return;
>> +
>> +	WARN_ON(!irqs_disabled());
>> +
>> +	gic_write_pmr(GIC_PRIO_IRQOFF);
>> +
>> +	cpuflags = read_sysreg(daif);
>> +
>> +	/* We can only unmask PSR.I if we can take aborts */
>> +	if (!(cpuflags & PSR_A_BIT))
>> +		write_sysreg(cpuflags & ~PSR_I_BIT, daif);
> 
> I don't understand this. If you don't switch off PSR_I_BIT here, where
> does it happen? In which scenario do we actually have the A bit still
> set? At a quick look, smp_prepare_boot_cpu() would have the A bit
> cleared previously by setup_arch(). We have secondary_start_kernel()
> where you call init_gic_priority_masking() before local_daif_restore().
> 

So this is for secondary CPUs where PSR.A can be still set.

The thing is that the daifflags.h establishes the order for disabling
types of exceptions:
Debug > Abort > IRQ

The idea is that when introducing pseudo-NMIs this becomes:
Debug > Abort > pseudo-NMI > IRQ

Whenever aborts are disabled (maybe because we just took an abort) we
don't want to take an NMI.

> So what happens if you always turn off PSR_I_BIT here?
> 

So semantically it would be saying "we can take a pseudo-NMI here".
Realistically, I think it depends on the state of the GIC redistributor
for this CPU:
- If the re-distributor was initialized, nothing bad could happen as no
NMI could have been configured for this CPU yet.
- If the re-distributor initialization is done between the call to
init_gic_priority_mask() and the local_daif_restore() then probably bad
things could happen

I can try to figure out if it is safe to just clear PSR.I always, but I
also find it easier to always play by the rule "if PSR.A is set, PSR.I
is set".

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
