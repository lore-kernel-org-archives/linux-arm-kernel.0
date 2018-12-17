Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D3EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:26:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1752084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="duCQVNoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1752084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vCfLqExSLW5iHP72yLmjF67HuYEDwjE+A2mn7QLBJQE=; b=duCQVNoyoc0YpB
	CLrRLFRF/ipJ2siYLd85mSIULAnTo4zlMDEgs+u/t9mBSGQa1sVcS1tiB0gxlgfpDCWuBpLtEvTnw
	0OboKFVpVfvKCuEn+rASnYjijozvd7DU0tg7IrVSn5UdB//l5UsZTFdLfya7uIP1tJV4m+FjRThZq
	QO/LSf9QvvGo3YvNW9aMp7MEHYuzT3UuV9UAuV301ZSp4YXbZtPqw0vb1JzYCDf2BwyFNIqf1be2R
	lrq7J25WLPwMsw8Crcp8TDc4iuyaD380Yik/3qWra4x4t9sGbPXowD5hEZTq3zw+Yd+xmFfG3SEFo
	0BDaF8KzHN4g2k+Q0NEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpAL-0006Sn-GG; Mon, 17 Dec 2018 09:26:21 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpAH-0006RZ-Sz
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:26:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88149A78;
 Mon, 17 Dec 2018 01:26:06 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43D3B3F6A8;
 Mon, 17 Dec 2018 01:26:04 -0800 (PST)
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Jian-Lin Chen <lecopzer@gmail.com>
References: <20181216144715.7486-1-lecopzer@gmail.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <e69be9ad-fcda-fa8d-1844-ad0decffb876@arm.com>
Date: Mon, 17 Dec 2018 09:26:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216144715.7486-1-lecopzer@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_012617_944321_57205297 
X-CRM114-Status: GOOD (  16.93  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Jian-Lin Chen <lecopzer.chen@mediatek.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
 joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jian-Lin,

Thanks for looking at this.

On 16/12/2018 14:47, Jian-Lin Chen wrote:
> From: Jian-Lin Chen <lecopzer.chen@mediatek.com>
> 
> 
> On Wed, 12 Dec 2018 at 17:48, Julien Thierry <julien.thierry@arm.com> wrote:
>>  static inline void arch_local_irq_enable(void)
>>  {
>> -       asm volatile(
>> -               "msr    daifclr, #2             // arch_local_irq_enable"
>> -               :
>> +       unsigned long unmasked = GIC_PRIO_IRQON;
>> +
> 
> Should we need a WARN_ON() to check if the daif_I bit is masked, or
> explicitly unmasked I bit here?
> 

While I would agree, adding the WARN_ON() will add some non-negligible
overhead, especially if we need to read the daif flags to check it.

Since these functions are called often in the whole system and using PMR
already makes things a bit slower, I'd prefer to avoid checks in here.

> If I bit was masked and someone calls arch_local_irq_enable(), they still
> couldn't recieve any interrupt.
> 
> 
>> +       asm volatile(ALTERNATIVE(
>> +               "msr    daifclr, #2             // arch_local_irq_enable\n"
>> +               "nop",
>> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
>> +               "dsb    sy",
>> +               ARM64_HAS_IRQ_PRIO_MASKING)
>>                 :
>> +               : "r" (unmasked)
>>                 : "memory");
>>  }
>>
>>  static inline void arch_local_irq_disable(void)
>>  {
>> -       asm volatile(
>> -               "msr    daifset, #2             // arch_local_irq_disable"
>> -               :
>> +       unsigned long masked = GIC_PRIO_IRQOFF;
>> +
>> +       asm volatile(ALTERNATIVE(
>> +               "msr    daifset, #2             // arch_local_irq_disable",
>> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> 
> May be a "dsb sy" here?

So, we need a "dsb sy" when unmasking interrupts because this ensures
the redistributor sees the latest PMR value and starts forwarding lower
priority interrupts again.

When we disable interrupts however, the GIC CPU interface guarantees
that no interrupts of lower priority than the current value of PMR will
be taken. So we don't really need the redistributor to immediately see
the new value of PMR as the logic in the GIC CPU interface is good
enough for our goal.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
