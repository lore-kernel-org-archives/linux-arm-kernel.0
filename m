From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Mar 2018 16:09:30 +0000
Subject: [PATCH 1/2] ARM: dts: armada388-clearfog: increase speed of i2c0
 to 400kHz
In-Reply-To: <87d10i5xqx.fsf@bootlin.com>
References: <20180227160135.GU9418@n2100.armlinux.org.uk>
 <E1eqhhV-0004ku-Nd@rmk-PC.armlinux.org.uk>
 <87d10i5xqx.fsf@bootlin.com>
Message-ID: <20180305160929.GG9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 04:48:54PM +0100, Gregory CLEMENT wrote:
> Hi Russell,
>  
>  On mar., f?vr. 27 2018, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> 
> > All the devices on I2C0 support fast mode, so increase the bus speed
> > to match.
> 
> I agree with this part. I didn't pay attention to it in the initial
> submission but now I've checked it, and indeed according to the
> datasheet the MCP3021 support "standard (100 kHz) and Fast (400 kHz) I2C
> Compatible modes"
> 
> > The Armada 388 is known to have a timing issue when in
> > standard mode, which we believe causes the ficticious device at 0x64
> > to appear.
> 
> This errata "FE-8471889 I2C Repeated Start is not supported in standard
> mode (up to 100K)" was supposed to be fixed with the commit c1d15b68aab8
> ("i2c: mv64xxx: Fix timing issue on Armada XP (errata FE-8471889)"). And
> it was used on the Armada 38x SoCs since fbffee74986c ("ARM: dts: Fix I2C
> repeated start issue on Armada-38x") in 4.14.

The commit pre-dates 4.14, and the commit message was correct at the time
it was committed (Nov 29 2016).  I don't know whether its still the case
that the ficticious device still appears, but increasing the bus speed is
still a sensible thing to do if the devices all support it.

> So I think that now even at 100kHz the ficticious device should not
> appear any more. If it is still the case then there might be an issue
> with the fix in the 2c driver.
> 
> Gregory
> 
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  arch/arm/boot/dts/armada-388-clearfog.dtsi | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
> > index 68acfc968706..0e3b1f140e6d 100644
> > --- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
> > +++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
> > @@ -143,8 +143,7 @@
> >  };
> >  
> >  &i2c0 {
> > -	/* Is there anything on this? */
> > -	clock-frequency = <100000>;
> > +	clock-frequency = <400000>;
> >  	pinctrl-0 = <&i2c0_pins>;
> >  	pinctrl-names = "default";
> >  	status = "okay";
> > @@ -239,13 +238,11 @@
> >  		};
> >  	};
> >  
> > -	/* The MCP3021 is 100kHz clock only */
> > +	/* The MCP3021 supports standard and fast modes */
> >  	mikrobus_adc: mcp3021 at 4c {
> >  		compatible = "microchip,mcp3021";
> >  		reg = <0x4c>;
> >  	};
> > -
> > -	/* Also something at 0x64 */
> >  };
> >  
> >  &i2c1 {
> > -- 
> > 2.7.4
> >
> 
> -- 
> Gregory Clement, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
