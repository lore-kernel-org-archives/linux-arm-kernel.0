From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 18 Apr 2013 16:43:43 +0200
Subject: [alsa-devel] [PATCH v4 02/10] ASoC: imx-pcm-dma: DT support
In-Reply-To: <1366288424-7660-3-git-send-email-mpa@pengutronix.de>
References: <1366288424-7660-1-git-send-email-mpa@pengutronix.de>
 <1366288424-7660-3-git-send-email-mpa@pengutronix.de>
Message-ID: <5170069F.4030200@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2013 02:33 PM, Markus Pargmann wrote:
> This patch adds the possibility to pass a of_node as platform_data which
> is used by generic-pcm-dma to request a DMA slave channel.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  sound/soc/fsl/imx-pcm-dma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
> index c246fb5..8945d22 100644
> --- a/sound/soc/fsl/imx-pcm-dma.c
> +++ b/sound/soc/fsl/imx-pcm-dma.c
> @@ -62,9 +62,11 @@ static const struct snd_dmaengine_pcm_config imx_dmaengine_pcm_config = {
>  
>  int imx_pcm_dma_init(struct platform_device *pdev)
>  {
> +	if (pdev->dev.platform_data)
> +		pdev->dev.of_node = pdev->dev.platform_data;

In my opinion it's better to use pdev->dev.parent->of_node here. In the ssi
driver you use platform_device_register_data, which will create a copy of
the of_node you pass in as platform data. I'm not quite sure how well this
will work. If you want to continue to use platform_data you should at least
change the code in the ssi driver to not make a copy of the of_node.

- Lars

> +
>  	return snd_dmaengine_pcm_register(&pdev->dev, &imx_dmaengine_pcm_config,
>  		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
> -		SND_DMAENGINE_PCM_FLAG_NO_DT |
>  		SND_DMAENGINE_PCM_FLAG_COMPAT);
>  }
>  
