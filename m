From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Sep 2016 11:08:53 +0200
Subject: [PATCH 2/3] gpio: Add a driver for the Raspberry Pi's firmware
 GPIO calls.
In-Reply-To: <20160919161314.25858-2-eric@anholt.net>
References: <20160919161314.25858-1-eric@anholt.net>
 <20160919161314.25858-2-eric@anholt.net>
Message-ID: <CACRpkda6HpJp97FUAh6yvo-BhiDbAXxzQS9U6uT+jvg6hiB8ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 6:13 PM, Eric Anholt <eric@anholt.net> wrote:

> This driver will be used for accessing the FXL6408 GPIO exander on the
> Pi3.  We can't drive it directly from Linux because the firmware is
> continuously polling one of the expander's lines to do its
> undervoltage detection.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
(...)

> +config GPIO_RASPBERRYPI
> +       tristate "Raspberry Pi firmware-based GPIO access"
> +       depends on OF_GPIO && RASPBERRYPI_FIRMWARE && (ARCH_BCM2835 || COMPILE_TEST)
> +       help
> +         Turns on support for using the Raspberry Pi firmware to
> +         control GPIO pins.  Used for access to the FXL6408 GPIO
> +         expander on the Pi 3.

Maybe it should be named GPIO_RPI_FXL6408 ?

(No strong opinion.)

> +#include <linux/err.h>
> +#include <linux/gpio.h>

No, only #include <linux/gpio/driver.h>

> +static int rpi_gpio_dir_in(struct gpio_chip *gc, unsigned off)
> +{
> +       /* We don't have direction control. */
> +       return -EINVAL;
> +}
> +
> +static int rpi_gpio_dir_out(struct gpio_chip *gc, unsigned off, int val)
> +{
> +       /* We don't have direction control. */
> +       return -EINVAL;
> +}

IMO this should return OK if you try to set it to the direction
that the line is hardwired for in that case, not just fail everything.

If you return errors here, any generic driver that tries to
set the line as input or output will fail and then require a
second workaround in that driver if it is used on rpi etc etc.

Try to return zero if the consumer asks for the direction that
the line is set to.

Also implement .get_direction(). Doing so will show how to
do the above two calls in the right way.

> +static void rpi_gpio_set(struct gpio_chip *gc, unsigned off, int val)
> +{
> +       struct rpi_gpio *rpi = container_of(gc, struct rpi_gpio, gc);
> +       u32 packet[2] = { rpi->offset + off, val };
> +       int ret;
> +
> +       ret = rpi_firmware_property(rpi->firmware,
> +                                   RPI_FIRMWARE_SET_GPIO_STATE,
> +                                   &packet, sizeof(packet));
> +       if (ret)
> +               dev_err(rpi->dev, "Error setting GPIO %d state: %d\n", off, ret);
> +}
> +
> +static int rpi_gpio_get(struct gpio_chip *gc, unsigned off)
> +{
> +       struct rpi_gpio *rpi = container_of(gc, struct rpi_gpio, gc);
> +       u32 packet[2] = { rpi->offset + off, 0 };
> +       int ret;
> +
> +       ret = rpi_firmware_property(rpi->firmware,
> +                                   RPI_FIRMWARE_GET_GPIO_STATE,
> +                                   &packet, sizeof(packet));
> +       if (ret) {
> +               dev_err(rpi->dev, "Error getting GPIO state: %d\n", ret);
> +               return ret;
> +       } else if (packet[0]) {
> +               dev_err(rpi->dev, "Firmware error getting GPIO state: %d\n",
> +                       packet[0]);
> +               return -EINVAL;
> +       } else {
> +               return packet[1];
> +       }

You can just remove the last } else { } clause and return on a
single line.

Please do it like this though:

return !!packet[1];

So you clamp the returned value to a boolean.

> +static int rpi_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct device_node *fw_node;
> +       struct rpi_gpio *rpi;
> +       u32 ngpio;
> +       int ret;
> +
> +       rpi = devm_kzalloc(dev, sizeof *rpi, GFP_KERNEL);
> +       if (!rpi)
> +               return -ENOMEM;
> +       rpi->dev = dev;
> +
> +       fw_node = of_parse_phandle(np, "firmware", 0);
> +       if (!fw_node) {
> +               dev_err(dev, "Missing firmware node\n");
> +               return -ENOENT;
> +       }
> +
> +       rpi->firmware = rpi_firmware_get(fw_node);
> +       if (!rpi->firmware)
> +               return -EPROBE_DEFER;
> +
> +       if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpio)) {
> +               dev_err(dev, "Missing ngpios");
> +               return -ENOENT;
> +       }

This is suspect you could skip and just hardcode to 8.

> +       if (of_property_read_u32(pdev->dev.of_node,
> +                                "raspberrypi,firmware-gpio-offset",
> +                                &rpi->offset)) {
> +               dev_err(dev, "Missing raspberrypi,firmware-gpio-offset");
> +               return -ENOENT;
> +       }

Can't you just hardcode this into the driver as well?

> +       rpi->gc.label = np->full_name;
> +       rpi->gc.owner = THIS_MODULE;
> +       rpi->gc.of_node = np;
> +       rpi->gc.ngpio = ngpio;
> +       rpi->gc.direction_input = rpi_gpio_dir_in;
> +       rpi->gc.direction_output = rpi_gpio_dir_out;

Implement .get_direction()

> +       rpi->gc.get = rpi_gpio_get;
> +       rpi->gc.set = rpi_gpio_set;
> +       rpi->gc.can_sleep = true;
> +
> +       ret = gpiochip_add(&rpi->gc);
> +       if (ret)
> +               return ret;

Use devm_gpiochip_add_data() and pass NULL as data
so you can still use the devm* function.

> +       platform_set_drvdata(pdev, rpi);

Should not be needed after that.

> +       return 0;
> +}
> +
> +static int rpi_gpio_remove(struct platform_device *pdev)
> +{
> +       struct rpi_gpio *rpi = platform_get_drvdata(pdev);
> +
> +       gpiochip_remove(&rpi->gc);
> +
> +       return 0;
> +}

Should be possible to drop after using devm_gpiochip_add_data()

> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
> index 3fb357193f09..671ccd00aea2 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -73,11 +73,13 @@ enum rpi_firmware_property_tag {
>         RPI_FIRMWARE_GET_DISPMANX_RESOURCE_MEM_HANDLE =       0x00030014,
>         RPI_FIRMWARE_GET_EDID_BLOCK =                         0x00030020,
>         RPI_FIRMWARE_GET_DOMAIN_STATE =                       0x00030030,
> +       RPI_FIRMWARE_GET_GPIO_STATE =                         0x00030041,
>         RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
>         RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
>         RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,
>         RPI_FIRMWARE_SET_TURBO =                              0x00038009,
>         RPI_FIRMWARE_SET_DOMAIN_STATE =                       0x00038030,
> +       RPI_FIRMWARE_SET_GPIO_STATE =                         0x00038041,

Can you please merge this orthogonally into the rpi tree to ARM SoC?

Yours,
Linus Walleij
