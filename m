Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB15C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:46:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E34121726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aV9p7tvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E34121726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P7+wCZFhWJBeY2hGDPonp9ErDN2Ooy57EH1HcIWpE8g=; b=aV9p7tvQ0XNkZp
	uKwszmUywMaDAlbAzMMyd1jTRIy0ICPxSl4vk8v7D2Cix1Phr4KyO7e+8xJ4ANMi+o0lA3WTVV0iT
	D2MKFBazMQRd26vVAQObh8rirSflB89gsQFYgr4fIoFfBu6z7P+LLHRyspsxnAISxvQMmTzOkj17B
	XMoe0TjmkjfvsCb+uhAaUU9kmZfIDPTZfivot3Zqc2edCuMeUhHHhY8jnWxLP89Skaw7ZMK5GkJad
	cpy2JOAaJZXPIbEomnQ96S73O8iUINJrNxAAh7iDX0G27V92ZMM5hAawMoFmL7HddUV9RtL8YgOwc
	1nlzD3/EcOnuHbcDWaFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUT0-00014o-Ef; Fri, 01 Feb 2019 08:46:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUSx-00014H-00
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:46:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83E36A78;
 Fri,  1 Feb 2019 00:46:26 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 059613F71E;
 Fri,  1 Feb 2019 00:46:24 -0800 (PST)
Subject: Re: [RFC PATCH 1/3] arm64: entry: Remove unneeded need_resched() loop
To: Valentin Schneider <valentin.schneider@arm.com>,
 linux-kernel@vger.kernel.org
References: <20190131182339.9835-1-valentin.schneider@arm.com>
 <20190131182339.9835-2-valentin.schneider@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <d7b5db35-0906-4ac2-d51e-905790020eaf@arm.com>
Date: Fri, 1 Feb 2019 08:46:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190131182339.9835-2-valentin.schneider@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_004627_153812_14B99499 
X-CRM114-Status: GOOD (  16.92  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Julien Grall <julien.grall@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Valentin,

On 31/01/2019 18:23, Valentin Schneider wrote:
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
> 
> Reported-by: Julien Thierry <julien.thierry@arm.com>
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Julien Grall <julien.grall@arm.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

> ---
>  arch/arm64/kernel/entry.S | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 0ec0c46b2c0c..4d0c81f29a60 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -611,7 +611,7 @@ el1_irq:
>  #ifdef CONFIG_PREEMPT
>  	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
>  	cbnz	x24, 1f				// preempt count != 0
> -	bl	el1_preempt
> +	bl	preempt_schedule_irq		// irq en/disable is done inside
>  1:
>  #endif
>  #ifdef CONFIG_TRACE_IRQFLAGS
> @@ -620,15 +620,6 @@ el1_irq:
>  	kernel_exit 1
>  ENDPROC(el1_irq)
>  
> -#ifdef CONFIG_PREEMPT
> -el1_preempt:
> -	mov	x24, lr
> -1:	bl	preempt_schedule_irq		// irq en/disable is done inside
> -	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get new tasks TI_FLAGS
> -	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
> -	ret	x24
> -#endif
> -
>  /*
>   * EL0 mode handlers.
>   */
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
