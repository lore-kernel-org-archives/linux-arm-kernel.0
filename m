From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Tue, 11 Feb 2014 11:57:46 +0800
Subject: [PATCH V5 4/8] phy: st-miphy-40lp: Add skeleton driver
In-Reply-To: <201402101654.22187.arnd@arndb.de>
References: <cover.1391871170.git.pratyush.anand@st.com>
 <fb505abd332645671d9ad125003d8253b6346715.1391871170.git.pratyush.anand@st.com>
 <201402101654.22187.arnd@arndb.de>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FD2CAA9B@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, February 10, 2014 9:24 PM
> To: Mohit KUMAR DCG
> Cc: Pratyush ANAND; Kishon Vijay Abraham I; spear-devel; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH V5 4/8] phy: st-miphy-40lp: Add skeleton driver
> 
> On Monday 10 February 2014, Mohit Kumar wrote:
> > diff --git a/Documentation/devicetree/bindings/phy/st-miphy40lp.txt
> > b/Documentation/devicetree/bindings/phy/st-miphy40lp.txt
> > new file mode 100644
> > index 0000000..d0c7096
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/st-miphy40lp.txt
> > @@ -0,0 +1,12 @@
> > +Required properties:
> > +- compatible : should be "st,miphy40lp-phy"
> > +	Other supported soc specific compatible:
> > +		"st,spear1310-miphy"
> > +		"st,spear1340-miphy"
> > +- reg : offset and length of the PHY register set.
> > +- misc: phandle for the syscon node to access misc registers
> > +- phy-id: Instance id of the phy.
> > +- #phy-cells : from the generic PHY bindings, must be 1.
> > +	- 1st cell: phandle to the phy node.
> > +	- 2nd cell: 0 if phy (in 1st cell) is to be used for SATA, 1 for PCIe
> > +	  and 2 for Super Speed USB.
> 
> It's common to start this file with a small header explaining what this
> hardware is.

- OK

> 
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig index
> > afa2354..2f58993 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -64,4 +64,10 @@ config BCM_KONA_USB2_PHY
> >  	help
> >  	  Enable this to support the Broadcom Kona USB 2.0 PHY.
> >
> > +config PHY_ST_MIPHY40LP
> > +	tristate "ST MIPHY 40LP driver"
> > +	help
> > +	  Support for ST MIPHY 40LP which can be used for PCIe, SATA and
> Super Speed USB.
> > +	select GENERIC_PHY
> > +
> >  endmenu
> 
> The 'select' statement should come before 'help', for consistency with the
> rest of the kernel.

- OK

> Maybe mention that this phy is used inside the spear13xx
> SoC here rather than a standalone phy.

- Yes, for spear13xx its used internally. Do you think that it requires to be mentioned here? 
We have few prototype boards that uses this as external phy.

> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv) {
> > +		dev_err(dev, "can't alloc miphy40lp private date
> memory\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	priv->plat_ops = (struct miphy40lp_plat_ops *)of_id->data;
> 
> The cast would incorrectly remove the 'const' attribute of the pointer.
> Better remove the cast and make priv->plat_ops const.

- OK

> 
> > +static int __init miphy40lp_phy_init(void) {
> > +
> > +	return platform_driver_probe(&miphy40lp_driver,
> > +				miphy40lp_probe);
> > +}
> > +module_init(miphy40lp_phy_init);
> 
> There should certainly be a module_exit() function here so you can unload
> the driver.

- yes, will add it in v6.

Thanks
Mohit

> 
> 	Arnd
