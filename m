From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 28 Dec 2017 08:46:23 +0100
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
 fourth network interface
In-Reply-To: <20171227222401.GT10595@n2100.armlinux.org.uk>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-6-antoine.tenart@free-electrons.com>
 <20171227222401.GT10595@n2100.armlinux.org.uk>
Message-ID: <20171228074623.GA28444@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 10:24:01PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 27, 2017 at 11:14:45PM +0100, Antoine Tenart wrote:
> > This patch enables the fourth network interface on the Marvell
> > Macchiatobin. It is configured in the 2500Base-X PHY mode.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> > index b3350827ee55..c51efd511324 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> > @@ -279,6 +279,14 @@
> >  	phys = <&cps_comphy0 1>;
> >  };
> >  
> > +&cps_eth2 {
> > +	/* CPS Lane 5 */
> > +	status = "okay";
> > +	phy-mode = "2500base-x";
> > +	/* Generic PHY, providing serdes lanes */
> > +	phys = <&cps_comphy5 2>;
> > +};
> > +
> 
> This is wrong.  This lane is connected to a SFP cage which can support
> more than just 2500base-X.  Tying it in this way to 2500base-X means
> that this port does not support conenctions at 1000base-X, despite
> that's one of the most popular and more standardised speeds.
> 

Hi Antoine

I agree with Russell here. SFP modules are hot pluggable, and support
a range of interface modes. You need to query what the SFP module is
in order to know how to configure the SERDES interface. The phylink
infrastructure does that for you.

   Andrew
