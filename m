From: stefan@agner.ch (Stefan Agner)
Date: Tue, 23 May 2017 12:16:01 -0700
Subject: [PATCH 1/2] pinctrl: pinctrl-imx: add IBE and OBE SoC property
In-Reply-To: <DBXPR04MB3205CEE820B4E130ACCE79280F90@DBXPR04MB320.eurprd04.prod.outlook.com>
References: <1494830906-6442-1-git-send-email-aisheng.dong@nxp.com>
 <1494830906-6442-2-git-send-email-aisheng.dong@nxp.com>
 <6560bc05ac21060efb5d39d81a662a7a@agner.ch>
 <DBXPR04MB3205CEE820B4E130ACCE79280F90@DBXPR04MB320.eurprd04.prod.outlook.com>
Message-ID: <0e430fc802cb89a4bd793e95dee57501@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-23 05:06, A.S. Dong wrote:
> Hi Stefan,
> 
>> -----Original Message-----
>> From: A.S. Dong
>> Sent: Wednesday, May 17, 2017 2:14 PM
>> To: 'Stefan Agner'
>> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy Duan;
>> kernel at pengutronix.de; Alexandre Courbot
>> Subject: RE: [PATCH 1/2] pinctrl: pinctrl-imx: add IBE and OBE SoC
>> property
>>
>> > -----Original Message-----
>> > From: Stefan Agner [mailto:stefan at agner.ch]
>> > Sent: Tuesday, May 16, 2017 1:11 AM
>> > To: A.S. Dong
>> > Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> > linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy Duan;
>> > kernel at pengutronix.de; Alexandre Courbot
>> > Subject: Re: [PATCH 1/2] pinctrl: pinctrl-imx: add IBE and OBE SoC
>> > property
>> >
>> > On 2017-05-14 23:48, Dong Aisheng wrote:
>> > > iMX ULP has different IOB/OBE shift from Vibrid, so let's make
>> >
>> > s/Vibrid/Vybrid
>> >
>> > > it a SoC property.
>> > >
>> > > Cc: Linus Walleij <linus.walleij@linaro.org>
>> > > Cc: Alexandre Courbot <gnurou@gmail.com>
>> > > Cc: Shawn Guo <shawnguo@kernel.org>
>> > > Cc: Stefan Agner <stefan@agner.ch>
>> > > Cc: Fugang Duan <fugang.duan@nxp.com>
>> > > Cc: Bai Ping <ping.bai@nxp.com>
>> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> > > ---
>> > >  drivers/pinctrl/freescale/pinctrl-imx.c     | 8 ++++----
>> > >  drivers/pinctrl/freescale/pinctrl-imx.h     | 2 ++
>> > >  drivers/pinctrl/freescale/pinctrl-imx7ulp.c | 2 ++
>> > >  drivers/pinctrl/freescale/pinctrl-vf610.c   | 2 ++
>> > >  4 files changed, 10 insertions(+), 4 deletions(-)
>> > >
>> > > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
>> > > b/drivers/pinctrl/freescale/pinctrl-imx.c
>> > > index 57e1f7a..0d6aaca 100644
>> > > --- a/drivers/pinctrl/freescale/pinctrl-imx.c
>> > > +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
>> > > @@ -331,8 +331,8 @@ static int imx_pmx_gpio_set_direction(struct
>> > > pinctrl_dev *pctldev,
>> > >  	u32 reg;
>> > >
>> > >  	/*
>> > > -	 * Only Vybrid has the input/output buffer enable flags (IBE/OBE)
>> > > -	 * They are part of the shared mux/conf register.
>> > > +	 * Only Vybrid and iMX ULP has the input/output buffer enable flags
>> > > +	 * (IBE/OBE) They are part of the shared mux/conf register.
>> > >  	 */
>> > >  	if (!(info->flags & SHARE_MUX_CONF_REG))
>> > >  		return 0;
>> > > @@ -344,9 +344,9 @@ static int imx_pmx_gpio_set_direction(struct
>> > > pinctrl_dev *pctldev,
>> > >  	/* IBE always enabled allows us to read the value "on the wire" */
>> > >  	reg = readl(ipctl->base + pin_reg->mux_reg);
>> > >  	if (input)
>> > > -		reg &= ~0x2;
>> > > +		reg = (reg & ~info->obe_bit) | info->ibe_bit;
>> > >  	else
>> > > -		reg |= 0x2;
>> > > +		reg = (reg & ~info->ibe_bit) | info->obe_bit;
>> >
>> > Why disabling IBE bit now? As the comment above states, it is really
>> > handy to leave the input buffer enabled so we can read back the true
>> > value on the wire...
>> >
>>
>> Does Vybrid reply on this bit to read the status of output from Port Data
>> Input Register (GPIOx_PDIR)?
>>
>> Then, it is a bit strange that read status from input register when the
>> GPIO is Actually configured as output.
>>
>> Probably it works on Vybrid, but I don't know if it's valid for MX7ULP.
>>
>> For MX7ULP, we will read input or output register accordingly by checking
>> GPIO direction register (PDDR) and we will not enable Input buffer if the
>> GPIO is configured as output, this also save a bit power.
>>
>> I know Vybrid has no PDDR, probably that's why you enable IBE by default
>> always.
>>

The main reason I enable input buffer by default is so that software has
a chance to see the actual state of the GPIO. E.g. when a GPIO is
connected to GND, and you set it high, you can read back a 0... (of
course you should not connect a GPIO to GND and set it high! But that is
exactly the point, with enabling the input buffer you actually see that
something is wrong!)

Can we not do this for iMX7ULP too?

> 
> We need make a decision on how to address the difference between Vybrid
> And IMX7ULP.
> 
> If Vybrid wants to keep input buffer enabled, we probably could invent
> A IMX_PINCONF_HAVE_PDDR just like GPIO driver and only disable IBE for IMX?

That would be one option yes. You also need a flag so you can opt out
from imx_pmx_gpio_enable/disable_free...

The more involved version would be to somehow move imx_pmx_gpio_* to
pinctrl-vf610.c, e.g. store the callbacks in imx_pinctrl_soc_info and
set them dynamically in imx_pinctrl_probe (you have to unconst
pinmux_ops). With that you can provide no
imx_pmx_gpio_enable/disable_free for iMX7ULP and your own
imx_pmx_gpio_set_direction...

--
Stefan

> 
> Do you think it's ok?
> 
> 
> Regards
> Dong Aisheng
> 
> 
>> Regards
>> Dong Aisheng
>>
>> > --
>> > Stefan
>> >
>> > >  	writel(reg, ipctl->base + pin_reg->mux_reg);
>> > >
>> > >  	return 0;
>> > > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h
>> > > b/drivers/pinctrl/freescale/pinctrl-imx.h
>> > > index eb0ce95..9ded65d 100644
>> > > --- a/drivers/pinctrl/freescale/pinctrl-imx.h
>> > > +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
>> > > @@ -67,6 +67,8 @@ struct imx_pinctrl_soc_info {
>> > >  	/* MUX_MODE shift and mask in case SHARE_MUX_CONF_REG */
>> > >  	unsigned int mux_mask;
>> > >  	u8 mux_shift;
>> > > +	u32 ibe_bit;
>> > > +	u32 obe_bit;
>> > >
>> > >  	/* generic pinconf */
>> > >  	bool generic_pinconf;
>> > > diff --git a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
>> > > b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
>> > > index dead416..f724a01 100644
>> > > --- a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
>> > > +++ b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
>> > > @@ -324,6 +324,8 @@ static struct imx_pinctrl_soc_info
>> > imx7ulp_pinctrl_info = {
>> > >  	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG,
>> > >  	.mux_mask = 0xf00,
>> > >  	.mux_shift = 8,
>> > > +	.ibe_bit = BIT(16),
>> > > +	.obe_bit = BIT(17),
>> > >  	.generic_pinconf = true,
>> > >  	.custom_params = imx7ulp_cfg_params,
>> > >  	.num_custom_params = ARRAY_SIZE(imx7ulp_cfg_params), diff --git
>> > > a/drivers/pinctrl/freescale/pinctrl-vf610.c
>> > > b/drivers/pinctrl/freescale/pinctrl-vf610.c
>> > > index 3bd8556..c0823f9 100644
>> > > --- a/drivers/pinctrl/freescale/pinctrl-vf610.c
>> > > +++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
>> > > @@ -301,6 +301,8 @@ static struct imx_pinctrl_soc_info
>> > vf610_pinctrl_info = {
>> > >  	.flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
>> > >  	.mux_mask = 0x700000,
>> > >  	.mux_shift = 20,
>> > > +	.ibe_bit = BIT(0),
>> > > +	.obe_bit = BIT(1),
>> > >  };
>> > >
>> > >  static const struct of_device_id vf610_pinctrl_of_match[] = {
