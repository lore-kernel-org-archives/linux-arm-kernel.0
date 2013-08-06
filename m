From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 06 Aug 2013 11:36:15 +0100
Subject: [PATCH] MFD: Make VEXPRESS MFD controller depends on VEXPRESS
 systems
In-Reply-To: <1375603249-27206-1-git-send-email-manjunath.goudar@linaro.org>
References: <1375603249-27206-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1375785375.12043.4.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-08-04 at 09:00 +0100, Manjunath Goudar wrote:
> This patch adds a Kconfig dependency on an ARCH_VEXPRESS(it is for
> both ARM and ARM64) or ARCH_VEXPRESS_CA9X being available before
> VEXPRESS_CONFIG can be enabled. Without this patch,build system
> can lead to issues. This was discovered during randconfig testing,
> in which VEXPRESS_CONFIG was enabled w/o ARCH_VEXPRESS or VEXPRESS_CONFIG
> being enabled,leading to the following error:
> 
> CC      drivers/mfd/vexpress-config.o
> drivers/mfd/vexpress-config.c: In function ?__vexpress_config_func_get?:
> drivers/mfd/vexpress-config.c:117:4: error: implicit declaration of function
> ?of_find_node_by_phandle? [-Werror=implicit-function-declaration]
>     bridge_node = of_find_node_by_phandle(
>     ^
> drivers/mfd/vexpress-config.c:117:16: warning: assignment makes pointer from
> integer without a cast [enabled by default]
>     bridge_node = of_find_node_by_phandle(

Thanks for reporting the problem...

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 633ee43..c9202f6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1174,7 +1174,7 @@ endmenu
>  
>  config VEXPRESS_CONFIG
>  	bool "ARM Versatile Express platform infrastructure"
> -	depends on ARM || ARM64
> +	depends on ARCH_VEXPRESS || ARCH_VEXPRESS_CA9X4
>  	help
>  	  Platform configuration infrastructure for the ARM Ltd.
>  	  Versatile Express.

... but this is not the right way to fix it. In case of ARM64 there is
no (or maybe: there will be no) ARCH_VEXPRESS nor ARCH_ANYTHING if it
comes to it ;-)

What is really missing is a stub for of_find_node_by_phandle() in case
of CONFIG_OF != y. Care to send a patch adding it?

Thanks!

Pawel
