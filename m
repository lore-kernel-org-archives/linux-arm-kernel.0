From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 25 Mar 2010 20:43:16 +0200
Subject: [PATCH v2 1/3] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
Message-ID: <20100325184316.GB20512@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 01:49:32PM +0000, Martin Guy wrote:
> On 3/18/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> > This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
> >  in EP93xx chips (EP9301, EP9302, EP9307, EP9312 and EP9315).
> >
> >  Driver currently supports only interrupt driven mode but in future we may add
> >  polling mode support as well.
> >
> >  Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> >  ---
> 
> >  diff --git a/drivers/spi/ep93xx_spi.c b/drivers/spi/ep93xx_spi.c
> >  new file mode 100644
> >  index 0000000..17935f3
> >  --- /dev/null
> >  +++ b/drivers/spi/ep93xx_spi.c
> 
> >  +/**
> >  + * ep93xx_spi_calc_divisors() - calculates SPI clock divisors
> >  + * @espi: ep93xx SPI controller struct
> >  + * @chip: divisors are calculated for this chip
> >  + * @rate: maximum rate (in Hz) that this chip supports
> 
> Isn't that
> >  + * @rate: desired SPI output clock rate

Yes.

> 
> >  + *
> >  + * Function calculates cpsr (clock pre-scaler) and scr divisors based on
> >  + * given @rate and places them to @chip->div_cpsr and @chip->div_scr. If,
> >  + * for some reason, divisors cannot be calculated nothing is stored and
> >  + * %-EINVAL is returned.
> >  + */
> >  +static int ep93xx_spi_calc_divisors(const struct ep93xx_spi *espi,
> >  +                                   struct ep93xx_spi_chip *chip,
> >  +                                   unsigned long rate)
> >  +{
> ...
> >  +       /*
> >  +        * Calculate divisors so that we can get speed according the
> >  +        * following formula:
> >  +        *      rate = max_speed / (cpsr * (1 + scr))
> >  +        * where max_speed is same as SPI clock rate.
> >  +        *
> >  +        * cpsr must be even number and starts from 2, scr can be any number
> >  +        * between 0 and 255.
> >  +        */
> >  +       for (cpsr = 2; cpsr <= 254; cpsr += 2) {
> >  +               for (scr = 0; scr <= 255; scr++) {
> >  +                       if ((espi->max_rate / (cpsr * (scr + 1))) < rate) {
> 
> Shouldn't that be
> 
> >  +                       if (clk_get_rate(espi->clk) / (cpsr * (scr + 1)) <= rate) {
> 
> since max_rate is the maximum usable rate, which is sspclk / 2, so the
> existing code seems like it would set the divisors to give twice the
> requested frequency.
> 
> Conversely, if an exact divisor of the master clock rate is requested
> (such as 1843200), the "<" would give the next lower rate instead of
> the requested rate so for the highest rates the doubling and this
> halving would cancel out, while for lower rates you could get up to
> twice the requested clock frequecy.

Yes, you are right. Very good observation :)

> 
> >  +static int __init ep93xx_spi_probe(struct platform_device *pdev)
> >  +{
> ...
> >  +       espi->max_rate = clk_get_rate(espi->clk) / 2;
> >  +       espi->min_rate = clk_get_rate(espi->clk) / (254 * 255);
> 
> Isn't that
> >  +       espi->min_rate = clk_get_rate(espi->clk) / (254 * 256);
> 
> since the output SPI clock frequency is sspclk / (cpsr * (1 + scr))
> where cpsr = 2..254 step 2, scr = 1..255

Yes.

> I also notice that the code recalculates the clock divisors, programs
> them ad resotres them for every transfer, even if the frequency etc is
> always the same.

It shouldn't. This is checked in ep93xx_spi_setup() and clocks are
only calculated when speed is changed. Same thing is with
ep93xx_spi_process_transfer() where clocks are only calculated when
different transfer speed is requested (t->speed_hz != 0).

Thank you for your comments. I will fix these in the next revision
of the patch series.

Regards,
MW
