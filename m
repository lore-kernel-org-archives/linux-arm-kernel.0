From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Dec 2013 09:20:50 +0000
Subject: [PATCH v3 11/15] mfd: menelaus: Start to use irqdomain
In-Reply-To: <1386606085-26838-11-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-11-git-send-email-balbi@ti.com>
Message-ID: <20131210092050.GT12675@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Introduce an irq_chip and irq_domain for menelaus driver. Following
> patches will convert uses to traditional request_threaded_irq().
> 
> While at that, some better error handling had to be added, so we could
> free irq descs we allocated.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++---

<snip>

> +	irq_domain_add_legacy(node, MENELAUS_NR_IRQS, irq_base, 0,
> +			&irq_domain_simple_ops, m);

When will this driver become DT compliant?

I think you should use irq_domain_add_simple() to future proof
yourself a little.

> +	m->irq_base = irq_base;
> +
> +	for (i = irq_base; i < irq_base + MENELAUS_NR_IRQS; i++) {
> +		irq_set_chip_data(i, m);
> +		irq_set_chip_and_handler(i, &menelaus_irq_chip,
> +				handle_simple_irq);
> +		irq_set_nested_thread(i, 1);
> +		set_irq_flags(i, IRQF_VALID);

This assumes that this h/w only exists on ARM platforms. Is that true?

> +	}

This is usually completed in an *_irq_map() operation call-back.

I can't see where you reverse this process either (usually *_irq_unmap())

<snip>

> -	mutex_init(&m->lock);
> -

This doesn't belong in this patch.

It should have been removed with the final use of the lock was.

<snip>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
