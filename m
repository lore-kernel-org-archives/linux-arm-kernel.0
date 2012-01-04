From: heiko@sntech.de (Heiko =?windows-1252?q?St=FCbner?=)
Date: Wed, 4 Jan 2012 12:51:41 +0100
Subject: [PATCH 2/4] rtc-s3c: make room for more variants in devicetree
 block
In-Reply-To: <4F042D61.2070309@samsung.com>
References: <201112211014.30695.heiko@sntech.de>
 <201112211016.51956.heiko@sntech.de> <4F042D61.2070309@samsung.com>
Message-ID: <201201041251.42509.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

Am Mittwoch, 4. Januar 2012, 11:43:45 schrieb Sylwester Nawrocki:
> Hello,
> 
> On 12/21/2011 10:16 AM, Heiko St?bner wrote:
> > Use the data field of of_device_id to hold the type for
> > s3c_cpu_type.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
> > ---
> > 
> This patch makes compilation with CONFIG_OF enabled fail with errors
> and warnings:
> 
> drivers/rtc/rtc-s3c.c: In function ?s3c_rtc_get_driver_data?:
> drivers/rtc/rtc-s3c.c:454: warning: return makes integer from pointer
> without a cast
> drivers/rtc/rtc-s3c.c: At top level:
> drivers/rtc/rtc-s3c.c:674: error: request for member ?data? in something
> not a structure or union
> drivers/rtc/rtc-s3c.c:677: error: request for member ?data? in something
> not a structure or union
> drivers/rtc/rtc-s3c.c:680: error: request for member ?data? in something
> not a structure or union
> drivers/rtc/rtc-s3c.c:683: error: request for member ?data? in something
> not a structure or union
> make[2]: *** [drivers/rtc/rtc-s3c.o] Error 1
thanks for spotting this.

@kgene: Should this go on top of the rtc series, or should I prepare a v4 with 
these fixes included?


> And the following patch fixes this:
> 
> 8<------------
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 4498053..9a0d388 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -451,7 +451,7 @@ static inline int s3c_rtc_get_driver_data(struct
> platform_device *pdev)
>         if (pdev->dev.of_node) {
>                 const struct of_device_id *match;
>                 match = of_match_node(s3c_rtc_dt_match, pdev->dev.of_node);
> -               return match->data;
> +               return (int)match->data;
>         }
>  #endif
>         return platform_get_device_id(pdev)->driver_data;
> @@ -670,17 +670,17 @@ static int s3c_rtc_resume(struct platform_device
> *pdev) #ifdef CONFIG_OF
>  static const struct of_device_id s3c_rtc_dt_match[] = {
>         {
> -               .compatible = "samsung,s3c2410-rtc"
> -               .data = TYPE_S3C2410,
> +               .compatible = "samsung,s3c2410-rtc",
> +               .data = (void*)TYPE_S3C2410,
>         }, {
> -               .compatible = "samsung,s3c2443-rtc"
> -               .data = TYPE_S3C2443,
> +               .compatible = "samsung,s3c2443-rtc",
> +               .data = (void*)TYPE_S3C2443,
>         }, {
> -               .compatible = "samsung,s3c2416-rtc"
> -               .data = TYPE_S3C2416,
> +               .compatible = "samsung,s3c2416-rtc",
> +               .data = (void*)TYPE_S3C2416,
>         }, {
> -               .compatible = "samsung,s3c6410-rtc"
> -               .data = TYPE_S3C64XX,
> +               .compatible = "samsung,s3c6410-rtc",
> +               .data = (void*)TYPE_S3C64XX,
>         },
>         {},
>  };
> 
> 8<-----------------

Heiko
