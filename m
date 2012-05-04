From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 09:51:46 -0700
Subject: [PATCH] omap: dma: Clear status registers on enable/disable irq.
In-Reply-To: <1334954578-10478-1-git-send-email-oleg.matcovschi@ti.com>
References: <1334954578-10478-1-git-send-email-oleg.matcovschi@ti.com>
Message-ID: <20120504165146.GB5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Oleg Matcovschi <oleg.matcovschi@ti.com> [120420 13:49]:
> Use omap_disable_channel_irq() function instead of directly accessing CICR.
> The omap_disable_chanel_irq() function clears pending interrupts
> and disables interrupt on channel.
> Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear interrupt
> status register.

This seems like a nice fix to me. As it affects all omaps, I'd like to
see some tested-by from Janusz/Jarkko/Peter. Can you guys give it a try
with some audio tests?

Also one comment below.
 
> @@ -575,10 +573,15 @@ static inline void omap_enable_channel_irq(int lch)
>  	p->dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
>  }
>  
> -static void omap_disable_channel_irq(int lch)
> +static inline void omap_disable_channel_irq(int lch)
>  {
> -	if (cpu_class_is_omap2())
> -		p->dma_write(0, CICR, lch);
> +	/* disable channel interrupts */
> +	p->dma_write(0, CICR, lch);
> +	/* Clear CSR */
> +	if (cpu_class_is_omap1())
> +		p->dma_read(CSR, lch);
> +	else if (cpu_class_is_omap2())
> +		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
>  }

You can leave out the else if cpu_class_is_omap2 and replace it
with just else above.

Regards,

Tony 
