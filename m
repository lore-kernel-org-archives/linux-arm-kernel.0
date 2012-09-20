From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 20 Sep 2012 10:29:23 +0300
Subject: [PATCH 08/29] ARM: OMAP2+: Make board-zoom.h local
In-Reply-To: <20120919210554.28074.2280.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210554.28074.2280.stgit@muffinssi>
Message-ID: <505AC5D3.1040907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,


On 09/20/2012 12:05 AM, Tony Lindgren wrote:
> This can be local to mach-omap2 after we rip out the messed up
> extmute stuff from board-zoom-peripherals.c that's all over
> the place and probably does not even work because of all the
> hardcoded GPIO numbers.
> 
> I also suggest ASoC gusy remove all extmute handling from
> sound/soc/codecs/twl4030.c unless it's been tested to work
> and implemented in a saner way.

I just wanted to note that I also have pending patch for zoom2.c as part of
the twl4030 audio module DT support series:
http://lkml.indiana.edu/hypermail/linux/kernel/1209.1/00711.html


> 
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: alsa-devel at alsa-project.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/board-3630sdp.c           |    2 +-
>  arch/arm/mach-omap2/board-ldp.c               |    2 +-
>  arch/arm/mach-omap2/board-zoom-debugboard.c   |    2 +-
>  arch/arm/mach-omap2/board-zoom-display.c      |    2 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c  |   16 +---------------
>  arch/arm/mach-omap2/board-zoom.c              |    2 +-
>  arch/arm/mach-omap2/board-zoom.h              |    0 
>  sound/soc/omap/zoom2.c                        |    2 +-
>  8 files changed, 7 insertions(+), 21 deletions(-)
>  rename arch/arm/mach-omap2/{include/mach/board-zoom.h => board-zoom.h} (100%)
> 
> diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
> index 8518b13..c7d6ea2 100644
> --- a/arch/arm/mach-omap2/board-3630sdp.c
> +++ b/arch/arm/mach-omap2/board-3630sdp.c
> @@ -20,7 +20,7 @@
>  #include <plat/gpmc-smc91x.h>
>  #include <plat/usb.h>
>  
> -#include <mach/board-zoom.h>
> +#include "board-zoom.h"
>  
>  #include "board-flash.h"
>  #include "mux.h"
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index 3f3a552..d0372a6 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -36,7 +36,7 @@
>  #include <plat/mcspi.h>
>  #include "common.h"
>  #include <plat/gpmc.h>
> -#include <mach/board-zoom.h>
> +#include "board-zoom.h"
>  #include <plat/usb.h>
>  #include <plat/gpmc-smsc911x.h>
>  
> diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
> index 0d8d919..42c97c2 100644
> --- a/arch/arm/mach-omap2/board-zoom-debugboard.c
> +++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
> @@ -20,7 +20,7 @@
>  #include <plat/gpmc.h>
>  #include <plat/gpmc-smsc911x.h>
>  
> -#include <mach/board-zoom.h>
> +#include "board-zoom.h"
>  
>  #include "soc.h"
>  #include "common.h"
> diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
> index ea79bc2..6a162fb 100644
> --- a/arch/arm/mach-omap2/board-zoom-display.c
> +++ b/arch/arm/mach-omap2/board-zoom-display.c
> @@ -16,7 +16,7 @@
>  #include <linux/spi/spi.h>
>  #include <plat/mcspi.h>
>  #include <video/omapdss.h>
> -#include <mach/board-zoom.h>
> +#include "board-zoom.h"
>  
>  #include "common.h"
>  
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 6bcc107..c8377b71 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -28,7 +28,7 @@
>  #include "common.h"
>  #include <plat/usb.h>
>  
> -#include <mach/board-zoom.h>
> +#include "board-zoom.h"
>  
>  #include "mux.h"
>  #include "hsmmc.h"
> @@ -245,12 +245,6 @@ static int zoom_twl_gpio_setup(struct device *dev,
>  	return ret;
>  }
>  
> -/* EXTMUTE callback function */
> -static void zoom2_set_hs_extmute(int mute)
> -{
> -	gpio_set_value(ZOOM2_HEADSET_EXTMUTE_GPIO, mute);
> -}
> -
>  static struct twl4030_gpio_platform_data zoom_gpio_data = {
>  	.setup		= zoom_twl_gpio_setup,
>  };
> @@ -271,14 +265,6 @@ static int __init omap_i2c_init(void)
>  			TWL_COMMON_PDATA_MADC | TWL_COMMON_PDATA_AUDIO,
>  			TWL_COMMON_REGULATOR_VDAC | TWL_COMMON_REGULATOR_VPLL2);
>  
> -	if (machine_is_omap_zoom2()) {
> -		struct twl4030_codec_data *codec_data;
> -		codec_data = zoom_twldata.audio->codec;
> -
> -		codec_data->ramp_delay_value = 3;	/* 161 ms */
> -		codec_data->hs_extmute = 1;
> -		codec_data->set_hs_extmute = zoom2_set_hs_extmute;
> -	}
>  	omap_pmic_init(1, 2400, "twl5030", 7 + OMAP_INTC_START, &zoom_twldata);
>  	omap_register_i2c_bus(2, 400, NULL, 0);
>  	omap_register_i2c_bus(3, 400, NULL, 0);
> diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
> index 4994438..cbfd9df 100644
> --- a/arch/arm/mach-omap2/board-zoom.c
> +++ b/arch/arm/mach-omap2/board-zoom.c
> @@ -24,7 +24,7 @@
>  #include "common.h"
>  #include <plat/usb.h>
>  
> -#include <mach/board-zoom.h>
> +#include "board-zoom.h"
>  
>  #include "board-flash.h"
>  #include "mux.h"
> diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h b/arch/arm/mach-omap2/board-zoom.h
> similarity index 100%
> rename from arch/arm/mach-omap2/include/mach/board-zoom.h
> rename to arch/arm/mach-omap2/board-zoom.h
> diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
> index 920e0d9..187cb0c 100644
> --- a/sound/soc/omap/zoom2.c
> +++ b/sound/soc/omap/zoom2.c
> @@ -28,7 +28,6 @@
>  #include <asm/mach-types.h>
>  #include <mach/hardware.h>
>  #include <mach/gpio.h>
> -#include <mach/board-zoom.h>
>  #include <plat/mcbsp.h>
>  
>  /* Register descriptions for twl4030 codec part */
> @@ -39,6 +38,7 @@
>  #include "omap-pcm.h"
>  
>  #define ZOOM2_HEADSET_MUX_GPIO		(OMAP_MAX_GPIO_LINES + 15)
> +#define ZOOM2_HEADSET_EXTMUTE_GPIO     153
>  
>  static int zoom2_hw_params(struct snd_pcm_substream *substream,
>  				struct snd_pcm_hw_params *params)
> 


-- 
P?ter
