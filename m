From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 19 Sep 2016 18:37:09 +0200
Subject: [PATCH] ASoC: samsung: make audio interface/controller explicitly
In-Reply-To: <1474300318-26767-1-git-send-email-ayaka@soulik.info>
References: <1474300318-26767-1-git-send-email-ayaka@soulik.info>
Message-ID: <20160919163709.GA5981@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 11:51:58PM +0800, Randy Li wrote:
> It is simple sound card time, we could assign different codec
> to a interface without making a specific driver for it. The SPDIF
> and I2S interface for Samsung would be possible used by simple-sound-card,
> but not sure about the PCM.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  sound/soc/samsung/Kconfig | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index 7b722b0..210ce38 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -1,3 +1,7 @@
> +menu "SoC Audio for Samsung CPUs"

This adds a new empty layer. One have to choose this menu and then
SND_SOC_SAMSUNG to access specific options. Instead of new menu, the
SND_SOC_SAMSUNG should be menuconfig. The existing "depends on" and the
one you added below won't be needed then, I think. Just have to be sure
that nothing selects particular drivers without selecting
SND_SOC_SAMSUNG first.


Best regards,
Krzysztof


> +
> +comment "Common SoC Audio options for Samsung CPUs:"
> +
>  config SND_SOC_SAMSUNG
>  	tristate "ASoC support for Samsung"
>  	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
> @@ -18,18 +22,22 @@ config SND_S3C2412_SOC_I2S
>  	select SND_S3C_I2SV2_SOC
>  
>  config SND_SAMSUNG_PCM
> -	tristate
> +	tristate "Samsung PCM interface support"
> +	depends on SND_SOC_SAMSUNG
>  
>  config SND_SAMSUNG_AC97
>  	tristate
>  	select SND_SOC_AC97_BUS
> +	depends on SND_SOC_SAMSUNG
>  
>  config SND_SAMSUNG_SPDIF
> -	tristate
> +	tristate "Samsung SPDIF transmitter support"
> +	depends on SND_SOC_SAMSUNG
>  	select SND_SOC_SPDIF
>  
>  config SND_SAMSUNG_I2S
> -	tristate
> +	tristate "Samsung I2S interface support"
> +	depends on I2C && SND_SOC_SAMSUNG
>  
>  config SND_SOC_SAMSUNG_NEO1973_WM8753
>  	tristate "Audio support for Openmoko Neo1973 Smartphones (GTA02)"
> @@ -229,3 +237,5 @@ config SND_SOC_ARNDALE_RT5631_ALC5631
>          depends on SND_SOC_SAMSUNG && I2C
>          select SND_SAMSUNG_I2S
>          select SND_SOC_RT5631
> +
> +endmenu
> -- 
> 2.7.4
> 
