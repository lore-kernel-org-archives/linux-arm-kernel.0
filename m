From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 5 Sep 2011 11:20:35 +0200
Subject: [PATCH v2 2/3] dmaengine: imx-sdma: sdma_get_firmware does not
	need to copy fw_name
In-Reply-To: <1310723066-567-3-git-send-email-shawn.guo@linaro.org>
References: <1310723066-567-1-git-send-email-shawn.guo@linaro.org>
	<1310723066-567-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110905092035.GC19678@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 05:44:25PM +0800, Shawn Guo wrote:
> It does not need to allocate space and copy fw_name in function
> sdma_get_firmware().
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
(appointed to act for Sascha who is on vacation)

Thanks
Uwe

> ---
>  drivers/dma/imx-sdma.c |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 4a7aa72..6b839a2 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1125,22 +1125,14 @@ static int __init sdma_get_firmware(struct sdma_engine *sdma,
>  		const char *fw_name)
>  {
>  	const struct firmware *fw;
> -	char *fwname;
>  	const struct sdma_firmware_header *header;
>  	int ret;
>  	const struct sdma_script_start_addrs *addr;
>  	unsigned short *ram_code;
>  
> -	fwname = kasprintf(GFP_KERNEL, "%s", fw_name);
> -	if (!fwname)
> -		return -ENOMEM;
> -
> -	ret = request_firmware(&fw, fwname, sdma->dev);
> -	if (ret) {
> -		kfree(fwname);
> +	ret = request_firmware(&fw, fw_name, sdma->dev);
> +	if (ret)
>  		return ret;
> -	}
> -	kfree(fwname);
>  
>  	if (fw->size < sizeof(*header))
>  		goto err_firmware;
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
