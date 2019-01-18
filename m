Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD5CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:09:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3C220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bulSzF2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3C220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+z+v6mLj8d2pvdyFPxM0pmLbI858l6MwLoBI2/XMGqg=; b=bulSzF2vnsZ2dq
	JIPrNWDyyjX0Hc0lXq063OVzlBe0nEcmKqx1z+tylK1MRjUVc70p5+R0toIxNg5QTDctKJXQjqYxP
	1GRx08QJ476mjVaT1oDro8r4KkhSCRrYoleTCC/GljKyE6yHn8d47YulfNSgZmfqx5oicv/47TD41
	YHWF7QnH2MCBOWY+IMJULkjD3upoC4jXS0+qSB5Si5HlZr3kzsOvOv+TymQsy300/Wsjg1X2F8eqS
	m1qprEdizxWR25rk1WFc+lDVFxDtQ45Uw2Z6RxOQhaJZo90nEZmwDe6hcPMYb6qiQ57vWVtgeuPPc
	xaPo4CEYCH83RnffXLaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWi0-0001S3-Ri; Fri, 18 Jan 2019 16:09:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWhx-0001Rj-KO
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:09:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42744EBD;
 Fri, 18 Jan 2019 08:09:25 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 2FB133F557; Fri, 18 Jan 2019 08:09:23 -0800 (PST)
Date: Fri, 18 Jan 2019 16:09:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190118160920.GF118707@arrakis.emea.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_080925_679250_89220DB8 
X-CRM114-Status: GOOD (  16.59  )
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

Hi Julien,

On Tue, Jan 08, 2019 at 02:07:30PM +0000, Julien Thierry wrote:
> + * Having two ways to control interrupt status is a bit complicated. Some
> + * locations like exception entries will have PSR.I bit set by the architecture
> + * while PMR is unmasked.
> + * We need the irqflags to represent that interrupts are disabled in such cases.
> + *
> + * For this, we lower the value read from PMR when the I bit is set so it is
> + * considered as an irq masking priority. (With PMR, lower value means masking
> + * more interrupts).
> + */
> +#define _get_irqflags(daif_bits, pmr)					\
> +({									\
> +	unsigned long flags;						\
> +									\
> +	BUILD_BUG_ON(GIC_PRIO_IRQOFF < (GIC_PRIO_IRQON & ~PSR_I_BIT));	\
> +	asm volatile(ALTERNATIVE(					\
> +		"mov	%0, %1\n"					\
> +		"nop\n"							\
> +		"nop",							\
> +		"and	%0, %1, #" __stringify(PSR_I_BIT) "\n"		\
> +		"mvn	%0, %0\n"					\
> +		"and	%0, %0, %2",					\
> +		ARM64_HAS_IRQ_PRIO_MASKING)				\

Can you write the last two instructions as a single:

		bic	%0, %2, %0

> +		: "=&r" (flags)						\
> +		: "r" (daif_bits), "r" (pmr)				\
> +		: "memory");						\
> +									\
> +	flags;								\
> +})
> +
> +/*
>   * Save the current interrupt enable state.
>   */
>  static inline unsigned long arch_local_save_flags(void)
>  {
> -	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_save_flags"
> -		: "=r" (flags)
> +	unsigned long daif_bits;
> +	unsigned long pmr; // Only used if alternative is on
> +
> +	daif_bits = read_sysreg(daif);
> +
> +	// Get PMR

Nitpick: don't use C++ (or arm asm) comment style in C code.

> +	asm volatile(ALTERNATIVE(
> +			"nop",
> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1),
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (pmr)
>  		:
>  		: "memory");
> +
> +	return _get_irqflags(daif_bits, pmr);
> +}

I find this confusing spread over two inline asm statements. IIUC, you
want something like below (it could be written as inline asm but I need
to understand it first):

	daif_bits = read_sysreg(daif);

	if (system_uses_irq_prio_masking()) {
		pmr = read_gicreg(ICC_PMR_EL1);
		flags = pmr & ~(daif_bits & PSR_I_BIT);
	} else {
		flags = daif_bits;
	}

	return flags;

In the case where the interrupts are disabled at the PSR level, is the
PMR value still relevant? Could we just return the GIC_PRIO_IRQOFF?
Something like:

	flags = read_sysreg(daif);

	if (system_uses_irq_prio_masking())
		flags = flags & PSR_I_BIT ?
			GIC_PRIO_IRQOFF : read_gicreg(ICC_PMR_EL1);

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
