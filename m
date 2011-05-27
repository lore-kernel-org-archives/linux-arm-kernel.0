From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 27 May 2011 15:06:53 -0600
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <20110527205721.21000.78599.stgit@riker>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
Message-ID: <20110527210653.GL6645@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 01:57:26PM -0700, John Bonesio wrote:
> This patch makes it so the gpio's used by the Tegra audio driver are
> initialized from device tree nodes.
> 
> Signed-off-by: John Bonesio<bones@secretlab.ca>
> ---
> 
>  arch/arm/boot/dts/tegra-harmony.dts |    6 ++++++
>  sound/soc/codecs/wm8903.c           |    5 +++++
>  sound/soc/tegra/harmony.c           |   37 ++++++++++++++++++-----------------
>  3 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> index 217a7f0..fc61e02 100644
> --- a/arch/arm/boot/dts/tegra-harmony.dts
> +++ b/arch/arm/boot/dts/tegra-harmony.dts
> @@ -55,6 +55,12 @@
>  
>  	harmony_audio: audio_card {
>  		compatible = "nvidia,harmony-audio";
> +
> +		gpios = <&codec 226 0>, /* spkr_en, gpio wm8903 #2 */
> +			<&gpio 178 0>, /* hp_det, gpio PW2 */
> +			<&gpio 184 0>, /* int_mic_en, gpio PX0 */
> +			<&gpio 185 0>; /* ext_mic_en, gpio PX1 */
> +
>  	};
>  
>  	serial at 70006300 {
> diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
> index a10e3b9..9ad3532 100644
> --- a/sound/soc/codecs/wm8903.c
> +++ b/sound/soc/codecs/wm8903.c
> @@ -1875,6 +1875,11 @@ static void wm8903_init_gpio(struct snd_soc_codec *codec)
>  			wm8903->gpio_chip.base = be32_to_cpup(prop);
>  	}
>  
> +#if defined(CONFIG_OF_GPIO)
> +	wm8903->gpio_chip.of_node = of_find_compatible_node(NULL, NULL,
> +						"wlf,wm8903");
> +#endif /* CONFIG_OF_GPIO */
> +

You shouldn't need to search for the node pointer here.  The of_node
should already be populated in the i2c device, and you can just use
that reference directly.

>  	ret = gpiochip_add(&wm8903->gpio_chip);
>  	if (ret != 0)
>  		dev_err(codec->dev, "Failed to add GPIOs: %d\n", ret);
> diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
> index faeec14..40c19f0 100644
> --- a/sound/soc/tegra/harmony.c
> +++ b/sound/soc/tegra/harmony.c
> @@ -34,6 +34,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/gpio.h>
> +#include <linux/of_gpio.h>
>  
>  #include <mach/harmony_audio.h>
>  
> @@ -52,18 +53,6 @@
>  
>  #define DRV_NAME "tegra-snd-harmony"
>  
> -/* temporary - info will go into device tree */
> -#define TEGRA_GPIO_PW2          178
> -#define TEGRA_GPIO_PX0          184
> -#define TEGRA_GPIO_PX1          185
> -
> -#define HARMONY_GPIO_WM8903(_x_)	(TEGRA_NR_GPIOS + (_x_))
> -#define TEGRA_GPIO_SPKR_EN		HARMONY_GPIO_WM8903(2)
> -#define TEGRA_GPIO_HP_DET		TEGRA_GPIO_PW2
> -#define TEGRA_GPIO_INT_MIC_EN		TEGRA_GPIO_PX0
> -#define TEGRA_GPIO_EXT_MIC_EN		TEGRA_GPIO_PX1
> -/* end temporary */
> -
>  #define GPIO_SPKR_EN    BIT(0)
>  #define GPIO_INT_MIC_EN BIT(1)
>  #define GPIO_EXT_MIC_EN BIT(2)
> @@ -213,6 +202,18 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
>  	struct harmony_audio_platform_data *pdata = harmony->pdata;
>  	int ret;
>  
> +	if (pdata->gpio_spkr_en == -1)
> +		pdata->gpio_spkr_en = of_get_gpio(card->dev->of_node, 0);
> +
> +	if (pdata->gpio_hp_det == -1)
> +		pdata->gpio_hp_det = of_get_gpio(card->dev->of_node, 1);
> +
> +	if (pdata->gpio_int_mic_en == -1)
> +		pdata->gpio_int_mic_en = of_get_gpio(card->dev->of_node, 2);
> +
> +	if (pdata->gpio_ext_mic_en == -1)
> +		pdata->gpio_ext_mic_en = of_get_gpio(card->dev->of_node, 3);
> +
>  	ret = gpio_request(pdata->gpio_spkr_en, "spkr_en");
>  	if (ret) {
>  		dev_err(card->dev, "cannot get spkr_en gpio\n");
> @@ -299,12 +300,12 @@ static struct snd_soc_card snd_soc_harmony = {
>  	.num_links = 1,
>  };
>  
> -/* temporary - put this into the device tree */
> +/* empty pdata struct - filled in with device tree properties */

As already mentioned, don't use an empty static structure.  kzalloc()
one instead.

>  static struct harmony_audio_platform_data harmony_audio_pdata = {
> -	.gpio_spkr_en		= TEGRA_GPIO_SPKR_EN,
> -	.gpio_hp_det		= TEGRA_GPIO_HP_DET,
> -	.gpio_int_mic_en	= TEGRA_GPIO_INT_MIC_EN,
> -	.gpio_ext_mic_en	= TEGRA_GPIO_EXT_MIC_EN,
> +	.gpio_spkr_en		= -1,
> +	.gpio_hp_det		= -1,
> +	.gpio_int_mic_en	= -1,
> +	.gpio_ext_mic_en	= -1,
>  };
>  
>  static __devinit int tegra_snd_harmony_probe(struct platform_device *pdev)
> @@ -328,7 +329,7 @@ static __devinit int tegra_snd_harmony_probe(struct platform_device *pdev)
>  #endif
>  
>  	if (pdev->dev.of_node) {
> -		pdev->dev.platform_data = &harmony_audio_pdata; /* temporary */
> +		pdev->dev.platform_data = &harmony_audio_pdata;
>  		pdata = pdev->dev.platform_data;
>  	} else {
>  		pdata = pdev->dev.platform_data;
> 
