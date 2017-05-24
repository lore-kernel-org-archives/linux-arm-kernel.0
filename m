From: aisheng.dong@nxp.com (A.S. Dong)
Date: Wed, 24 May 2017 05:40:57 +0000
Subject: [PATCH 2/2] pinctrl: pinctrl-imx: do not assume mux 0 is gpio
In-Reply-To: <1fdef56e7e0d7786789922db9f952a7a@agner.ch>
References: <1494830906-6442-1-git-send-email-aisheng.dong@nxp.com>
 <1494830906-6442-3-git-send-email-aisheng.dong@nxp.com>
 <6d47abc0527ae6f2214a9b37dfbeb154@agner.ch>
 <AM3PR04MB3061FB0760F94F2F816055A80E70@AM3PR04MB306.eurprd04.prod.outlook.com>
 <e056a1185a4094e558fb20c7eb19da3d@agner.ch>
 <DBXPR04MB320067F5C96D376B61730E780F90@DBXPR04MB320.eurprd04.prod.outlook.com>
 <1fdef56e7e0d7786789922db9f952a7a@agner.ch>
Message-ID: <AM3PR04MB3061E2A290228D2FC5E1AC780FE0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stefan Agner [mailto:stefan at agner.ch]
> Sent: Wednesday, May 24, 2017 3:55 AM
> To: A.S. Dong
> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy Duan;
> kernel at pengutronix.de; Alexandre Courbot
> Subject: Re: [PATCH 2/2] pinctrl: pinctrl-imx: do not assume mux 0 is gpio
> 
> On 2017-05-23 03:23, A.S. Dong wrote:
> > Hi Stefan,
> >
> >> -----Original Message-----
> >> From: A.S. Dong
> >> Sent: Thursday, May 18, 2017 3:00 PM
> >> To: 'Stefan Agner'
> >> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> >> linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy Duan;
> >> kernel at pengutronix.de; Alexandre Courbot
> >> Subject: RE: [PATCH 2/2] pinctrl: pinctrl-imx: do not assume mux 0 is
> >> gpio
> >>
> >> > -----Original Message-----
> >> > From: Stefan Agner [mailto:stefan at agner.ch]
> >> > Sent: Thursday, May 18, 2017 2:16 AM
> >> > To: A.S. Dong
> >> > Cc: linux-gpio at vger.kernel.org;
> >> > linux-arm-kernel at lists.infradead.org;
> >> > linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy
> >> > Duan; kernel at pengutronix.de; Alexandre Courbot
> >> > Subject: Re: [PATCH 2/2] pinctrl: pinctrl-imx: do not assume mux 0
> >> > is gpio
> >> >
> >> > On 2017-05-17 00:18, A.S. Dong wrote:
> >> > >> -----Original Message-----
> >> > >> From: Stefan Agner [mailto:stefan at agner.ch]
> >> > >> Sent: Tuesday, May 16, 2017 1:27 AM
> >> > >> To: A.S. Dong
> >> > >> Cc: linux-gpio at vger.kernel.org;
> >> > >> linux-arm-kernel at lists.infradead.org;
> >> > >> linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy
> >> > >> Duan; kernel at pengutronix.de; Alexandre Courbot
> >> > >> Subject: Re: [PATCH 2/2] pinctrl: pinctrl-imx: do not assume mux
> >> > >> 0 is gpio
> >> > >>
> >> > >> On 2017-05-14 23:48, Dong Aisheng wrote:
> >> > >> > Do not assume MUX 0 is GPIO function in core driver as a
> >> > >> > different SoC may have different value. e.g. MX7ULP Mux 1 is
> GPIO.
> >> > >> >
> >> > >> > Cc: Linus Walleij <linus.walleij@linaro.org>
> >> > >> > Cc: Alexandre Courbot <gnurou@gmail.com>
> >> > >> > Cc: Shawn Guo <shawnguo@kernel.org>
> >> > >> > Cc: Stefan Agner <stefan@agner.ch>
> >> > >> > Cc: Fugang Duan <fugang.duan@nxp.com>
> >> > >> > Cc: Bai Ping <ping.bai@nxp.com>
> >> > >> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >> > >> > ---
> >> > >> >  drivers/pinctrl/freescale/pinctrl-imx.c | 3 ++-
> >> > >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> > >> >
> >> > >> > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> >> > >> > b/drivers/pinctrl/freescale/pinctrl-imx.c
> >> > >> > index 0d6aaca..ed8ea32 100644
> >> > >> > --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> >> > >> > +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> >> > >> > @@ -281,7 +281,7 @@ static int
> >> > >> > imx_pmx_gpio_request_enable(struct
> >> > >> > pinctrl_dev *pctldev,
> >> > >> >  			continue;
> >> > >> >  		for (pin = 0; pin < grp->num_pins; pin++) {
> >> > >> >  			imx_pin = &((struct imx_pin *)(grp->data))[pin];
> >> > >> > -			if (imx_pin->pin == offset && !imx_pin->mux_mode)
> >> > >> > +			if (imx_pin->pin == offset)
> >> > >> >  				goto mux_pin;
> >> > >>
> >> > >> The reason I added that check was to make sure we pick a mux
> >> > >> option which is GPIO... With this change, any pinmux might be
> picked...
> >> > >>
> >> > >
> >> > > First of all, this seems to be wrong to me that GPIO mux mode is
> >> > > SoC Dependant and should not be put in pinctrl-imx core driver.
> >> >
> >> > Hm, agree, we should consider to move
> >> > imx_pmx_gpio_request_enable/disable_free and
> >> > imx_pmx_gpio_set_direction into pinctrl-vf610.c
> >> >
> >>
> >> IMX7ULP may want to use imx_pmx_gpio_set_direction as well to support
> >> dynamically change GPIO from output to input.
> >>
> >> > >
> >> > > Secondly, I think we may be over worried and it's not quite
> >> > > necessary As we did not do the sanity check for both raw config
> >> > > and mux data read From Device tree, why only do it for GPIO?
> >> > >
> >> > > We may trust the data in device tree.
> >> >
> >> > In Vybrid, there is no need to explicitly assign a pinmux to use a
> >> > pin as GPIO. So the pinmux could be anything... The implemented
> >> > semantics for Vyrbid is really different than i.MX, see below.
> >> >
> >>
> >> Strange, I do see Vybrid assigning pinmux to GPIO in device tree.
> >> e.g.
> >> arch/arm/boot/dts/vf-colibri.dtsi
> >> pinctrl_esdhc1: esdhc1grp {
> >>         fsl,pins = <
> >>                 VF610_PAD_PTA24__ESDHC1_CLK     0x31ef
> >>                 VF610_PAD_PTA25__ESDHC1_CMD     0x31ef
> >>                 VF610_PAD_PTA26__ESDHC1_DAT0    0x31ef
> >>                 VF610_PAD_PTA27__ESDHC1_DAT1    0x31ef
> >>                 VF610_PAD_PTA28__ESDHC1_DATA2   0x31ef
> >>                 VF610_PAD_PTA29__ESDHC1_DAT3    0x31ef
> >>                 VF610_PAD_PTB20__GPIO_42        0x219d
> >>         >;
> >> };
> >>
> >> > >
> >> > >> >  		}
> >> > >> >  	}
> >> > >> > @@ -292,6 +292,7 @@ static int
> >> > >> > imx_pmx_gpio_request_enable(struct
> >> > >> > pinctrl_dev *pctldev,
> >> > >> >  	reg = readl(ipctl->base + pin_reg->mux_reg);
> >> > >> >  	reg &= ~info->mux_mask;
> >> > >> >  	reg |= imx_pin->config;
> >> > >> > +	reg |= imx_pin->mux_mode << info->mux_shift;
> >> > >>
> >> > >> ... and muxed...
> >> > >>
> >> > >> Not sure if we want that.
> >> > >>
> >> > >> I had to control GPIO output/input through pinctrl since Vybrid
> >> > >> does not allow to control that from the GPIO block.
> >> > >>
> >> > >> However, according to your GPIO patchset, the i.MX 7ULP has a
> >> > >> new register GPIO_PDDR to control output from the GPIO block. Is
> >> > >> controlling the output driver from IOMUXC still required?
> >> > >
> >> > > Yes, it's still required.
> >> > >
> >> >
> >> > That sounds weird, what is the GPIO_PDDR for then? Sure I  need to
> >> > enable the output driver to drive the pin, but can I disable output
> >> > just using GPIO_PDDR?
> >>
> >> No, to fully disable a output, you must disable OBE as well.
> >>
> >> >
> >> > Maybe we have a miss understanding here:
> >> >
> >> > Lets assume we want to switch a GPIO between output and input:
> >> >
> >> > echo "output" > /sys/class/gpio/gpioN/direction ..
> >> > echo "input" > /sys/class/gpio/gpioN/direction
> >> >
> >> > Do I need to disable the output driver in the IOMUXC or can we just
> >> > disable GPIO_PDDR and use the pin as input?
> >> >
> >>
> >> OBE should also be disabled. Otherwise the input may not function well.
> >>
> >> > If we can disable the output driver just using GPIO_PDDR, we can
> >> > avoid the gpio_set_direction cross call.
> >> >
> >> >
> >> > >> If not, I really would just not use all that "find pinctrl config"
> >> > >> hackery... e.g. add a new flag, USE_IOMUXC_FOR_GPIO_OUTPUT, and
> >> > >> set that only for Vybrid.
> >> > >>
> >> > >> This would also align much better with the other i.MX devices,
> >> > >> where pinmuxing and GPIO is completely orthogonal.
> >> > >>
> >> > >
> >> > > Actually this patch came only because to make the exist code not
> >> > > break MX7ULP.
> >> > >
> >> > > Actually I'm wondering why we need implement
> >> > > imx_pmx_gpio_request_enable function?
> >> > >
> >> > > Per my understanding, IMX binding already set GPIO mux by Parsing
> >> > > MUX mode from device tree, so why need gpio_request_enable which
> >> > > looks like is duplicated.
> >> > >
> >> > > Can you help explain it?
> >> >
> >> > I suggest to read this clarification email wrt to pinctrl/gpio from
> >> > Linus
> >> > Walleij:
> >> > https://lkml.org/lkml/2016/10/10/87
> >> >
> >> > To summarize: We have different semantics in Vybrid: The GPIO
> >> > subsystem automatically mux the GPIO for you. So in Vybrid, you do
> >> > not have to mux a GPIO (but a valid entry in your device tree is
> >> > needed, but does not assigned to any node).
> >>
> >> Okay, Clearer now.
> >>
> >> But I do see the users of GPIO pads in Vybrid dts.
> >> Above is an example which make me confuse at first.
> >>
> >> >
> >> > Is what the driver is doing for Vybrid wrong? It is different from
> >> > i.MX, but afaik, it is not really wrong... Its a valid
> >> > implementation according to the currently defined semantics...  Due
> >> > to the *need* to touch pinctrl for direction, I had to implement
> >> > cross calls anyway, so I thought I might as well go full mile and
> >> > also mux the GPIO on
> >> request...
> >> >
> >>
> >> It's not strickly wrong.
> >> Just a bit confuse that gpio_request_enable seems not quite necessary
> >> As we actually already and must define GPIO mux in device tree
> >> according To standard IMX binding format.
> >> e.g. VF610_PAD_PTB20__GPIO_42 in above sd pad group.
> >> That means pinctrl already does the GPIO mux when enable sd function.
> >>
> >> > So the question is, what semantic do we want for i.MX 7ULP? Since
> >> > it is a i.MX device, we probably want the same semantics as i.MX
> >> > 6/7 is already using for the sake of consistency. So in this case
> >> > the gpio_request_enable/disable callbacks are not needed...
> >> >
> >> > This is how I hope we can do the implementation for i.MX 7ULP:
> >> > - Do not use gpio_request_enable/disable
> >>
> >> Yes, we do want that.
> >>
> >> > - Do not use gpio_set_direction either
> >>
> >> Not, ULP needs it to support GPIO direction switch.
> >>
> >> > - Users using a GPIO should enable output driver in IOMUXC (just
> >> > use a pin configuration where output driver is enabled)
> >>
> >> Users still need configure OBE/IBE in devicetree for statically
> assignment.
> >>
> >> > - The GPIO driver only enables/disables the output driver using its
> >> > GPIO_PDDR register depending on GPIO direction
> >>
> >> No, same reason as the second question.
> >>
> >>
> >> So, finnaly, I think the solution may be:
> >> 1. If Vybrid does not use gpio_request_enable/disable, we can simply
> >> remove it. Both driver keeps using pinctrl gpio_set_direction.
> >>
> >> Or.
> >>
> >> 2. Make gpio_request_enable/disable and gpio_set_direction As
> >> pinctrl-imx core driver callbacks. And only assign gpio_set_direction
> >> For IMX7ULP platform driver while assign both for Vybrid.
> >>
> >> Which one would you prefer?
> 
> 1 would mean a semantic change.
> 
> For all GPIO I checked in upstream device trees we assign a pinctrl to the
> same node, so in all cases gpio_request_enable/disable is really
> unnecessary.
> 
> And since the current implementation has adversarial effects for I2C
> recovery (https://patchwork.kernel.org/patch/9351401/), we use the
> orthogonal semantic in the closely related i.MX SoCs and it even
> simplifies the driver, I am ok to change the semantic.
> 

I checked the I2C recovery issue you mentioned above, it looks
Changing the semantic as I proposed may fix it as well.

> Can you prepare such a patchset so that we can further test that on Vybrid?
> 

I will prepare it.

Thanks

Regards
Dong Aisheng
