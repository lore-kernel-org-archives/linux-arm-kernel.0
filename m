From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 14:40:13 +0000
Subject: Build failure: OMAP4430 failed due to exynos4 pinctrl
In-Reply-To: <007b01cdc0bf$50c9ee70$f25dcb50$%kim@samsung.com>
References: <007b01cdc0bf$50c9ee70$f25dcb50$%kim@samsung.com>
Message-ID: <201211121440.13980.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 November 2012, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > Last night's randconfig for OMAP4430 failed with:
> > 
> > drivers/built-in.o:(.rodata+0x1a60): undefined reference to
> > `exynos4210_pin_ctrl'
> > 
> > Config and log:
> > http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2693
> > http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=2693
> 
> Oops, yeah right.

Hmm, I found the same thing earlier and it got lost in my backlog of unsubmitted
patches.

> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 7bf914d..18b473b 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -179,11 +179,13 @@ config PINCTRL_COH901
>  
>  config PINCTRL_SAMSUNG
>  	bool "Samsung pinctrl driver"
> +	depends on PLAT_SAMSUNG
>  	select PINMUX
>  	select PINCONF
>  
>  config PINCTRL_EXYNOS4
>  	bool "Pinctrl driver data for Exynos4 SoC"
> +	depends on PINCTRL_SAMSUNG && ARCH_EXYNOS4
>  	select PINCTRL_SAMSUNG

This won't work. A driver can't "select" and "depend on"
another symbol at the same time.

This is what I came up with earlier.

	Arnd
8<----------------
>From a15cc6277a3a43c8b5c1dd90ca71732b2ffe2b18 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Oct 2012 13:31:45 +0000
Subject: [PATCH] pinctrl: samsung: don't allow enabling pinctrl-samsung
 standalone

The main samsung pinctrl module references the specific exynos4210
pinctrl driver, which selects the main driver in Kconfig.

Making the main driver a silent "bool" option avoid this potential
build error if CONFIG_PINCTRL_SAMSUNG=y && CONFIG_PINCTRL_EXYNOS4=n:

drivers/built-in.o:(.rodata+0x4e4): undefined reference to `exynos4210_pin_ctrl'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 7bf914d..9f54bd4 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -178,7 +178,7 @@ config PINCTRL_COH901
 	  ports of 8 GPIO pins each.
 
 config PINCTRL_SAMSUNG
-	bool "Samsung pinctrl driver"
+	bool
 	select PINMUX
 	select PINCONF
 
