Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA3EC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D65B20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cqYqooc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D65B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VVuKnvxq1FJHyh6f5/vfT0OcvaWT5sKbam/Ckz68Ztk=; b=cqYqooc0CA8w/I
	x3T5gQnY/XiOiqqzcGE3lOBxLXm/R44ji5EviIAchAW2R5Z4mB/10o0jjDYXmVTc1UW0wga4u7e2D
	QBQLsC0D00sZfr8wc7CWbImjjvnttRQrzq0IZxHTOaFSaaQRHuctXmcxmiqInZ8yRCFZXuK/pI3dq
	8VWu58iwWHBukETjlH1VMYq64+368mZssbPk3grohBQxBjZd5yvcCnKXabyk/ksfzH8T9Sf0lbvga
	9YcNDqjV2iOBxMbUsxcgyDvXIRs34N9aMa9HUbOGaRbGIEomwNRsVMbI8R1pQl8BrQs1HKAPaz63m
	XzJ5niPa5xI5cRfT6Dyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUW9-0001cQ-DI; Fri, 01 Feb 2019 08:49:45 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUW6-0001bz-MW
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:49:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20B45A78;
 Fri,  1 Feb 2019 00:49:42 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE583F71E;
 Fri,  1 Feb 2019 00:49:40 -0800 (PST)
Subject: Re: [RFC PATCH 2/3] ARM: entry: Remove unneeded need_resched() loop
To: Valentin Schneider <valentin.schneider@arm.com>,
 linux-kernel@vger.kernel.org
References: <20190131182339.9835-1-valentin.schneider@arm.com>
 <20190131182339.9835-3-valentin.schneider@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <fa090a80-5579-5dac-da19-56c9a6c5c423@arm.com>
Date: Fri, 1 Feb 2019 08:49:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190131182339.9835-3-valentin.schneider@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_004942_744840_FFB14AC0 
X-CRM114-Status: GOOD (  18.04  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
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
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Cheers,

> ---
>  arch/arm/kernel/entry-armv.S | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index e85a3af9ddeb..a7ac22e09bb2 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -220,7 +220,7 @@ __irq_svc:
>  	teq	r8, #0				@ if preempt count != 0
>  	movne	r0, #0				@ force flags to 0
>  	tst	r0, #_TIF_NEED_RESCHED
> -	blne	svc_preempt
> +	blne	preempt_schedule_irq            @ irq en/disable is done inside
>  #endif
>  
>  	svc_exit r5, irq = 1			@ return from exception
> @@ -229,16 +229,6 @@ ENDPROC(__irq_svc)
>  
>  	.ltorg
>  
> -#ifdef CONFIG_PREEMPT
> -svc_preempt:
> -	mov	r8, lr
> -1:	bl	preempt_schedule_irq		@ irq en/disable is done inside
> -	ldr	r0, [tsk, #TI_FLAGS]		@ get new tasks TI_FLAGS
> -	tst	r0, #_TIF_NEED_RESCHED
> -	reteq	r8				@ go again
> -	b	1b
> -#endif
> -
>  __und_fault:
>  	@ Correct the PC such that it is pointing at the instruction
>  	@ which caused the fault.  If the faulting instruction was ARM
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
