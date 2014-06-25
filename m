From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Jun 2014 09:08:49 +0200
Subject: [PATCH] ARM: dts: add support for Ka-Ro TX51
In-Reply-To: <20140625064841.GA2224@dragon>
References: <1402578584-12640-1-git-send-email-LW@KARO-electronics.de>
 <20140618150152.GP8860@dragon> <20140623121839.679f35ee@ipc1.ka-ro>
 <20140625064841.GA2224@dragon>
Message-ID: <20140625070849.GO15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 02:48:43PM +0800, Shawn Guo wrote:
> On Mon, Jun 23, 2014 at 12:18:39PM +0200, Lothar Wa?mann wrote:
> ...
> > > > +	phy-handle = <&phy0>;
> > > > +	mac-address = [000000000000]; /* will be set by U-Boot */
> > > 
> > > Shouldn't it be local-mac-address?
> > > 
> > probably yes, but both 'mac-address' and 'local-mac-address' are being
> > set up by U-Boot anyway.
> 
> Okay, never mind.  I just realized kernel supports both properties.
> 
> ...
> 
> > > > +&esdhc1 {
> > > > +	cd-gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
> > > > +	fsl,wp-controller;
> > > 
> > > Does it work for you, since the driver does not support it as of today?
> > > 
> > What driver doesn't support what?
> > AFAICT the sdhci-esdhc-imx.c driver supports both of these properties.
> 
> That was the case before, but it's not the case since commit
> 89d7e5c13122 (mmc: sdhci-esdhc-imx: add runtime pm support).
> 
> http://thread.gmane.org/gmane.linux.kernel.mmc/27287
> 
> ...
> 
> > > > +	spidev0: spi at 0 {
> > > > +		compatible = "spidev";
> > > > +		reg = <0>;
> > > > +		spi-max-frequency = <54000000>;
> > > > +	};
> > > > +
> > > > +	spidev1: spi at 1 {
> > > > +		compatible = "spidev";
> > > > +		reg = <1>;
> > > > +		spi-max-frequency = <54000000>;
> > > > +	};
> > > 
> > > I'm not sure we should have these two devices.
> > > 
> > Why not? With this the SPI bus can readily be used with the spidev
> > driver from Documentation/spi/spidev_test.c (which is what most of our
> > customers are asking for)!
> 
> Is this something that has been approved by DT maintainers?  I do not
> see "spidev" documented as a compatible in any bindings doc.

I don't think it has been approved, but it's used already in several
places:

arch/arm/boot/dts/spear1340-evb.dts:496:                                        compatible = "spidev";
arch/arm/boot/dts/spear1310-evb.dts:402:                                        compatible = "spidev";
arch/arm/boot/dts/imx28-tx28.dts:623:           compatible = "spidev";
arch/arm/boot/dts/imx28-tx28.dts:629:           compatible = "spidev";
arch/arm/boot/dts/atlas6-evb.dts:32:                                    compatible = "spidev";
arch/arm/boot/dts/marco-evb.dts:41:                                     compatible = "spidev";
arch/arm/boot/dts/tegra30-colibri-eval-v3.dts:78:                       compatible = "spidev";
arch/arm/boot/dts/imx53-tx53.dtsi:173:          compatible = "spidev";
arch/arm/boot/dts/imx53-tx53.dtsi:179:          compatible = "spidev";
arch/powerpc/boot/dts/mgcoge.dts:235:                                   compatible = "gen,spidev";
arch/powerpc/boot/dts/o2d.dtsi:43:                              compatible = "spidev";
arch/powerpc/boot/dts/digsy_mtc.dts:34:                         compatible = "spidev";

Usually this binding gets denied with "spidev is Linux specific. Use a
specific compatible instead". This had the result that the spidev driver
now matches to "rohm,dh2228fv" and I have already seen people claiming
that their spi device is a "rohm,dh2228fv" just to let the spidev driver
match.

Maybe the reasoning for a spidev binding could be:

There is a SPI device, but we don't know what it is, so we just call it
"spidev". Linux just tries to make the best from the situation and makes
a userspace device from it.


Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
