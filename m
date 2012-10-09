From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Oct 2012 14:34:46 +0100
Subject: [PATCH v2 2/2] [media]: mx2_camera: Fix regression caused by
 clock conversion
In-Reply-To: <1349735823-30315-1-git-send-email-festevam@gmail.com>
References: <1349735823-30315-1-git-send-email-festevam@gmail.com>
Message-ID: <20121009133446.GE4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 07:37:03PM -0300, Fabio Estevam wrote:
> @@ -460,7 +462,11 @@ static int mx2_camera_add_device(struct soc_camera_device *icd)
>  	if (pcdev->icd)
>  		return -EBUSY;
>  
> -	ret = clk_prepare_enable(pcdev->clk_csi);
> +	ret = clk_prepare_enable(pcdev->clk_csi_ahb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_prepare_enable(pcdev->clk_csi_per);
>  	if (ret < 0)
>  		return ret;

>From the point of view of error cleanup, this looks buggy to me.  If
the prepare_enable for the per clock fails, what cleans up the ahb clock?
