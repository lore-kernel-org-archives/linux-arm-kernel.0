From: balbi@ti.com (Felipe Balbi)
Date: Fri, 28 Sep 2012 16:02:41 +0300
Subject: [PATCH 6/6] usb: dwc3: core: add dt support for dwc3 core
In-Reply-To: <1348836795-4783-7-git-send-email-kishon@ti.com>
References: <1348836795-4783-1-git-send-email-kishon@ti.com>
 <1348836795-4783-7-git-send-email-kishon@ti.com>
Message-ID: <20120928130240.GN31006@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 06:23:15PM +0530, Kishon Vijay Abraham I wrote:
> Added dwc3 support for dwc3 core and update the documentation with
> device tree binding information.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt |   24 ++++++++++++++++++++++++
>  drivers/usb/dwc3/core.c                        |   14 ++++++++++++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/dwc3.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> new file mode 100644
> index 0000000..87d5eeb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -0,0 +1,24 @@
> +SYNOPSIS DWC3 CORE
> +
> +DWC3- USB3 CONTROLLER
> +
> +Required properties:
> + - compatible: Should be "synopsis,dwc3"

"synopsys" and I think:

- compatible: Must be "synopsys,dwc3" reads a bit better.

> + - reg : Address and length of the register set for the device
> + - interrupts: Interrupts used by the dwc3 controller.
> + - interrupt-parent: the phandle for the interrupt controller that
> +   services interrupts for this device.
> +
> +Optional properties:
> + - tx-fifo-resize: determines if the fifo spaces can be reallocated according
> + to use-cases.

actually, this should read: "determines if the FIFO *has* to be
reallocated.

On OMAP5 ES1 the default value is not good enough and we _must_
reallocate FIFO sizes.

> +This is usually a subnode to DWC3 glue to which it is connected.
> +
> +dwc3 at 4a030000 {
> +	compatible = "synopsis,dwc3";

"synopsys"

> +	reg = <0x4a030000 0xcfff>;
> +	interrupts = <0 92 4>
> +	interrupt-parent = <&gic>
> +	tx-fifo-resize;
> +};
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 08a5738..0c17a7a 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -484,8 +484,7 @@ static int __devinit dwc3_probe(struct platform_device *pdev)
>  	else
>  		dwc->maximum_speed = DWC3_DCFG_SUPERSPEED;
>  
> -	if (of_get_property(node, "tx-fifo-resize", NULL))
> -		dwc->needs_fifo_resize = true;
> +	dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
>  
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
> @@ -602,11 +601,22 @@ static int __devexit dwc3_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_dwc3_matach[] = {
> +	{
> +		.compatible = "synopsis,dwc3"

"synopsys"

> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_dwc3_matach);
> +#endif
> +
>  static struct platform_driver dwc3_driver = {
>  	.probe		= dwc3_probe,
>  	.remove		= __devexit_p(dwc3_remove),
>  	.driver		= {
>  		.name	= "dwc3",
> +		.of_match_table	= of_match_ptr(of_dwc3_matach),
>  	},
>  };
>  
> -- 
> 1.7.10.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120928/464e635c/attachment-0001.sig>
