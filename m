From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 20 May 2011 15:16:42 +0200 (CEST)
Subject: [PATCH 8/9] dma IPU: rework irq handling
In-Reply-To: <1305878365-827-10-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
	<1305878365-827-10-git-send-email-s.hauer@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1105201507250.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 May 2011, Sascha Hauer wrote:
> @@ -354,48 +139,41 @@ static struct irq_chip ipu_irq_chip = {
>  /* Install the IRQ handler */
>  int __init ipu_irq_attach_irq(struct ipu *ipu, struct platform_device *dev)
>  {
> -	struct ipu_platform_data *pdata = dev->dev.platform_data;
> -	unsigned int irq, irq_base, i;
> +	unsigned int irq, irq_base;
>  
> -	irq_base = pdata->irq_base;
> +	irq_base = irq_alloc_descs(-1, 0, IPU_IRQ_NR_BANKS * 32, 0);

  	IPU_NUM_IRQS perhaps ?

> +	if (irq_base < 0)
> +		return irq_base;
  
So this allocates 160 interrupts. How many of them are actually going
to be used ?

Thanks,

	tglx
