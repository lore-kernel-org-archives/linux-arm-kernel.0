Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53905C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:56:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010382084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YpRLAxpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010382084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8os4atwhRrpFmPDtv86IblymPuLAks8cQrhcOhD+6jo=; b=YpRLAxpmQd9t4m
	IFT471NhbqpZleYElKiF5ImwA/uxIMt33/dUhZfodedP963oudHTttfJL5GQJtExxb9APav9y4ih2
	JI9bFywnv79ToGURdzEX40FWMa3hkJ8kM42UUWDtAWCbozNb0V5UxdvTaw3/tP616LixjrHlUuZRs
	4yTyBp4ffrWciy17kwWn3ML15mGwQ/MySJsSuu0jSH5OVI5kI/slefLc/oiOn4l/l/qNCKKxp/6Yf
	fwdMpJWzL7W2zj/i/SocTOJif7W1dBRcQmo5p3pD2pKryB2pPyryYrNSgOV7+aEuCV8AByHQzq7fZ
	Jwk6sWG67SIvFRIQ7tNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaT7-0000TH-Un; Wed, 05 Dec 2018 16:56:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaT5-0000ST-7n
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:56:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 198B9A78;
 Wed,  5 Dec 2018 08:55:59 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B39F3F5AF;
 Wed,  5 Dec 2018 08:55:56 -0800 (PST)
Subject: Re: [PATCH v6 10/24] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Catalin Marinas <catalin.marinas@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-11-git-send-email-julien.thierry@arm.com>
 <20181204173610.GC19210@arrakis.emea.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <bc8d0621-8b6c-c678-49ec-ad1c96bac88a@arm.com>
Date: Wed, 5 Dec 2018 16:55:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181204173610.GC19210@arrakis.emea.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_085611_280480_38D84D91 
X-CRM114-Status: GOOD (  18.41  )
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
Cc: daniel.thompson@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
 joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 04/12/18 17:36, Catalin Marinas wrote:
> On Mon, Nov 12, 2018 at 11:57:01AM +0000, Julien Thierry wrote:
>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>> index 24692ed..e0a32e4 100644
>> --- a/arch/arm64/include/asm/irqflags.h
>> +++ b/arch/arm64/include/asm/irqflags.h
>> @@ -18,7 +18,27 @@
>>  
>>  #ifdef __KERNEL__
>>  
>> +#include <asm/alternative.h>
>> +#include <asm/cpufeature.h>
>>  #include <asm/ptrace.h>
>> +#include <asm/sysreg.h>
>> +
>> +
>> +/*
>> + * When ICC_PMR_EL1 is used for interrupt masking, only the bit indicating
>> + * whether the normal interrupts are masked is kept along with the daif
>> + * flags.
>> + */
>> +#define ARCH_FLAG_PMR_EN 0x1
>> +
>> +#define MAKE_ARCH_FLAGS(daif, pmr)					\
>> +	((daif) | (((pmr) >> GIC_PRIO_STATUS_SHIFT) & ARCH_FLAG_PMR_EN))
>> +
>> +#define ARCH_FLAGS_GET_PMR(flags)				 \
>> +	((((flags) & ARCH_FLAG_PMR_EN) << GIC_PRIO_STATUS_SHIFT) \
>> +		| GIC_PRIO_IRQOFF)
>> +
>> +#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)
> 
> I wonder whether we could just use the PSR_I_BIT here to decide whether
> to set the GIC_PRIO_IRQ{ON,OFF}. We could clear the PSR_I_BIT in
> _restore_daif() with an alternative.
> 

So, the issue with it is that some contexts might be using PSR.I to
disable interrupts (any contexts with async errors or debug exceptions
disabled, kvm guest entry paths, pseudo-NMIs, ...).

If any of these contexts calls local_irq_save()/local_irq_restore() or
local_daif_save()/local_daif_restore(), by only relying on PSR_I_BIT to
represent the PMR status, we might end up clearing PSR.I when we shouldn't.

I'm not sure whether there are no callers of these functions in those
context. But if that is the case, we could simplify things, yes.

Thanks,


>> +/*
>> + * CPU interrupt mask handling.
>> + */
>>  static inline void arch_local_irq_enable(void)
>>  {
>> -	asm volatile(
>> -		"msr	daifclr, #2		// arch_local_irq_enable"
>> -		:
>> +	unsigned long unmasked = GIC_PRIO_IRQON;
>> +
>> +	asm volatile(ALTERNATIVE(
>> +		"msr	daifclr, #2		// arch_local_irq_enable\n"
>> +		"nop",
>> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
>> +		"dsb	sy",
>> +		ARM64_HAS_IRQ_PRIO_MASKING)
> 
> DSB needed here as well? I guess I'd have to read the GIC spec before
> asking again ;).
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
