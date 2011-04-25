From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 25 Apr 2011 12:20:33 +0530
Subject: davinci: Use generic irq chip
In-Reply-To: <20110416211307.686087239@linutronix.de>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.686087239@linutronix.de>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CAE2FAB@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Sun, Apr 17, 2011 at 02:44:08, Thomas Gleixner wrote:
> Simple conversion which simply uses the fact that the second irq chip
> base address has offset 0x04 to the first one.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Boot tested it on a DM365 EVM.

Tested-by: Sekhar Nori <nsekhar@ti.com>

> @@ -152,13 +103,8 @@ void __init davinci_irq_init(void)
>  		davinci_irq_writel(pri, i);
>  	}
>  
> -	/* set up genirq dispatch for ARM INTC */
> -	for (i = 0; i < davinci_soc_info.intc_irq_num; i++) {
> -		irq_set_chip(i, &davinci_irq_chip_0);
> -		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
> -		if (i != IRQ_TINT1_TINT34)
> -			irq_set_handler(i, handle_edge_irq);
> -		else
> -			irq_set_handler(i, handle_level_irq);
> -	}
> +	for (i = 0, j= 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
                   ^
There is a space needed before the '=' as pointed by checkpatch.

Thanks,
Sekhar
