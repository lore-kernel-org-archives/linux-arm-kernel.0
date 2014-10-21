From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Oct 2014 11:36:22 +0200
Subject: [PATCH 1/2] regulator: max77686: Implement suspend disable for
 some LDOs
In-Reply-To: <54462304.8050602@collabora.co.uk>
References: <1413879912-26606-1-git-send-email-k.kozlowski@samsung.com>
 <1413879912-26606-2-git-send-email-k.kozlowski@samsung.com>
 <54462304.8050602@collabora.co.uk>
Message-ID: <1413884182.26980.12.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2014-10-21 at 11:10 +0200, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 10/21/2014 10:25 AM, Krzysztof Kozlowski wrote:
> > Some LDOs of Maxim 77686 PMIC support disabling during system suspend
> > (LDO{2,6,7,8,10,11,12,14,15,16}). This was already implemented as part
> 
> You should also document what each regulator support in the max77686 DT binding
> doc, which btw I see is in Documentation/devicetree/bindings/mfd/max77686.txt
> while I think it should be in Documentation/devicetree/bindings/regulators/
> I just posted a patch to add this information to the max77802 DT binding doc [0]
> so maybe you can add something along those lines?

Sure, I'll document this.

> > of set_suspend_mode function. In that case the mode was one of:
> >  - disable,
> >  - normal mode,
> >  - low power mode.
> > However there are no bindings for setting the mode during suspend.
> > 
> > Implement a set_suspend_disable function for regulators supporting this.
> > This helps reducing energy consumption during system sleep.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/regulator/max77686.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
> > index ef1af2debbd2..84603051f24d 100644
> > --- a/drivers/regulator/max77686.c
> > +++ b/drivers/regulator/max77686.c
> > @@ -123,6 +123,24 @@ static int max77686_set_suspend_mode(struct regulator_dev *rdev,
> >  	return 0;
> >  }
> >  
> > +static int max77686_ldo_set_suspend_disable(struct regulator_dev *rdev,
> > +				     unsigned int mode)
> > +{
> > +	unsigned int val;
> > +	struct max77686_data *max77686 = rdev_get_drvdata(rdev);
> > +	int ret;
> > +
> > +	val = 0x1 << MAX77686_OPMODE_SHIFT;
> 
> Maybe instead of using magic numbers you can document what 0x1 means here.
> I don't have access to the max77686 data-sheet but I do have for the max77802
> so my educated guess is that 0x1 means "Output ON/OFF Controlled by PWRREQ"
> and that the Exynos 4412 XPWRRGTON pin is connected to the max77686 PWRREQ in
> the Trats2 board.

OK.

> 
> > +
> > +	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
> > +				 rdev->desc->enable_mask, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	max77686->opmode[rdev_get_id(rdev)] = val;
> > +	return 0;
> > +}
> > +
> 
> There is already a max77686_buck_set_suspend_disable() that is used by BUCK 1-4.
> 
> At least in the max77802, all regulators expect LDO 1, 3, 20 and 21 support OFF
> by PWRREQ so with some refactoring (using a function to get the opmode shift)
> you can use the same function for all regulators that support this instead of
> having separate .set_suspend_disable function handlers.

OK, I can merge this into one suspend_disable.

> 
> >  /* Some LDOs supports LPM-ON/OFF/Normal-ON mode during suspend state */
> >  static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
> >  				     unsigned int mode)
> > @@ -212,6 +230,7 @@ static struct regulator_ops max77686_ldo_ops = {
> >  	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> >  	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
> >  	.set_suspend_mode	= max77686_ldo_set_suspend_mode,
> > +	.set_suspend_disable	= max77686_ldo_set_suspend_disable,
> 
> You probably want add .set_suspend_enable as well.

Yes, I'll add it.

> 
> >  };
> >  
> >  static struct regulator_ops max77686_buck1_ops = {
> > 
> 
> In general, could you please take a look to the latest patches I posted for the
> max77802? They are in a topic branch in Mark's regulator tree [1]. I would like
> both 77686 and 77802 drivers to handle things similarly even though I know that
> the PMICs don't behave identically and that's why we decided to have different
> drivers (although maybe that was a mistake and makes more sense to merge them).

I looked at them. In this patchset I didn't want to implement fully the
whole suspend-mode-thing. Just the first, easier part - set suspend
disable.

In general I would like to do it similar to your solution but that is
work for future. Especially as I would like to wait for merging your
"Add max77802 regulator operating mode support".

Best regards,
Krzysztof

> 
> Thanks a lot and best regards,
> Javier
> 
> [0]: https://lkml.org/lkml/2014/10/20/320
> [1]: https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/log/?h=topic/max77802
