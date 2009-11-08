From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Nov 2009 16:53:50 +0000
Subject: [PATCH 1/6] pxa: support pxa168 LCD controller SPI operation
In-Reply-To: <7c34ac520911022245x2845e5dex1311bd74a08606db@mail.gmail.com>
References: <7c34ac520911022245x2845e5dex1311bd74a08606db@mail.gmail.com>
Message-ID: <20091108165350.GA28368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2009 at 02:45:20PM +0800, Jun Nie wrote:
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 84d8327..27bdf2b 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -29,10 +29,91 @@
>  #include <linux/uaccess.h>
>  #include <video/pxa168fb.h>
> 
> +#include <mach/pxa168fb.h>
> +#include <mach/gpio.h>

linux/gpio.h

> +int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
> +		unsigned int spi_gpio_cs, unsigned int interval_us)
> +{
> +	u32 x, spi_byte_len;
> +	u8 *cmd = (u8 *)value;
> +	int i, err, isr, iopad, ret = 0;
> +
> +	if (gpio_is_valid(spi_gpio_cs)) {
> +		err = gpio_request(spi_gpio_cs, "LCD_SPI_CS");
> +		if (err) {
> +			dev_err(fbi->dev, "failed to request GPIO for LCD CS\n");
> +			return -1;

Please stop using '-1' as a general error return value.  It has a specific
meaning, translating as "operation not permitted" or "permission denied".
This is not what this error is.  Always propagate error codes back when
you have them.
