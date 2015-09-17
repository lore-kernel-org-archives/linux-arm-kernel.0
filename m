From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 17 Sep 2015 11:05:34 +0900
Subject: [PATCH] mach-s3c64xx:Fix error handling for certain calls to
 s3c_gpio_cfgpin_range in the file dev-audio.c
In-Reply-To: <1442454673-26752-1-git-send-email-xerofoify@gmail.com>
References: <1442454673-26752-1-git-send-email-xerofoify@gmail.com>
Message-ID: <55FA1FEE.5070506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.09.2015 10:51, Nicholas Krause wrote:
> This fixes error handling for calls to the function
> s3c_gpio_cfgpin_range in the file dev-audio.c that
> assume calls to this particular function always run
> successfully to properly check now if these calls
> fail by returning a error code and if so return it
> directly to the call of these functions in order for
> the caller to be able to handle these failed calls in
> its own error path(s).
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/dev-audio.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

I am assuming (from the past events) that you did not test the patch and
how returning the error condition affects rest of the code. In the same
time you ignored my request to mark such patches with Request-For-Test.

Please send it after testing.

Commit message is hard to understand, please re-phrase so it would be
easily to find how this affects upper layers.

As you are banned on LKML, the patch needs thorough testing and review
before applying.

Best regards,
Krzysztof

> 
> diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
> index ff780a8..81fabdb 100644
> --- a/arch/arm/mach-s3c64xx/dev-audio.c
> +++ b/arch/arm/mach-s3c64xx/dev-audio.c
> @@ -27,6 +27,7 @@
>  static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
>  {
>  	unsigned int base;
> +	int ret;
>  
>  	switch (pdev->id) {
>  	case 0:
> @@ -47,9 +48,9 @@ static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3));
> -
> -	return 0;
> +	ret = s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3));
> +
> +	return ret;
>  }
>  
>  static struct resource s3c64xx_iis0_resource[] = {
> @@ -122,6 +123,7 @@ EXPORT_SYMBOL(s3c64xx_device_iisv4);
>  static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
>  {
>  	unsigned int base;
> +	int ret;
>  
>  	switch (pdev->id) {
>  	case 0:
> @@ -136,8 +138,8 @@ static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(2));
> -	return 0;
> +	ret = s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(2));
> +	return ret;
>  }
>  
>  static struct resource s3c64xx_pcm0_resource[] = {
> 
