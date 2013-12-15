From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 15 Dec 2013 18:06:01 +0530
Subject: [PATCH v6 2/6] This patch converts the davinci gpio driver to
 use irqdomain support.
In-Reply-To: <1385057731-4348-3-git-send-email-prabhakar.csengg@gmail.com>
References: <1385057731-4348-1-git-send-email-prabhakar.csengg@gmail.com>
 <1385057731-4348-3-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <52ADA231.4080603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 November 2013 11:45 PM, Prabhakar Lad wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> [grygorii.strashko at ti.com:
>  - switch to use one irq-domain per  all GPIO banks
>  - keep irq_create_mapping() call in gpio_to_irq_banked() as it
>    simply transformed to irq_find_mapping() if IRQ mapping exist
>    already]
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

A proper subject line is missing. I added the following as the subject:

gpio: davinci: convert to use irqdomain

and moved your current subject line to become the commit text.

> @@ -396,6 +411,20 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
>  	}
>  	clk_prepare_enable(clk);
>  
> +	irq = irq_alloc_descs(-1, 0, ngpio, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "Couldn't allocate IRQ numbers\n");
> +		return -ENODEV;

modified this to:

		return irq;

since your have already received a more relevant error code. With these
modifications and Linus's ack, queuing for v3.14.

Thanks,
Sekhar
