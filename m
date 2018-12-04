Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315D5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:36:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C4920659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yr3kqvft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C4920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yNLrYjMRAh3moyf2lIBJCISxr18sMhkydAQE0zu72x4=; b=Yr3kqvft6QtntG
	cvMNBLhQSVlVynd4U5qAdggSvojy38lYZr9jKL5dO8Ho5c/JXSluXXCJZ51srrtz/DEsTb5tIhKIG
	yiTTj1KRfHGdH1eJUXl3vaxTzBd0eqQPMeLijteh0B7oIBzHf4rr1D07Q7iTtZ4PhwV6HbEIVCqKC
	DTiv7DN0fY0RBqjqv2GPQwTRglGJ4UWZSnzG18qKt8bBh1mAqzhEdlu4t3/M+C/GYux5lYlATlNlj
	RM7MGxC1km9senGUrhkz27uatHlM+3fQBUrs9Bl3xwmr3ooYwaC3d6Ny84kPQsAg9tjiySlo4hg5G
	w2MVyn6V9GWnha+WB8pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUEcX-00081U-Gr; Tue, 04 Dec 2018 17:36:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUEcT-0007za-Vz
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:36:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36368A78;
 Tue,  4 Dec 2018 09:36:15 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 459533F59C; Tue,  4 Dec 2018 09:36:13 -0800 (PST)
Date: Tue, 4 Dec 2018 17:36:10 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 10/24] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20181204173610.GC19210@arrakis.emea.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-11-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542023835-21446-11-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_093626_035074_A1E514A4 
X-CRM114-Status: GOOD (  15.46  )
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

On Mon, Nov 12, 2018 at 11:57:01AM +0000, Julien Thierry wrote:
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..e0a32e4 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -18,7 +18,27 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <asm/alternative.h>
> +#include <asm/cpufeature.h>
>  #include <asm/ptrace.h>
> +#include <asm/sysreg.h>
> +
> +
> +/*
> + * When ICC_PMR_EL1 is used for interrupt masking, only the bit indicating
> + * whether the normal interrupts are masked is kept along with the daif
> + * flags.
> + */
> +#define ARCH_FLAG_PMR_EN 0x1
> +
> +#define MAKE_ARCH_FLAGS(daif, pmr)					\
> +	((daif) | (((pmr) >> GIC_PRIO_STATUS_SHIFT) & ARCH_FLAG_PMR_EN))
> +
> +#define ARCH_FLAGS_GET_PMR(flags)				 \
> +	((((flags) & ARCH_FLAG_PMR_EN) << GIC_PRIO_STATUS_SHIFT) \
> +		| GIC_PRIO_IRQOFF)
> +
> +#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)

I wonder whether we could just use the PSR_I_BIT here to decide whether
to set the GIC_PRIO_IRQ{ON,OFF}. We could clear the PSR_I_BIT in
_restore_daif() with an alternative.

> +/*
> + * CPU interrupt mask handling.
> + */
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

DSB needed here as well? I guess I'd have to read the GIC spec before
asking again ;).

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
