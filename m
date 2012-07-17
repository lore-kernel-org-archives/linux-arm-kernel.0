From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 17 Jul 2012 11:02:26 +0800
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: add support for set bits
 for general purpose registers
In-Reply-To: <CACRpkdbHtgKLA3JJxc4VY35zSpJFvk15u62Z3aBCqERoeQ10CA@mail.gmail.com>
References: <1342084080-3145-1-git-send-email-b29396@freescale.com>
 <CACRpkdbHtgKLA3JJxc4VY35zSpJFvk15u62Z3aBCqERoeQ10CA@mail.gmail.com>
Message-ID: <20120717030225.GF19699@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2012 at 04:43:03AM +0800, Linus Walleij wrote:
> On Thu, Jul 12, 2012 at 11:07 AM, Dong Aisheng <b29396@freescale.com> wrote:
> 
> Hm, hm. This makes be ever more hesitant to have this in pinctrl.
> 
> Remeber again that nothing stops you from remapping the same register
> range in another driver.
> 
Well, i understand and agree with your point.
We will try and see if we can find a better place.

> > +#define IMX6Q_GPR0_CLOCK_8_MUX_SEL_MASK                (0x3 << 30)
> 
> This belongs in drivers/clk/*
> 
> Why funnel these register writes through pinctrl? Just remap that address
> offset in the clk driver.
> 
Hmm, i looked a bit more, not sure they could be put in driver/clk/*
The mux here are module internal clocks, like:
Selects the source of asrck_clock_3 in ASRC according to clock muxing scheme:
00 audmux.amx_output_rxclk_p7 muxed with ssi3.ssi_srck
01 audmux.amx_output_rxclk_p7
10 ssi3.ssi_srck
11 ssi3.rx_bit_clk

I'm not sure we should abstract them in clk framework since usually they're
internally controlled by module driver itself.

> > +#define IMX6Q_GPR0_DMAREQ_MUX_SEL7_MASK                BIT(7)
> 
> This belongs in drivers/dma/*
> 
> Same comments.
> 
> > +#define IMX6Q_GPR1_PCIE_REQ_MASK               (0x3 << 30)
> 
> Looks like it belongs in some PCI driver or glue layer.
> 
> > +#define IMX6Q_GPR1_MIPI_COLOR_SW               BIT(25)
> > +#define IMX6Q_GPR1_DPI_OFF                     BIT(24)
> 
> Looks related to some test or something...
> 
> And so on.
> 
Yes, most of them are modules specific.

> If you really wants a "funnel driver" doing all these diverse things,
> I'd put it in drivers/mfd.
Yes, we may wants this "funnel driver".
What i'm thinking is we may only provides setting api for conveniently use
and how drivers use it or abstract it is driver specific.

> 
> This whole issue appears in other systems so you're not alone
> on this, for example the ux500 PRCMU driver has exactly these
> properties.
> 
So how does ux500 PRCMU handle this?

> I'm also contemplating drivers/syscon again, but
> I have a hard time seeing it would be much more than another
> drivers/mfd-similar construct.
> 
yes, that may be a proper place.

> I would really like input from Arnd and Samuel and other clever
> people on the placement of drivers like this one :-/
> 
> But close address range proximity to the pin controller is not a
> reason to have it in pinctrl.
> 
Well, understand.

Regards
Dong Aisheng
