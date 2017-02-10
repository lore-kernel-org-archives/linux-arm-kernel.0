From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 10 Feb 2017 11:40:38 -0800
Subject: [PATCH 10/10] ARM: davinci: add pdata-quirks for da850-evm vpif
 display
In-Reply-To: <1486485683-11427-11-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Tue, 7 Feb 2017 17:41:23 +0100")
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
 <1486485683-11427-11-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <m2bmu9hm15.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> Similarly to vpif capture: we need to register the vpif display driver
> and the corresponding adv7343 encoder in pdata-quirks as the DT
> support is not complete.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/pdata-quirks.c | 86 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
> index 09f62ac..0a55546 100644
> --- a/arch/arm/mach-davinci/pdata-quirks.c
> +++ b/arch/arm/mach-davinci/pdata-quirks.c
> @@ -9,13 +9,17 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/of_platform.h>
> +#include <linux/gpio.h>
>  
>  #include <media/i2c/tvp514x.h>
> +#include <media/i2c/adv7343.h>
>  
>  #include <mach/common.h>
>  #include <mach/da8xx.h>
>  #include <mach/mux.h>
>  
> +#define DA850_EVM_UI_EXP_SEL_VPIF_DISP 5
> +
>  struct pdata_init {
>  	const char *compatible;
>  	void (*fn)(void);
> @@ -107,7 +111,78 @@ static struct vpif_capture_config da850_vpif_capture_config = {
>  	},
>  	.card_name = "DA850/OMAP-L138 Video Capture",
>  };
> +#endif /* IS_ENABLED(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE) */
> +
> +#if defined(CONFIG_DA850_UI_SD_VIDEO_PORT)
> +static void vpif_evm_display_setup(void)
> +{
> +	int gpio = DAVINCI_N_GPIO + DA850_EVM_UI_EXP_SEL_VPIF_DISP, ret;
> +
> +	ret = gpio_request(gpio, "sel_c");
> +	if (ret) {
> +		pr_warn("Cannot open UI expander pin %d\n", gpio);
> +		return;
> +	}
> +
> +	gpio_direction_output(gpio, 0);
> +}

I had a closer look at the UI board schematic, and it looks like the
SEL_C line of the GPIO exapander is actualy to select the VPIF *input*
source, not output, so I don't think it should be needed in this patch.

Can you test VPIF display works without calling this function?

Kevin
