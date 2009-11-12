From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Nov 2009 22:17:53 +0000
Subject: [PATCH 1/8] pxa: support pxa168 LCD controller SPI operation
In-Reply-To: <7c34ac520911111816q22dcf293r98d67a588bf83913@mail.gmail.com>
References: <7c34ac520911100012s3504b2ek75670ecb057692a7@mail.gmail.com>
	<7c34ac520911111816q22dcf293r98d67a588bf83913@mail.gmail.com>
Message-ID: <20091112221753.GD12308@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 10:16:16AM +0800, Jun Nie wrote:
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 84d8327..e1f1c5f 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -27,12 +27,90 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/uaccess.h>
> +#include <linux/gpio.h>
>  #include <video/pxa168fb.h>
>  
> +#include <mach/gpio.h>

If you include linux/gpio.h, then if the right configuration symbol
(CONFIG_GENERIC_GPIO) is selected, asm/gpio.h and therefore mach/gpio.h
will be included for you.

> +static inline void spi_gpio_assert(int spi_gpio_cs, int val)
> +{
> +	       if (gpio_is_valid(spi_gpio_cs))
> +		                      gpio_set_value(spi_gpio_cs, val);

This seems to have style problems - please run it through checkpatch.
