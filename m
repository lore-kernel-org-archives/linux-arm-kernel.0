Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25ADC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3BD20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iTK9+QlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3BD20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vpqwzmr84XtkfLlN+J6RGToaBQjRAEI0zMYqO/37zLo=; b=iTK9+QlWuBbwrH
	teCY+Fae7HSC11VzvBnMH0PunkSRt+ggobrc2WyMs+h7kwQqJovqEDawrB/Q9P+GznjgTgtR2r7+a
	B8JpL43TATIDmUa551n4An056577VtOhA6RcObZCAi7KRU5I8m5Z3YzgVSp+lPv+/LNC4qu1GHX6+
	5A3v9HmZKWEYyVuWHl9CLo2tCBSCSRiJPUv9QZa9HErj1xLggrbHcrQ7vecJVTeYAOj1KT8KkGaKl
	3w97LOJXingzXApH8QCfQEXpX3AoYN5lC6A/yJuVbFlETyK2YzcaipGv00K67wec/tBhgqtRdSlSx
	loDuhT03B45oW04gS5yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxsH-0004Ff-1O; Tue, 22 Jan 2019 15:22:01 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxsD-0004Ei-On
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:21:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED3C3A78;
 Tue, 22 Jan 2019 07:21:53 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 DA39D3F589; Tue, 22 Jan 2019 07:21:51 -0800 (PST)
Date: Tue, 22 Jan 2019 15:21:49 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v9 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190122152149.GD187049@arrakis.emea.arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_072157_819005_FB7886A4 
X-CRM114-Status: GOOD (  15.55  )
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
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 03:33:31PM +0000, Julien Thierry wrote:
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..7e82a92 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -18,7 +18,9 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <asm/alternative.h>
>  #include <asm/ptrace.h>
> +#include <asm/sysreg.h>
>  
>  /*
>   * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
> @@ -36,33 +38,31 @@
>  /*
>   * CPU interrupt mask handling.
>   */
> -static inline unsigned long arch_local_irq_save(void)
> -{
> -	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_irq_save\n"
> -		"msr	daifset, #2"
> -		: "=r" (flags)
> -		:
> -		: "memory");
> -	return flags;
> -}
> -
>  static inline void arch_local_irq_enable(void)
>  {
> -	asm volatile(
> -		"msr	daifclr, #2		// arch_local_irq_enable"
> -		:
> +	unsigned long unmasked = GIC_PRIO_IRQON;
> +
> +	asm volatile(ALTERNATIVE(
> +		"msr	daifclr, #2		// arch_local_irq_enable\n"
> +		"nop",
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +		"dsb	sy",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> +		: "r" (unmasked)
>  		: "memory");
>  }
>  
>  static inline void arch_local_irq_disable(void)
>  {
> -	asm volatile(
> -		"msr	daifset, #2		// arch_local_irq_disable"
> -		:
> +	unsigned long masked = GIC_PRIO_IRQOFF;
> +
> +	asm volatile(ALTERNATIVE(
> +		"msr	daifset, #2		// arch_local_irq_disable",
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> +		: "r" (masked)
>  		: "memory");
>  }

Nitpicks: you could drop masked/unmasked variables here (it's up to you,
it wouldn't make any difference on the generated asm).

> @@ -71,12 +71,44 @@ static inline void arch_local_irq_disable(void)
>   */
>  static inline unsigned long arch_local_save_flags(void)
>  {
> +	unsigned long daif_bits;
>  	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_save_flags"
> -		: "=r" (flags)
> -		:
> +
> +	daif_bits = read_sysreg(daif);
> +
> +	/*
> +	 * The asm is logically equivalent to:
> +	 *
> +	 * if (system_uses_irq_prio_masking())
> +	 *	flags = (daif_bits & PSR_I_BIT) ?
> +	 *			GIC_PRIO_IRQOFF :
> +	 *			read_sysreg_s(SYS_ICC_PMR_EL1);
> +	 * else
> +	 *	flags = daif_bits;
> +	 */
> +	asm volatile(ALTERNATIVE(
> +			"mov	%0, %1\n"
> +			"nop\n"
> +			"nop",
> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1) "\n"
> +			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
> +			"csel	%0, %0, %2, eq",
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (flags), "+r" (daif_bits)
> +		: "r" (GIC_PRIO_IRQOFF)
>  		: "memory");
> +
> +	return flags;
> +}

BTW, how's the code generated from the C version? It will have a branch
but may not be too bad. Either way is fine by me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
