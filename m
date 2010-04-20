From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 20 Apr 2010 08:20:46 +0800
Subject: [PATCH V2] mach-pxa/viper: Fix timeout usage for I2C
In-Reply-To: <1271591309-22567-1-git-send-email-w.sang@pengutronix.de>
References: <20100412213235.1688dda8@hyperion.delvare>
	<1271591309-22567-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <z2xf17812d71004191720o3f8660a4kdd31ef9cdb6beae9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 18, 2010 at 7:48 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> The timeout value is in jiffies, so it should be using HZ, not a plain
> number. Assume with HZ=100 '100' means 1s here and adapt accordingly.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marc Zyngier <maz@misterjones.org>
> Cc: Paul Shen <paul.shen@marvell.com>
> Cc: Mike Rapoport <mike@compulab.co.il>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>
> Changes since V1:
>
> * Don't assume 100 means 100ms
>
> Thanks for the comments!
>
> Admitted, the first try was a really bad guess. Maybe I got distracted from the
> previous patch for another arch where the value was 10000.
>
> While this may still not be the favoured solution for Eric, I think it is at
> least better than before, so it might be worth applying after all?

Ack. The clearest fix would involve more code to be updated, which
can be postponed. This fix, at least, makes the time quantity clearer.

>
> Janitorial fix, not tested due to no hardware.
>
> ?arch/arm/mach-pxa/viper.c | ? ?5 +++--
> ?1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
> index 1dd1334..12cf38c 100644
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
> + ? ? ? .timeout = HZ,
> ?};
>
> ?static struct platform_device i2c_bus_device = {
> @@ -778,7 +779,7 @@ static void __init viper_tpm_init(void)
> ? ? ? ? ? ? ? ?.sda_pin = VIPER_TPM_I2C_SDA_GPIO,
> ? ? ? ? ? ? ? ?.scl_pin = VIPER_TPM_I2C_SCL_GPIO,
> ? ? ? ? ? ? ? ?.udelay ?= 10,
> - ? ? ? ? ? ? ? .timeout = 100,
> + ? ? ? ? ? ? ? .timeout = HZ,
> ? ? ? ?};
> ? ? ? ?char *errstr;
>
> --
> 1.7.0
>
>
