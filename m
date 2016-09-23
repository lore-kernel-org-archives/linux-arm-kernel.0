From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Sep 2016 16:08:23 +0200
Subject: [PATCH 2/3] gpio: Add a driver for the Raspberry Pi's firmware
 GPIO calls.
In-Reply-To: <87mviy92qw.fsf@eliezer.anholt.net>
References: <20160919161314.25858-1-eric@anholt.net>
 <20160919161314.25858-2-eric@anholt.net>
 <CACRpkda6HpJp97FUAh6yvo-BhiDbAXxzQS9U6uT+jvg6hiB8ag@mail.gmail.com>
 <87mviy92qw.fsf@eliezer.anholt.net>
Message-ID: <CACRpkdbJoM-RbcuoC=7xJyrT3v7p2n9HiidRp1GUw=o43_Fkwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 3:15 PM, Eric Anholt <eric@anholt.net> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

>> Maybe it should be named GPIO_RPI_FXL6408 ?
>>
>> (No strong opinion.)
>
> See DT binding comment -- I think since this driver has no dependency on
> being to the 6408 on the pi3, we shouldn't needlessly bind it to the
> FXL6408.  (the help comment was just context for why you would want the
> driver today).

OK

>>> +static int rpi_gpio_dir_in(struct gpio_chip *gc, unsigned off)
>>> +{
>>> +       /* We don't have direction control. */
>>> +       return -EINVAL;
>>> +}
>>> +
>>> +static int rpi_gpio_dir_out(struct gpio_chip *gc, unsigned off, int val)
>>> +{
>>> +       /* We don't have direction control. */
>>> +       return -EINVAL;
>>> +}
>>
>> IMO this should return OK if you try to set it to the direction
>> that the line is hardwired for in that case, not just fail everything.
>>
>> If you return errors here, any generic driver that tries to
>> set the line as input or output will fail and then require a
>> second workaround in that driver if it is used on rpi etc etc.
>>
>> Try to return zero if the consumer asks for the direction that
>> the line is set to.
>>
>> Also implement .get_direction(). Doing so will show how to
>> do the above two calls in the right way.
>
> I was worried about the lack of direction support.  The firmware
> interface doesn't give me anything for direction, and a get or set
> of the value doesn't try to set direction.
>
> I can try to bother them to give me support for that, but if they
> cooperate on that it means that users will only get HDMI detection once
> they update firmware.
>
> The alternative to new firmware interface would be to provide a bunch of
> DT saying which of these should be in/out at boot time and refuse to
> change them after that.  That seems like a mess, though.

It has to be resolved one way or another I'm afraid.

Do you have an API in place to ask for the firmware version?
RPI_FIRMWARE_GET_FIRMWARE_REVISION seems to
exist at least?

In that case try to make some compromise, e.g. if lines 0 and 1
are output and the rest input in a certain firmware version:

struct rpi_gpio {
    (...)
    u8 dirs;
};

if (fw_version <= a)
     rpi->dirs = 0x03;
else if (fw_version > a && fw_version <= b)
    rpi->dirs = 0x07;
else
     /* Ask firmware */

Then in e.g.

static int rpi_gpio_dir_in(struct gpio_chip *gc, unsigned off)
{
     struct rpi_gpio *rpi = gpiochip_get_data(gc);

     if (!(rpi->dirs & BIT(off)))
            return 0;
     return -EINVAL;
}

I think this should be managed by code in the driver like this
and not by any DT properties. I suspect also the ngpio number
is better to determine from looking at the fw version number.

>> Use devm_gpiochip_add_data() and pass NULL as data
>> so you can still use the devm* function.
>
> Oh, nice.

I forgot this: with devm_gpiochip_add_data() pass struct rpi_gpio *
as data then you can just:

static void rpi_gpio_set(struct gpio_chip *gc, unsigned off, int val)
{
-       struct rpi_gpio *rpi = container_of(gc, struct rpi_gpio, gc);
+      struct rpi_gpio *rpi = gpiochip_get_data(gc);

Applies everywhere.

>>> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
>>> index 3fb357193f09..671ccd00aea2 100644
>>> --- a/include/soc/bcm2835/raspberrypi-firmware.h
>>> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
>>> @@ -73,11 +73,13 @@ enum rpi_firmware_property_tag {
>>>         RPI_FIRMWARE_GET_DISPMANX_RESOURCE_MEM_HANDLE =       0x00030014,
>>>         RPI_FIRMWARE_GET_EDID_BLOCK =                         0x00030020,
>>>         RPI_FIRMWARE_GET_DOMAIN_STATE =                       0x00030030,
>>> +       RPI_FIRMWARE_GET_GPIO_STATE =                         0x00030041,
>>>         RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
>>>         RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
>>>         RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,
>>>         RPI_FIRMWARE_SET_TURBO =                              0x00038009,
>>>         RPI_FIRMWARE_SET_DOMAIN_STATE =                       0x00038030,
>>> +       RPI_FIRMWARE_SET_GPIO_STATE =                         0x00038041,
>>
>> Can you please merge this orthogonally into the rpi tree to ARM SoC?
>
> This driver would appear in the rpi downstream tree once we settle the
> driver here.  Or are you asking me to delay this series until I can get
> them to pull just a patch extending the set of packets?

Sorry I am not familiar with your development model. I don't know
about any RPI downstream tree... What I mean is that the patch to
include/soc/bcm2835/raspberrypi-firmware.h should be merged by
whoever is maintaining that file, it is not a GPIO file.

If I get an ACK from the maintainer I can take it into the GPIO
tree.

Yours,
Linus Walleij
