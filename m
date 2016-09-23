From: eric@anholt.net (Eric Anholt)
Date: Fri, 23 Sep 2016 16:15:03 +0300
Subject: [PATCH 2/3] gpio: Add a driver for the Raspberry Pi's firmware
 GPIO calls.
In-Reply-To: <CACRpkda6HpJp97FUAh6yvo-BhiDbAXxzQS9U6uT+jvg6hiB8ag@mail.gmail.com>
References: <20160919161314.25858-1-eric@anholt.net>
 <20160919161314.25858-2-eric@anholt.net>
 <CACRpkda6HpJp97FUAh6yvo-BhiDbAXxzQS9U6uT+jvg6hiB8ag@mail.gmail.com>
Message-ID: <87mviy92qw.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Mon, Sep 19, 2016 at 6:13 PM, Eric Anholt <eric@anholt.net> wrote:
>
>> This driver will be used for accessing the FXL6408 GPIO exander on the
>> Pi3.  We can't drive it directly from Linux because the firmware is
>> continuously polling one of the expander's lines to do its
>> undervoltage detection.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
> (...)
>
>> +config GPIO_RASPBERRYPI
>> +       tristate "Raspberry Pi firmware-based GPIO access"
>> +       depends on OF_GPIO && RASPBERRYPI_FIRMWARE && (ARCH_BCM2835 || COMPILE_TEST)
>> +       help
>> +         Turns on support for using the Raspberry Pi firmware to
>> +         control GPIO pins.  Used for access to the FXL6408 GPIO
>> +         expander on the Pi 3.
>
> Maybe it should be named GPIO_RPI_FXL6408 ?
>
> (No strong opinion.)

See DT binding comment -- I think since this driver has no dependency on
being to the 6408 on the pi3, we shouldn't needlessly bind it to the
FXL6408.  (the help comment was just context for why you would want the
driver today).

>> +static int rpi_gpio_dir_in(struct gpio_chip *gc, unsigned off)
>> +{
>> +       /* We don't have direction control. */
>> +       return -EINVAL;
>> +}
>> +
>> +static int rpi_gpio_dir_out(struct gpio_chip *gc, unsigned off, int val)
>> +{
>> +       /* We don't have direction control. */
>> +       return -EINVAL;
>> +}
>
> IMO this should return OK if you try to set it to the direction
> that the line is hardwired for in that case, not just fail everything.
>
> If you return errors here, any generic driver that tries to
> set the line as input or output will fail and then require a
> second workaround in that driver if it is used on rpi etc etc.
>
> Try to return zero if the consumer asks for the direction that
> the line is set to.
>
> Also implement .get_direction(). Doing so will show how to
> do the above two calls in the right way.

I was worried about the lack of direction support.  The firmware
interface doesn't give me anything for direction, and a get or set
of the value doesn't try to set direction.

I can try to bother them to give me support for that, but if they
cooperate on that it means that users will only get HDMI detection once
they update firmware.

The alternative to new firmware interface would be to provide a bunch of
DT saying which of these should be in/out at boot time and refuse to
change them after that.  That seems like a mess, though.

>> +static void rpi_gpio_set(struct gpio_chip *gc, unsigned off, int val)
>> +{
>> +       struct rpi_gpio *rpi = container_of(gc, struct rpi_gpio, gc);
>> +       u32 packet[2] = { rpi->offset + off, val };
>> +       int ret;
>> +
>> +       ret = rpi_firmware_property(rpi->firmware,
>> +                                   RPI_FIRMWARE_SET_GPIO_STATE,
>> +                                   &packet, sizeof(packet));
>> +       if (ret)
>> +               dev_err(rpi->dev, "Error setting GPIO %d state: %d\n", off, ret);
>> +}
>> +
>> +static int rpi_gpio_get(struct gpio_chip *gc, unsigned off)
>> +{
>> +       struct rpi_gpio *rpi = container_of(gc, struct rpi_gpio, gc);
>> +       u32 packet[2] = { rpi->offset + off, 0 };
>> +       int ret;
>> +
>> +       ret = rpi_firmware_property(rpi->firmware,
>> +                                   RPI_FIRMWARE_GET_GPIO_STATE,
>> +                                   &packet, sizeof(packet));
>> +       if (ret) {
>> +               dev_err(rpi->dev, "Error getting GPIO state: %d\n", ret);
>> +               return ret;
>> +       } else if (packet[0]) {
>> +               dev_err(rpi->dev, "Firmware error getting GPIO state: %d\n",
>> +                       packet[0]);
>> +               return -EINVAL;
>> +       } else {
>> +               return packet[1];
>> +       }
>
> You can just remove the last } else { } clause and return on a
> single line.
>
> Please do it like this though:
>
> return !!packet[1];
>
> So you clamp the returned value to a boolean.

Will do.

>> +       rpi->gc.get = rpi_gpio_get;
>> +       rpi->gc.set = rpi_gpio_set;
>> +       rpi->gc.can_sleep = true;
>> +
>> +       ret = gpiochip_add(&rpi->gc);
>> +       if (ret)
>> +               return ret;
>
> Use devm_gpiochip_add_data() and pass NULL as data
> so you can still use the devm* function.

Oh, nice.

>> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
>> index 3fb357193f09..671ccd00aea2 100644
>> --- a/include/soc/bcm2835/raspberrypi-firmware.h
>> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
>> @@ -73,11 +73,13 @@ enum rpi_firmware_property_tag {
>>         RPI_FIRMWARE_GET_DISPMANX_RESOURCE_MEM_HANDLE =       0x00030014,
>>         RPI_FIRMWARE_GET_EDID_BLOCK =                         0x00030020,
>>         RPI_FIRMWARE_GET_DOMAIN_STATE =                       0x00030030,
>> +       RPI_FIRMWARE_GET_GPIO_STATE =                         0x00030041,
>>         RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
>>         RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
>>         RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,
>>         RPI_FIRMWARE_SET_TURBO =                              0x00038009,
>>         RPI_FIRMWARE_SET_DOMAIN_STATE =                       0x00038030,
>> +       RPI_FIRMWARE_SET_GPIO_STATE =                         0x00038041,
>
> Can you please merge this orthogonally into the rpi tree to ARM SoC?

This driver would appear in the rpi downstream tree once we settle the
driver here.  Or are you asking me to delay this series until I can get
them to pull just a patch extending the set of packets?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160923/83848ae6/attachment.sig>
