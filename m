Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB398C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:28:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B6E2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Li6qcoO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B6E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ach6yadbRaCrWGqxrfBt/zT5c/x6cmyf39vcHoU5azg=; b=Li6qcoO3d+G78S
	b3SY8AQQXyIgN80Pge4BVaoOO4rX8O34VgkH76q0iIli1AhlVLPc/L0J8pxpYregm5wBHD98cLJt5
	uOhjvc03+XVAjq25xq5j9jOdWmV/A+wtZcOIL6YrcbIuB9ZMZ9Oi5iSzMZy4QN1GsDp6U6fgGf62j
	6zLDeeyol/EQ+TxTdyhroz2Cck5UZKE4K2Xxo/mQ3yys88N9VE4L7La1mU2ME8pH6G94P62GPnxHv
	sowv6hPTZR1ACda+dXa/oE7zHMf3WOdoqCi8Gkdv28WT2lEW+3nIOV/RRFJodbakaoEMOHfI7BRUp
	tR4ItSGrMkVAiEhVa7kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWop-0007pY-KG; Mon, 21 Jan 2019 10:28:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWom-0007p8-DM
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:28:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9880EBD;
 Mon, 21 Jan 2019 02:28:33 -0800 (PST)
Received: from [10.1.33.132] (e121487-lin.cambridge.arm.com [10.1.33.132])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A32563F5C1;
 Mon, 21 Jan 2019 02:28:32 -0800 (PST)
Subject: Re: [RESEND PATCH] ARM: NOMMU: Toggle only bits in EXC_RETURN we are
 really care of
To: linux-arm-kernel@lists.infradead.org
References: <1547477565-3327-1-git-send-email-vladimir.murzin@arm.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <f53ae2f1-d51a-922e-f88e-b435bdbc0379@arm.com>
Date: Mon, 21 Jan 2019 10:28:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547477565-3327-1-git-send-email-vladimir.murzin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_022836_462932_AD92B3AA 
X-CRM114-Status: GOOD (  19.14  )
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
Cc: sza@esh.hu, kbuild-all@01.org, alexandre.torgue@st.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Any comments?

I received zero feedback on version sent back in November, so I'm considering
that folks either do not care or there is no issue with the patch. Explicit 
ACK/NAK would be handy, meanwhile I'm planing to dropping this into Russell's
patch system later this week.

Cheers
Vladimir


On 1/14/19 2:52 PM, Vladimir Murzin wrote:
> ARMv8M introduces support for Security extension to M class, among
> other things it affects exception handling, especially, encoding of
> EXC_RETURN.
> 
> The new bits have been added:
> 
> Bit [6]	Secure or Non-secure stack
> Bit [5]	Default callee register stacking
> Bit [0]	Exception Secure
> 
> which conflicts with hard-coded value of EXC_RETURN:
> 
> In fact, we only care of few bits:
> 
> Bit [3]	 Mode (0 - Handler, 1 - Thread)
> Bit [2]	 Stack pointer selection (0 - Main, 1 - Process)
> 
> We can toggle only those bits and left other bits as they were on
> exception entry.
> 
> It is basically, what patch does - saves EXC_RETURN when we do
> transition form Thread to Handler mode (it is first svc), so later
> saved value is used instead of EXC_RET_THREADMODE_PROCESSSTACK.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
> 
> Kernel Version: v5.0-rc2
> 
>  arch/arm/include/asm/v7m.h     | 2 +-
>  arch/arm/kernel/entry-header.S | 3 ++-
>  arch/arm/kernel/entry-v7m.S    | 4 ++++
>  arch/arm/mm/proc-v7m.S         | 3 +++
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
> index 187ccf6..2cb00d1 100644
> --- a/arch/arm/include/asm/v7m.h
> +++ b/arch/arm/include/asm/v7m.h
> @@ -49,7 +49,7 @@
>   * (0 -> msp; 1 -> psp). Bits [1:0] are fixed to 0b01.
>   */
>  #define EXC_RET_STACK_MASK			0x00000004
> -#define EXC_RET_THREADMODE_PROCESSSTACK		0xfffffffd
> +#define EXC_RET_THREADMODE_PROCESSSTACK		(3 << 2)
>  
>  /* Cache related definitions */
>  
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index 7734248..62db1c9 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -127,7 +127,8 @@
>           */
>  	.macro	v7m_exception_slow_exit ret_r0
>  	cpsid	i
> -	ldr	lr, =EXC_RET_THREADMODE_PROCESSSTACK
> +	ldr	lr, =exc_ret
> +	ldr	lr, [lr]
>  
>  	@ read original r12, sp, lr, pc and xPSR
>  	add	r12, sp, #S_IP
> diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
> index abcf478..19d2dcd 100644
> --- a/arch/arm/kernel/entry-v7m.S
> +++ b/arch/arm/kernel/entry-v7m.S
> @@ -146,3 +146,7 @@ ENTRY(vector_table)
>  	.rept	CONFIG_CPU_V7M_NUM_IRQ
>  	.long	__irq_entry		@ External Interrupts
>  	.endr
> +	.align	2
> +	.globl	exc_ret
> +exc_ret:
> +	.space	4
> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> index 47a5acc..92e8418 100644
> --- a/arch/arm/mm/proc-v7m.S
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -139,6 +139,9 @@ __v7m_setup_cont:
>  	cpsie	i
>  	svc	#0
>  1:	cpsid	i
> +	ldr	r0, =exc_ret
> +	orr	lr, lr, #EXC_RET_THREADMODE_PROCESSSTACK
> +	str	lr, [r0]
>  	ldmia	sp, {r0-r3, r12}
>  	str	r5, [r12, #11 * 4]	@ restore the original SVC vector entry
>  	mov	lr, r6			@ restore LR
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
