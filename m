From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 16 Jul 2012 16:17:04 +0800
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: add support for set bits
 for general purpose registers
In-Reply-To: <CACRpkdbHtgKLA3JJxc4VY35zSpJFvk15u62Z3aBCqERoeQ10CA@mail.gmail.com>
References: <1342084080-3145-1-git-send-email-b29396@freescale.com>
 <CACRpkdbHtgKLA3JJxc4VY35zSpJFvk15u62Z3aBCqERoeQ10CA@mail.gmail.com>
Message-ID: <20120716081703.GH21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2012 at 10:43:03PM +0200, Linus Walleij wrote:
> On Thu, Jul 12, 2012 at 11:07 AM, Dong Aisheng <b29396@freescale.com> wrote:
> 
> Hm, hm. This makes be ever more hesitant to have this in pinctrl.
> 
> Remeber again that nothing stops you from remapping the same register
> range in another driver.
> 
> > +#define IMX6Q_GPR0_CLOCK_8_MUX_SEL_MASK                (0x3 << 30)
> 
> This belongs in drivers/clk/*
> 
> Why funnel these register writes through pinctrl? Just remap that address
> offset in the clk driver.
> 
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
> If you really wants a "funnel driver" doing all these diverse things,
> I'd put it in drivers/mfd.
It's like driver drivers/mfd/anatop-mfd.c. They both store misc bits.
We may need a generic driver to simply provide register accessor.

Thanks
Richard
> 
> This whole issue appears in other systems so you're not alone
> on this, for example the ux500 PRCMU driver has exactly these
> properties.
> 
> I'm also contemplating drivers/syscon again, but
> I have a hard time seeing it would be much more than another
> drivers/mfd-similar construct.
> 
> I would really like input from Arnd and Samuel and other clever
> people on the placement of drivers like this one :-/
> 
> But close address range proximity to the pin controller is not a
> reason to have it in pinctrl.
> 
> Yours,
> Linus Walleij
> 
