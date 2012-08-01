From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 1 Aug 2012 14:02:27 +0300
Subject: [PATCH] Visstrim SM10: Use mo_version to decide board video mode.
In-Reply-To: <1343817938-21905-1-git-send-email-javier.martin@vista-silicon.com>
References: <1343817938-21905-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20120801110227.GF29843@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Wed, Aug 01, 2012 at 12:45:38PM +0200, Javier Martin wrote:
> If the mother board version number is odd, emmaprp() for
> format conversion + UVC camera will be used.
> 
> Otherwise mx2_camera and m2m-deinterlacer will be registered.
> 
> For both cases Coda video codec is registered.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---

[snip]

> @@ -442,6 +446,27 @@ static void __init visstrim_deinterlace_init(void)
>  		return;
>  }
>  
> +/* Emma-PrP for format conversion */
> +static void __init visstrim_emmaprp_init(void)
> +{
> +	struct platform_device *pdev;
> +	int dma;
> +
> +	pdev = imx27_add_mx2_emmaprp();
> +	if (IS_ERR(pdev))
> +		return;
> +
> +	/*
> +	 * Use the same memory area as the analog camera since both
> +	 * devices are, by nature, exclusive.
> +	 */
> +	dma = dma_declare_coherent_memory(&pdev->dev,
> +				mx2_camera_base, mx2_camera_base,
> +				MX2_CAMERA_BUF_SIZE,
> +				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
> +	if (!(dma & DMA_MEMORY_MAP))
> +		return;

What's the point of these two lines at the end of a void function? Maybe print 
an error?

baruch

> +}

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
