From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 8 Aug 2018 20:58:04 +0300
Subject: [PATCH 27/28] ARM: davinci: mityomapl138: use device properties
 for at24 eeprom
In-Reply-To: <20180808153150.23444-28-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808153150.23444-28-brgl@bgdev.pl>
Message-ID: <CAHp75VdBkSHtqXkzRJgOHwaL5UhgV+TgySjEs57bisbKTpO4SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
>
> Remove the at24_platform_data structure and replace it with an array
> of property entries. Drop the byte_len/size property, as the model name
> already implies the EEPROM's size.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-mityomapl138.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index 17b67e26bc0e..be0fb7d17e25 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -14,11 +14,11 @@
>  #include <linux/init.h>
>  #include <linux/console.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/notifier.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/i2c.h>
> -#include <linux/platform_data/at24.h>
>  #include <linux/etherdevice.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/flash.h>
> @@ -185,10 +185,9 @@ static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
>         }
>  };
>
> -static struct at24_platform_data mityomapl138_fd_chip = {
> -       .byte_len       = 256,
> -       .page_size      = 8,
> -       .flags          = AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
> +static const struct property_entry mityomapl138_fd_chip_properties[] = {
> +       PROPERTY_ENTRY_U32("pagesize", 8),
> +       PROPERTY_ENTRY_BOOL("read-only"),
>  };
>
>  static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
> @@ -317,7 +316,7 @@ static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
>         },
>         {
>                 I2C_BOARD_INFO("24c02", 0x50),
> -               .platform_data = &mityomapl138_fd_chip,
> +               .properties = mityomapl138_fd_chip_properties,
>         },
>  };
>
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
