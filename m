From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 1 Oct 2014 09:48:31 -0400
Subject: soc: ti: add Keystone Navigator DMA support
In-Reply-To: <20141001080549.GA12488@mwanda>
References: <20141001080549.GA12488@mwanda>
Message-ID: <542C062F.5070900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 October 2014 04:05 AM, Dan Carpenter wrote:
> Hello Santosh Shilimkar,
> 
> The patch 88139ed03058: "soc: ti: add Keystone Navigator DMA support"
> from Mar 30, 2014, leads to the following static checker warning:
> 
> 	drivers/soc/ti/knav_dma.c:402 of_channel_match_helper()
> 	warn: unsigned 'args.args[0]' is never less than zero.
> 
> drivers/soc/ti/knav_dma.c
>    378  static int of_channel_match_helper(struct device_node *np, const char *name,
>    379                                          const char **dma_instance)
>    380  {
>    381          struct of_phandle_args args;
>    382          struct device_node *dma_node;
>    383          int index;
>    384  
>    385          dma_node = of_parse_phandle(np, "ti,navigator-dmas", 0);
>    386          if (!dma_node)
>    387                  return -ENODEV;
>    388  
>    389          *dma_instance = dma_node->name;
>    390          index = of_property_match_string(np, "ti,navigator-dma-names", name);
>    391          if (index < 0) {
>    392                  dev_err(kdev->dev, "No 'ti,navigator-dma-names' propery\n");
>    393                  return -ENODEV;
>    394          }
>    395  
>    396          if (of_parse_phandle_with_fixed_args(np, "ti,navigator-dmas",
>    397                                          1, index, &args)) {
>    398                  dev_err(kdev->dev, "Missing the pahndle args name %s\n", name);
>    399                  return -ENODEV;
>    400          }
>    401  
>    402          if (args.args[0] < 0) {
>                     ^^^^^^^^^^^^^^^^
> I don't know what was intended here.
> 
The check was to avoid missing phandle parameters. I will fix it up.
Thanks for reporting.

Regards,
Santosh
