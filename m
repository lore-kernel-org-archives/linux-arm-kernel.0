From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 15 Jul 2014 12:38:58 +0200
Subject: [PATCH 1/3 v6] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <20140714172524.GH6800@sirena.org.uk>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
 <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
 <20140714172524.GH6800@sirena.org.uk>
Message-ID: <CABxcv==yuWJYmSiVV=HELMdwi-8aAG-aiT9o12HUBp8uRaBxkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

I agree that the commit message could have a better description and I
understand your concerns. I'm not an SPI expert by any means but I did
my best to review the patches and provide feedback to Naveen on the
first iterations of the series.

On Mon, Jul 14, 2014 at 7:25 PM, Mark Brown <broonie@kernel.org> wrote:
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
>

Please correct me if I'm wrong but in this case I think that using
gpio_is_valid(spi->cs_gpio) is the right thing to do. The SPI core
will set spi->cs_gpio to -ENOENT if a Device Tree didn't use the
"cs-gpios" property of if the format (explained in
Documentation/devicetree/bindings/spi/spi-bus.txt) to specify a
native/built-in line chip select is used:

cs-gpios = <&gpio1 0 0> <0>
cs0 : &gpio1 0 0
cs1 : native

So in that case gpio_is_valid(spi->cs_gpio) will return false which is
what Naveen wants in his patch.

Now, a problem is that in the non-DT case the patch does not rely on
the spi->cs_gpio value set by the SPI core but instead overwrites it
with the value in cs->line. So as you said this would have been an
issue if legacy non-DT board code used s3c64xx_spi_csinfo .line to
specify that the built-in chip select should be used instead of a
GPIO.

But looking at the board files that sets struct spi_board_info
.controller_data to struct s3c64xx_spi_csinfo I see that the the .line
field is actually used to specify a GPIO pin and not a chip select.

In fact there is only one user in mainline
(arch/arm/mach-s3c64xx/mach-crag6410-module.c) that do this:

#define S3C64XX_GPC(_nr)      (S3C64XX_GPIO_C_START + (_nr))

static struct s3c64xx_spi_csinfo wm0010_spi_csinfo = {
        .line = S3C64XX_GPC(3),
};

static struct spi_board_info wm1253_devs[] = {
        [0] = {
                .modalias       = "wm0010",
                .max_speed_hz   = 26 * 1000 * 1000,
                .bus_num        = 0,
                .chip_select    = 0,
                .mode           = SPI_MODE_0,
                .irq            = S3C_EINT(4),
                .controller_data = &wm0010_spi_csinfo,
                .platform_data = &wm0010_pdata,
        },
};

So, the .line field is used to specify a GPIO, not a chip select. So
gpio_is_valid() should also be used to check that cs->line is a valid
GPIO. If board file does not want to use a GPIO and wants to use a
built-in chip select then it should either not use a struct
s3c64xx_spi_csinfo at all or set .line to -ENOENT in order to be
consistent with the SPI core.

Now, looking at this I realize that there is a bug in the spi-s3c64xx
driver since it does not check if spi->controller_data is NULL in the
non-DT case which I believe it can be true.

> In general it's quite hard to tie the description in the patch to the
> code changes, not helped by the decision to do separate refactorings
> like this conversion to gpio_is_valid() as part of the one patch.  The
> description of the patch now makes some statements about what the
> problem that's intended to be fixed is but it still doesn't seem
> entirely clear that everything has been thought through fully and tied
> to the code.
>

AFAICT most of the refactoring is actually removing the buggy code
that was introduced in commit 3146bee ("spi: s3c64xx: Added provision
for dedicated cs pin"). So maybe Naveen can try doing a new series
first reverting the offending commit and then on top of that adding
the support for the generic "cs-gpios" DT property used by the SPI
core?

As I said before this patch is fixing a bug in the SPI driver, the
first version of the series was posted on June, 10 so many other
patches already depend on this fix. So it would be great if we can
move this forward since this is hurting the platform support as a
whole.

Thanks a lot and best regards,
Javier
