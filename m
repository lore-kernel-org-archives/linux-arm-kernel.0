From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 8 Aug 2018 20:57:02 +0300
Subject: [PATCH 24/28] ARM: davinci: sffsdr: use device properties for
 at24 eeprom
In-Reply-To: <20180808153150.23444-25-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808153150.23444-25-brgl@bgdev.pl>
Message-ID: <CAHp75VfU6Dsge0XX5h18zjY9kJ73kFPevLT9j7vZBO__tNronw@mail.gmail.com>
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
>  arch/arm/mach-davinci/board-sffsdr.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
> index f6a4d094cbc3..680e5d7628a8 100644
> --- a/arch/arm/mach-davinci/board-sffsdr.c
> +++ b/arch/arm/mach-davinci/board-sffsdr.c
> @@ -26,7 +26,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
> -#include <linux/platform_data/at24.h>
> +#include <linux/property.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
> @@ -92,16 +92,15 @@ static struct platform_device davinci_sffsdr_nandflash_device = {
>         .resource       = davinci_sffsdr_nandflash_resource,
>  };
>
> -static struct at24_platform_data eeprom_info = {
> -       .byte_len       = (64*1024) / 8,
> -       .page_size      = 32,
> -       .flags          = AT24_FLAG_ADDR16,
> +static const struct property_entry eeprom_properties[] = {
> +       PROPERTY_ENTRY_U32("pagesize", 32),
> +       { },
>  };
>
>  static struct i2c_board_info __initdata i2c_info[] =  {
>         {
>                 I2C_BOARD_INFO("24c64", 0x50),
> -               .platform_data  = &eeprom_info,
> +               .properties = eeprom_properties,
>         },
>         /* Other I2C devices:
>          * MSP430,  addr 0x23 (not used)
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
