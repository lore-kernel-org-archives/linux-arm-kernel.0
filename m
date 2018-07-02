From: groeck@google.com (Guenter Roeck)
Date: Mon, 2 Jul 2018 07:39:45 -0700
Subject: [PATCH 1/3] platform/chrome: Move cros-ec transport drivers to
 drivers/platform.
In-Reply-To: <20180702102201.13461-2-enric.balletbo@collabora.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
 <20180702102201.13461-2-enric.balletbo@collabora.com>
Message-ID: <CABXOdTcWnCTbn4NTmyZY53asOVXB47Uc2PNV4WC-kwbXU5tj3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 3:22 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> There are some cros-ec transport drivers (I2C, SPI) living in MFD, while
> others (LPC) living in drivers/platform. The transport drivers are more
> platform specific. So, move the I2C and SPI transport drivers to the
> platform/chrome directory. The patch also removes the MFD_ prefix of
> their Kconfig symbols.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/mfd/Kconfig                           | 20 -------------------
>  drivers/mfd/Makefile                          |  2 --
>  drivers/platform/chrome/Kconfig               | 20 +++++++++++++++++++
>  drivers/platform/chrome/Makefile              |  2 ++
>  .../{mfd => platform/chrome}/cros_ec_i2c.c    |  0
>  .../{mfd => platform/chrome}/cros_ec_spi.c    |  0
>  6 files changed, 22 insertions(+), 22 deletions(-)
>  rename drivers/{mfd => platform/chrome}/cros_ec_i2c.c (100%)
>  rename drivers/{mfd => platform/chrome}/cros_ec_spi.c (100%)
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5aa194..013458e728dc 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -202,26 +202,6 @@ config MFD_CROS_EC
>           You also need to enable the driver for the bus you are using. The
>           protocol for talking to the EC is defined by the bus driver.
>
> -config MFD_CROS_EC_I2C
> -       tristate "ChromeOS Embedded Controller (I2C)"
> -       depends on MFD_CROS_EC && I2C
> -
> -       help
> -         If you say Y here, you get support for talking to the ChromeOS
> -         EC through an I2C bus. This uses a simple byte-level protocol with
> -         a checksum. Failing accesses will be retried three times to
> -         improve reliability.
> -
> -config MFD_CROS_EC_SPI
> -       tristate "ChromeOS Embedded Controller (SPI)"
> -       depends on MFD_CROS_EC && SPI
> -
> -       ---help---
> -         If you say Y here, you get support for talking to the ChromeOS EC
> -         through a SPI bus, using a byte-level protocol. Since the EC's
> -         response time cannot be guaranteed, we support ignoring
> -         'pre-amble' bytes before the response actually starts.
> -
>  config MFD_CROS_EC_CHARDEV
>          tristate "Chrome OS Embedded Controller userspace device interface"
>          depends on MFD_CROS_EC
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e9fd20dba18d..d13e859d7c1e 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -14,8 +14,6 @@ obj-$(CONFIG_MFD_BCM590XX)    += bcm590xx.o
>  obj-$(CONFIG_MFD_BD9571MWV)    += bd9571mwv.o
>  cros_ec_core-objs              := cros_ec.o
>  obj-$(CONFIG_MFD_CROS_EC)      += cros_ec_core.o
> -obj-$(CONFIG_MFD_CROS_EC_I2C)  += cros_ec_i2c.o
> -obj-$(CONFIG_MFD_CROS_EC_SPI)  += cros_ec_spi.o
>  obj-$(CONFIG_MFD_CROS_EC_CHARDEV) += cros_ec_dev.o
>  obj-$(CONFIG_MFD_EXYNOS_LPASS) += exynos-lpass.o
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index cb0df9eb3e0f..16b1615958aa 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -52,6 +52,26 @@ config CHROMEOS_TBMC
>  config CROS_EC_CTL
>          tristate
>
> +config CROS_EC_I2C
> +       tristate "ChromeOS Embedded Controller (I2C)"
> +       depends on MFD_CROS_EC && I2C
> +
> +       help
> +         If you say Y here, you get support for talking to the ChromeOS
> +         EC through an I2C bus. This uses a simple byte-level protocol with
> +         a checksum. Failing accesses will be retried three times to
> +         improve reliability.
> +
> +config CROS_EC_SPI
> +       tristate "ChromeOS Embedded Controller (SPI)"
> +       depends on MFD_CROS_EC && SPI
> +
> +       ---help---
> +         If you say Y here, you get support for talking to the ChromeOS EC
> +         through a SPI bus, using a byte-level protocol. Since the EC's
> +         response time cannot be guaranteed, we support ignoring
> +         'pre-amble' bytes before the response actually starts.
> +
>  config CROS_EC_LPC
>          tristate "ChromeOS Embedded Controller (LPC)"
>          depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index e44c37a63fa9..cd591bf872bb 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -6,6 +6,8 @@ obj-$(CONFIG_CHROMEOS_TBMC)             += chromeos_tbmc.o
>  cros_ec_ctl-objs                       := cros_ec_sysfs.o cros_ec_lightbar.o \
>                                            cros_ec_vbc.o cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_CTL)              += cros_ec_ctl.o
> +obj-$(CONFIG_CROS_EC_I2C)              += cros_ec_i2c.o
> +obj-$(CONFIG_CROS_EC_SPI)              += cros_ec_spi.o
>  cros_ec_lpcs-objs                      := cros_ec_lpc.o cros_ec_lpc_reg.o
>  cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC) += cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)              += cros_ec_lpcs.o
> diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> similarity index 100%
> rename from drivers/mfd/cros_ec_i2c.c
> rename to drivers/platform/chrome/cros_ec_i2c.c
> diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> similarity index 100%
> rename from drivers/mfd/cros_ec_spi.c
> rename to drivers/platform/chrome/cros_ec_spi.c
> --
> 2.18.0
>
