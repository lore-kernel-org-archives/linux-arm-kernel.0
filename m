Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71833C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:15:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406222083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hm+AG9y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406222083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lvJZEOsGlqIPlzL1SOGIKqTz53JAh1TujwQIMOGph7I=; b=hm+AG9y0C0yABk
	biEXBSMcwNIaRRjUV2vmdDGg7jswP8B3Th5KP7UDK1N5lF4U9lNXdO2QFko7HERuXNBuK0LW4posd
	BQJxHA7GUIAzbP5z1SMa9FGpZMqtQE9oK5mThmQvmw5WtcrrgzisPZ0jnXmIayy49anH/Y9UdoBWL
	AhRb4ZPWi/tV9//n1nH2iZb+sVYmfGR0OassRsvHAbAwxMi65VaEch5ZBzwc0mOmpB187AlTMwqA9
	ySTAHf1AnFbDd3pKjrXb2obssb7Gc09x70Q01dDyiUp4K20FfLfkmeb8W2Y0gcnSGONhobfGx69a5
	MpY3+CN8edSVzToD/dIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKec-0005CP-7M; Fri, 07 Dec 2018 18:15:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKeX-0004gd-Hb
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:15:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C7BBEBD;
 Fri,  7 Dec 2018 10:14:55 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 781823F5AF; Fri,  7 Dec 2018 10:14:53 -0800 (PST)
Subject: Re: [PATCH 2/3] irqchip: stm32: protect configuration registers with
 hwspinlock
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>, tglx@linutronix.de,
 jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com,
 alexandre.torgue@st.com
References: <20181113144805.1054-1-benjamin.gaignard@st.com>
 <20181113144805.1054-3-benjamin.gaignard@st.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <499e10d5-b0d4-b0a6-b2ce-2565dc8935f7@arm.com>
Date: Fri, 7 Dec 2018 18:14:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181113144805.1054-3-benjamin.gaignard@st.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_101505_685824_258336D7 
X-CRM114-Status: GOOD (  21.56  )
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
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/11/2018 14:48, Benjamin Gaignard wrote:
> If a hwspinlock is defined in device tree use it to protect
> configuration registers.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/irqchip/irq-stm32-exti.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index 0a2088e12d96..a010a2eed078 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/hwspinlock.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> @@ -20,6 +21,8 @@
>  
>  #define IRQS_PER_BANK 32
>  
> +#define HWSPINLOCK_TIMEOUT	5 /* msec */
> +
>  struct stm32_exti_bank {
>  	u32 imr_ofst;
>  	u32 emr_ofst;
> @@ -47,6 +50,7 @@ struct stm32_exti_drv_data {
>  struct stm32_exti_chip_data {
>  	struct stm32_exti_host_data *host_data;
>  	const struct stm32_exti_bank *reg_bank;
> +	struct hwspinlock *hwlock;
>  	struct raw_spinlock rlock;
>  	u32 wake_active;
>  	u32 mask_cache;
> @@ -275,25 +279,34 @@ static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
>  	struct stm32_exti_chip_data *chip_data = gc->private;
>  	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
>  	u32 rtsr, ftsr;
> -	int err;
> +	int err = 0;
>  
>  	irq_gc_lock(gc);
>  
> +	if (chip_data->hwlock)
> +		err = hwspin_lock_timeout(chip_data->hwlock,
> +					  HWSPINLOCK_TIMEOUT);
> +
> +	if (err)
> +		goto unlock;
> +
>  	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
>  	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
>  
>  	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
> -	if (err) {
> -		irq_gc_unlock(gc);
> -		return err;
> -	}
> +	if (err)
> +		goto unspinlock;
>  
>  	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
>  	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
>  
> +unspinlock:
> +	if (chip_data->hwlock)
> +		hwspin_unlock(chip_data->hwlock);
> +unlock:
>  	irq_gc_unlock(gc);
>  
> -	return 0;
> +	return err;
>  }
>  
>  static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
> @@ -670,6 +683,7 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
>  	int nr_irqs, ret, i;
>  	struct irq_chip_generic *gc;
>  	struct irq_domain *domain;
> +	struct hwspinlock *hwlock = NULL;
>  
>  	host_data = stm32_exti_host_init(drv_data, node);
>  	if (!host_data)
> @@ -692,12 +706,22 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
>  		goto out_free_domain;
>  	}
>  
> +	/* hwspinlock is optional */
> +	ret = of_hwspin_lock_get_id(node, 0);
> +	if (ret < 0) {
> +		if (ret == -EPROBE_DEFER)
> +			goto out_free_domain;

Wouldn't it make sense to probe for this before allocating the domain?

> +	} else {
> +		hwlock = hwspin_lock_request_specific(ret);
> +	}
> +
>  	for (i = 0; i < drv_data->bank_nr; i++) {
>  		const struct stm32_exti_bank *stm32_bank;
>  		struct stm32_exti_chip_data *chip_data;
>  
>  		stm32_bank = drv_data->exti_banks[i];
>  		chip_data = stm32_exti_chip_init(host_data, i, node);
> +		chip_data->hwlock = hwlock;
>  
>  		gc = irq_get_domain_generic_chip(domain, i * IRQS_PER_BANK);
>  
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
