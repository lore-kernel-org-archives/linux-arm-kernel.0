From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Jun 2014 17:19:06 +0200
Subject: [PATCH v10 2/2] dmaengine: sun6i: Add driver for the Allwinner
 A31 DMA controller
In-Reply-To: <20140630142054.GA8756@leverpostej>
References: <1404134454-25513-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404134454-25513-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140630142054.GA8756@leverpostej>
Message-ID: <20140630151906.GG28647@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 03:20:54PM +0100, Mark Rutland wrote:
> Hi Maxime,
> 
> On Mon, Jun 30, 2014 at 02:20:54PM +0100, Maxime Ripard wrote:
> > The Allwinner A31 has a 16 channels DMA controller that it shares with the
> > newer A23. Although sharing some similarities with the DMA controller of the
> > older Allwinner SoCs, it's significantly different, I don't expect it to be
> > possible to share the driver for these two.
> >
> > The A31 Controller is able to memory-to-memory or memory-to-device transfers on
> > the 16 channels in parallel.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/dma/Kconfig     |    8 +
> >  drivers/dma/Makefile    |    1 +
> >  drivers/dma/sun6i-dma.c | 1058 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1067 insertions(+)
> >  create mode 100644 drivers/dma/sun6i-dma.c
> 
> [...]
> 
> > +       sdc->clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(sdc->clk)) {
> > +               dev_err(&pdev->dev, "No clock specified\n");
> > +               return PTR_ERR(sdc->clk);
> > +       }
> > +
> > +       mux = clk_get(NULL, "ahb1_mux");
> > +       if (IS_ERR(mux)) {
> > +               dev_err(&pdev->dev, "Couldn't get AHB1 Mux\n");
> > +               return PTR_ERR(mux);
> > +       }
> > +
> > +       pll6 = clk_get(NULL, "pll6");
> > +       if (IS_ERR(pll6)) {
> > +               dev_err(&pdev->dev, "Couldn't get PLL6\n");
> > +               clk_put(mux);
> > +               return PTR_ERR(pll6);
> > +       }
> 
> I'm slightly confused. The binding listed a single unnamed clock (the
> AHB clock). What is going on here?

The device itself needs only a single clock to work...

> 
> > +       ret = clk_set_parent(mux, pll6);
> > +       clk_put(pll6);
> > +       clk_put(mux);
> > +
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Couldn't reparent AHB1 on PLL6\n");
> > +               return ret;
> > +       }
> 
> Why do we need to reparent the mux?

... but will function only if this clock is derived from PLL6.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/5f27ba48/attachment.sig>
