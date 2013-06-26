From: christian.ruppert@abilis.com (Christian Ruppert)
Date: Wed, 26 Jun 2013 15:15:43 +0200
Subject: [PATCH] pinctrl: elaborate a bit on arrangements in doc
In-Reply-To: <1372169952-22439-1-git-send-email-linus.walleij@stericsson.com>
References: <1372169952-22439-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130626131543.GD7095@ab42.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 04:19:12PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This elaborates a bit on the pinctrl vs GPIO arangements
> in the hardware.
> 
> Inspired by some drawings in a mail from Christian
> Ruppert.
> 
> Cc: Rob Landley <rob@landley.net>
> Cc: Christian Ruppert <christian.ruppert@abilis.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/pinctrl.txt | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
> index 447fd4c..41ecad0 100644
> --- a/Documentation/pinctrl.txt
> +++ b/Documentation/pinctrl.txt
> @@ -784,11 +784,38 @@ special GPIO-handler is registered.
>  GPIO mode pitfalls
>  ==================
>  
> -Sometime the developer may be confused by a datasheet talking about a pin
> -being possible to set into "GPIO mode". It appears that what hardware
> -engineers mean with "GPIO mode" is not necessarily the use case that is
> -implied in the kernel interface <linux/gpio.h>: a pin that you grab from
> -kernel code and then either listen for input or drive high/low to
> +The GPIO portions of a pin and its relation to a certain pin controller
> +logic can be constructed in several ways. Here are three examples:
> +
> +(A)
> +
> +                                         +- SPI
> +     Physical pins --- GPIO --- pinctrl -+- I2C
> +                                         +- mmc
> +
> +(B)
> +                    +- GPIO
> +     Physical pins -+           +- SPI
> +                    +- pinctrl -+- I2C
> +                                +- mmc
> +
> +(C)
> +                                +- SPI
> +     Physical pins --- pinctrl -+- I2C
> +                                +- mmc
> +                                +- GPIO
> +
> +In (A) the GPIO-like functionality of the pin is *always* available.
> +For example it is possible to read the GPIO input register to "spy" on
> +the SPI, I2C or MMC line while it is being used by the peripheral.
> +In (B) the GPIO functionality is orthogonal to any device using the
> +pin, and in (C) the GPIO case is the same as "some peripheral".
> +
> +For this reason the developer may be confused by a datasheet talking
> +about a pin being possible to set into "GPIO mode". It appears that what
> +hardware engineers mean with "GPIO mode" is not necessarily the use case
> +that is implied in the kernel interface <linux/gpio.h>: a pin that you
> +grab from kernel code and then either listen for input or drive high/low to
>  assert/deassert some external line.
>  
>  Rather hardware engineers think that "GPIO mode" means that you can
> -- 
> 1.7.11.3

In my experience, in hardware engineering terminology, GPIO/General
Purpose I/O just means a physical pad macro cell which can be
dynamically configured in different modes, e.g. as an input or as an
output, as an open drain driver etc. This configuration is done through
hardware signals and controlled by digital logic. This logic might
either be a GPIO controller or some other hardware block, e.g. an I2C
controller block.

Hardware GPIOs have nothing to do with the concept of GPIOs from the
Linux kernel point of view where a GPIO is a swoftware controllable pin
with a similar configuration space as "hardware GPIOs". To put it
simple, a software GPIO is a hardware GPIO plus some digital logic which
implements a register interface to drive all the hardware GPIO's control
lines from software.

In some cases, both modes are combined, e.g. one can imagine an SPI
interface where the output levels are driven from an SPI controller
hardware block and other parameters such as the drive strength or
integrated pull-up/pull-down resistors are controlled through some
independent mechanism. The parameters controlled through that
independent mechanism are sometimes referred to as the GPIO mode of the
pin.

-- 
  Christian Ruppert              ,          <christian.ruppert@abilis.com>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr?-Fleuri
                             _// | bilis Systems   CH-1228 Plan-les-Ouates
