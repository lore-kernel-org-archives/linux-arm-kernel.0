From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 5 Jan 2016 14:18:12 +0100
Subject: [Regression] No display on i.MX53 after update to 4.4-rc4
In-Reply-To: <1451935417.3884.49.camel@pengutronix.de>
References: <5674149C.90206@parkeon.com>
 <1451935417.3884.49.camel@pengutronix.de>
Message-ID: <568BC294.5020503@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 04/01/16 20:23, Philipp Zabel wrote:
> Hi Martin,
>
> Am Freitag, den 18.12.2015, 15:13 +0100 schrieb Martin Fuzzey:
>> should ipu_add_client_devices() not bail out if one node is missing?
> The ports are marked as optional in the binding docs, so the driver
> should not bail out if they are not present. How about this patch:
>
> -----8<-----
>  From d82649ac3bde511eb5977beb1080f0c6c78e391a Mon Sep 17 00:00:00 2001
> From: Philipp Zabel <p.zabel@pengutronix.de>
> Subject: [PATCH] gpu: ipu-v3: Do not bail out on missing optional port nodes
>
> The port nodes are documented as optional, treat them accordingly.
>
> Reported-by: Martin Fuzzey <mfuzzey@parkeon.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Fixes: 304e6be652e2 ("gpu: ipu-v3: Assign of_node of child platform devices to corresponding ports")
> ---
>   drivers/gpu/ipu-v3/ipu-common.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
> index 8ba367b..2093de2 100644
> --- a/drivers/gpu/ipu-v3/ipu-common.c
> +++ b/drivers/gpu/ipu-v3/ipu-common.c
> @@ -1094,10 +1094,11 @@ static int ipu_add_client_devices(struct ipu_soc *ipu, unsigned long ipu_base)
>   		/* Associate subdevice with the corresponding port node */
>   		pdev->dev.of_node = of_graph_get_port_by_id(dev->of_node, i);
>   		if (i < 4 && !pdev->dev.of_node) {
> -			dev_err(dev, "missing port@%d node in %s\n", i,
> -				dev->of_node->full_name);
> -			ret = -ENODEV;
> -			goto err_register;
> +			dev_info(dev,
> +				 "no port@%d node in %s, not using %s%d\n",
> +				 i, dev->of_node->full_name,
> +				 (i / 2) ? "DI" : "CSI", i % 2);
> +			continue;
>   		}
>   
>   		ret = platform_device_add_data(pdev, &reg->pdata,
> ----->8-----

It doesn't apply as is to current mainline (the i < 4 condition doesn't 
exist there).

But manually applying it works fine.

Thank you.

Martin
