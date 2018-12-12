Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA0C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:00:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97B320839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tmBC99QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97B320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YBKuD28IVRVOL2qMpML+N+/t2fJ6SfPDiNGaP+9FUkU=; b=tmBC99QOZzcVJ4
	qSZglIYIPNXCgPmgxvlS8/7GoOYoFUzocR9zQsokNGRSQZriFphwUjA40k6iWw/a+2rFcZCmM4epU
	Z0oGMHYw+eASsUqXuREKd6jm+XVQJCD6abtA85hotq7+U0I68TUJWUewM1yprtelhqfd37eZjEgst
	T3/2n92xE8udgakpitOSwNsgp9lKkHYwKz3P3yLWNDFQBuG+yEkskAAovz+3HR/6GAaPSvZXGaRfQ
	4v0k1iFLMxeQNq7naJQQBz8lc9wAcB4dpvwr60aUphRgT6+muXjeYRe2vPSq9tAG/2nx8GV/gL8oa
	eIMtYo7fjWwO0r83oJWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8nn-0004PJ-BM; Wed, 12 Dec 2018 18:00:07 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8ni-0003Yc-UN
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 18:00:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50B7C80D;
 Wed, 12 Dec 2018 09:59:51 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7563F575;
 Wed, 12 Dec 2018 09:59:49 -0800 (PST)
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <19500d6b-62a3-21cb-9ac0-a4e5d4714a63@arm.com>
Date: Wed, 12 Dec 2018 17:59:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_100003_001412_112D7E34 
X-CRM114-Status: GOOD (  31.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 oleg@redhat.com, joel@joelfernandes.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/12/2018 17:27, Ard Biesheuvel wrote:
> On Wed, 12 Dec 2018 at 17:48, Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Instead disabling interrupts by setting the PSR.I bit, use a priority
>> higher than the one used for interrupts to mask them via PMR.
>>
>> When using PMR to disable interrupts, the value of PMR will be used
>> instead of PSR.[DAIF] for the irqflags.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> ---
>>  arch/arm64/include/asm/efi.h      |   5 +-
>>  arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
>>  2 files changed, 99 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
>> index 7ed3208..a9d3ebc 100644
>> --- a/arch/arm64/include/asm/efi.h
>> +++ b/arch/arm64/include/asm/efi.h
>> @@ -42,7 +42,10 @@
>>
>>  efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
>>
>> -#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>> +#define ARCH_EFI_IRQ_FLAGS_MASK                                                \
>> +       (system_uses_irq_prio_masking() ?                               \
>> +               GIC_PRIO_IRQON :                                        \
>> +               (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT))
>>
> 
> This mask is used to determine whether we return from a firmware call
> with a different value for the I flag than we entered it with. So
> instead of changing the mask, we should change the way we record DAIF,
> given that the firmware is still going to poke the I bit if it
> misbehaves, regardless of whether the OS happens to use priorities for
> interrupt masking.
> 

Thanks for pointing that out, so this change makes little sense...

The annoying part is that the flag checking takes place in the arch
agnostic code.

Would introducing some overriddable efi_get_flags() or efi_save_flags()
that default to local_save_flags() seem like an acceptable solution?

This way I could override it for arm64 and still return the DAIF bits.

> It also means that the NMI concept is a best effort thing only, given
> that uncooperative firmware could prevent them from being delivered.
> 

Yes, but we would get an error on the EFI side if it starts setting the
I bit. The NMI would be mostly a debug tool at that point anyway, so I
guess if external forces are against us, it is not really worth fighting
for it.

Thanks,

> 
> 
>>  /* arch specific definitions used by the stub code */
>>
>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>> index 24692ed..fa3b06f 100644
>> --- a/arch/arm64/include/asm/irqflags.h
>> +++ b/arch/arm64/include/asm/irqflags.h
>> @@ -18,7 +18,9 @@
>>
>>  #ifdef __KERNEL__
>>
>> +#include <asm/alternative.h>
>>  #include <asm/ptrace.h>
>> +#include <asm/sysreg.h>
>>
>>  /*
>>   * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
>> @@ -36,47 +38,96 @@
>>  /*
>>   * CPU interrupt mask handling.
>>   */
>> -static inline unsigned long arch_local_irq_save(void)
>> -{
>> -       unsigned long flags;
>> -       asm volatile(
>> -               "mrs    %0, daif                // arch_local_irq_save\n"
>> -               "msr    daifset, #2"
>> -               : "=r" (flags)
>> -               :
>> -               : "memory");
>> -       return flags;
>> -}
>> -
>>  static inline void arch_local_irq_enable(void)
>>  {
>> -       asm volatile(
>> -               "msr    daifclr, #2             // arch_local_irq_enable"
>> -               :
>> +       unsigned long unmasked = GIC_PRIO_IRQON;
>> +
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
>> +               ARM64_HAS_IRQ_PRIO_MASKING)
>>                 :
>> +               : "r" (masked)
>>                 : "memory");
>>  }
>>
>>  /*
>> + * Having two ways to control interrupt status is a bit complicated. Some
>> + * locations like exception entries will have PSR.I bit set by the architecture
>> + * while PMR is unmasked.
>> + * We need the irqflags to represent that interrupts are disabled in such cases.
>> + *
>> + * For this, we lower the value read from PMR when the I bit is set so it is
>> + * considered as an irq masking priority. (With PMR, lower value means masking
>> + * more interrupts).
>> + */
>> +#define _get_irqflags(daif_bits, pmr)                                  \
>> +({                                                                     \
>> +       unsigned long flags;                                            \
>> +                                                                       \
>> +       BUILD_BUG_ON(GIC_PRIO_IRQOFF < (GIC_PRIO_IRQON & ~PSR_I_BIT));  \
>> +       asm volatile(ALTERNATIVE(                                       \
>> +               "mov    %0, %1\n"                                       \
>> +               "nop\n"                                                 \
>> +               "nop",                                                  \
>> +               "and    %0, %1, #" __stringify(PSR_I_BIT) "\n"          \
>> +               "mvn    %0, %0\n"                                       \
>> +               "and    %0, %0, %2",                                    \
>> +               ARM64_HAS_IRQ_PRIO_MASKING)                             \
>> +               : "=&r" (flags)                                         \
>> +               : "r" (daif_bits), "r" (pmr)                            \
>> +               : "memory");                                            \
>> +                                                                       \
>> +       flags;                                                          \
>> +})
>> +
>> +/*
>>   * Save the current interrupt enable state.
>>   */
>>  static inline unsigned long arch_local_save_flags(void)
>>  {
>> -       unsigned long flags;
>> -       asm volatile(
>> -               "mrs    %0, daif                // arch_local_save_flags"
>> -               : "=r" (flags)
>> +       unsigned long daif_bits;
>> +       unsigned long pmr; // Only used if alternative is on
>> +
>> +       daif_bits = read_sysreg(daif);
>> +
>> +       // Get PMR
>> +       asm volatile(ALTERNATIVE(
>> +                       "nop",
>> +                       "mrs_s  %0, " __stringify(SYS_ICC_PMR_EL1),
>> +                       ARM64_HAS_IRQ_PRIO_MASKING)
>> +               : "=&r" (pmr)
>>                 :
>>                 : "memory");
>> +
>> +       return _get_irqflags(daif_bits, pmr);
>> +}
>> +
>> +#undef _get_irqflags
>> +
>> +static inline unsigned long arch_local_irq_save(void)
>> +{
>> +       unsigned long flags;
>> +
>> +       flags = arch_local_save_flags();
>> +
>> +       arch_local_irq_disable();
>> +
>>         return flags;
>>  }
>>
>> @@ -85,16 +136,32 @@ static inline unsigned long arch_local_save_flags(void)
>>   */
>>  static inline void arch_local_irq_restore(unsigned long flags)
>>  {
>> -       asm volatile(
>> -               "msr    daif, %0                // arch_local_irq_restore"
>> -       :
>> -       : "r" (flags)
>> -       : "memory");
>> +       asm volatile(ALTERNATIVE(
>> +                       "msr    daif, %0\n"
>> +                       "nop",
>> +                       "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0\n"
>> +                       "dsb    sy",
>> +                       ARM64_HAS_IRQ_PRIO_MASKING)
>> +               : "+r" (flags)
>> +               :
>> +               : "memory");
>>  }
>>
>>  static inline int arch_irqs_disabled_flags(unsigned long flags)
>>  {
>> -       return flags & PSR_I_BIT;
>> +       int res;
>> +
>> +       asm volatile(ALTERNATIVE(
>> +                       "and    %w0, %w1, #" __stringify(PSR_I_BIT) "\n"
>> +                       "nop",
>> +                       "cmp    %w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
>> +                       "cset   %w0, ls",
>> +                       ARM64_HAS_IRQ_PRIO_MASKING)
>> +               : "=&r" (res)
>> +               : "r" ((int) flags)
>> +               : "memory");
>> +
>> +       return res;
>>  }
>>  #endif
>>  #endif
>> --
>> 1.9.1
>>

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
