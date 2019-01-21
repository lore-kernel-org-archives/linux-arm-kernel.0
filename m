Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD96C31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:05:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFFC32085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PpcIa3/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFC32085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y333YtggZj9isOx734wiENT1yTp1rwdQlUD63bM3Obc=; b=PpcIa3/y4oUnA3
	KQW3miWtey7j9aQcB3RgXsJ5gZ2SoF9DS0H0PrfFAKVVEfkFUrQYrI807wHjS9K+4QiXL8UfmwPyX
	qqKPd4wlgGvA8XTHJBRkOPfqykRbdlnPbQO+tcdes3MCksKplfgsmpsVhsbbxEjAWH4KFsgV9AydE
	VVi2OByHV3pFya7NUNDwKk2AxHI/E1psB5H+swKHCyikjI98/SGKz2PDUze5bj0g5VXmqBil3MzWx
	PMKhnlMlQgqFGLokb1UhJFcRsfw7RJJac306jzd5jN+1hfoF3bhoywoS04fsn5y0Wbup0Si7JyrN2
	M+gAGEbgshs3VnKRQLKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldx5-0002yY-KC; Mon, 21 Jan 2019 18:05:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldx2-0002xj-3B
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 18:05:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B118315AB;
 Mon, 21 Jan 2019 10:05:35 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EC943F6A8;
 Mon, 21 Jan 2019 10:05:32 -0800 (PST)
Subject: Re: [PATCH v9 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu-m2KcbDNsM1AJZHOKrJkE5Ki=xX8qqUvFnDc=87-4OsA@mail.gmail.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <35daeeda-c3fe-83bb-09ee-77480064c67d@arm.com>
Date: Mon, 21 Jan 2019 18:05:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-m2KcbDNsM1AJZHOKrJkE5Ki=xX8qqUvFnDc=87-4OsA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_100536_143135_C548168C 
X-CRM114-Status: GOOD (  23.17  )
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
 Oleg Nesterov <oleg@redhat.com>, Joel Fernandes <joel@joelfernandes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 21/01/2019 15:45, Ard Biesheuvel wrote:
> On Mon, 21 Jan 2019 at 16:34, Julien Thierry <julien.thierry@arm.com> wrote:
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
>>  arch/arm64/include/asm/efi.h      |   6 +++
>>  arch/arm64/include/asm/irqflags.h | 104 ++++++++++++++++++++++++++++----------
>>  2 files changed, 82 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
>> index 7ed3208..3db6772 100644
>> --- a/arch/arm64/include/asm/efi.h
>> +++ b/arch/arm64/include/asm/efi.h
>> @@ -44,6 +44,12 @@
>>
>>  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>>
>> +#define arch_efi_save_flags(state_flags)               \
>> +       ((void)((state_flags) = read_sysreg(daif)))
>> +
>> +#define arch_efi_restore_flags(state_flags)    write_sysreg(state_flags, daif)
>> +
>> +
>>  /* arch specific definitions used by the stub code */
>>
>>  /*
> 
> For the EFI changes
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks!

> 
> although it deserves a comment as to why it is unaffected by
> ARM64_HAS_IRQ_PRIO_MASKING

So far we've relied on EFI not modifying PMR, otherwise we could've
ended up without any interrupts in Linux after coming back from an EFI
service.

Now, the ARM64_HAS_IRQ_PRIO_MASKING only modifies the behaviour of
Linux, but we should have the same expectations from EFI. If we want to
be paranoid we could save/restore PMR along with the DAIF flags.

But you're right, it is fair to add a comment clearly stating that we
expect EFI not to modify PMR. I'll include that in the next posting.

Thanks,

Julien

> 
> 
>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>> index 24692ed..7e82a92 100644
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
>> @@ -36,33 +38,31 @@
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
>> @@ -71,12 +71,44 @@ static inline void arch_local_irq_disable(void)
>>   */
>>  static inline unsigned long arch_local_save_flags(void)
>>  {
>> +       unsigned long daif_bits;
>>         unsigned long flags;
>> -       asm volatile(
>> -               "mrs    %0, daif                // arch_local_save_flags"
>> -               : "=r" (flags)
>> -               :
>> +
>> +       daif_bits = read_sysreg(daif);
>> +
>> +       /*
>> +        * The asm is logically equivalent to:
>> +        *
>> +        * if (system_uses_irq_prio_masking())
>> +        *      flags = (daif_bits & PSR_I_BIT) ?
>> +        *                      GIC_PRIO_IRQOFF :
>> +        *                      read_sysreg_s(SYS_ICC_PMR_EL1);
>> +        * else
>> +        *      flags = daif_bits;
>> +        */
>> +       asm volatile(ALTERNATIVE(
>> +                       "mov    %0, %1\n"
>> +                       "nop\n"
>> +                       "nop",
>> +                       "mrs_s  %0, " __stringify(SYS_ICC_PMR_EL1) "\n"
>> +                       "ands   %1, %1, " __stringify(PSR_I_BIT) "\n"
>> +                       "csel   %0, %0, %2, eq",
>> +                       ARM64_HAS_IRQ_PRIO_MASKING)
>> +               : "=&r" (flags), "+r" (daif_bits)
>> +               : "r" (GIC_PRIO_IRQOFF)
>>                 : "memory");
>> +
>> +       return flags;
>> +}
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
>> @@ -85,16 +117,32 @@ static inline unsigned long arch_local_save_flags(void)
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
