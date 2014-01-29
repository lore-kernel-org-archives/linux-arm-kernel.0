From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 30 Jan 2014 00:19:18 +0100
Subject: [PATCH v2] ARM: iop32x: fix power off handling for the EM7210
 board
In-Reply-To: <1391005215-8520-1-git-send-email-linus.walleij@linaro.org>
 (Linus Walleij's message of "Wed, 29 Jan 2014 15:20:15 +0100")
References: <1391005215-8520-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <87lhxyfkax.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> This board was missed when converting all the others to proper
> abstracted GPIO handling. Fix it up the right way by requesting
> and driving GPIO line 0 high through gpiolib to power off the
> machine.
>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Request the power off and set the power off hook with a
>   device_initcall() so we know the GPIO driver is available
>   when requesting the line.
> - Refer to POWER OFF rather than RESET everywhere.
>
> ARM SoC folks, if you're happy with this fix, please apply it
> directly to fixes in the ARM SoC tree.
> ---
>  arch/arm/mach-iop32x/em7210.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
> index 177cd073a83b..77e1ff057303 100644
> --- a/arch/arm/mach-iop32x/em7210.c
> +++ b/arch/arm/mach-iop32x/em7210.c
> @@ -23,6 +23,7 @@
>  #include <linux/mtd/physmap.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
> +#include <linux/gpio.h>
>  #include <mach/hardware.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> @@ -176,11 +177,35 @@ static struct platform_device em7210_serial_device = {
>  	.resource	= &em7210_uart_resource,
>  };
>  
> +#define EM7210_HARDWARE_POWER 0
> +
>  void em7210_power_off(void)
>  {
> -	*IOP3XX_GPOE &= 0xfe;
> -	*IOP3XX_GPOD |= 0x01;
> +	int ret;
> +
> +	ret = gpio_direction_output(EM7210_HARDWARE_POWER, 1);

btw, any reason for not using gpio_direction_output() in
em7210_request_gpios() and gpio_set_value() here ? (just wondering)

I can't test it on my ss4000e but at least this patch looks fine.

Arnaud
