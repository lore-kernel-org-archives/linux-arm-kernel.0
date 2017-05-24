From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 24 May 2017 10:59:52 +0200
Subject: [PATCH 1/2] pinctrl: pinctrl-imx: add IBE and OBE SoC property
In-Reply-To: <AM3PR04MB306FDB343CC46DFE7766D3D80FE0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1494830906-6442-1-git-send-email-aisheng.dong@nxp.com>
 <1494830906-6442-2-git-send-email-aisheng.dong@nxp.com>
 <6560bc05ac21060efb5d39d81a662a7a@agner.ch>
 <DBXPR04MB3205CEE820B4E130ACCE79280F90@DBXPR04MB320.eurprd04.prod.outlook.com>
 <0e430fc802cb89a4bd793e95dee57501@agner.ch>
 <AM3PR04MB306FDB343CC46DFE7766D3D80FE0@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <20170524105952.62760b1f@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"A.S. Dong" <aisheng.dong@nxp.com> wrote:

> Hi Stefan,
> 
> > -----Original Message-----
> > From: Stefan Agner [mailto:stefan at agner.ch]
> > Sent: Wednesday, May 24, 2017 3:16 AM
> > To: A.S. Dong
> > Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy Duan;
> > kernel at pengutronix.de; Alexandre Courbot
> > Subject: Re: [PATCH 1/2] pinctrl: pinctrl-imx: add IBE and OBE SoC
> > property
> > 
> > On 2017-05-23 05:06, A.S. Dong wrote:
> > > Hi Stefan,
> > >
> > >> -----Original Message-----
> > >> From: A.S. Dong
> > >> Sent: Wednesday, May 17, 2017 2:14 PM
> > >> To: 'Stefan Agner'
> > >> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > >> linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy Duan;
> > >> kernel at pengutronix.de; Alexandre Courbot
> > >> Subject: RE: [PATCH 1/2] pinctrl: pinctrl-imx: add IBE and OBE SoC
> > >> property
> > >>
> > >> > -----Original Message-----
> > >> > From: Stefan Agner [mailto:stefan at agner.ch]
> > >> > Sent: Tuesday, May 16, 2017 1:11 AM
> > >> > To: A.S. Dong
> > >> > Cc: linux-gpio at vger.kernel.org;
> > >> > linux-arm-kernel at lists.infradead.org;
> > >> > linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy
> > >> > Duan; kernel at pengutronix.de; Alexandre Courbot
> > >> > Subject: Re: [PATCH 1/2] pinctrl: pinctrl-imx: add IBE and OBE SoC
> > >> > property
> > >> >
> > >> > On 2017-05-14 23:48, Dong Aisheng wrote:
> > >> > > iMX ULP has different IOB/OBE shift from Vibrid, so let's make
> > >> >
> > >> > s/Vibrid/Vybrid
> > >> >
> > >> > > it a SoC property.
> > >> > >
> > >> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > >> > > Cc: Alexandre Courbot <gnurou@gmail.com>
> > >> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > >> > > Cc: Stefan Agner <stefan@agner.ch>
> > >> > > Cc: Fugang Duan <fugang.duan@nxp.com>
> > >> > > Cc: Bai Ping <ping.bai@nxp.com>
> > >> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > >> > > ---
> > >> > >  drivers/pinctrl/freescale/pinctrl-imx.c     | 8 ++++----
> > >> > >  drivers/pinctrl/freescale/pinctrl-imx.h     | 2 ++
> > >> > >  drivers/pinctrl/freescale/pinctrl-imx7ulp.c | 2 ++
> > >> > >  drivers/pinctrl/freescale/pinctrl-vf610.c   | 2 ++
> > >> > >  4 files changed, 10 insertions(+), 4 deletions(-)
> > >> > >
> > >> > > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> > >> > > b/drivers/pinctrl/freescale/pinctrl-imx.c
> > >> > > index 57e1f7a..0d6aaca 100644
> > >> > > --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> > >> > > +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> > >> > > @@ -331,8 +331,8 @@ static int imx_pmx_gpio_set_direction(struct
> > >> > > pinctrl_dev *pctldev,
> > >> > >  	u32 reg;
> > >> > >
> > >> > >  	/*
> > >> > > -	 * Only Vybrid has the input/output buffer enable flags
> > (IBE/OBE)
> > >> > > -	 * They are part of the shared mux/conf register.
> > >> > > +	 * Only Vybrid and iMX ULP has the input/output buffer enable
> > flags
> > >> > > +	 * (IBE/OBE) They are part of the shared mux/conf register.
> > >> > >  	 */
> > >> > >  	if (!(info->flags & SHARE_MUX_CONF_REG))
> > >> > >  		return 0;
> > >> > > @@ -344,9 +344,9 @@ static int imx_pmx_gpio_set_direction(struct
> > >> > > pinctrl_dev *pctldev,
> > >> > >  	/* IBE always enabled allows us to read the value "on the
> > wire" */
> > >> > >  	reg = readl(ipctl->base + pin_reg->mux_reg);
> > >> > >  	if (input)
> > >> > > -		reg &= ~0x2;
> > >> > > +		reg = (reg & ~info->obe_bit) | info->ibe_bit;
> > >> > >  	else
> > >> > > -		reg |= 0x2;
> > >> > > +		reg = (reg & ~info->ibe_bit) | info->obe_bit;
> > >> >
> > >> > Why disabling IBE bit now? As the comment above states, it is
> > >> > really handy to leave the input buffer enabled so we can read back
> > >> > the true value on the wire...
> > >> >
> > >>
> > >> Does Vybrid reply on this bit to read the status of output from Port
> > >> Data Input Register (GPIOx_PDIR)?
> > >>
> > >> Then, it is a bit strange that read status from input register when
> > >> the GPIO is Actually configured as output.
> > >>
> > >> Probably it works on Vybrid, but I don't know if it's valid for MX7ULP.
> > >>
> > >> For MX7ULP, we will read input or output register accordingly by
> > >> checking GPIO direction register (PDDR) and we will not enable Input
> > >> buffer if the GPIO is configured as output, this also save a bit power.
> > >>
> > >> I know Vybrid has no PDDR, probably that's why you enable IBE by
> > >> default always.
> > >>
> > 
> > The main reason I enable input buffer by default is so that software has a
> > chance to see the actual state of the GPIO. E.g. when a GPIO is connected
> > to GND, and you set it high, you can read back a 0... (of course you
> > should not connect a GPIO to GND and set it high! But that is exactly the
> > point, with enabling the input buffer you actually see that something is
> > wrong!)
> > 
> > Can we not do this for iMX7ULP too?
> > 
> 
> Hmm.. I probably would think it reversely.
> For me, I'd prefer the gpio value read back reflect the real value set in
> GPIO controller, not the actual state on the line.
> It at least tells "Hey, your GPIO SW setting is okay, check HW ..".
> 
> Users could measure the actual state if something is wrong.
> 
This doesn't buy the user anything. You can safely assume, that writing
some value to a register will actually set the designated bits in that
register. There is no need to confirm that by reading back.
What's more interesting is whether the change in the register setting
had the desired effect on the hardware outside the chip!


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
