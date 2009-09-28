From: rabin@rab.in (Rabin Vincent)
Date: Mon, 28 Sep 2009 07:16:28 +0530
Subject: [PATCH] Fix U300 generic GPIO, remove ifdefs from MMCI
In-Reply-To: <1254078501-11745-1-git-send-email-linus.walleij@stericsson.com>
References: <1254078501-11745-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20090928014628.GA15318@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2009 at 09:08:21PM +0200, Linus Walleij wrote:
> The #ifdefs in the MMCI driver were erroneous and just masking
> a bug in the U300 generic GPIO implementation. This removes the
> ifdefs and fixes the U300 generic GPIO instead.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  arch/arm/mach-u300/gpio.c              |    8 ++++++++
>  arch/arm/mach-u300/include/mach/gpio.h |    1 +
>  drivers/mmc/host/mmci.c                |    2 --
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-u300/gpio.c b/arch/arm/mach-u300/gpio.c
> index 63c8f27..ce268ef 100644
> --- a/arch/arm/mach-u300/gpio.c
> +++ b/arch/arm/mach-u300/gpio.c
> @@ -281,6 +281,14 @@ int gpio_unregister_callback(unsigned gpio)
>  }
>  EXPORT_SYMBOL(gpio_unregister_callback);
>  
> +int gpio_is_valid(int number)
> +{
> +	if (number < (U300_GPIO_NUM_PORTS * U300_GPIO_PINS_PER_PORT))
> +		return 0;
> +	return -EINVAL;
> +}

gpio_is_valid() should return non-zero if the GPIO is valid, and zero
if it's not.   Also, number may be negative so this function needs to
check for that.

Rabin
