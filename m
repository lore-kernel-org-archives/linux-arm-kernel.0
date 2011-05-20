From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 20 May 2011 14:52:28 +0200 (CEST)
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <1305878365-827-3-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
	<1305878365-827-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1105201451160.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 May 2011, Sascha Hauer wrote:
> @@ -500,7 +500,17 @@ int wm8350_irq_init(struct wm8350 *wm8350, int irq,
>  
>  	mutex_init(&wm8350->irq_lock);
>  	wm8350->chip_irq = irq;
> -	wm8350->irq_base = pdata->irq_base;

Keeping this line would save you the else path :)

> +
> +	if (!pdata->irq_base) {
> +		wm8350->irq_base = irq_alloc_descs(-1, 0, ARRAY_SIZE(wm8350_irqs), 0);
> +		if (wm8350->irq_base < 0) {
> +			dev_warn(wm8350->dev, "Allocating irqs failed with %d\n",
> +				wm8350->irq_base);
> +			return 0;

  Hmm, return 0 on failure ?

> +		}
> +	} else {
> +		wm8350->irq_base = pdata->irq_base;
> +	}
>  
>  	if (pdata->irq_high) {
>  		flags |= IRQF_TRIGGER_HIGH;
> -- 
> 1.7.4.1
> 
> 
