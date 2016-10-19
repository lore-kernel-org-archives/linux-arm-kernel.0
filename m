From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Oct 2016 09:09:10 +0200
Subject: [PATCH] Revert "gpio/mvebu: convert to use
 irq_domain_add_simple()"
In-Reply-To: <1476831396-24359-1-git-send-email-jgunthorpe@obsidianresearch.com>
 (Jason Gunthorpe's message of "Tue, 18 Oct 2016 16:56:36 -0600")
References: <1476831396-24359-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <871szcerxl.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,
 
 On mer., oct. 19 2016, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:

> This reverts commit ce931f571b6dcf8534e8740e8cd16565cf362536.
>
> The only difference betwen _simple and _legacy is that _simple
> calls irq_alloc_descs, however mvebu_gpio_probe already called
> irq_alloc_descs a few lines above.

And what about removing the irq_alloc_descs ?

Going back to use the _legacy version seems wrong for me.

Gregory

>
> This fixes these kernel error messages from the double call
> to irq_alloc_descs:
>
>  irq: Cannot allocate irq_descs @ IRQ34, assuming pre-allocated
>  irq: Cannot allocate irq_descs @ IRQ66, assuming pre-allocated
>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: ce931f571b6d ("gpio/mvebu: convert to use irq_domain_add_simple()")
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/gpio/gpio-mvebu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index cd5dc27320a2..2e0c8d8b7792 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -807,8 +807,8 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
>  			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
>  
>  	/* Setup irq domain on top of the generic chip. */
> -	mvchip->domain = irq_domain_add_simple(np, mvchip->chip.ngpio,
> -					       mvchip->irqbase,
> +	mvchip->domain = irq_domain_add_legacy(np, mvchip->chip.ngpio,
> +					       mvchip->irqbase, 0,
>  					       &irq_domain_simple_ops,
>  					       mvchip);
>  	if (!mvchip->domain) {
> -- 
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
