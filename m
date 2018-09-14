From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Sep 2018 13:00:29 +0300
Subject: [PATCH v2 6/8] drm/imx: support handling bridge timings bus flags
In-Reply-To: <20180912183222.25414-7-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
 <20180912183222.25414-7-stefan@agner.ch>
Message-ID: <1666767.e3BgH42IGz@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Thank you for the patch.

On Wednesday, 12 September 2018 21:32:20 EEST Stefan Agner wrote:
> A bridge might require specific settings for the pixel data on
> the bus. Copy the bus flags from the bridge timings if a bridge
> is in use.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/imx/parallel-display.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/imx/parallel-display.c
> b/drivers/gpu/drm/imx/parallel-display.c index aefd04e18f93..7798a0621df7
> 100644
> --- a/drivers/gpu/drm/imx/parallel-display.c
> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -239,6 +239,9 @@ static int imx_pd_bind(struct device *dev, struct device
> *master, void *data) if (ret && ret != -ENODEV)
>  		return ret;
> 
> +	if (imxpd->bridge && imxpd->bridge->timings)
> +		imxpd->bus_flags = imxpd->bridge->timings->input_bus_flags;

As explained in different replies in this mail thread (and in v1), we need 
something more complex than this.

How about creating a helper function that would take a sampling edge, setup 
and hold times, clock frequency and internal delay on the driving side, and 
return which edge to drive the data on ? I agree with you that the logic is 
complex, so we shouldn't duplicate it in multiple drivers. If you submit such 
a patch I'll implement support for configuring the clock edge in the R-Car DU 
driver and test it with the ADV7123.

>  	imxpd->dev = dev;
> 
>  	ret = imx_pd_register(drm, imxpd);

-- 
Regards,

Laurent Pinchart
