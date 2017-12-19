From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 19 Dec 2017 19:56:01 +0530
Subject: [PATCH] i2c/ARM: davinci: Deep refactoring of I2C recovery
In-Reply-To: <20171208133132.17099-1-linus.walleij@linaro.org>
References: <20171208133132.17099-1-linus.walleij@linaro.org>
Message-ID: <63b45c19-8961-bf2d-c6bb-4cd4024b3cbf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 December 2017 07:01 PM, Linus Walleij wrote:
> Alter the DaVinci GPIO recovery fetch to use descriptors
> all the way down into the board files.
> 
> Cc: arm at kernel.org
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> It turns out someone else was busy doing the same thing I was
> doing. Trying to carry over the useful part with this patch!
> A Tested-by or ACK from a DaVinci maintainer would be
> appreciated, also an ACK from and ARM SoC maintainer.
> The patch can be easily tested by applying on top of
> linux-next.

This patch causes I2C probe failure on DM6446 EVM.

> ---
>  arch/arm/mach-davinci/board-dm355-evm.c   | 15 +++++++++++++--
>  arch/arm/mach-davinci/board-dm644x-evm.c  | 15 +++++++++++++--
>  drivers/i2c/busses/i2c-davinci.c          | 21 +++++++++++----------
>  include/linux/platform_data/i2c-davinci.h |  5 ++---
>  4 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
> index 62e7bc3018f0..60aec5437276 100644
> --- a/arch/arm/mach-davinci/board-dm355-evm.c
> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
> @@ -17,6 +17,7 @@
>  #include <linux/mtd/rawnand.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/clk.h>
>  #include <linux/videodev2.h>
>  #include <media/i2c/tvp514x.h>
> @@ -108,11 +109,20 @@ static struct platform_device davinci_nand_device = {
>  	},
>  };
>  
> +static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
> +	.dev_id = "i2c_davinci",
> +	.table = {
> +		GPIO_LOOKUP("davinci_gpio.0", 15, "sda",

This should just be "davinci_gpio"

> +			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
> +		GPIO_LOOKUP("davinci_gpio.0", 14, "scl",

This too

> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> index b07c9b18d427..2efc6dbc5ac0 100644
> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> @@ -13,6 +13,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_data/pcf857x.h>
>  #include <linux/platform_data/at24.h>
> @@ -595,18 +596,28 @@ static struct i2c_board_info __initdata i2c_info[] =  {
>  	},
>  };
>  
> +static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
> +	.dev_id = "i2c_davinci",
> +	.table = {
> +		GPIO_LOOKUP("davinci_gpio.0", 44, "sda",
> +			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
> +		GPIO_LOOKUP("davinci_gpio.0", 43, "scl",
> +			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
> +	},
> +};

And these too.

With that fixed, please add:

Acked-by: Sekhar Nori <nsekhar@ti.com>

I could not test the recovery itself, but the probe succeeds.

It would be nice if this can be split into platform and driver parts to
avoid any conflicts, but that does not seem straightforward.

FWIW, the patch does not clash with anything I have queued ATM.

Thanks,
Sekhar
