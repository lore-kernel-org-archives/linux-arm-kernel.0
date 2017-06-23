From: jeffy.chen@rock-chips.com (jeffy)
Date: Fri, 23 Jun 2017 12:02:09 +0800
Subject: [PATCH v3 1/3] spi: rockchip: add support for "cs-gpios" dts
 property
In-Reply-To: <CAD=FV=WqhOUqf+JP2=m0Jt5dHqB_FqKLEw2SZTQtBbEv41+u_A@mail.gmail.com>
References: <1497411483-23377-1-git-send-email-jeffy.chen@rock-chips.com>
 <CAD=FV=WqhOUqf+JP2=m0Jt5dHqB_FqKLEw2SZTQtBbEv41+u_A@mail.gmail.com>
Message-ID: <594C92C1.1040704@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi doug,

Thanx for your comments.

On 06/23/2017 05:41 AM, Doug Anderson wrote:
> Hi,
>
> On Tue, Jun 13, 2017 at 8:38 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> Support using "cs-gpios" property to specify cs gpios.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v3:
>> include linux/gpio/consumer.h for compile errors on ARCH_X86
>> (reported by kbuild test robot <lkp@intel.com>)
>>
>> Changes in v2:
>> 1/ request cs gpios in probe for better error handling
>> 2/ use gpiod* function
>> (suggested by Heiko Stuebner)
>> 3/ split dt-binding changes to new patch
>> (suggested by Shawn Lin & Heiko Stuebner)
>>
>>   drivers/spi/spi-rockchip.c | 31 ++++++++++++++++++++++++++++++-
>>   1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
>> index bab9b13..4bcf251 100644
>> --- a/drivers/spi/spi-rockchip.c
>> +++ b/drivers/spi/spi-rockchip.c
>> @@ -16,7 +16,8 @@
>>   #include <linux/clk.h>
>>   #include <linux/dmaengine.h>
>>   #include <linux/module.h>
>> -#include <linux/of.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/of_gpio.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/spi/spi.h>
>> @@ -663,6 +664,27 @@ static bool rockchip_spi_can_dma(struct spi_master *master,
>>          return (xfer->len > rs->fifo_len);
>>   }
>>
>> +static int rockchip_spi_setup_cs_gpios(struct device *dev)
>> +{
>> +       struct device_node *np = dev->of_node;
>> +       struct gpio_desc *cs_gpio;
>> +       int i, nb;
>> +
>> +       if (!np)
>> +               return 0;
>
> Not sure you really to check for NULL "np".  Do we really run properly
> without device tree?  We already call of_property_read_u32()
> unconditionally...
hmm, right
>
>
>> +
>> +       nb = of_gpio_named_count(np, "cs-gpios");
>> +       for (i = 0; i < nb; i++) {
>
> Implicitly if there is any error getting "cs-gpios" (AKA if it doesn't
> exist) you'll return a negative value here, then return "0" for the
> function.  AKA cs-gpios is optional...  The behavior is correct, but
> it's a bit non-obvious.  Personally I would have at least put a
> comment even if you didn't put an explicit check.
ok
>
>
>> +               /* We support both GPIO CS and HW CS */
>> +               cs_gpio = devm_gpiod_get_index_optional(dev, "cs",
>> +                                                       i, GPIOD_ASIS);
>> +               if (IS_ERR(cs_gpio))
>> +                       return PTR_ERR(cs_gpio);
>
> As per your discussion with Brian, your whole reason for having this
> function is that:
>
> 1. Core SPI framework treats errors getting the GPIO as non-fatal (SPI
> framework falls back on using the HW chip select).
>
> Mark is the expert, but IMHO that seems like a bug in the core SPI
> framework and you should fix it there rather than hacking around in
> the driver.  _In theory_ you could break backward compatibility
> (someone could have been relying on the old behavior that an error
> caused you to fallback to the HW chip select), but I think that's not
> likely as long as you handle things like:
>
>    cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
>
> AKA if someone has explicitly specified <0> for the GPIO then _that_
> shouldn't be an error and we should do the fallback to HW chip select.
> If we really expect old buggy DTS files that get broken by the old
> behavior then we'd have to ask for advice from Mark and/or device tree
> experts...
right, it would be good to be handled in the spi core.
and i think devm_gpiod_get_index_optional would take care of the <0> 
fallback case
>
>
> As evidence that the current SPI core is broken in the way it is and
> could use a patch, it would be easy to "fall back" to a chip select
> that's greater than "master->num_chipselect", which seems to me like a
> clear bug.
>
> --
>
> 2. The SPI framework doesn't end up calling gpiod_request().  It seems
> like it ought to.  Requiring the sub driver to do this seems wrong.
>
>
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static int rockchip_spi_probe(struct platform_device *pdev)
>>   {
>>          int ret = 0;
>> @@ -749,6 +771,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
>>          master->transfer_one = rockchip_spi_transfer_one;
>>          master->max_transfer_size = rockchip_spi_max_transfer_size;
>>          master->handle_err = rockchip_spi_handle_err;
>> +       master->flags = SPI_MASTER_GPIO_SS;
>
> IMHO this one line in your patch makes total sense and it seems like
> you could post it by itself and it could land.  All the error check
> and gpiod_request() bikeshedding could be deferred to a separate
> patch.
ok, that make sense, will do in next version.
>
>
>
