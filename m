From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 7 Nov 2016 14:54:30 +0100
Subject: [PATCH] spi: atmel: use managed resource for gpio chip select
In-Reply-To: <CAMuHMdUQLkHn4=3U6TNjgTN--RUHZHsbwNu9dLdFrBJA0sx4aw@mail.gmail.com>
References: <20160921075528.14452-1-nicolas.ferre@atmel.com>
 <CAMuHMdUQLkHn4=3U6TNjgTN--RUHZHsbwNu9dLdFrBJA0sx4aw@mail.gmail.com>
Message-ID: <3f5b93d7-ee40-bb1a-2cfb-49fa193e2b9d@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/09/2016 ? 10:20, Geert Uytterhoeven a ?crit :
> Hi Nicolas,
> 
> On Wed, Sep 21, 2016 at 9:55 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>> Use the managed gpio CS pin request so that we avoid having trouble
>> in the cleanup code.
>> In fact, if module was configured with DT, cleanup code released
>> invalid pin.  Since resource wasn't freed, module cannot be reinserted.
>>
>> Reported-by: Alexander Morozov <linux@meltdown.ru>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  drivers/spi/spi-atmel.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
>> index 8feac599e9ab..4e3f2345844a 100644
>> --- a/drivers/spi/spi-atmel.c
>> +++ b/drivers/spi/spi-atmel.c
>> @@ -1248,7 +1248,8 @@ static int atmel_spi_setup(struct spi_device *spi)
>>                         return -ENOMEM;
>>
>>                 if (as->use_cs_gpios) {
>> -                       ret = gpio_request(npcs_pin, dev_name(&spi->dev));
>> +                       ret = devm_gpio_request(&spi->dev,
>> +                                               npcs_pin, dev_name(&spi->dev));
> 
> Note that spi_master.setup() can be called multiple times during the lifetime
> of the spi_device.

Sure, this is what I read in include/linux/spi/spi.h "It's always safe
to call this unless transfers are pending on the device whose settings
are being modified."

It also means that the whole memory allocation for devices that is done
a few lines above this gpio request is also completely wrong... This
function needs a serious refactoring.

Thanks for the heads-up.

Best regards,

>>                         if (ret) {
>>                                 kfree(asd);
>>                                 return ret;
>> @@ -1471,13 +1472,11 @@ static int atmel_spi_transfer_one_message(struct spi_master *master,
>>  static void atmel_spi_cleanup(struct spi_device *spi)
>>  {
>>         struct atmel_spi_device *asd = spi->controller_state;
>> -       unsigned                gpio = (unsigned long) spi->controller_data;
>>
>>         if (!asd)
>>                 return;
>>
>>         spi->controller_state = NULL;
>> -       gpio_free(gpio);
>>         kfree(asd);
>>  }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Nicolas Ferre
