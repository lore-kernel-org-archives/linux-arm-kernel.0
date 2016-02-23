From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 23 Feb 2016 09:55:06 +0100
Subject: [PATCH] thermal: mediatek: add missing dependencies
In-Reply-To: <1455921381-1881305-1-git-send-email-arnd@arndb.de>
References: <1455921381-1881305-1-git-send-email-arnd@arndb.de>
Message-ID: <20160223085506.GB3939@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Feb 19, 2016 at 11:36:06PM +0100, Arnd Bergmann wrote:
> The newly added mtk_thermal driver uses the generic reset
> and nvmem infrastructure, but lacks a dependency that enforces
> them from actually being present:
> 
> drivers/thermal/mtk_thermal.c: In function 'mtk_thermal_probe':
> drivers/thermal/mtk_thermal.c:560:8: error: implicit declaration of function 'device_reset' [-Werror=implicit-function-declaration]
> drivers/thermal/built-in.o: In function `mtk_thermal_probe':
> mtk_thermal.c:(.text+0x7fb0): undefined reference to `nvmem_cell_get'
> mtk_thermal.c:(.text+0x7fd8): undefined reference to `nvmem_cell_read'
> mtk_thermal.c:(.text+0x7fe4): undefined reference to `nvmem_cell_put'
> 
> Without CONFIG_THERMAL, the driver cannot build, so this needs
> to be a hard dependency.

s/CONFIG_THERMAL/CONFIG_RESET_CONTROLLER/ ?

> 
> For CONFIG_NVMEM, the header file allows building the driver even
> when the subsystem is disabled, but we get the link error above
> when nvmem is built as a module and the thermal driver is built-in,
> so we can allow compile-testing when NVMEM is completely disabled,
> but otherwise require the dependency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/thermal/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5e7c97a3f1d8..75d164341f0d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -368,6 +368,8 @@ config INTEL_PCH_THERMAL
>  config MTK_THERMAL
>  	tristate "Temperature sensor driver for mediatek SoCs"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on NVMEM || (!NVMEM && COMPILE_TEST)

This doesn't work as expected. When NVMEM is off I can still not select
MTK_THERMAL, even when COMPILE_TEST is enabled.

Even if it would work, do we really want this? It raises eyebrows and
without reading the commit messages it's probably not clear what's going
on here. I don't see that much value in it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
