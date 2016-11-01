From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 1 Nov 2016 17:26:48 +0100
Subject: [PATCH v2 2/6] net: phy: broadcom: Add BCM54810 PHY entry
In-Reply-To: <20161101155950.GA19378@broadcom.com>
References: <1477688219-3871-1-git-send-email-jon.mason@broadcom.com>
 <1477688219-3871-3-git-send-email-jon.mason@broadcom.com>
 <20161029081839.GA32579@lunn.ch>
 <20161101155950.GA19378@broadcom.com>
Message-ID: <20161101162648.GG10785@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +	if (of_property_read_bool(np, "brcm,enet-phy-lane-swap")) {
> > > +		/* Lane Swap - Undocumented register...magic! */
> > > +		ret = bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_SEL_ER + 0x9,
> > > +					0x11B);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +	}
> > > +
> > 
> > I wounder if this property could be made generic? What exactly are you
> > swapping? Rx and Tx lanes? Maybe we should add it to phy.txt?
> 
> Are you envisioning adding a DT check (similar to the
> of_property_read_bool above, only with a more generic string) in
> phy_device_create(), which will then set a PHY device flag?  This flag
> would then be checked for in the PHY driver and the appropriate action
> taken (in this case the bcm_phy_write_exp above).

I would keep the parsing of the property in the driver. But if we
think other PHYs could also support this feature, it would be good to
avoid having "brcm,enet-phy-lane-swap", "marvell,enet-phy-lane-swap",
"davicom,enet-phy-lane-swap", etc. It would be better to have one well
defined property documented in phy.txt which any PHY is free to
implement.

	Andrew
