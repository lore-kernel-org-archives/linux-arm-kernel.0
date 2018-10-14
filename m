From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sun, 14 Oct 2018 18:03:24 +0200
Subject: [PATCH] irqchip/irq-mvebu-sei: Fix a NULL vs IS_ERR() bug in probe
In-Reply-To: <20181013102246.GD16086@mwanda>
References: <20181013102246.GD16086@mwanda>
Message-ID: <20181014180324.56e7d8d5@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

Dan Carpenter <dan.carpenter@oracle.com> wrote on Sat, 13 Oct 2018
13:22:46 +0300:

> The devm_ioremap_resource() function never returns NULL, it returns
> error pointers.
> 
> Fixes: 61ce8d8d8a81 ("irqchip/irq-mvebu-sei: Add new driver for Marvell SEI")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/irqchip/irq-mvebu-sei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
> index 566d69a2edbc..add4c9c934c8 100644
> --- a/drivers/irqchip/irq-mvebu-sei.c
> +++ b/drivers/irqchip/irq-mvebu-sei.c
> @@ -384,9 +384,9 @@ static int mvebu_sei_probe(struct platform_device *pdev)
>  
>  	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sei->base = devm_ioremap_resource(sei->dev, sei->res);
> -	if (!sei->base) {
> +	if (IS_ERR(sei->base)) {
>  		dev_err(sei->dev, "Failed to remap SEI resource\n");
> -		return -ENODEV;
> +		return PTR_ERR(sei->base);
>  	}
>  
>  	/* Retrieve the SEI capabilities with the interrupt ranges */


Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu?l
