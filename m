From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 06 Apr 2017 11:43:34 +0200
Subject: [PATCH v6 19/39] media: Add i.MX media core driver
In-Reply-To: <1490661656-10318-20-git-send-email-steve_longerbeam@mentor.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-20-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1491471814.2392.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-03-27 at 17:40 -0700, Steve Longerbeam wrote:
> Add the core media driver for i.MX SOC.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
[...]
> diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
> new file mode 100644
> index 0000000..b383be4
> --- /dev/null
> +++ b/drivers/staging/media/imx/imx-media-of.c
> @@ -0,0 +1,267 @@
[...]
> +/*
> + * find the remote device node and remote port id (remote pad #)
> + * given local endpoint node
> + */
> +static void of_get_remote_pad(struct device_node *epnode,
> +			      struct device_node **remote_node,
> +			      int *remote_pad)
> +{
> +	struct device_node *rp, *rpp;
> +	struct device_node *remote;
> +
> +	rp = of_graph_get_remote_port(epnode);
> +	rpp = of_graph_get_remote_port_parent(epnode);
> +
> +	if (of_device_is_compatible(rpp, "fsl,imx6q-ipu")) {
> +		/* the remote is one of the CSI ports */
> +		remote = rp;
> +		*remote_pad = 0;
> +		of_node_put(rpp);
> +	} else {
> +		remote = rpp;
> +		of_property_read_u32(rp, "reg", remote_pad);

If this fails because there is no reg property, *remote_pad will keep
the previous value. It should be set to 0 in this case.

----------8<----------
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@ -85,7 +85,9 @@ static void of_get_remote_pad(struct device_node *epnode,
                of_node_put(rpp);
        } else {
                remote = rpp;
-               of_property_read_u32(rp, "reg", remote_pad);
+               /* FIXME port number and pad index are not the same */
+               if (of_property_read_u32(rp, "reg", remote_pad))
+                       *remote_pad = 0;
                of_node_put(rp);
        }
 
---------->8----------

regards
Philipp
