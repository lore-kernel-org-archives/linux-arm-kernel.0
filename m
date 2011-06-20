From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 20 Jun 2011 11:27:05 +0100
Subject: [PATCH 1/2] Exynos4 NURI: configure regulators and PMIC
In-Reply-To: <BANLkTiniwMCW-ED4CX=qybMvk243Zdki4Q@mail.gmail.com>
References: <1308215372-17420-1-git-send-email-myungjoo.ham@samsung.com>
	<20110618151227.GB25163@sirena.org.uk>
	<BANLkTiniwMCW-ED4CX=qybMvk243Zdki4Q@mail.gmail.com>
Message-ID: <20110620102705.GC31864@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 03:26:08PM +0900, MyungJoo Ham wrote:
> On Sun, Jun 19, 2011 at 12:12 AM, Mark Brown

> >> +static struct regulator_consumer_supply nuri_max8997_ldo1_consumer[] = {
> >> + ? ? REGULATOR_SUPPLY("vadc", NULL), /* Used by CPU's ADC drv */
> >> +};

> > In the ADC regulator patch you called the supply vdd (though the chip
> > normally calls it vadc so that's the better name)...

> Um.. this happened as I have seperated NURI-board platform patch for
> ADC and PMIC.
> After ADC patch, that name became ("vdd", "s5p-adc").
> I'll let them either be merged or be disjoint completely.

You may as well get it right to start off with, there's no harm 
defining a supply that doesn't get used.

> Anyway, do you think "vadc" is better than "vdd" for ADC drivers? The
> circuit schematics says the pin on the consumer side is "VDD33_ADC"
> (VDD 3.3V for ADC).

If that's what the pin is called on the package that is the best name
to use.

> >> +static void __init nuri_pmic_init(void)
> >> +{
> >> + ? ? int gpio;
> >> +
> >> + ? ? nuri_max8997_pdata.irq_base = irq_get_next_irq(IRQ_GPIO_END);
> >> + ? ? gpio = NURI_PMIC_GPIO;
> >> + ? ? gpio_request(gpio, "AP_PMIC_IRQ");
> >> + ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
> >> + ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> >> +}

> > I'm not sure both the #define and the variable make sense here...

> I've defined them because two statements are using the gpio address of
> NURI_PMIC.

Right, but there's no point in doing both - either use the #define
everywhere or use the variable everywhere but having both seems
excessive.
