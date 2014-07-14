From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Tue, 15 Jul 2014 00:31:32 +0530
Subject: [PATCH 1/3 v6] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <20140714172524.GH6800@sirena.org.uk>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
 <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
 <20140714172524.GH6800@sirena.org.uk>
Message-ID: <CAHfPSqAzab931yurSs+3zj=uoFj93FuAdd24AQKm1fZm07Nq8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 14 July 2014 22:55, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 14, 2014 at 11:11:44AM +0530, Naveen Krishna Chatradhi wrote:
>
>> @@ -812,6 +800,10 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>>               spi->controller_data = cs;
>>       }
>>
>> +     /* For the non-DT platforms derive chip selects from controller data */
>> +     if (!spi->dev.of_node)
>> +             spi->cs_gpio = cs->line;
>> +
>>       if (IS_ERR_OR_NULL(cs)) {
>>               dev_err(&spi->dev, "No CS for SPI(%d)\n", spi->chip_select);
>>               return -ENODEV;
>> @@ -819,17 +811,16 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>>
>>       if (!spi_get_ctldata(spi)) {
>>               /* Request gpio only if cs line is asserted by gpio pins */
>> -             if (sdd->cs_gpio) {
>> -                     err = gpio_request_one(cs->line, GPIOF_OUT_INIT_HIGH,
>> -                                     dev_name(&spi->dev));
>> +             if (gpio_is_valid(spi->cs_gpio)) {
>
> As previously mentioned gpio_is_valid() is *not* a direct substitute for
> checking if the boolean flag cs_gpio has been set since 0 is a valid
> GPIO on at least some of these platforms and as discussed several times
> already some of the SoCs require the use of the built in chip select.
Yes, gpio_is_valid() is not a direct substitute for boolean cs_gpio.

It was a review comment to use gpio_is_valid() and quickly iterated
another version with that change.  Now that we see gpio_is_valid() is
breaking the native chip select for gpio number 0. Shall i go back to
using the boolean or do you have a better way to do this.

>
> In general it's quite hard to tie the description in the patch to the
> code changes, not helped by the decision to do separate refactorings
> like this conversion to gpio_is_valid() as part of the one patch.  The
> description of the patch now makes some statements about what the
> problem that's intended to be fixed is but it still doesn't seem
> entirely clear that everything has been thought through fully and tied
> to the code.
>
> The original code appears to be buggy which isn't helping anything but
> it's hard to have confidence that this isn't going to break some other
> use case that currently works given the lack of clarity and the number
> of revisions that have been required so far.

spi-s3c64xx.c is supporting a wide range of SoCs ranging from s3c64xx
series followed by s5p series and then exynos4 and exynos5 series.
However, Exynos4 and Exynos5 series currently available are all DT based.
Support for DT and non-DT was taken good care.

Revision number went to 5 for minor changes like
1. Missing documentation
2. Using gpio_is_valid() instead of boolean cs_gpio
3. Adding SignedOff-By and Acked-By

>
> I think some combination of smaller changes and a clearer working
> through of the before and after states for both DT and non DT cases to
> show that everything has been considered would help a lot.  I may have
> another stare at this but it's worrying how hard I'm needing to think.


The intention of the patch was to fix the broken platforms by implementing
dt bindings similar to generic SPI core in spi-s3c64xx.c.

Current dt bindings:
spi-s3c64xx.c is expects the cs-gpio" property in the SPI DT node
and also defined under the "controller-data".

Solution 1:
Add support for "cs-gpios" property in the SPI DT node and
remove "cs-gpio" from sub node "controller-data".

Solution 2:
As Javier suggested
//
Inverting the default of cs_gpio. and By default not having the
"cs-gpio" property in the SPI dev node should mean that the "cs-gpio"
property in the controller-data node should be used to signal the
chip-select and having the "cs-gpio" property in the SPI node should
mean that the native chip select should be used instead of a GPIO.
That preserves the old DT binding semantic while making the GPIO to be optional
//

in this case spi-s3c64xx.c will continue to ignore the generic SPI "cs-gpios"
implementation.

I'm willing to implement any suggestion to fix this issue.

-- 
Regards,
(: Naveen :)
