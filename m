From: marex@denx.de (Marek Vasut)
Date: Mon, 25 Jun 2012 15:30:31 +0200
Subject: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
In-Reply-To: <CAOMZO5BYoU5=tJCUH1nkT24FJhhXXhNwF46yYREGJj7G33HdVg@mail.gmail.com>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
 <1340477033-2761-7-git-send-email-marex@denx.de>
 <CAOMZO5BYoU5=tJCUH1nkT24FJhhXXhNwF46yYREGJj7G33HdVg@mail.gmail.com>
Message-ID: <201206251530.32203.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> Hi Marek,
> 
> On Sat, Jun 23, 2012 at 3:43 PM, Marek Vasut <marex@denx.de> wrote:
> > +       ssp->clk = clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(ssp->clk)) {
> > +               ret = PTR_ERR(ssp->clk);
> > +               goto out_spi_free;
> > +       }
> 
> You could use devm_clk_get here instead,
> 
> > +
> > +       clk_prepare_enable(ssp->clk);
> > +       ssp->clk_rate = clk_get_rate(ssp->clk) / 1000;
> > +
> > +       stmp_reset_block(ssp->base);
> > +
> > +       platform_set_drvdata(pdev, host);
> > +
> > +       ret = spi_register_master(host);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Cannot register SPI master, %d\n",
> > ret); +               goto out_clk_put;
> > +       }
> > +
> > +       return 0;
> > +
> > +out_clk_put:
> > +       clk_disable_unprepare(ssp->clk);
> > +       clk_put(ssp->clk);
> 
> ,and then you would not need this clk_put here.

Oh, good point! I'll wait a little bit more until someone else reviews it and 
then I'll resubmit new version.

btw. I'm already working on a combined PIO/DMA-capable version -- seems like 
using PIO for small transfers and DMA for large transfers is good strategy that 
gives me about 200kbps boost ;-)

> Driver looks good. Thanks for working on it.
> 
> Regards,
> 
> Fabio Estevam

Best regards,
Marek Vasut
