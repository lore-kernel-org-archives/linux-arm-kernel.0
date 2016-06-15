From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 15 Jun 2016 13:36:46 +0100
Subject: [PATCH v2 03/10] mfd: ac100: Add driver for X-Powers AC100 audio
 codec / RTC combo IC
In-Reply-To: <1465986467-14802-4-git-send-email-wens@csie.org>
References: <1465986467-14802-1-git-send-email-wens@csie.org>
 <1465986467-14802-4-git-send-email-wens@csie.org>
Message-ID: <20160615123646.GD4948@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jun 2016, Chen-Yu Tsai wrote:

> The AC100 is a multifunction device with an audio codec subsystem and
> an RTC subsystem. These two subsystems share a common register space
> and host interface.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Change log?

>  drivers/mfd/Kconfig       |  10 +++
>  drivers/mfd/Makefile      |   2 +
>  drivers/mfd/ac100.c       | 135 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ac100.h | 176 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 323 insertions(+)
>  create mode 100644 drivers/mfd/ac100.c
>  create mode 100644 include/linux/mfd/ac100.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 1bcf601de5bc..bd83849a0c8d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -101,6 +101,16 @@ config MFD_BCM590XX
>  	help
>  	  Support for the BCM590xx PMUs from Broadcom
>  
> +config MFD_AC100
> +	tristate "X-Powers AC100"
> +	select MFD_CORE
> +	depends on SUNXI_RSB
> +	help
> +	  If you say Y here you get support for the X-Powers AC100 audio codec
> +	  IC.
> +	  This driver include only the core APIs. You have to select individual
> +	  components like codecs or RTC under the corresponding menus.
> +
>  config MFD_AXP20X
>  	tristate
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 42a66e19e191..60f9a6b0557c 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -113,6 +113,8 @@ obj-$(CONFIG_PMIC_DA9052)	+= da9052-irq.o
>  obj-$(CONFIG_PMIC_DA9052)	+= da9052-core.o
>  obj-$(CONFIG_MFD_DA9052_SPI)	+= da9052-spi.o
>  obj-$(CONFIG_MFD_DA9052_I2C)	+= da9052-i2c.o
> +
> +obj-$(CONFIG_MFD_AC100)		+= ac100.o
>  obj-$(CONFIG_MFD_AXP20X)	+= axp20x.o
>  obj-$(CONFIG_MFD_AXP20X_I2C)	+= axp20x-i2c.o
>  obj-$(CONFIG_MFD_AXP20X_RSB)	+= axp20x-rsb.o
> diff --git a/drivers/mfd/ac100.c b/drivers/mfd/ac100.c
> new file mode 100644
> index 000000000000..15d24fa77771
> --- /dev/null
> +++ b/drivers/mfd/ac100.c
> @@ -0,0 +1,135 @@
> +/*
> + * ac100.c - MFD core driver for X-Powers' AC100 Audio Codec IC

Nit: Drop the filename here.

Apart from that:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
