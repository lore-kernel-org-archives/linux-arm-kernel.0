From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 13 Jun 2017 12:22:42 +0200
Subject: [PATCH 1/1] ARM: imx: Enable REGMAP_MMIO per default
In-Reply-To: <20170607064316.2766-1-alexander.stein@systec-electronic.com>
References: <20170607064316.2766-1-alexander.stein@systec-electronic.com>
Message-ID: <20170613102242.adtnoxznpvknw5rb@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jun 07, 2017 at 08:43:16AM +0200, Alexander Stein wrote:
> If unset, the gpc drivers fails to link with this error:
> drivers/built-in.o: In function `imx_gpc_probe':
> core.c:(.text+0x1e16c): undefined reference to
>  `__devm_regmap_init_mmio_clk'
> 
> As the gpc driver is built when ARCH_MXC is set, enable REGMAP_MMIO in
> this case too.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> ---
>  arch/arm/mach-imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 936c59d0e18b..1b8eead0d113 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -7,6 +7,7 @@ menuconfig ARCH_MXC
>  	select GPIOLIB
>  	select PINCTRL
>  	select PM_OPP if PM
> +	select REGMAP_MMIO
>  	select SOC_BUS
>  	select SRAM
>  	help

I wonder if this should be selected nearer to the gpc driver. Something
like:

------->8---------
From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] soc: imx: Introduce Kconfig symbol for gpc driver selecting regmap-mmio

This fixes a build failure if REGMAP_MMIO and REGMAP are not enabled:

	  CC      drivers/soc/imx/gpc.o
	drivers/soc/imx/gpc.c:306:21: error: variable 'imx_gpc_regmap_config' has initializer but incomplete type
	 static const struct regmap_config imx_gpc_regmap_config = {
			     ^
	drivers/soc/imx/gpc.c:307:2: error: unknown field 'reg_bits' specified in initializer
	  .reg_bits = 32,
	  ^
	drivers/soc/imx/gpc.c:307:14: warning: excess elements in struct initializer
	  .reg_bits = 32,
		      ^
	drivers/soc/imx/gpc.c:307:14: note: (near initialization for 'imx_gpc_regmap_config')
	drivers/soc/imx/gpc.c:308:2: error: unknown field 'val_bits' specified in initializer
	  .val_bits = 32,
	  ^
	drivers/soc/imx/gpc.c:308:14: warning: excess elements in struct initializer
	  .val_bits = 32,
		      ^
	drivers/soc/imx/gpc.c:308:14: note: (near initialization for 'imx_gpc_regmap_config')
	drivers/soc/imx/gpc.c:309:2: error: unknown field 'reg_stride' specified in initializer
	  .reg_stride = 4,
	  ^
	drivers/soc/imx/gpc.c:309:16: warning: excess elements in struct initializer
	  .reg_stride = 4,
			^
	drivers/soc/imx/gpc.c:309:16: note: (near initialization for 'imx_gpc_regmap_config')
	drivers/soc/imx/gpc.c:310:2: error: unknown field 'max_register' specified in initializer
	  .max_register = 0x2ac,
	  ^
	drivers/soc/imx/gpc.c:310:18: warning: excess elements in struct initializer
	  .max_register = 0x2ac,
			  ^
	drivers/soc/imx/gpc.c:310:18: note: (near initialization for 'imx_gpc_regmap_config')
	drivers/soc/imx/gpc.c: In function 'imx_gpc_probe':
	drivers/soc/imx/gpc.c:390:11: error: implicit declaration of function 'devm_regmap_init_mmio_clk' [-Werror=implicit-function-declaration]
	  regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
		   ^
	drivers/soc/imx/gpc.c:390:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
	  regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
		 ^
	cc1: some warnings being treated as errors

As an added bonus this symbol is only enabled on imx6 builds as other
mxc SoC don't make use of this driver.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/imx/Kconfig  | 5 +++++
 drivers/soc/imx/Makefile | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a5b86a28f343..49f95d8c371f 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -1,5 +1,10 @@
 menu "i.MX SoC drivers"
 
+config IMX6_PM_DOMAINS
+	bool
+	default y if SOC_IMX6
+	select REGMAP_MMIO
+
 config IMX7_PM_DOMAINS
 	bool "i.MX7 PM domains"
 	depends on SOC_IMX7D || (COMPILE_TEST && OF)
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 5b6e396c1121..ee6857673089 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,2 @@
-obj-y += gpc.o
+obj-$(CONFIG_IMX6_PM_DOMAINS) += gpc.o
 obj-$(CONFIG_IMX7_PM_DOMAINS) += gpcv2.o
-- 
2.11.0

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
