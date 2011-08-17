From: inderpal.singh@linaro.org (Inderpal Singh)
Date: Wed, 17 Aug 2011 16:20:22 +0530
Subject: [PATCH] ARM: EXYNOS4: Configure MAX8997 PMIC for Origen
In-Reply-To: <20110816151916.GA15484@opensource.wolfsonmicro.com>
References: <1313034965-21286-1-git-send-email-inderpal.singh@linaro.org>
	<20110814150148.GB25504@sirena.org.uk>
	<CAG17yqTP+Amg_UhWNjwZ0x8bH+VzV82k3La5Y0fep9WRArbe+g@mail.gmail.com>
	<20110816151916.GA15484@opensource.wolfsonmicro.com>
Message-ID: <CAG17yqRvL1=PdWL8r1FVd7HHYX5Nd7gYY5HLD+L2pofBQc-DQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 August 2011 20:49, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>
> On Tue, Aug 16, 2011 at 04:38:46PM +0530, Inderpal Singh wrote:
> > On 14 August 2011 20:31, Mark Brown <broonie@opensource.wolfsonmicro.com>wrote:
> > > On Thu, Aug 11, 2011 at 09:26:05AM +0530, Inderpal Singh wrote:
>
> > > > +static struct regulator_consumer_supply __initdata ldo7_consumer[] = {
> > > > + ? ? REGULATOR_SUPPLY("avdd", "soc-audio"), /* Reatek ALC5625*/
> > > > +};
>
> > > Ick, no. ?The soc-audio device is a virtual device within Linux and is
> > > being phased out, any driver adding new soc-audio devices will be
> > > rejected. ?The CODEC driver should deal with its own power.
>
> > Ok. So does it mean that sound cards will have their own devices? And those
> > device names should be listed as consumers?
>
> As I said above "The CODEC driver should deal with its own power."

Ok, will change accordingly.

>
> > > > +static struct i2c_board_info i2c0_devs[] __initdata = {
> > > > +[I2C0_MAX8997] = {
> > > > + ? ? I2C_BOARD_INFO("max8997", (0xCC >> 1)),
> > > > + ? ? .platform_data = &origen_max8997_pdata,
> > > > + ? ? },
> > > > +};
>
> > > Why are you assigning the array index? ?That's very unusual.
>
> > Have seen this kind of initialisation at few places. It looked more
> > readable.
> > If its not preferred, I will remove it.
>
> You shouldn't need to be looking up individual members in a board info
> array in the first place.

Ok, will remove array index assignment.

>
> > > > + ? ? s3c_i2c0_set_platdata(NULL);
> > > > + ? ? i2c0_devs[I2C0_MAX8997].irq = gpio_to_irq(EXYNOS4_GPX0(4));
>
> > > There should be defines to do this statically.
>
> > What advantages do you see in using defines?
>
> It's non-idiomatic to modify the I2C board info at runtime, all the
> numbers are known at compile time anyway.

This line is External Interrupt line, so will use suitable IRQ_EINT
macro and resubmit the patch.


With Regards,
Inder
