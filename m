From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Feb 2015 19:08:34 +0000
Subject: [PATCH 2/2] drivers/tty: pl011: read fifo size from OF if present
In-Reply-To: <1424285593-2886-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1424285593-2886-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1424285593-2886-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <20150218190834.GJ29429@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 06:53:13PM +0000, Jorge Ramirez-Ortiz wrote:
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 02016fc..23fef63 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -84,6 +84,12 @@ struct vendor_data {
>  
>  static unsigned int get_fifosize_arm(struct amba_device *dev)
>  {
> +	const void *prop;
> +
> +	prop = of_get_property(dev->dev.of_node, "fifo-size", NULL);
> +	if (prop)
> +		return of_read_ulong(prop, 1);

Use of_property_read_u32.

You will need to sanity check the result, also.

What value do you need for your platform?

Mark.

> +
>  	return amba_rev(dev) < 3 ? 16 : 32;
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
