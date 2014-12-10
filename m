From: b.galvani@gmail.com (Beniamino Galvani)
Date: Wed, 10 Dec 2014 13:14:43 +0100
Subject: [PATCH v2] irqchip: mediatek: Use IS_ERR() instead of NULL
 pointer check
In-Reply-To: <1418205302-22531-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1418050989-21411-1-git-send-email-yingjoe.chen@mediatek.com>
 <1418205302-22531-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <20141210121442.GA14485@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 05:55:02PM +0800, Yingjoe Chen wrote:
> Beniamino reported a kernel oops caused by an invalid DT file for the
> mediatek interrupt polarity extension.
> 
> The reason is that the interrupt polarity support for mediatek chips
> merely checks for NULL pointer instead of a casted error return
> value in mtk_sysirq_of_init() so any other casted error value passes
> the NULL pointer check and causes a kernel panic when dereferenced.
> 
> Use IS_ERR() and return the error value via PTR_ERR().
> 
> Reported-and-tested-by: Beniamino Galvani <b.galvani@gmail.com>

Well, actually I only reported the bug and didn't do any test. Can the
"-and-tested" portion of the tag be dropped while applying the patch?

Beniamino

> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  drivers/irqchip/irq-mtk-sysirq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> index 7e342df..0b0d2c0 100644
> --- a/drivers/irqchip/irq-mtk-sysirq.c
> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> @@ -137,9 +137,9 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
>  		return -ENOMEM;
>  
>  	chip_data->intpol_base = of_io_request_and_map(node, 0, "intpol");
> -	if (!chip_data->intpol_base) {
> +	if (IS_ERR(chip_data->intpol_base)) {
>  		pr_err("mtk_sysirq: unable to map sysirq register\n");
> -		ret = -ENOMEM;
> +		ret = PTR_ERR(chip_data->intpol_base);
>  		goto out_free;
>  	}
>  
> -- 
> 1.8.1.1.dirty
> 
