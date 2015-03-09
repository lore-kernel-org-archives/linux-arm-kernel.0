From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Mar 2015 21:36:18 +0100
Subject: [PATCH 2/2] pinctrl: mediatek: Adjust mt8173 pinctrl kconfig
In-Reply-To: <1425623091-30478-2-git-send-email-yingjoe.chen@mediatek.com>
References: <1425623091-30478-1-git-send-email-yingjoe.chen@mediatek.com>
 <1425623091-30478-2-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <3011616.9oVy3HN0Pj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 March 2015 14:24:51 Yingjoe Chen wrote:
> Linus,
> This one make PINCTRL_MT8173 option user selectable and is based on
> mtk-staging in your tree. If you think this is OK, please applied or
> squash this into previous change. Thanks.

The patch looks good in principle, just two small comments

> --------------------------------------------------

To simplify the job for Linus here, please start the line above
with 

8<------

(a stylized pair if scissors)

which is the magic that git-am looks for.


> ARM64 maintainer doesn't want to add MACH_* for each SoC.
> Adjust mt8173 pinctrl kconfig entry so user can manually select it.
> 
> Also make PINCTRL_MT8135 build when COMPILE_TEST is enabled.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 49b8649..1472f0e 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -1,4 +1,4 @@
> -if ARCH_MEDIATEK
> +if ARCH_MEDIATEK || COMPILE_TEST
>  
>  config PINCTRL_MTK_COMMON
>  	bool
> @@ -8,11 +8,13 @@ config PINCTRL_MTK_COMMON
>  	select OF_GPIO
>  
>  config PINCTRL_MT8135
> -	def_bool MACH_MT8135
> +	def_bool MACH_MT8135 || COMPILE_TEST
>  	select PINCTRL_MTK_COMMON
>  
>  config PINCTRL_MT8173
> -	def_bool MACH_MT8173
> +	bool "Mediatek MT8173 pin control"
> +	def_bool y
> +	depends on ARM64 || COMPILE_TEST
>  	select PINCTRL_MTK_COMMON
>  

You have slightly different logic here: PINCTRL_MT8135 will
always be enabled when COMPILE_TEST is on, while PINCTRL_MT8173
is enabled by default in this case, but can be turned off.

Neither of them is what you really want, which would be

config PINCTRL_MT8135
	bool "Mediatek MT8135 pin control"
	depends on MACH_MT8135 || COMPILE_TEST
	default MACH_MT8135
	select PINCTRL_MTK_COMMON

config PINCTRL_MT8135
	bool "Mediatek MT8173 pin control"
	depends on MACH_MT8173 || COMPILE_TEST
	default MACH_MT8173
	select PINCTRL_MTK_COMMON

This way, the options are only enabled by default if MACH_MT8135
or MACH_MT8173 are enabled, but you are free to enable or disable
them when COMPILE_TEST is set. Alternatively, you can do

config PINCTRL_MT8135
	bool "Mediatek MT8135 pin control" if COMPILE_TEST && !MACH_MT8135
	default MACH_MT8135
	select PINCTRL_MTK_COMMON

config PINCTRL_MT8135
	bool "Mediatek MT8173 pin control" if COMPILE_TEST && !MACH_MT8173
	default MACH_MT8173
	select PINCTRL_MTK_COMMON

which will let you turn on the options if COMPILE_TEST is set, but not
let you turn them off when the drivers are required.

	Arnd
