From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Mon, 08 Oct 2012 12:04:24 +0200
Subject: [PATCH 2/2] [media]: mx2_camera: Fix regression caused by clock
 conversion
In-Reply-To: <1349473981-15084-1-git-send-email-fabio.estevam@freescale.com>
References: <1349473981-15084-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <5072A528.8010605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 10/05/2012 11:53 PM, Fabio Estevam wrote:
> Since mx27 transitioned to the commmon clock framework in 3.5, the correct way
> to acquire the csi clock is to get csi_ahb and csi_per clocks separately.
>
> By not doing so the camera sensor does not probe correctly:
>
> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
> mx2-camera mx2-camera.0: Camera driver attached to camera 0
> ov2640 0-0030: Product ID error fb:fb
> mx2-camera mx2-camera.0: Camera driver detached from camera 0
> mx2-camera mx2-camera.0: MX2 Camera (CSI) driver probed, clock frequency: 66500000
>
> Adapt the mx2_camera driver to the new clock framework and make it functional
> again.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>   drivers/media/platform/soc_camera/mx2_camera.c |   42 ++++++++++++++++--------
>   1 file changed, 29 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/media/platform/soc_camera/mx2_camera.c b/drivers/media/platform/soc_camera/mx2_camera.c
> index 0c0dd74..2c67969 100644
> --- a/drivers/media/platform/soc_camera/mx2_camera.c
> +++ b/drivers/media/platform/soc_camera/mx2_camera.c
> @@ -272,8 +272,9 @@ struct mx2_camera_dev {
>   	struct device		*dev;
>   	struct soc_camera_host	soc_host;
>   	struct soc_camera_device *icd;
> -	struct clk		*clk_csi, *clk_emma_ahb, *clk_emma_ipg;
> -
> +	struct clk		*clk_emma_ahb, *clk_emma_ipg;
> +	struct clk		*clk_csi_ahb, *clk_csi_per;
> +
>   	unsigned int		irq_csi, irq_emma;
>   	void __iomem		*base_csi, *base_emma;
>   	unsigned long		base_dma;
> @@ -435,7 +436,8 @@ static void mx2_camera_deactivate(struct mx2_camera_dev *pcdev)
>   {
>   	unsigned long flags;
>
> -	clk_disable_unprepare(pcdev->clk_csi);
> +	clk_disable_unprepare(pcdev->clk_csi_ahb);
> +	clk_disable_unprepare(pcdev->clk_csi_per);
>   	writel(0, pcdev->base_csi + CSICR1);
>   	if (cpu_is_mx27()) {
>   		writel(0, pcdev->base_emma + PRP_CNTL);
> @@ -463,7 +465,11 @@ static int mx2_camera_add_device(struct soc_camera_device *icd)
>   	if (pcdev->icd)
>   		return -EBUSY;
>
> -	ret = clk_prepare_enable(pcdev->clk_csi);
> +	ret = clk_prepare_enable(pcdev->clk_csi_ahb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_prepare_enable(pcdev->clk_csi_per);
>   	if (ret < 0)
>   		return ret;
>
> @@ -1736,13 +1742,21 @@ static int __devinit mx2_camera_probe(struct platform_device *pdev)
>   		goto exit;
>   	}
>
> -	pcdev->clk_csi = clk_get(&pdev->dev, "ahb");
> -	if (IS_ERR(pcdev->clk_csi)) {
> -		dev_err(&pdev->dev, "Could not get csi clock\n");
> -		err = PTR_ERR(pcdev->clk_csi);
> +	pcdev->clk_csi_ahb = clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(pcdev->clk_csi_ahb)) {
> +		dev_err(&pdev->dev, "Could not get csi ahb clock\n");
> +		err = PTR_ERR(pcdev->clk_csi_ahb);
>   		goto exit_kfree;
>   	}
>
> +	pcdev->clk_csi_per = clk_get(&pdev->dev, "per");
> +	if (IS_ERR(pcdev->clk_csi_per)) {
> +		dev_err(&pdev->dev, "Could not get csi per clock\n");
> +		err = PTR_ERR(pcdev->clk_csi_per);
> +		goto exit_kfree;
> +	}
> +
> +
>   	pcdev->res_csi = res_csi;
>   	pcdev->pdata = pdev->dev.platform_data;
>   	if (pcdev->pdata) {
> @@ -1750,12 +1764,12 @@ static int __devinit mx2_camera_probe(struct platform_device *pdev)
>
>   		pcdev->platform_flags = pcdev->pdata->flags;
>
> -		rate = clk_round_rate(pcdev->clk_csi, pcdev->pdata->clk * 2);
> +		rate = clk_round_rate(pcdev->clk_csi_per, pcdev->pdata->clk * 2);
>   		if (rate <= 0) {
>   			err = -ENODEV;
>   			goto exit_dma_free;
>   		}
> -		err = clk_set_rate(pcdev->clk_csi, rate);
> +		err = clk_set_rate(pcdev->clk_csi_per, rate);
>   		if (err < 0)
>   			goto exit_dma_free;
>   	}
> @@ -1827,7 +1841,7 @@ static int __devinit mx2_camera_probe(struct platform_device *pdev)
>   		goto exit_free_emma;
>
>   	dev_info(&pdev->dev, "MX2 Camera (CSI) driver probed, clock frequency: %ld\n",
> -			clk_get_rate(pcdev->clk_csi));
> +			clk_get_rate(pcdev->clk_csi_per));
>
>   	return 0;
>
> @@ -1851,7 +1865,8 @@ exit_iounmap:
>   exit_release:
>   	release_mem_region(res_csi->start, resource_size(res_csi));
>   exit_dma_free:
> -	clk_put(pcdev->clk_csi);
> +	clk_put(pcdev->clk_csi_per);
> +	clk_put(pcdev->clk_csi_ahb);
>   exit_kfree:
>   	kfree(pcdev);
>   exit:
> @@ -1865,7 +1880,8 @@ static int __devexit mx2_camera_remove(struct platform_device *pdev)
>   			struct mx2_camera_dev, soc_host);
>   	struct resource *res;
>
> -	clk_put(pcdev->clk_csi);
> +	clk_put(pcdev->clk_csi_per);
> +	clk_put(pcdev->clk_csi_ahb);
>   	if (cpu_is_mx25())
>   		free_irq(pcdev->irq_csi, pcdev);
>   	if (cpu_is_mx27())
>

This patch does not apply on linux-next-20121008. I suppose that 
linux-media development branch is needed. How can I put linux-media 
branch on top of linux-next using git ?
Is the linux-media branch is always compatible with linux-next ?
Thanks a lot,
Ga?tan Carlier.
