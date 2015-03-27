From: alexanders83@web.de (Alexander Stein)
Date: Fri, 27 Mar 2015 12:54:23 +0100
Subject: [PATCH 1/2] pinctrl: at91: Add set_multiple GPIO chip feature
In-Reply-To: <20150327101152.GB16851@odux.rfo.atmel.com>
References: <1426878721-2618-1-git-send-email-alexanders83@web.de>
 <20150327101152.GB16851@odux.rfo.atmel.com>
Message-ID: <4728260.M5jZylgLPj@kongar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ludovic,

On Friday 27 March 2015, 11:11:52 wrote Ludovic Desroches:
> On Fri, Mar 20, 2015 at 08:12:00PM +0100, Alexander Stein wrote:
> > This adds the callback for set_multiple.
> > As this controller has a separate set and clear register, we can't write
> > directly to PIO_ODSR as this would required a cached variable and would
> > race with at91_gpio_set.
> > So build masks for the PIO_SODR and PIO_CODR registers and write them
> > together.
> 
> Sure seems safer and easier to use SODR and CODR.
> 
> > 
> > Signed-off-by: Alexander Stein <alexanders83@web.de>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> A question below.
> 
> > ---
> > This was tested by using an own test driver which uses
> > gpiod_set_array_cansleep to set multiple GPIOs at once.
> > 
> >  drivers/pinctrl/pinctrl-at91.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> > index f4cd0b9..a882523 100644
> > --- a/drivers/pinctrl/pinctrl-at91.c
> > +++ b/drivers/pinctrl/pinctrl-at91.c
> > @@ -1330,6 +1330,33 @@ static void at91_gpio_set(struct gpio_chip *chip, unsigned offset,
> >  	writel_relaxed(mask, pio + (val ? PIO_SODR : PIO_CODR));
> >  }
> >  
> > +static void at91_gpio_set_multiple(struct gpio_chip *chip,
> > +				      unsigned long *mask, unsigned long *bits)
> > +{
> > +	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
> > +	void __iomem *pio = at91_gpio->regbase;
> > +	unsigned long set_mask;
> > +	unsigned long clear_mask;
> > +	size_t i;
> > +
> > +	set_mask = 0;
> > +	clear_mask = 0;
> > +
> > +	for (i = 0; i < chip->ngpio; i++) {
> > +		if (*mask == 0)
> > +			break;
> > +		if (__test_and_clear_bit(i, mask)) {
> 
> For my knowledge, why do you need to clear the mask?

I tried to do the same as mpc8xxx_gpio_set_multiple. I think the reason is that an empty mask will quit that loop potentially earlier.

Best regards,
Alexander
