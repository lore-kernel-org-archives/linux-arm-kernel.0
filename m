From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu, 6 Apr 2017 16:51:08 -0700
Subject: [PATCH v6 19/39] media: Add i.MX media core driver
In-Reply-To: <1491471814.2392.11.camel@pengutronix.de>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-20-git-send-email-steve_longerbeam@mentor.com>
 <1491471814.2392.11.camel@pengutronix.de>
Message-ID: <fafcad5e-1717-cd85-6763-b52e242ea2f1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/06/2017 02:43 AM, Philipp Zabel wrote:
> On Mon, 2017-03-27 at 17:40 -0700, Steve Longerbeam wrote:
>> Add the core media driver for i.MX SOC.
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> [...]
>> diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
>> new file mode 100644
>> index 0000000..b383be4
>> --- /dev/null
>> +++ b/drivers/staging/media/imx/imx-media-of.c
>> @@ -0,0 +1,267 @@
> [...]
>> +/*
>> + * find the remote device node and remote port id (remote pad #)
>> + * given local endpoint node
>> + */
>> +static void of_get_remote_pad(struct device_node *epnode,
>> +			      struct device_node **remote_node,
>> +			      int *remote_pad)
>> +{
>> +	struct device_node *rp, *rpp;
>> +	struct device_node *remote;
>> +
>> +	rp = of_graph_get_remote_port(epnode);
>> +	rpp = of_graph_get_remote_port_parent(epnode);
>> +
>> +	if (of_device_is_compatible(rpp, "fsl,imx6q-ipu")) {
>> +		/* the remote is one of the CSI ports */
>> +		remote = rp;
>> +		*remote_pad = 0;
>> +		of_node_put(rpp);
>> +	} else {
>> +		remote = rpp;
>> +		of_property_read_u32(rp, "reg", remote_pad);
>
> If this fails because there is no reg property, *remote_pad will keep
> the previous value. It should be set to 0 in this case.

Ok, I will apply this change.

Steve

>
> ----------8<----------
> --- a/drivers/staging/media/imx/imx-media-of.c
> +++ b/drivers/staging/media/imx/imx-media-of.c
> @@ -85,7 +85,9 @@ static void of_get_remote_pad(struct device_node *epnode,
>                 of_node_put(rpp);
>         } else {
>                 remote = rpp;
> -               of_property_read_u32(rp, "reg", remote_pad);
> +               /* FIXME port number and pad index are not the same */
> +               if (of_property_read_u32(rp, "reg", remote_pad))
> +                       *remote_pad = 0;
>                 of_node_put(rp);
>         }
>
> ---------->8----------
>
> regards
> Philipp
>
