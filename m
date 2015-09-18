From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 18 Sep 2015 14:44:32 +0300
Subject: [PATCH v2 04/23] ARM: davinci/common: Convert edma driver to
 handle one eDMA instance per driver
In-Reply-To: <1441974442-8233-5-git-send-email-peter.ujfalusi@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
 <1441974442-8233-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <55FBF920.2090204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2015 03:27 PM, Peter Ujfalusi wrote:
> +	if (irq >= 0) {
> +		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint\n",

The '\n' should not be in the format string.

> +					  dev_name(dev));
> +		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
> +				       cc);
> +		if (ret) {
> +			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
> +			return ret;
>  		}
> +	}
>  
> -		for (i = 0; i < edma_cc[j]->num_channels; i++)
> -			map_dmach_queue(j, i, info[j]->default_queue);
> +	irq = platform_get_irq_byname(pdev, "edma3_ccerrint");
> +	if (irq < 0 && node)
> +		irq = irq_of_parse_and_map(node, 2);
> +
> +	if (irq >= 0) {
> +		irq_name = devm_kasprintf(dev, GFP_KERNEL,
> +					  "%s_ccerrint\n",

Same here.

> +					  dev_name(dev));
> +		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
> +				       cc);
> +		if (ret) {
> +			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
> +			return ret;
> +		}
> +	}

-- 
P?ter
