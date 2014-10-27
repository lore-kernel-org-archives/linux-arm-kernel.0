From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 14:45:37 +0100
Subject: [PATCH v5 2/4] regulator: max77686: Store opmode non-shifted
In-Reply-To: <544E4A8E.3060803@collabora.co.uk>
References: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
 <1414411911-5539-3-git-send-email-k.kozlowski@samsung.com>
 <544E4A8E.3060803@collabora.co.uk>
Message-ID: <1414417537.1674.5.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-10-27 at 14:37 +0100, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 10/27/2014 01:11 PM, Krzysztof Kozlowski wrote:
> > Introduce simple helper for calculating the shift for OPMODE field in
> > registers. This allows storing the current value of opmode in
> > non-shifted form and simplifies a little set_suspend_disable and enable
> > functions. Additionally this will allow adding support LDOs to the
> > existing set_suspend_disable function.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > ---
> >  drivers/regulator/max77686.c | 49 ++++++++++++++++++++++++++++++--------------
> >  1 file changed, 34 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
> 
> The patch looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> >  
> >  static int max77686_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
> > @@ -495,7 +513,8 @@ static int max77686_pmic_probe(struct platform_device *pdev)
> >  		config.init_data = pdata->regulators[i].initdata;
> >  		config.of_node = pdata->regulators[i].of_node;
> >  
> > -		max77686->opmode[i] = regulators[i].enable_mask;
> > +		max77686->opmode[i] = regulators[i].enable_mask >>
> > +						max77686_get_opmode_shift(i);
> 
> I don't think it has to be done in your patch but as a follow-up it would be
> good to change this to:
> 
> 		max77686->opmode[i] = MAX77686_NORMAL;
> 
> since that is really what this code is trying to do AFAIU. This just happens
> to work because the value of MAX77686_OPMODE_MASK (0x3) is also "Output ON in
> Normal Mode" but the code is not correct IMHO.

It is technically correct (and regulator core use it this way if
enable_val is not specified) but I agree that MAX77686_NORMAL would be
more readable. I have some next patches almost ready, so I'll change it
there.

> Or even better, the regulator mode should be read from the hw registers instead
> of setting always to normal. That is what the max77802 driver does for example.

This would put trust on the bootloader... I don't know if I could trust
him :)
