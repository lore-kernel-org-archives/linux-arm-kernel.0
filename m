From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 4 Feb 2015 21:17:17 +0800
Subject: [patch] irqchip: mtk-sysirq: fix an error code
In-Reply-To: <20150130082847.GB21357@mwanda>
References: <20150130082847.GB21357@mwanda>
Message-ID: <1423055837.31210.29.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-01-30 at 11:28 +0300, Dan Carpenter wrote:
> "chip_data->intpol_base" used to be an ERR_PTR() but we recently changed
> it to be NULL.  We need to update the error code as well because
> "PTR_ERR(NULL)" means success where really we want to return -ENOMEM.
> 
> Fixes: cdb647a772e9 ('irqchip: mtk-sysirq: Get irq number from register resource size')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> index eaf0a71..22eb34c 100644
> --- a/drivers/irqchip/irq-mtk-sysirq.c
> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> @@ -144,7 +144,7 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
>  	chip_data->intpol_base = ioremap(res.start, size);
>  	if (!chip_data->intpol_base) {
>  		pr_err("mtk_sysirq: unable to map sysirq register\n");
> -		ret = PTR_ERR(chip_data->intpol_base);
> +		ret = -ENOMEM;
>  		goto out_free;
>  	}
>  

Dan,

Thanks for catching this.
Acked-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

I changed to use ioremap(), and remember to change the null pointer
check but not the return type. Sorry for the mistake.

Joe.C
