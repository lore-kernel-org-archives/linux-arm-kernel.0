From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 13 Jun 2017 08:58:47 -0500
Subject: [PATCH v2 1/1] PCI: imx6: Add pcie compliance test option
In-Reply-To: <2668097.SlerkO2uVy@en-pc05>
References: <1472121518-9340-1-git-send-email-stefan.schoefegger@ginzinger.com>
 <1496835374-13053-1-git-send-email-stefan.schoefegger@ginzinger.com>
 <20170612234924.GE4379@bhelgaas-glaptop.roam.corp.google.com>
 <2668097.SlerkO2uVy@en-pc05>
Message-ID: <20170613135847.GA7128@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 05:43:14AM +0000, Sch?fegger Stefan wrote:
> On Monday, June 12, 2017 6:49:24 PM CEST Bjorn Helgaas wrote:
> > On Wed, Jun 07, 2017 at 01:36:11PM +0200, Stefan Schoefegger wrote:
> > > Link speed must not be limited to gen1 during link test for compliance
> > > tests
> > > 
> > > Signed-off-by: Stefan Schoefegger <stefan.schoefegger@ginzinger.com>
> > > ---
> > > 
> > > Changes since v1:
> > >  - pci-imx6.c moved to dwc directory
> > >  
> > >  drivers/pci/dwc/Kconfig    | 10 ++++++++++
> > >  drivers/pci/dwc/pci-imx6.c | 21 ++++++++++++---------
> > >  2 files changed, 22 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> > > index b7e15526d676..b6e9ced5a45d 100644
> > > --- a/drivers/pci/dwc/Kconfig
> > > +++ b/drivers/pci/dwc/Kconfig
> > > @@ -77,6 +77,16 @@ config PCI_IMX6
> > > 
> > >  	select PCIEPORTBUS
> > >  	select PCIE_DW_HOST
> > > 
> > > +config PCI_IMX6_COMPLIANCE_TEST
> > > +	bool "Enable pcie compliance tests on imx6"
> > > +	depends on PCI_IMX6
> > > +	default n
> > > +	help
> > > +	  Enables support for pcie compliance test on FSL iMX SoCs.
> > > +	  The link speed wouldn't be limited to gen1 when enabled.
> > > +	  Enable only during compliance tests, otherwise
> > > +	  link detection will fail on some peripherals.
> > 
> > I'm puzzled about why we would want to merge this patch.  It looks
> > like we're trying to game the system to make the device pass
> > compliance testing when it isn't really compliant.  Is this config
> > option useful to users, or is it only useful during internal
> > development of iMX SoCs?
> 
> It's not for passing compliance tests, it is necessary to do the compliance 
> tests. Without this patch only gen 1 speed is possible to test. Also i.mx6 is 
> not fully gen2 compliant (withour external clk) we should have the option to 
> do gen2 tests. Switching from gen1 to gen2 is done with a 100MHz (1ms) clk 
> pulse on the receiver. Without this patch link speed is forced to gen1 
> afterwards.

I don't understand the purpose of this yet, so maybe all we need is a
better description.

"It's not for passing compliance testing, it is necessary to do the
compliance tests" doesn't make sense to me -- it seems
self-contradictory.

The Kconfig text says "enable only for testing because it makes link
detection fail."  To me that means this option is not useful for
users.  We need some justification for why it should be in the
mainline kernel, where users and distros may enable it.

If you can only support gen2 in certain board configurations, maybe
you should add a config option that can always be enabled for those
boards.

> Yes it is only useful for board setup, it is comparable to 
> CONFIG_USB_EHSET_TEST_FIXTURE for usb (ok, this is more general and not host 
> specific).

USB_EHSET_TEST_FIXTURE (added by 1353aa53851e ("usb: misc: EHSET Test
Fixture device driver for host compliance")) looks like just another
driver in the sense that it's always safe to enable it and it doesn't
hurt anything if you enable it without having the hardware.

This patch doesn't seem comparable to USB_EHSET_TEST_FIXTURE because
this new option apparently breaks link detection in some cases.

> > >  config PCIE_SPEAR13XX
> > >  
> > >  	bool "STMicroelectronics SPEAr PCIe controller"
> > >  	depends on PCI
> > > 
> > > diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> > > index 19a289b8cc94..b0fbe52e25b0 100644
> > > --- a/drivers/pci/dwc/pci-imx6.c
> > > +++ b/drivers/pci/dwc/pci-imx6.c
> > > @@ -533,15 +533,18 @@ static int imx6_pcie_establish_link(struct imx6_pcie
> > > *imx6_pcie)> 
> > >  	u32 tmp;
> > >  	int ret;
> > > 
> > > -	/*
> > > -	 * Force Gen1 operation when starting the link.  In case the link is
> > > -	 * started in Gen2 mode, there is a possibility the devices on the
> > > -	 * bus will not be detected at all.  This happens with PCIe switches.
> > > -	 */
> > > -	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
> > > -	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> > > -	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> > > -	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
> > > +	if (!IS_ENABLED(CONFIG_PCI_IMX6_COMPLIANCE_TEST)) {
> > > +		/*
> > > +		 * Force Gen1 operation when starting the link.  In case the
> > > +		 * link is started in Gen2 mode, there is a possibility the
> > > +		 * devices on the bus will not be detected at all.  This
> > > +		 * happens with PCIe switches.
> > > +		 */
> > > +		tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
> > > +		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> > > +		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> > > +		dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
> > > +	}
> > > 
> > >  	/* Start LTSSM. */
> > >  	if (imx6_pcie->variant == IMX7D)
> 
