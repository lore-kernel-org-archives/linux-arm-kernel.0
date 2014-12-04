From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Thu, 04 Dec 2014 14:49:44 +0800
Subject: [PATCH v3 1/2] ARM: hip04: set ARCH_NR_GPIO to 128
In-Reply-To: <142367414.tx9doeBDv9@wuerfel>
References: <1417156188-500-1-git-send-email-wangzhou.bry@gmail.com>
 <CACRpkdb1nZN-vOXLC-QFUAT9wDGM2Nm5YeH0qY_u2JV9toOaVg@mail.gmail.com>
 <547D5FA7.3040307@gmail.com> <142367414.tx9doeBDv9@wuerfel>
Message-ID: <54800408.3020403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?12?02? 16:42, Arnd Bergmann wrote:
> On Tuesday 02 December 2014 14:43:51 Zhou Wang wrote:
>>
>> how about a patch like this, we read the base from the dts here.
>>
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index e8e98ca..0c40f53 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -107,11 +107,16 @@ struct gpio_chip *gpiod_to_chip(const struct
>> gpio_desc *desc)
>>    EXPORT_SYMBOL_GPL(gpiod_to_chip);
>>
>>    /* dynamic allocation of GPIOs, e.g. on a hotplugged device */
>> -static int gpiochip_find_base(int ngpio)
>> +static int gpiochip_find_base(struct gpio_chip *gpio_chip)
>>    {
>>           struct gpio_chip *chip;
>> +       int ngpio = gpio_chip->ngpio;
>>           int base = ARCH_NR_GPIOS - ngpio;
>>
>> +       /* just prototype */
>> +       if (!of_property_read_u32(gpio_chip->dev->of_node, "base", &base))
>> +               return base;
>> +
>
> I don't think that would be appropriate. The concept of a gpio number
> base is implementation specific to current Linux versions and we want
> to get rid of that in the future, so it should not be part of an
> OS-independent spec.
>
> 	Arnd
>
Got it. I will make a patch in which it finds base number of a GPIO
controller in a increasing order. Maybe it can get rid of ARCH_NR_GPIOS
in the future.

Thanks,
Zhou Wang
