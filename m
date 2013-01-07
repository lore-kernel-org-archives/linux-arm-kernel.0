From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 07 Jan 2013 11:36:16 +0200
Subject: [PATCH 3/4] ALSA: pxa27x: ac97 controller driver requests gpio
In-Reply-To: <1357499640-13871-4-git-send-email-mikedunn@newsguy.com>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-4-git-send-email-mikedunn@newsguy.com>
Message-ID: <50EA9710.3060107@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/13 21:13, Mike Dunn wrote:
> During initialization, the ac97 driver must obtain the gpio for the mfp that is
> used by the ac97 controller as the AC97_nRESET line, or else gpiolib will issue
> a warning and stack dump.  Gpiolib may change this to a hard error soon.  The
> line is used during an ac97 warm reset for working around a hardware bug in the
> controller.
> 
> Tested on a palm treo 680 machine.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
>  sound/arm/pxa2xx-ac97-lib.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
> index 1ecd0a66..416d2e3 100644
> --- a/sound/arm/pxa2xx-ac97-lib.c
> +++ b/sound/arm/pxa2xx-ac97-lib.c
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/io.h>
> +#include <linux/gpio.h>
>  
>  #include <sound/ac97_codec.h>
>  #include <sound/pxa2xx-lib.h>
> @@ -344,7 +345,12 @@ int pxa2xx_ac97_hw_probe(struct platform_device *dev)
>  	}
>  
>  	if (cpu_is_pxa27x()) {
> -		/* Use GPIO 113 as AC97 Reset on Bulverde */
> +		ret = gpio_request(reset_gpio, "pxa27x ac97 reset");
> +		if (ret < 0) {
> +			pr_err("%s: gpio_request() failed: %d\n",
> +			       __func__, ret);
> +			goto err_conf;
> +		}

I think if we are fine with the request in the driver,
then we should move the direction and value configuration also
to the driver, but let the pxa27x_assert_ac97reset() only switch
the AF.

>  		pxa27x_assert_ac97reset(reset_gpio, 0);
>  		ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
>  		if (IS_ERR(ac97conf_clk)) {
> @@ -388,6 +394,8 @@ EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_probe);
>  
>  void pxa2xx_ac97_hw_remove(struct platform_device *dev)
>  {
> +	if (cpu_is_pxa27x())
> +		gpio_free(reset_gpio);
>  	GCR |= GCR_ACLINK_OFF;
>  	free_irq(IRQ_AC97, NULL);
>  	if (ac97conf_clk) {

-- 
Regards,
Igor.
