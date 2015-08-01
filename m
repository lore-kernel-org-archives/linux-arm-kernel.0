From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sat, 01 Aug 2015 12:11:47 +0300
Subject: [PATCH] media: atmel-isi: parse the DT parameters for vsync/hsync
 polarity
In-Reply-To: <1438338812-22329-1-git-send-email-josh.wu@atmel.com>
References: <1438338812-22329-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1896672.nsMcFlgNH5@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

Thank you for the patch.

On Friday 31 July 2015 18:33:32 Josh Wu wrote:
> This patch will get the DT parameters of vsync/hsync polarity, and pass to
> the platform data.
> 
> Also add a debug information for test purpose.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> 
>  drivers/media/platform/soc_camera/atmel-isi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/media/platform/soc_camera/atmel-isi.c
> b/drivers/media/platform/soc_camera/atmel-isi.c index fe9247a..a7de55c
> 100644
> --- a/drivers/media/platform/soc_camera/atmel-isi.c
> +++ b/drivers/media/platform/soc_camera/atmel-isi.c
> @@ -811,6 +811,11 @@ static int isi_camera_set_bus_param(struct
> soc_camera_device *icd) if (common_flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
>  		cfg1 |= ISI_CFG1_PIXCLK_POL_ACTIVE_FALLING;
> 
> +	dev_dbg(icd->parent, "vsync is active %s, hsyc is active %s, pix clock is
> sampling %s\n",

s/hsyc/hsync/

I'd write it as "vsync active %s, hsync active %s, sampling on pix clock %s 
edge\n" with "falling" and "rising" instead of "fall" and "rise".

> +		common_flags & V4L2_MBUS_VSYNC_ACTIVE_LOW ? "low" : "high",
> +		common_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW ? "low" : "high",
> +		common_flags & V4L2_MBUS_PCLK_SAMPLE_FALLING ? "fall" : "rise");
> +
>  	if (isi->pdata.has_emb_sync)
>  		cfg1 |= ISI_CFG1_EMB_SYNC;
>  	if (isi->pdata.full_mode)
> @@ -898,6 +903,11 @@ static int atmel_isi_probe_dt(struct atmel_isi *isi,
>  		goto err_probe_dt;
>  	}
> 
> +	if (ep.bus.parallel.flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
> +		isi->pdata.hsync_act_low = true;
> +	if (ep.bus.parallel.flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
> +		isi->pdata.vsync_act_low = true;

While you're at it, how about setting has_emb_sync based on ep.bus_type and 
pclk_act_falling from flags & V4L2_MBUS_PCLK_SAMPLE_FALLING ?

>  err_probe_dt:
>  	of_node_put(np);

-- 
Regards,

Laurent Pinchart
