From: antony@phenome.org (Antony Antony)
Date: Mon, 4 Sep 2017 16:26:19 +0200
Subject: [PATCH v5] arm64: allwinner: h5: add support for NanoPi NEO Plus2
In-Reply-To: <20170904082732.g2q2tjd6qlvhaea7@flea>
References: <20170824231716.2623-1-antony@phenome.org>
 <20170830125057.38529-1-antony@phenome.org>
 <20170831145859.rief3fqo36ns23rm@flea>
 <20170901105313.m26y2re3ulskua43@AntonyAntony.local>
 <20170904082732.g2q2tjd6qlvhaea7@flea>
Message-ID: <20170904142619.zq4x2l2qwtpukdc7@AntonyAntony.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, Sep 04, 2017 at 10:27:32AM +0200, Maxime Ripard wrote:
> On Fri, Sep 01, 2017 at 12:53:13PM +0200, Antony Antony wrote:
> > > > +&emac {
> > > > +	pinctrl-names = "default";
> > > > +	pinctrl-0 = <&emac_rgmii_pins>;
> > > > +	phy-supply = <&reg_gmac_3v3>;
> > > > +	phy-handle = <&ext_rgmii_phy>;
> > > > +	phy-mode = "rgmii";
> > > > +	status = "okay";
> > > > +};
> > > > +
> > > > +&mdio {
> > > > +	ext_rgmii_phy: ethernet-phy at 7 {
> > > > +		compatible = "ethernet-phy-ieee802.3-c22";
> > > > +		reg = <7>;
> > > > +	};
> > > > +};
> > > 
> > > This will not compile.
> > 
> > I don't understand you, because, v5 file compiled for me. Here is output 
> > from running system, just the relevant part.  using dtc -I fs 
> > /proc/device-tree
> > 
> > ext_rgmii_phy = "/soc/ethernet at 1c30000/mdio/ethernet-phy at 7";
> > 
> > ethernet at 1c30000 {
> > 	mdio {
> > 	..
> > 		ethernet-phy at 7 {
> > 			compatible = "ethernet-phy-ieee802.3-c22";
> > 			phandle = <0x1c>;
> > 			reg = <0x7>;
> > 			linux,phandle = <0x1c>;
> > 		};
> > };
> > 
> > Is this what you expect?
> 
> The bindings have been reverted recently, so if you based your work on
> a version between 4.13-rc1 and 4.13-rc6 it will work, but anything
> more recent will not compile anymore.

I deleted emc and related node.
I see. I hope stmmac: sun8i come back soon. It works well well on this 
board, running 4.13-rc6

> > > > +	status = "okay";
> > > > +
> > > > +	/*
> > > > +	 * AMPAK AP6212A WiFi module with BCM43430, rev=1 inside
> > > > +	 * sdio vendor ID: 0x02d0, sdio device ID: 0xa9a6
> > > > +	 * There is no specific Documentation: dt-binding for BCM43430
> > > > +	 * brcm,bcm4329-fmac compatible can initialize this module
> > > > +	 */
> > > 
> > > This is not really relevant.
> > 
> > would you prefer no comment or a rewrite? How does this look?
> > 
> > /*
> >  * AMPAK AP6212A WiFi module with BCM43430, rev=1 inside
> >  * sdio vendor ID: 0x02d0, sdio device ID: 0xa9a6
> >  */
> > 
> > I am afraid a casual reader would think "brcm,bcm4329-fmac" is wrong, 
> > because that is not the actual chip inside the module.
> 
> No comment is fine, and I'm not sure the casual reader will ever read
> this :)

Deleted.

> > > > +&usb_otg {
> > > > +	dr_mode = "host";
> > > > +	status = "okay";
> > > > +};
> > > > +
> > > > +&usbphy {
> > > > +	/* USB Type-A ports' VBUS is always on */
> > > > +	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> > > 
> > > If it has an ID-detect pin, then it's not a host-only USB OTG
> > > controller. dr_mode should be set to otga 
> > 
> > good point. I don't see an ID-detect connected in the schematic. The 
> > previous generation had. 
> > 
> > I will leave 
> > &usb_otg {
> >   dr_mode = "host";
> >   status = "okay";
> > };
> > 
> > &usbphy {
> > 	/* USB Type-A ports' VBUS is always on */
> > 	status = "okay";
> > };
> 
> Looking at the schematics, it seems that the micro USB isn't even
> wired to a bus but is only used to power the board. If so, you can
> even remove the usb_otg node.

Yes, the Micro USB data pins are not connected. However, it there is a 
second USB A port connected to the processor. If I remove &usb_otg node, in 
4.13-rc6, the second port goes to disabled.

BTW would this work s/brcm,bcm4329-fmac/brcm/ or should I revert it?

I will send an updated version, v8, soon.

thanks,

-antony
