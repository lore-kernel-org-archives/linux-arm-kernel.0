From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jun 2014 17:39:31 +0100
Subject: [PATCH] regulator: convert to use gpio_desc internally
In-Reply-To: <CACRpkdY_w=Vjv0fL5Ay-CkCpvuyjvwyBhOd4wYr0LcmJD6i4qA@mail.gmail.com>
References: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
 <CACRpkdY_w=Vjv0fL5Ay-CkCpvuyjvwyBhOd4wYr0LcmJD6i4qA@mail.gmail.com>
Message-ID: <20140630163931.GD32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

Bear in mind that Mark has already committed this patch - rather too
hastily I think.  I've no idea why he didn't wait for your review
before doing so, that would have been the appropriate thing to have
done.

On Mon, Jun 30, 2014 at 06:31:08PM +0200, Linus Walleij wrote:
> On Sun, Jun 29, 2014 at 6:55 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > Convert the regulator GPIO handling to use a gpio descriptor rather than
> > numbers.  This allows us to revise the interfaces to permit all GPIOs
> > to be used with the regulator core.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > This is an initial step towards allowing the first GPIO (specified in
> > DT on Cubox-i/HB as <&gpio1 0 0> to work with the regulator code.
> >
> >  drivers/regulator/core.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index 4c1f999041dd..03ce33387a5d 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/suspend.h>
> >  #include <linux/delay.h>
> >  #include <linux/gpio.h>
> 
> ^ This include should not be needed anymore after using
> <linux/gpio/consumer.h> I presume?

No, because we still need to use the legacy API to request the GPIO.

> 
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/of.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/of_regulator.h>
> 
> (...)
> 
> > @@ -1660,10 +1661,13 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
> >                                 const struct regulator_config *config)
> >  {
> >         struct regulator_enable_gpio *pin;
> > +       struct gpio_desc *gpiod;
> >         int ret;
> >
> > +       gpiod = gpio_to_desc(config->ena_gpio);
> 
> So this point is where we will optionally first look for a descriptor
> from the device
> itself, like devm_gpiod_get(&rdev->dev, "enable"); or so. (For a later
> patch.) That
> should work smoothly with DT I think (but haven't tried, admittedly).

This is where the problem comes.  devm_gpiod_get() can only be used once
per GPIO, so there's no sharing possible when using this interface.
Since we need to share GPIOs here, we can't use any GPIO interface which
ensures exclusivity.

Consider the case where you have two regulators wired up to a single
control GPIO.  DT would specify the same GPIO in two regulator
descriptions.  The GPIO interfaces will allow the GPIO to be "got"
for the first regulator to be probed, and fail the second one with
-EBUSY.

That's what this code is trying to avoid.

> > @@ -1701,10 +1705,10 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
> >
> >         /* Free the GPIO only in case of no use */
> >         list_for_each_entry_safe(pin, n, &regulator_ena_gpio_list, list) {
> > -               if (pin->gpio == rdev->ena_pin->gpio) {
> > +               if (pin->gpiod == rdev->ena_pin->gpiod) {
> >                         if (pin->request_count <= 1) {
> >                                 pin->request_count = 0;
> > -                               gpio_free(pin->gpio);
> > +                               gpiod_put(pin->gpiod);
> 
> gpio_to_desc() doesn't automatically gpiod_get() the GPIOs, it just grabs
> the descriptor off the global list, so just skip this. I know this is not
> elegant, it's a way of dealing with backward compatibility.

Correct, and that's why it's being used.  It's being used to get a
"cookie" for the GPIO which we can then match against the GPIOs we
already know about.  If we find that it's a new cookie, we use the
legacy gpio_request() API to mark it in use.

This is why I mentioned in the commit message that this is a step
towards solving this properly - the core regulator code needs to deal
with gpio_desc's internally and use the new API, but we need to solve
how to get the gpio_desc from OF in a manner which permits sharing.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
