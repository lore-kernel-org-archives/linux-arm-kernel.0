From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 May 2014 13:30:54 +0200
Subject: [PATCH] pinctrl: sunxi: Fix recursive dependency
In-Reply-To: <1400343715-27884-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1400343715-27884-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <4667053.sVVFqnz4qh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 May 2014 18:21:55 Maxime Ripard wrote:
> Fix the following configuration error:
> drivers/pinctrl/sunxi/Kconfig:3:error: recursive dependency detected!
> drivers/pinctrl/sunxi/Kconfig:3:        symbol PINCTRL_SUNXI is selected by PINCTRL_SUN4I_A10
> drivers/pinctrl/sunxi/Kconfig:9:        symbol PINCTRL_SUN4I_A10 default value contains PINCTRL_SUNXI
> 
> Drop the select on PINCTRL_SUNXI, and make PINCTRL_SUNXI enabled by default instead.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I stubled over the same thing already, but came to a different conclusion.

>  drivers/pinctrl/sunxi/Kconfig | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index 2007327e0c48..8411857d2a45 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -1,32 +1,26 @@
>  if ARCH_SUNXI
>  
>  config PINCTRL_SUNXI
> -       bool
> +       def_bool ARCH_SUNXI
>         select PINMUX
>         select GENERIC_PINCONF
>  
>  config PINCTRL_SUN4I_A10
>         def_bool PINCTRL_SUNXI || MACH_SUN4I
> -       select PINCTRL_SUNXI
>  

This means you won't be able to stop selecting all drivers dropping
the 'select PINCTRL_SUNXI' later. How about this one?

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 2007327..75b71bb 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -2,31 +2,34 @@ if ARCH_SUNXI
 
 config PINCTRL_SUNXI
 	bool
+
+config PINCTRL_SUNXI_COMMON
+	bool
 	select PINMUX
 	select GENERIC_PINCONF
 
 config PINCTRL_SUN4I_A10
        def_bool PINCTRL_SUNXI || MACH_SUN4I
-       select PINCTRL_SUNXI
+       select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN5I_A10S
        def_bool PINCTRL_SUNXI || MACH_SUN5I
-       select PINCTRL_SUNXI
+       select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN5I_A13
        def_bool PINCTRL_SUNXI || MACH_SUN5I
-       select PINCTRL_SUNXI
+       select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN6I_A31
        def_bool PINCTRL_SUNXI || MACH_SUN6I
-       select PINCTRL_SUNXI
+       select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN6I_A31_R
        def_bool PINCTRL_SUNXI || MACH_SUN6I
-       select PINCTRL_SUNXI
+       select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN7I_A20
        def_bool PINCTRL_SUNXI || MACH_SUN7I
-       select PINCTRL_SUNXI
+       select PINCTRL_SUNXI_COMMON
 
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index 8e23a15..0f4461c 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -1,5 +1,5 @@
 # Core
-obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sunxi.o
+obj-$(CONFIG_PINCTRL_SUNXI_COMMON)	+= pinctrl-sunxi.o
 
 # SoC Drivers
 obj-$(CONFIG_PINCTRL_SUN4I_A10)		+= pinctrl-sun4i-a10.o
