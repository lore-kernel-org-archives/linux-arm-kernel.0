From: varkabhadram@gmail.com (Varka Bhadram)
Date: Thu, 16 Apr 2015 18:05:37 +0530
Subject: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix return value check in
 s3c24xx_iis_dev_probe()
In-Reply-To: <1429186682-20629-1-git-send-email-weiyj_lk@163.com>
References: <1429186682-20629-1-git-send-email-weiyj_lk@163.com>
Message-ID: <552FAC99.1030804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2015 05:48 PM, weiyj_lk at 163.com wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function devm_ioremap_resource() returns
> ERR_PTR() and never returns NULL. The NULL test in the return
> value check should be replaced with IS_ERR().

This bug is there in other drivers in sound/soc/samsung/

Try do for all the drivers.

> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  sound/soc/samsung/s3c24xx-i2s.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
> index 326d3c3..5bf7236 100644
> --- a/sound/soc/samsung/s3c24xx-i2s.c
> +++ b/sound/soc/samsung/s3c24xx-i2s.c
> @@ -461,8 +461,8 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  	s3c24xx_i2s.regs = devm_ioremap_resource(&pdev->dev, res);
> -	if (s3c24xx_i2s.regs == NULL)
> -		return -ENXIO;
> +	if (IS_ERR(s3c24xx_i2s.regs))
> +		return PTR_ERR(s3c24xx_i2s.regs);
>  
>  	s3c24xx_i2s_pcm_stereo_out.dma_addr = res->start + S3C2410_IISFIFO;
>  	s3c24xx_i2s_pcm_stereo_in.dma_addr = res->start + S3C2410_IISFIFO;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Varka Bhadram
