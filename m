From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Sep 2012 10:50:08 +0100
Subject: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <20120903094448.GB11780@pengutronix.de>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
 <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
 <20120831112258.GA2624@pengutronix.de>
 <20120831122323.GC5962@gmail.com>
 <CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ@mail.gmail.com>
 <20120903094448.GB11780@pengutronix.de>
Message-ID: <20120903095001.GB5782@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 11:44:48AM +0200, Wolfram Sang wrote:
> On Mon, Sep 03, 2012 at 11:22:28AM +0200, Linus Walleij wrote:
> > On Fri, Aug 31, 2012 at 2:23 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > (...)
> > >  static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
> > >  {
> > >         int ret = 0;
> > >         struct nmk_i2c_controller *pdata = adev->dev.platform_data;
> > > +       struct device_node *np = adev->dev.of_node;
> > >         struct nmk_i2c_dev      *dev;
> > >         struct i2c_adapter *adap;
> > >
> > > +       if (np) {
> > > +               if (!pdata) {
> > 
> > So, if no pdata is provided, we go on to allocate some ...
> > 
> > > +                       pdata = devm_kzalloc(&adev->dev, sizeof(*pdata), GFP_KERNEL);
> > > +                       if (!pdata) {
> > > +                               ret = -ENOMEM;
> > > +                               goto err_no_mem;
> > > +                       }
> > > +               }
> > > +               /* Provide the default configuration as a base. */
> > > +               pdata = &u8500_i2c;
> > 
> > Then you just override that pointer with a pointer to the local config.
> > 
> > > +               nmk_i2c_of_probe(np, pdata);
> > > +       }
> > > +
> > >         if (!pdata)
> > >                 /* No i2c configuration found, using the default. */
> > >                 pdata = &u8500_i2c;
> > 
> > This in it's entirety does not look sound. I *think* this is what you
> > want to do,
> > replace all of the above codde (including the last if (!pdata) clause) with:
> > 
> > if (!pdata) {
> >     /* If no platform data passed in, use the default configuration as
> > a base. */
> >     pdata = &u8500_i2c;
> >     if (np)
> >         /* Further, if we have a DT node, override the default with this */
> >         nmk_i2c_of_probe(np, pdata);
> > }
> > 
> > This makes any passed pdata take precedence, else default pdata
> > complemented with DT info. Which is what we want.
> 
> No. of_probe modifies pdata which in this case the default config which
> might already be in use. So, you will get problems if you have two
> instances with different configuration. So, we need to allocate memory
> but copy the content of the default data. The patch above just copies
> the pointer which is bogus.

Agreed. I'll fixup.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
