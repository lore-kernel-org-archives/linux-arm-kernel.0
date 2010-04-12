From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 13 Apr 2010 01:57:51 +0800
Subject: [PATCH] mach-pxa/viper: Fix timeout usage for I2C
In-Reply-To: <1270390118-1802-1-git-send-email-w.sang@pengutronix.de>
References: <1270390118-1802-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <m2rf17812d71004121057n5131d025pb4965f45b61271f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 4, 2010 at 10:08 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> The timeout value is in jiffies, so it should be using HZ, not a plain
> number. Assume '100' means 100ms here and adapt accordingly.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marc Zyngier <maz@misterjones.org>
> Cc: Paul Shen <paul.shen@marvell.com>
> Cc: Mike Rapoport <mike@compulab.co.il>
> ---
>
> Janitorial fix, not tested due to no hardware.
>
> ?arch/arm/mach-pxa/viper.c | ? ?5 +++--
> ?1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
> index 1dd1334..c25921f 100644
> --- a/arch/arm/mach-pxa/viper.c
> +++ b/arch/arm/mach-pxa/viper.c
> @@ -33,6 +33,7 @@
> ?#include <linux/pm.h>
> ?#include <linux/sched.h>
> ?#include <linux/gpio.h>
> +#include <linux/jiffies.h>
> ?#include <linux/i2c-gpio.h>
> ?#include <linux/serial_8250.h>
> ?#include <linux/smc91x.h>
> @@ -453,7 +454,7 @@ static struct i2c_gpio_platform_data i2c_bus_data = {
> ? ? ? ?.sda_pin = VIPER_RTC_I2C_SDA_GPIO,
> ? ? ? ?.scl_pin = VIPER_RTC_I2C_SCL_GPIO,
> ? ? ? ?.udelay ?= 10,
> - ? ? ? .timeout = 100,
> + ? ? ? .timeout = HZ / 10,
> ?};
>
> ?static struct platform_device i2c_bus_device = {
> @@ -778,7 +779,7 @@ static void __init viper_tpm_init(void)
> ? ? ? ? ? ? ? ?.sda_pin = VIPER_TPM_I2C_SDA_GPIO,
> ? ? ? ? ? ? ? ?.scl_pin = VIPER_TPM_I2C_SCL_GPIO,
> ? ? ? ? ? ? ? ?.udelay ?= 10,
> - ? ? ? ? ? ? ? .timeout = 100,
> + ? ? ? ? ? ? ? .timeout = HZ / 10,
> ? ? ? ?};
> ? ? ? ?char *errstr;
>

One other better and cleaner approach to such inconsistency issue is
to have a timeout_ms field, and having i2c-gpio.c driver to convert this
to jiffies using msec_to_jiffies() at run-time.
