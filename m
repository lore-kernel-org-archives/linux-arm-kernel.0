From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 15 Feb 2017 15:57:51 -0600
Subject: [PATCH v4 3/3] PCI: imx6: Add code to support i.MX7D
In-Reply-To: <20170215212624.btdhfn4xvuppv6hq@rob-hp-laptop>
References: <20170207155027.7734-1-andrew.smirnov@gmail.com>
 <20170207155027.7734-4-andrew.smirnov@gmail.com>
 <20170215171700.5vz5seeihgtwn76p@rob-hp-laptop>
 <20170215173850.GH19040@bhelgaas-glaptop.roam.corp.google.com>
 <20170215212624.btdhfn4xvuppv6hq@rob-hp-laptop>
Message-ID: <20170215215751.GD6981@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 03:26:24PM -0600, Rob Herring wrote:
> On Wed, Feb 15, 2017 at 11:38:50AM -0600, Bjorn Helgaas wrote:
> > On Wed, Feb 15, 2017 at 11:17:00AM -0600, Rob Herring wrote:
> > > On Tue, Feb 07, 2017 at 07:50:27AM -0800, Andrey Smirnov wrote:
> > > > Add various bits of code needed to support i.MX7D variant of the IP.
> 
> > > 
> > > [...]
> > > 
> > > > @@ -251,6 +261,10 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> > > >  	u32 val, gpr1, gpr12;
> > > >  
> > > >  	switch (imx6_pcie->variant) {
> > > > +	case IMX7D:
> > > > +		reset_control_assert(imx6_pcie->pciephy_reset);
> > > > +		reset_control_assert(imx6_pcie->apps_reset);
> > > > +		break;
> > > >  	case IMX6SX:
> > > >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > >  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> > > 
> > > So the difference with i.MX7D is not really that it has a reset or not, 
> > > but some platforms use a reset driver and some do not. The latter should 
> > > be fixed.
> > 
> > I have this patch queued for v4.11.  Are these things that should be
> > fixed first?  If so, I can drop this.
> 
> Well, depends if you trust things will get fixed later and if the PHY 
> in fact should be separate as that affects the binding. It would affect 
> how the driver changes are done as instead of "if (IMX7D) ...", you'd 
> have "if (imx6_pcie->apps_reset) ..." for example. That part depends on
> how much churn you want there.

I dropped it for now, not that I don't trust it will get fixed, but it
sounds like not completely trivial changes and will affect the binding
as well, so the intermediate state sounds a little messy.

Bjorn
