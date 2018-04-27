From: anson.huang@nxp.com (Anson Huang)
Date: Fri, 27 Apr 2018 02:12:49 +0000
Subject: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
In-Reply-To: <AM3PR04MB1315F80C9B5190F4E26DC723F58D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
 <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <AM3PR04MB1315B04BE46755E3EB82E04CF58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AS=aH8p1+tmgJ4ooeqExNqOALh7vbPAsQdqdky8CkXyQ@mail.gmail.com>
 <DB5PR04MB132072FEDCAFEDF6592C6A32F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
 <CAOMZO5Df__UpcLXVUrW0sT24g=Kmu2132QeQSBE9aZrjcyqsCw@mail.gmail.com>
 <AM3PR04MB1315F80C9B5190F4E26DC723F58D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <AM3PR04MB131578877377FCEB44B685E2F58D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Friday, April 27, 2018 9:37 AM
> To: 'Fabio Estevam' <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>;
> Andy Duan <fugang.duan@nxp.com>
> Subject: RE: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> 
> 
> 
> Anson Huang
> Best Regards!
> 
> 
> > -----Original Message-----
> > From: Fabio Estevam [mailto:festevam at gmail.com]
> > Sent: Friday, April 27, 2018 1:29 AM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX /
> > MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open
> > list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> > <devicetree@vger.kernel.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; Andy Duan <fugang.duan@nxp.com>
> > Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> >
> > On Thu, Apr 26, 2018 at 3:57 AM, Anson Huang <anson.huang@nxp.com>
> > wrote:
> >
> > > The 'phy-supply' is for enabling/disabling phy regulator, but here
> > > the
> > > MAX7322 IO0 is NOT for enabling/disabling PHY regulator, it is for
> > > IO voltage switch between 1.5V and 1.8V, our ENET IO can work with
> > > both 1.5V
> > and 1.8V, so any config is OK for ENET function.
> >
> > Thanks for the clarification.
> >
> > > The 1.5V/1.8V selection is a one time setting thing, that means we
> > > only need to config it once during boot up, most of i.MX platforms
> > > does NOT provide such voltage switch function for ENET IO, on this
> > > 6SX sabre auto board, it is more like a backup or validation
> > > purpose. With default
> > settings, ENET's function is NOT impacted at all.
> > >
> > > I think we can add a gpio regulator for it and let the regulator
> > > initialization set the GPIO Level for fec, such below, with "
> > > enable-active-high " present, GPIO will be at LOW and voltage is
> > > 1.5V, without
> > this property, GPIO will be HIGH and voltage will be 1.8V.
> > > +               reg_fec: fec_io_supply {
> > > +                       compatible = "regulator-gpio";
> > > +                       regulator-name = "1.8V_1.5V_FEC";
> > > +                       regulator-min-microvolt = <1500000>;
> > > +                       regulator-max-microvolt = <1800000>;
> > > +                       states = <1500000 0x0 1800000 0x1>;
> > > +                       enable-gpio = <&max7322 0
> > GPIO_ACTIVE_HIGH>;
> > > +                       vin-supply = <&sw2_reg>;
> > > +                       enable-active-high;
> >
> > If there is no consumer for this regulator, the regulator API will disable it.
> >
> > It seems you need a 'regulator-always-on;'.
> 
> GPIO regulator is slight different when regulator framework try to disable those
> unused regulator in late phase, in _regulator_do_disable, the GPIO regulator
> only got disabled when it is explicitly enabled before (ena_gpio_state is set when
> regulator is enabled), but this reg_fec is NOT getting enabled, since it only has
> voltage switch function. But I agree that we can anyway add
> 'regulator-always-on'
> to avoid any confusion, will send out new patch, thanks!
> 
>          if (rdev->ena_pin) {
>                  if (rdev->ena_gpio_state) {
>                          ret = regulator_ena_gpio_ctrl(rdev, false);
> 
> 
> Anson.

I found if I add ' regulator-always-on ', the regulator core will explicitly enable this GPIO
regulator and cause MAX7322 IO0 to be HIGH and the FEC IO will be 1.8V, since the GPIO regulator
state 1 means 1.8V, but what we want for now is 1.5V, so I think we should NOT add ' regulator-always-on ',
if anyone wants to use 1.8V IO voltage, they can enable this GPIO regulator to get 1.8V. So I think V5 patch set
is just what we want, we want to use the OFF state's voltage (1.5V) of this MAX7322 IO0 GPIO regulator. Thanks.

Anson.


> 
> >
> >
> > > +               };
> > > +
> > >
> > > Anson.
> > >
