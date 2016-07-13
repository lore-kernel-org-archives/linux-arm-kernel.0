From: atull@opensource.altera.com (atull)
Date: Wed, 13 Jul 2016 09:47:03 -0500
Subject: [PATCH 2/2] fpga-manager: Add Socfpga Arria10 support
In-Reply-To: <20160712222029.GW1041@n2100.armlinux.org.uk>
References: <20160712190709.5964-1-atull@opensource.altera.com>
 <20160712190709.5964-3-atull@opensource.altera.com>
 <CAAtXAHfSBzLisqBgF4Vry0vrcL3+DB4b1ctMOrTdOq5ue4D7JQ@mail.gmail.com>
 <20160712222029.GW1041@n2100.armlinux.org.uk>
Message-ID: <alpine.DEB.2.02.1607130944410.10735@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jul 2016, Russell King - ARM Linux wrote:

> On Tue, Jul 12, 2016 at 02:31:05PM -0700, Moritz Fischer wrote:
> > On Tue, Jul 12, 2016 at 12:07 PM, Alan Tull <atull@opensource.altera.com> wrote:
> > > +       priv->clk = devm_clk_get(dev, NULL);
> > > +       if (IS_ERR(priv->clk)) {
> > > +               dev_err(dev, "no clock specified\n");
> > > +               return PTR_ERR(priv->clk);
> > > +       }
> > > +
> > > +       ret = clk_prepare_enable(priv->clk);
> > > +       if (ret) {
> > > +               dev_err(dev, "could not enable clock\n");
> > > +               clk_put(priv->clk);
> > 
> > Seen that you used devm_clk_get() is this one necessary?
> 
> That's actually a bug.

Yes, it's wrong.  And not needed anyway.

>  Never clk_put() a devm_clk_get()'d clock.
> devm_clk_put() is what you want if provided.  However, I think
> this clk_put() call is useless here.
> 
> > > +static int socfpga_a10_fpga_remove(struct platform_device *pdev)
> > > +{
> > > +       struct fpga_manager *mgr = platform_get_drvdata(pdev);
> > > +       struct a10_fpga_priv *priv = mgr->priv;
> > > +
> > > +       fpga_mgr_unregister(&pdev->dev);
> > > +       clk_disable_unprepare(priv->clk);
> > > +       clk_put(priv->clk);
> > 
> > Same here, if needed at all shouldn't it be devm_clk_put() ?
> 
> And also useless here, as the whole point of the devm_* stuff is to
> clean up the resources that were claimed on probe failure or when
> the device is unbound from its driver.

Thanks for pointing this out.  I'll take out the clk_put's.

Alan

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 
