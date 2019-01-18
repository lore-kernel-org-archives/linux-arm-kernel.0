Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E027BC07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:27:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B296B20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kWlsmFaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B296B20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+BI1/WBUXBKgQvwMRlUlYQePMLZdrskko/FKKp2W4yU=; b=kWlsmFaL3Z8FlX
	NiBKVRqbG7p1hXkdBXad+cFZqOMwkl11VoBFAAkrSp2ROjM3IMcSHdZCJveFOEip62onIBTBQg2xe
	964grLgDgHzzURlbHDHm8htEVJIy3FzJ/3N0XV6/1lOkb3Ak+/k2F1rHdInKz0pHnQjY5ln0mXvqK
	+Pv5+J3V9vW74DWOI4ppwagqzdYeMGRFb/snJHnZSM7m29+bX5eXIvQkqjeBkUwM8AGbdvvBpIZcm
	2GPayfxiVGrKJNlaZR4q1bqbd8O9W7wcuiRS+fnD9/x95fujBwLWu1fbk0xSfw/+x3BSxLSS41iad
	w0KSM2SPNYmbGeH4A0ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXve-0007mD-07; Fri, 18 Jan 2019 17:27:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXva-0007lU-Ot
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:27:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C50880D;
 Fri, 18 Jan 2019 09:27:33 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 474043F7BE;
 Fri, 18 Jan 2019 09:27:31 -0800 (PST)
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Dave Martin <Dave.Martin@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
 <20190118163556.GB3578@e103592.cambridge.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <2bdc47ca-5aa0-24a2-b7fe-7b59158698e2@arm.com>
Date: Fri, 18 Jan 2019 17:27:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118163556.GB3578@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_092734_821321_9DE1D305 
X-CRM114-Status: GOOD (  26.10  )
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
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
 joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 18/01/2019 16:35, Dave Martin wrote:
> On Tue, Jan 08, 2019 at 02:07:30PM +0000, Julien Thierry wrote:
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
>>  arch/arm64/include/asm/efi.h      |  11 ++++
>>  arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
>>  2 files changed, 106 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
>> index 7ed3208..134ff6e 100644
>> --- a/arch/arm64/include/asm/efi.h
>> +++ b/arch/arm64/include/asm/efi.h
>> @@ -44,6 +44,17 @@
>>  
>>  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>>  
>> +#define arch_efi_save_flags(state_flags)		\
>> +	do {						\
>> +		(state_flags) =	read_sysreg(daif);	\
>> +	} while (0)
>> +
>> +#define arch_efi_restore_flags(state_flags)		\
>> +	do {						\
>> +		write_sysreg(state_flags, daif);	\
>> +	} while (0)
>> +
>> +
> 
> Randomly commenting a few minor nits as I glance down my mailbox...
> 
> There's no need to protect single statements with do { } while(0).
> 
> Just protect an expression statement that could be misparsed with ( ).
> 
> ->
> 
> #define arch_efi_save_flags(state_flags) ((state_flags) = read_sysreg(daif))

For the efi_save_flags(), I wanted to avoid it getting used as an
expression.

Would casting the assignment expression to (void) be acceptable?

> #define arch_efi_restore_flags(state_flags) write_sysreg(state_flags, daif)

For this one, write_sysreg() is already a statement, so yes, I
definitely don't need a do { } while (0) here.

> 
> [...]
> 
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
> 
> [...]
> 
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
>> +#define _get_irqflags(daif_bits, pmr)					\
>> +({									\
>> +	unsigned long flags;						\
>> +									\
>> +	BUILD_BUG_ON(GIC_PRIO_IRQOFF < (GIC_PRIO_IRQON & ~PSR_I_BIT));	\
>> +	asm volatile(ALTERNATIVE(					\
>> +		"mov	%0, %1\n"					\
>> +		"nop\n"							\
>> +		"nop",							\
>> +		"and	%0, %1, #" __stringify(PSR_I_BIT) "\n"		\
>> +		"mvn	%0, %0\n"					\
>> +		"and	%0, %0, %2",					\
>> +		ARM64_HAS_IRQ_PRIO_MASKING)				\
>> +		: "=&r" (flags)						\
>> +		: "r" (daif_bits), "r" (pmr)				\
>> +		: "memory");						\
>> +									\
>> +	flags;								\
>> +})
> 
> Nit: does this need to be a macro?
> 
> ({ ... }) is mildly gross and it's preferable to avoid it if the code
> works just as well without...
> 
> pmr would need to be passed as a pointer, with "r" (*pmr) in the asm,
> but I think it would compile down to precisely the same code.
> 

The only motivation for it to be a macro was to be able to #undef it
after its use.

But with Catalin's suggestion, looks like we can makes things simple and
avoid having a separate macro/function.

>> +
>> +/*
>>   * Save the current interrupt enable state.
>>   */
>>  static inline unsigned long arch_local_save_flags(void)
>>  {
>> -	unsigned long flags;
>> -	asm volatile(
>> -		"mrs	%0, daif		// arch_local_save_flags"
>> -		: "=r" (flags)
>> +	unsigned long daif_bits;
>> +	unsigned long pmr; // Only used if alternative is on
>> +
>> +	daif_bits = read_sysreg(daif);
>> +
>> +	// Get PMR
>> +	asm volatile(ALTERNATIVE(
>> +			"nop",
>> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1),
>> +			ARM64_HAS_IRQ_PRIO_MASKING)
>> +		: "=&r" (pmr)
> 
> Why earlyclobber?
>>>  		:
>>  		: "memory");
> 
> [...]
> 
>> @@ -85,16 +136,32 @@ static inline unsigned long arch_local_save_flags(void)
> 
> [...]
> 
>>  static inline int arch_irqs_disabled_flags(unsigned long flags)
>>  {
>> -	return flags & PSR_I_BIT;
>> +	int res;
>> +
>> +	asm volatile(ALTERNATIVE(
>> +			"and	%w0, %w1, #" __stringify(PSR_I_BIT) "\n"
>> +			"nop",
>> +			"cmp	%w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
>> +			"cset	%w0, ls",
>> +			ARM64_HAS_IRQ_PRIO_MASKING)
>> +		: "=&r" (res)
> 
> Why earlyclobber?  %0 is not written before the reading of any input
> argument so far as I can see, in either alternative.
> 

I didn't really understand what the earlyclobber semantic was, thanks
for explaining it.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
