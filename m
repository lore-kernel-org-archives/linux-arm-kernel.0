From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 3 Aug 2012 18:37:08 +0300
Subject: [PATCH v2] Visstrim SM10: Use mo_version to decide board video
 mode.
In-Reply-To: <1343995703-13578-1-git-send-email-javier.martin@vista-silicon.com>
References: <1343995703-13578-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20120803153708.GA3733@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Fri, Aug 03, 2012 at 02:08:23PM +0200, Javier Martin wrote:
> If the mother board version number is odd, emmaprp() for
> format conversion + UVC camera will be used.
> 
> Otherwise mx2_camera and m2m-deinterlacer will be registered.
> 
> For both cases Coda video codec is registered.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
> Changes since v1:
>  - Add error message to emmaprp init function.
> ---

...

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
> +	if (!(dma & DMA_MEMORY_MAP)) {
> +		pr_err("Failed to declare memory for emmaprp\n");
> +		return;

Nitpick: the 'return' is redundant here.

> +	}
> +}

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
