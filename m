From: david@lechnology.com (David Lechner)
Date: Mon, 24 Oct 2016 19:53:53 -0500
Subject: [PATCH/RFT v2 16/17] USB: ohci-da8xx: Allow probing from DT
In-Reply-To: <20161024164634.4330-17-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-17-ahaslam@baylibre.com>
Message-ID: <a32c58db-d3f8-2a1b-53b3-ae78e342c5e7@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 11:46 AM, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
>
> This adds the compatible string to the ohci driver
> to be able to probe from DT
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  drivers/usb/host/ohci-da8xx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
> index bebc3f0..1a8db25 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -273,6 +273,13 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  }
>
>  /*-------------------------------------------------------------------------*/
> +#ifdef CONFIG_OF

#ifdef CONFIG_OF is probably not needed here...

> +static const struct of_device_id da8xx_ohci_ids[] = {
> +	{ .compatible = "ti,da830-ohci" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, da8xx_ohci_ids);
> +#endif
>
>  static int ohci_da8xx_probe(struct platform_device *pdev)
>  {
> @@ -421,6 +428,7 @@ static int ohci_da8xx_resume(struct platform_device *dev)
>  #endif
>  	.driver		= {
>  		.name	= "ohci",
> +		.of_match_table = da8xx_ohci_ids,

...otherwise, da8xx_ohci_ids will not be defined here

>  	},
>  };
>
>
