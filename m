From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jun 2015 17:34:21 +0100
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <20150608154448.GA11103@ulmo.nvidia.com>
References: <4184159.j0iXe39dFB@phil> <2619686.csNBBFyt8W@phil>
 <20150605110159.GA16254@ulmo.nvidia.com>
 <23123577.mOoqGCAPdL@diego>
 <20150605231058.GQ7557@n2100.arm.linux.org.uk>
 <20150608140256.GA10354@ulmo.nvidia.com>
 <20150608142926.GY7557@n2100.arm.linux.org.uk>
 <20150608154448.GA11103@ulmo.nvidia.com>
Message-ID: <20150608163420.GZ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 05:44:53PM +0200, Thierry Reding wrote:
> On Mon, Jun 08, 2015 at 03:29:26PM +0100, Russell King - ARM Linux wrote:
> > You're asking questions we have no real answers to - all we have is the
> > available documentation provided by Freescale - we don't even have the
> > Rochchip documentation.
> > 
> > From the Freescale documentation, which documents the HDMI transmitter
> > entirely separately from the HDMI phy, I would say that the IP is
> > structured as two entirely separate blocks, and the chip designer is
> > free to choose an appropriate phy from a range of HDMI phys.
> 
> Does it associate any of the registers with the HDMI PHY? According to
> the register definitions in drivers/gpu/drm/bridge/dw_hdmi.h the PHY
> registers are interleaved with other registers that are likely part of
> the HDMI transmitter proper (there are things like HDCP and CEC engines
> in that IP as well).

The protocol stuff is handled by the HDMI Tx - the phy is the conversion
from the internal digital to the interface domain.

I could write lots to describe it, but really, the best thing to do is
to download the iMX6 documentation and take a peek at it...

https://community.freescale.com/docs/DOC-101840

Particularly, look at the HDMI 3D Phy section, the system level block
diagram (34.1.5.1), and 34.2.1 which has the top level I/O diagram for
just the 3D phy.

The previous section (section 33) covers the HDMI Tx.

> > Moreover, in the feature list for the HDMI transmitter, it says (though
> > this is not applicable to iMX6 - and is probably lifted from the
> > Synopsis documentation):
> > 
> > "* Option to remove pixel repetition clock from HDMI TX interface for an
> >   easy integration with third party HDMI TX PHYs"
> > 
> > So - here's the question: what do we do when we find something using the
> > Synopsis design-ware HDMI transmitter with a different HDMI phy?
> > 
> > Remember, VP, VPH, VP_FILT_* are all part of the HDMI phy according to
> > the freescale documentation, and not part of the HDMI transmitter.
> > 
> > > I
> > > see register definitions for a "source" PHY and a "master" PHY, where
> > > the latter seems to be an I2C controller rather than a PHY. Perhaps it
> > > is used to communicate with an external PHY?
> > 
> > I'm not sure where you get that from.  Maybe you could give a chapter
> > reference?
> 
> That's just from skimming drivers/gpu/drm/bridge/dw_hdmi.h (register
> offsets 0x3000 and the following). The large gap between them and the
> preceding FC registers could be an additional indication that they are
> indeed separate IP blocks. Then again, the AUD registers start at an
> offset of 0x3100, so maybe it's no indication at all.

Ah, you're getting slightly confused.

All those registers are to do with the HDMI Tx itself.  The block at
0x3000 to 0x3007 is to do with the HDMI Tx receiving various status
signals from the HDMI Phy, such as HPD, rxsense, and whether the phy
PLL is locked (which I'm fairly certain is mis-described, as there is
no output signal from the phy to indicate this, but there is a TX_READY
signal.)

The set at 0x3020-0x3032 are to do with talking to the HDMI phy over
the dedicated I2C interface integrated into the HDMI Tx.  All the
HDMI Phy registers are accessed through this I2C interface.

> > What if someone designs a chip with their own HDMI phy which uses
> > different supplies?
> 
> That's really one more reason to write proper drivers for the PHYs. If
> you really ever have to deal with a different PHY chances are that more
> than just the supplies will be different, in which case you'd need to
> somehow also abstract away the interoperation between HDMI transmitter
> and PHY.

Exactly, but that didn't happen before this code moved out of
drivers/staging, which is rather unfortunate, but everyone was too busy
to put much thought into that.

This is one of the problems when drivers are taken from BSPs rather than
going away and writing something from documentation: if you start afresh,
you can model the code according to the documentation without any of the
original BSP decisions in place.  If you start from the BSP code, you
have a whole pile of changes you need to identify, and it's very easy to
overlook something, because what you have works.

It's something which _should_ be done nevertheless.  The problem is
finding someone with the time and motivation to do a good job.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
