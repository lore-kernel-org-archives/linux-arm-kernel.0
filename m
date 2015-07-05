From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 5 Jul 2015 12:15:46 +0530
Subject: [PATCH v2 6/9] arm: twr-k70f120m: extend Freescale eDMA driver
 with the ability to support Kinetis SoC
In-Reply-To: <1435667250-28299-7-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-7-git-send-email-pawelo@king.net.pl>
Message-ID: <20150705064546.GY3246@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 02:27:27PM +0200, Paul Osmialowski wrote:
The patch title is not per subsystem semantics, pls fix that

> Surprisingly small amount of work was required in order to extend already
> existing eDMA driver with the support for Kinetis SoC architecture.
And this doesn't tell me the stuff you added/removed/fixed in current driver
to extend to Kinetis. Our changelog should tell what changed and why

Btw is this patch dependent upon the rest of the series?

>  
>  static int
> -fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
> +fsl_edma_irq_init(struct platform_device *pdev,
> +		  struct fsl_edma_engine *fsl_edma)
please keep style changes in a separate patch

>  {
> +	struct device_node *np = pdev->dev.of_node;
> +	int irq, errirq;
>  	int ret;
>  
> -	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
> -	if (fsl_edma->txirq < 0) {
> -		dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
> -		return fsl_edma->txirq;
> -	}
> -
> -	fsl_edma->errirq = platform_get_irq_byname(pdev, "edma-err");
> -	if (fsl_edma->errirq < 0) {
> +	errirq = platform_get_irq_byname(pdev, "edma-err");
> +	if (errirq < 0) {
>  		dev_err(&pdev->dev, "Can't get edma-err irq.\n");
> -		return fsl_edma->errirq;
> +		return irq;
shouldn't this be errirq

>  	}
>  
> -	if (fsl_edma->txirq == fsl_edma->errirq) {
> -		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
> -				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Can't register eDMA IRQ.\n");
> -			 return  ret;
> +	if (fsl_edma->kinetis) {
> +		int i;
> +		int irqs = of_irq_count(np);
> +
> +		if (irqs <= 1) {
> +			dev_err(&pdev->dev, "Wrong eDMA irq count %d\n", irqs);
> +			return -EINVAL;
why not return irqs?

>  		}
> -	} else {
> -		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
> +
> +		for (i = 0; i < (irqs - 1); i++) {
> +			char irq_name[32];
> +
> +			sprintf(irq_name, "edma-tx-%d,%d", i, 16 + i);
> +			irq = platform_get_irq_byname(pdev, irq_name);
> +			if (irq < 0) {
> +				dev_err(&pdev->dev, "Can't get %s irq.\n",
> +							irq_name);
> +				return irq;
> +			}
> +
> +			ret = devm_request_irq(&pdev->dev, irq,
>  				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Can't register eDMA tx IRQ.\n");
> -			return  ret;
> +			if (ret) {
> +				dev_err(&pdev->dev, "Can't register %s IRQ.\n",
> +							irq_name);
> +				return  ret;
> +			}
>  		}
>  
> -		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
> -				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
> +		ret = devm_request_irq(&pdev->dev, errirq,
> +			fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
>  		if (ret) {
>  			dev_err(&pdev->dev, "Can't register eDMA err IRQ.\n");
> -			return  ret;
> +		return  ret;
> +		}
> +	} else {
> +		irq = platform_get_irq_byname(pdev, "edma-tx");
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
> +			return irq;
> +		}
> +
> +		if (irq == errirq) {
> +			ret = devm_request_irq(&pdev->dev, irq,
> +				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +						"Can't register eDMA IRQ.\n");
> +				return  ret;
> +			}
> +		} else {
> +			ret = devm_request_irq(&pdev->dev, irq,
> +				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +					    "Can't register eDMA tx IRQ.\n");
> +				return  ret;
> +			}
> +
> +			ret = devm_request_irq(&pdev->dev, errirq,
> +				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +					    "Can't register eDMA err IRQ.\n");
> +				return  ret;
> +			}
>  		}
>  	}
Okay here we have a bunch of changes without explanation on why these are
required and what are they supposed to do. So it is kind of very difficult to
review!

So please split these up in sequence of patches where each patch does only
ONE thing with right changelog messages

Thanks

-- 
~Vinod
