From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Jun 2014 18:31:08 +0200
Subject: [PATCH] regulator: convert to use gpio_desc internally
In-Reply-To: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
References: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdY_w=Vjv0fL5Ay-CkCpvuyjvwyBhOd4wYr0LcmJD6i4qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 6:55 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Convert the regulator GPIO handling to use a gpio descriptor rather than
> numbers.  This allows us to revise the interfaces to permit all GPIOs
> to be used with the regulator core.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This is an initial step towards allowing the first GPIO (specified in
> DT on Cubox-i/HB as <&gpio1 0 0> to work with the regulator code.
>
>  drivers/regulator/core.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 4c1f999041dd..03ce33387a5d 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -24,6 +24,7 @@
>  #include <linux/suspend.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>

^ This include should not be needed anymore after using
<linux/gpio/consumer.h> I presume?

> +#include <linux/gpio/consumer.h>
>  #include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/of_regulator.h>

(...)

> @@ -1660,10 +1661,13 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
>                                 const struct regulator_config *config)
>  {
>         struct regulator_enable_gpio *pin;
> +       struct gpio_desc *gpiod;
>         int ret;
>
> +       gpiod = gpio_to_desc(config->ena_gpio);

So this point is where we will optionally first look for a descriptor
from the device
itself, like devm_gpiod_get(&rdev->dev, "enable"); or so. (For a later
patch.) That
should work smoothly with DT I think (but haven't tried, admittedly).

> @@ -1701,10 +1705,10 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
>
>         /* Free the GPIO only in case of no use */
>         list_for_each_entry_safe(pin, n, &regulator_ena_gpio_list, list) {
> -               if (pin->gpio == rdev->ena_pin->gpio) {
> +               if (pin->gpiod == rdev->ena_pin->gpiod) {
>                         if (pin->request_count <= 1) {
>                                 pin->request_count = 0;
> -                               gpio_free(pin->gpio);
> +                               gpiod_put(pin->gpiod);

gpio_to_desc() doesn't automatically gpiod_get() the GPIOs, it just grabs
the descriptor off the global list, so just skip this. I know this is not
elegant, it's a way of dealing with backward compatibility.

When we complement the code using devm_gpiod_get() later we get
automatic grabage collection and can thus handle both cases seamlessly.

The rest of the patch looks good.

Yours,
Linus Walleij
