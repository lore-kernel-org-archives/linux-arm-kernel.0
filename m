From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 8 Aug 2014 16:47:39 -0300
Subject: [PATCH 2/6] ARM: mvebu: Add proper pin muxing on Globalscale
 Mirabox board
In-Reply-To: <20140808192106.GD26751@lunn.ch>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1407511136-26477-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140808171208.GC26751@lunn.ch>
 <20140808182156.GA16889@arch.cereza>
 <20140808192106.GD26751@lunn.ch>
Message-ID: <20140808194739.GA17826@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08 Aug 09:21 PM, Andrew Lunn wrote:
> On Fri, Aug 08, 2014 at 03:21:56PM -0300, Ezequiel Garcia wrote:
> > On 08 Aug 07:12 PM, Andrew Lunn wrote:
> > > On Fri, Aug 08, 2014 at 12:18:52PM -0300, Ezequiel Garcia wrote:
> > > > This commit adds the required pin muxing for the network interfaces and
> > > > the MDIO interface to be properly initialized. For instance, this makes
> > > > it possible for a bootloader to initialize and access the network interfaces.
> > > > 
> > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > > ---
> > > >  arch/arm/boot/dts/armada-370-mirabox.dts | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
> > > > index 097df7d8..c745256 100644
> > > > --- a/arch/arm/boot/dts/armada-370-mirabox.dts
> > > > +++ b/arch/arm/boot/dts/armada-370-mirabox.dts
> > > > @@ -91,6 +91,8 @@
> > > >  			};
> > > >  
> > > >  			mdio {
> > > > +				pinctrl-0 = <&mdio_pins>;
> > > > +				pinctrl-names = "default";
> > > >  				phy0: ethernet-phy at 0 {
> > > >  					reg = <0>;
> > > >  				};
> > > > @@ -100,11 +102,15 @@
> > > >  				};
> > > >  			};
> > > >  			ethernet at 70000 {
> > > > +				pinctrl-0 = <&ge0_pins>;
> > > > +				pinctrl-names = "default";
> > > 
> > > Hi Ezequiel
> > > 
> > > Could you put these one level higher in the DT hierarchy? i.e. once in
> > > armada-370.dtsi and not in every board .dts file?
> > > 
> > 
> > Are you sure that's the correct approach?
> > 
> > As explained on the cover letter, these MAC MPP mux are not required in the
> > SGMII case. Moreover, this is not the only way to wire the MAC0 and MAC1
> > controllers, so I even considered pushing down the pinmux to the dts files!
> 
> Hi Ezequiel
> 
> At least at the moment, it seems like RGMII is the norm, and SGMII is
> the exception. So having the default as RGMII probably makes
> sense. Boards which don't require it can then override this in there
> .dts file. If we see this changes with time, we can swap it around.
> 

OK.

> > The devicetree location of the pinmux is something that still confuses me,
> > so I'm more than open to directions here.
> 
> Patch #1 comment is not really correct. It defines a number of pin
> configuration nodes. These nodes can then be used via phandles.  What
> might help is naming these differently. Name them
> ge[01]_rgmii_pins. It is then clear when they should be used. You can
> also add ge[0]_sgmii_pins, which would be an empty set. You can then
> use ge[01]_rgmii_pins as the default in armada-370.dtsi and override
> them with ge[0]_sgmii_pins for the 370 RD.
> 

OK.

> Experience from Kirkwood is that it also has multiple ways to wire up
> MAC0 and MAC1, but in practice, nobody ever does. And if they did, it
> can be overridden in the .dts file.
> 

The above sounds good, although I don't have a strong opinion.

If everybody is happy with the approach, I'll prepare a v2 changing the .dtsi
with RGMII as the default mux, and overriding it in the A370-RD dts.

Jason, Thomas, Greg: Any objections?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
