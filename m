From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 05 Mar 2015 09:11:44 +0100
Subject: [PATCH v5 6/8] pinctrl: cygnus: add gpio/pinconf driver
In-Reply-To: <1425515756-321-7-git-send-email-rjui@broadcom.com>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
 <1425515756-321-7-git-send-email-rjui@broadcom.com>
Message-ID: <1425543104.24292.185.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-03-04 at 16:35 -0800, Ray Jui wrote:
> --- a/drivers/pinctrl/bcm/Kconfig
> +++ b/drivers/pinctrl/bcm/Kconfig
> @@ -20,6 +20,28 @@ config PINCTRL_BCM2835
>  	select PINMUX
>  	select PINCONF
>  
> +config PINCTRL_CYGNUS_GPIO
> +	bool "Broadcom Cygnus GPIO (with PINCONF) driver"

bool type.

> +	depends on OF_GPIO && ARCH_BCM_CYGNUS
> +	select GPIOLIB_IRQCHIP
> +	select PINCONF
> +	select GENERIC_PINCONF
> +	default ARCH_BCM_CYGNUS
> +	help
> +	  Say yes here to enable the Broadcom Cygnus GPIO driver.
> +
> +	  The Broadcom Cygnus SoC has 3 GPIO controllers including the ASIU
> +	  GPIO controller (ASIU), the chipCommonG GPIO controller (CCM), and
> +	  the always-ON GPIO controller (CRMU/AON). All 3 GPIO controllers are
> +	  supported by this driver.
> +
> +	  All 3 Cygnus GPIO controllers support basic PINCONF functions such
> +	  as bias pull up, pull down, and drive strength configurations, when
> +	  these pins are muxed to GPIO.
> +
> +	  Pins from the ASIU GPIO can be individually muxed to GPIO function,
> +	  through interaction with the Cygnus IOMUX controller.
> +
>  config PINCTRL_CYGNUS_MUX
>  	bool "Broadcom Cygnus IOMUX driver"
>  	depends on (ARCH_BCM_CYGNUS || COMPILE_TEST)
> diff --git a/drivers/pinctrl/bcm/Makefile b/drivers/pinctrl/bcm/Makefile
> index bb6beb6..2b2f70e 100644
> --- a/drivers/pinctrl/bcm/Makefile
> +++ b/drivers/pinctrl/bcm/Makefile
> @@ -2,4 +2,5 @@
>  
>  obj-$(CONFIG_PINCTRL_BCM281XX)		+= pinctrl-bcm281xx.o
>  obj-$(CONFIG_PINCTRL_BCM2835)		+= pinctrl-bcm2835.o
> +obj-$(CONFIG_PINCTRL_CYGNUS_GPIO)	+= pinctrl-cygnus-gpio.o

So pinctrl-cygnus-gpio. will be built-in or not built at all.

>  obj-$(CONFIG_PINCTRL_CYGNUS_MUX)	+= pinctrl-cygnus-mux.o
> diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
> new file mode 100644
> index 0000000..4687284
> --- /dev/null
> +++ b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
> @@ -0,0 +1,884 @@

[...]

> +MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
> +MODULE_DESCRIPTION("Broadcom Cygnus GPIO Driver");
> +MODULE_LICENSE("GPL v2");

These three macros will be preprocessed away. (There's also
MODULE_DEVICE_TABLE. I don't yet know how that is handled in a
non-modular build, sorry.)


Paul Bolle
