From: ping.bai@nxp.com (Jacky Bai)
Date: Mon, 9 Jan 2017 02:32:36 +0000
Subject: [PATCH v2 05/12] Document: dt: binding: imx: update pinctrl doc
 for imx6sll
In-Reply-To: <CACRpkdYUME8K+JusA0ORRKqxyBuhDdyei8eg7UZbHidKw9=bQw@mail.gmail.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-6-git-send-email-ping.bai@nxp.com>
 <CACRpkdYUME8K+JusA0ORRKqxyBuhDdyei8eg7UZbHidKw9=bQw@mail.gmail.com>
Message-ID: <AM3PR04MB5304992095753B761E66A9A87640@AM3PR04MB530.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v2 05/12] Document: dt: binding: imx: update pinctrl doc
> for imx6sll
> 
> On Tue, Dec 27, 2016 at 10:47 AM, Bai Ping <ping.bai@nxp.com> wrote:
> 
> > Add pinctrl binding doc update for imx6sll.
> >
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> 
> I have to push back on this a bit.
> 
> > +Please refer to fsl,imx-pinctrl.txt in this directory for common
> > +binding part and usage.
> 
> I understand that it is building on top of the old i.MX bindings and that it has
> some kind of "tradition" coming with it.
> 
> At the same time, the i.MX bindings came about before we had the generic pin
> control bindings defined.
> 
> > +CONFIG bits definition:
> > +PAD_CTL_LVE                    (1 << 22)
> > +PAD_CTL_HYS                     (1 << 16)
> > +PAD_CTL_PUS_100K_DOWN           (0 << 14)
> > +PAD_CTL_PUS_47K_UP              (1 << 14)
> > +PAD_CTL_PUS_100K_UP             (2 << 14)
> > +PAD_CTL_PUS_22K_UP              (3 << 14)
> > +PAD_CTL_PUE                     (1 << 13)
> > +PAD_CTL_PKE                     (1 << 12)
> > +PAD_CTL_ODE                     (1 << 11)
> > +PAD_CTL_SPEED_LOW               (0 << 6)
> > +PAD_CTL_SPEED_MED               (1 << 6)
> > +PAD_CTL_SPEED_HIGH              (3 << 6)
> > +PAD_CTL_DSE_DISABLE             (0 << 3)
> > +PAD_CTL_DSE_260ohm              (1 << 3)
> > +PAD_CTL_DSE_130ohm              (2 << 3)
> > +PAD_CTL_DSE_87ohm               (3 << 3)
> > +PAD_CTL_DSE_65ohm               (4 << 3)
> > +PAD_CTL_DSE_52ohm               (5 << 3)
> > +PAD_CTL_DSE_43ohm               (6 << 3)
> > +PAD_CTL_DSE_37ohm               (7 << 3)
> > +PAD_CTL_SRE_FAST                (1 << 0)
> > +PAD_CTL_SRE_SLOW                (0 << 0)
> 
> A whole slew of these if not all correspond to the generic bindings.
> 
> I would consider augmenting the code in the driver to handle the generic
> bindings *in addition* to the old legacy bindings, and use those over these
> random custom bits.
> 
> Read drivers using CONFIG_GENERIC_PINCONF as an inspiration.
> 
> For example see commit
> cefbf1a1b29531a970bc2908a50a75d6474fcc38
> "pinctrl: sunxi: Support generic binding"
> from Maxime Ripard, where he does a similar thing for sunxi.

I have look into the above commit on using generic binding. But I think the generic pinconf
is not very easy to add in imx pinctrl Driver. imx pinctrl use a different way to parse the pin configure.
 
Each fsl,pin entry  looks like <PIN_FUNC_ID  CONFIG> in dts, the CONFIG is the pad setting value like
pull-up, open-drain, drive strength etc. The above config bit definition is specific to each SOC in the PAD CTL register.

If we want set the pin config to enable hysteresis, 47KOhm Pull Up, 50Mhz speed, 80Ohm driver strength
and Fast Slew Rate, then the CONFIG value should be 0x17059( ORs corresponding bit definition). This value will be set in
PAD CTL register to config the corresponding pin.

BR
Jacky Bai

> 
> Yours,
> Linus Walleij
