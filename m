From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 1 Jul 2014 09:24:24 +0200
Subject: [PATCH v2 07/12] usb: chipidea: add a generic driver
In-Reply-To: <20140701002112.GA26146@shlinux1.ap.freescale.net>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-8-git-send-email-antoine.tenart@free-electrons.com>
 <20140627032506.GA18039@shlinux1.ap.freescale.net>
 <20140630133313.GA11880@kwain>
 <20140701002112.GA26146@shlinux1.ap.freescale.net>
Message-ID: <20140701072424.GA8958@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

On Tue, Jul 01, 2014 at 08:21:14AM +0800, Peter Chen wrote:
> On Mon, Jun 30, 2014 at 03:33:13PM +0200, Antoine T?nart wrote:
> > On Fri, Jun 27, 2014 at 11:25:07AM +0800, Peter Chen wrote:
> > > On Tue, Jun 24, 2014 at 12:35:16PM +0200, Antoine T?nart wrote:
> > > >  
> > > >  ifneq ($(CONFIG_OF),)
> > > >  	obj-$(CONFIG_USB_CHIPIDEA)	+= usbmisc_imx.o ci_hdrc_imx.o
> > > > +	obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_generic.o
> > > >  endif
> > > 
> > > As a generic driver, you may need to support both dt and non-dt
> > > solution.
> > 
> > Since the dt is now the best practice and since there is no need (yet)
> > for a non-dt usage of this driver shouldn't we let anyone needing it
> > implement it when the time comes?
> > 
> 
> No, at least your code structure should support both dt and non-dt,
> and let the compile pass for non-dt platform if you don't have one.
> Then, someone with non-dt platform can change few to support it. 
> A good example is: drivers/usb/host/ehci-platform.c

Ok. I'll isolate dt-specific code in the probe, and remove the CONFIG_OF
dependency.

> 
> > > > +static int ci_hdrc_generic_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct device *dev = &pdev->dev;
> > > > +	struct ci_hdrc_generic_priv *priv;
> > > > +	struct ci_hdrc_platform_data ci_pdata = {
> > > > +		.name		= "ci_hdrc",
> > > 
> > > How about this using dev_name(&pdev->dev) for name?
> > 
> > Yes, why not. I don't have a strong preference.
> > 
> > > > +
> > > > +clk_err:
> > > > +	clk_disable_unprepare(priv->clk);
> > > 
> > > You may need to add "if (!IS_ERR(priv->clk))"
> > 
> > Right! I'll update this.
> > 
> > > > +
> > > > +static const struct of_device_id ci_hdrc_generic_of_match[] = {
> > > > +	{ .compatible = "chipidea-usb" },
> > > > +	{ }
> > > > +};
> > > 
> > > Even as a generic driver, you can also use your own compatible string.
> > 
> > Well, there is nothing specific about the Berlin CI. Some subsystems
> > use the 'generic' keyword in these cases. Do you see a particular reason
> > I should use some Berlin related compatible here?
> > 
> 
> Not must, one suggestion is: can you change the compatible string
> to "chipidea-usb-generic"?

Sounds good, I'll update.


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
