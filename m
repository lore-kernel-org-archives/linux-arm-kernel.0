From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 7 Aug 2012 19:34:19 +0800
Subject: [PATCH] pinctrl: pinctrl-imx: add imx35 pinctrl driver
In-Reply-To: <20120807084904.GA9888@pengutronix.de>
References: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAP1dx+wRZea8o8KTGRDCMtQkt7EjDRN5EoFek80OKqJgTxbvZA@mail.gmail.com>
 <20120807084904.GA9888@pengutronix.de>
Message-ID: <20120807113418.GA13786@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 10:49:04AM +0200, Uwe Kleine-K?nig wrote:
...
> > > +See below for available PIN_FUNC_ID for imx35:
> > > +# grep '   IMX_PIN_REG' drivers/pinctrl/pinctrl-imx35.c | awk '{ print NR-1 " " $8 }'
> > > +0 MX35_PAD_CAPTURE__GPT_CAPIN1
> > > +1 MX35_PAD_CAPTURE__GPT_CMPOUT2
> > I'm not sure if you can use the format as exist IMX PIN_FUNC_ID tables as:
> > MX35_PAD_CAPTURE__GPT_CAPIN1        0
> > MX35_PAD_CAPTURE__GPT_CMPOUT2    1
> I choosed to switch the order here to have a more column like format.
> the length of the numbers is more uniform. I can switch if you want.
> 
I think either is ok.
You can do as you wish. :)

> > Maybe the difficulty is the command (i did not know how to do it before),
> > If you know, we can do like that.
> > Anyway, it's not a big issue and does not block an ack.
> > 
> > > +enum imx35_pads {
> > > +       /* sed -r -n 's@^#define MX35_PAD_([0-9A-Z_]*)__([0-9A-Z_]*)\s+IOMUX_PAD\(\s*([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9]*),\s*NO_PAD_CTRL\)@\tMX35_PAD_\1, at p' arch/arm/plat-mxc/include/mach/iomux-mx35.h | uniq */
> > > +       MX35_PAD_CAPTURE,
> > > +       MX35_PAD_COMPARE,
> > > +       MX35_PAD_WDOG_RST,
> > > +       MX35_PAD_GPIO1_0,
> > > +       MX35_PAD_GPIO1_1,
> > > +       MX35_PAD_GPIO2_0,
> > > +       MX35_PAD_GPIO3_0,
> > Can we use the format as exist one?
> > enum imx53_pads {
> >         MX53_PAD_GPIO_19 = 1,
> >         MX53_PAD_KEY_COL0 = 2,
> >         MX53_PAD_KEY_ROW0 = 3,
> >         MX53_PAD_KEY_COL1 = 4,
> > .......
> > }
> > Then people can easy know its pin id.
> > I'm wondering there may be still some debug info are using pin id
> > then the above format helps.
> I didn't see output referring to pin ids (which doesn't mean it doesn't
> exist of course). I don't care much
Right, it seems currently most places of debug information
has a pin name going with pin id.
So without id here seems not affect debug information a lot.

But i'm not sure whether it won't be used in the future since it's a basic
property of pin and should be nature to have.
e.g. i formerly proposed pinctrl gpio binding uses the pin id like:
<&gpio0 $gpio_offset $pin_id $count>
So i think it may be better to also explicitly define it in driver.
It does not harm and make things clear, especially it's not a big work. :)

> and wondered why you started at 1 and not 0.
It looks my mistake during the data transition before.:)
It should be better 0. Thanks for the finding.

Regards
Dong Aisheng
