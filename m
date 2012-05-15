From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 May 2012 17:29:14 +0900
Subject: [PATCH 10/20] of/irq: fix interrupt parent lookup procedure
In-Reply-To: <1335813270-13083-11-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
 <1335813270-13083-11-git-send-email-thomas.abraham@linaro.org>
Message-ID: <07f801cd3274$cfbe4200$6f3ac600$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> The interrupt parent lookup fails for a node that is a interrupt-controller
> but does not have an explict interrupt-parent property and instead inherits
> this property from the root node.
> 
> Consider the nodes listed below.
> 
>     / {
>         interrupt-parent = <&intc_level1>;
> 
>         intc_level1: interrupt-controller at xxx {
>                 interrupt-controller;
>                 #interrupt-cells = <3>;
>                 <rest of the properties here>;
>         };
> 
>         intc_level2: interrupt-controller at yyy {
>                 interrupt-controller;
>                 #interrupt-cells = <2>;
>                 <rest of the properties here>;
>         };
>     };
> 
> The interrupt parent lookup for interrupt-controller at yyy fails. It inherits
> the interrupt-parent property from the root node and the root node ('/')
> specifies a 'interrupt-parent' property which represents the default interrupt
> root controller. But, the property '#interrupt-cells' might not be specified
> in the root node.
> 
> In case a interrupt controller node does not include a 'interrupt-parent'
> property but inherits that property from the root node, the check for
> 'interrupt-cells' property in the root node fails. Fix this removing the
> check for 'interrupt-cells' property.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/of/irq.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 9cf0060..a520363 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -66,14 +66,16 @@ struct device_node *of_irq_find_parent(struct device_node *child)
>  		if (parp == NULL)
>  			p = of_get_parent(child);
>  		else {
> +			of_node_put(child);
>  			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
>  				p = of_node_get(of_irq_dflt_pic);
>  			else
>  				p = of_find_node_by_phandle(be32_to_cpup(parp));
> +			return p;
>  		}
>  		of_node_put(child);
>  		child = p;
> -	} while (p && of_get_property(p, "#interrupt-cells", NULL) == NULL);
> +	} while (p);
> 
>  	return p;
>  }
> --
> 1.7.5.4

Hi Grant and Rob,

I'm ok on this and this patch and #11 patch in this series are required for patches that add device tree based support for wakeup
interrupts on EXYNOS5250.

So could you have a look at this patch and let us know if this is okay or any rework is required.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
