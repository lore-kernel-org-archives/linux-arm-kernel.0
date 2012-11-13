From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 Nov 2012 14:11:35 +0900
Subject: Build failure: OMAP4430 failed due to exynos4 pinctrl
In-Reply-To: <201211121440.13980.arnd@arndb.de>
References: <007b01cdc0bf$50c9ee70$f25dcb50$%kim@samsung.com>
 <201211121440.13980.arnd@arndb.de>
Message-ID: <01a601cdc15d$5a4c46c0$0ee4d440$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 

[...]

> This won't work. A driver can't "select" and "depend on"
> another symbol at the same time.
> 
Ooooops. You're right. I missed :-(

> This is what I came up with earlier.
> 
> 	Arnd
> 8<----------------
> From a15cc6277a3a43c8b5c1dd90ca71732b2ffe2b18 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 10 Oct 2012 13:31:45 +0000
> Subject: [PATCH] pinctrl: samsung: don't allow enabling pinctrl-samsung
>  standalone
> 
> The main samsung pinctrl module references the specific exynos4210
> pinctrl driver, which selects the main driver in Kconfig.
> 
> Making the main driver a silent "bool" option avoid this potential
> build error if CONFIG_PINCTRL_SAMSUNG=y && CONFIG_PINCTRL_EXYNOS4=n:
> 
> drivers/built-in.o:(.rodata+0x4e4): undefined reference to
> `exynos4210_pin_ctrl'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Linus, can you pick this up in your pinctrl/fixes ree?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> 
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 7bf914d..9f54bd4 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -178,7 +178,7 @@ config PINCTRL_COH901
>  	  ports of 8 GPIO pins each.
> 
>  config PINCTRL_SAMSUNG
> -	bool "Samsung pinctrl driver"
> +	bool
>  	select PINMUX
>  	select PINCONF
> 
