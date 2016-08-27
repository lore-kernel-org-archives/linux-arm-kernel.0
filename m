From: zhengxing@rock-chips.com (Xing Zheng)
Date: Sat, 27 Aug 2016 21:45:23 +0800
Subject: [PATCH] ASoC: rockchip: use SPI dependency for rt5514
In-Reply-To: <20160826155120.1162512-1-arnd@arndb.de>
References: <20160826155120.1162512-1-arnd@arndb.de>
Message-ID: <57C19973.1050906@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 2016?08?26? 23:50, Arnd Bergmann wrote:
> The rk3399 scans the spi_bus_type to find the rt5514 driver, but does not
> actually have a Kconfig dependency on SPI, so we can end up with a link
> failure:
>
> sound/soc/codecs/snd-soc-rt5514-spi.o: In function `rt5514_spi_driver_init':
> rt5514-spi.c:(.init.text+0x14): undefined reference to `__spi_register_driver'
> sound/soc/codecs/snd-soc-rt5514-spi.o: In function `rt5514_spi_burst_read':
> rt5514-spi.c:(.text.rt5514_spi_burst_read+0x18c): undefined reference to `spi_sync'
> sound/soc/codecs/snd-soc-rt5514-spi.o: In function `rt5514_spi_burst_write':
> rt5514-spi.c:(.text.rt5514_spi_burst_write+0x1b4): undefined reference to `spi_sync'
> sound/soc/rockchip/snd-soc-rk3399-gru-sound.o: In function `rockchip_sound_probe':
> rk3399_gru_sound.c:(.text.rockchip_sound_probe+0x128): undefined reference to `spi_bus_type'
>
> This adds the missing dependency.
>
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
> Fixes: c6eac8a36a84 ("ASoC: rockchip: Add machine driver for RK3399 GRU Boards")
> ---
>   sound/soc/rockchip/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
> index d82d763d4854..c783f9a22595 100644
> --- a/sound/soc/rockchip/Kconfig
> +++ b/sound/soc/rockchip/Kconfig
> @@ -44,7 +44,7 @@ config SND_SOC_ROCKCHIP_RT5645
>
>   config SND_SOC_RK3399_GRU_SOUND
>   	tristate "ASoC support multiple codecs for Rockchip RK3399 GRU boards"
> -	depends on SND_SOC_ROCKCHIP&&  I2C&&  GPIOLIB&&  CLKDEV_LOOKUP
> +	depends on SND_SOC_ROCKCHIP&&  I2C&&  GPIOLIB&&  CLKDEV_LOOKUP&&  SPI
>   	select SND_SOC_ROCKCHIP_I2S
>   	select SND_SOC_MAX98357A
>   	select SND_SOC_RT5514
So sorry to miss it... Thanks to help us to fix it. :-)

Tested-by: Xing Zheng <zhengxing@rock-chips.com>

Thanks.

-- 
- Xing Zheng
