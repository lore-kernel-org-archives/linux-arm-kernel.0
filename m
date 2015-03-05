From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 05 Mar 2015 09:03:32 +0100
Subject: [PATCH v5 3/8] pinctrl: cygnus: add initial IOMUX driver support
In-Reply-To: <1425515756-321-4-git-send-email-rjui@broadcom.com>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
 <1425515756-321-4-git-send-email-rjui@broadcom.com>
Message-ID: <1425542612.24292.180.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-03-04 at 16:35 -0800, Ray Jui wrote:
> diff --git a/drivers/pinctrl/bcm/Kconfig b/drivers/pinctrl/bcm/Kconfig
> index bc6d048..eb13201 100644
> --- a/drivers/pinctrl/bcm/Kconfig
> +++ b/drivers/pinctrl/bcm/Kconfig
> @@ -19,3 +19,16 @@ config PINCTRL_BCM2835
>  	bool
>  	select PINMUX
>  	select PINCONF
> +
> +config PINCTRL_CYGNUS_MUX
> +	bool "Broadcom Cygnus IOMUX driver"

bool type.

> +	depends on (ARCH_BCM_CYGNUS || COMPILE_TEST)
> +	select PINMUX
> +	select GENERIC_PINCONF
> +	default ARCH_BCM_CYGNUS
> +	help
> +	  Say yes here to enable the Broadcom Cygnus IOMUX driver.
> +
> +	  The Broadcom Cygnus IOMUX driver supports group based IOMUX
> +	  configuration, with the exception that certain individual pins
> +	  can be overrided to GPIO function
> diff --git a/drivers/pinctrl/bcm/Makefile b/drivers/pinctrl/bcm/Makefile
> index 7ba80a3..bb6beb6 100644
> --- a/drivers/pinctrl/bcm/Makefile
> +++ b/drivers/pinctrl/bcm/Makefile
> @@ -1,4 +1,5 @@
>  # Broadcom pinctrl support
>  
> -obj-$(CONFIG_PINCTRL_BCM281XX)	+= pinctrl-bcm281xx.o
> -obj-$(CONFIG_PINCTRL_BCM2835)	+= pinctrl-bcm2835.o
> +obj-$(CONFIG_PINCTRL_BCM281XX)		+= pinctrl-bcm281xx.o
> +obj-$(CONFIG_PINCTRL_BCM2835)		+= pinctrl-bcm2835.o
> +obj-$(CONFIG_PINCTRL_CYGNUS_MUX)	+= pinctrl-cygnus-mux.o

So pinctrl-cygnus-mux.o will be built-in (or not built, of course).

> diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
> new file mode 100644
> index 0000000..f9a9283
> --- /dev/null
> +++ b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
> @@ -0,0 +1,1022 @@
>[...]
> +MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
> +MODULE_DESCRIPTION("Broadcom Cygnus IOMUX driver");
> +MODULE_LICENSE("GPL v2");

These three macros will be preprocessed away. (And I guess you could
also drop the linux/module.h include, but I haven't actually tested that
guess.)


Paul Bolle
