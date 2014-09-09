From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 9 Sep 2014 13:17:42 -0400
Subject: [Patch v2 RfT] ARM: Kirkwood: Fix DT based DSA.
In-Reply-To: <cbad0fa9a53346c4a67863ce924189a4@IL-EXCH02.marvell.com>
References: <1409592941-22244-1-git-send-email-andrew@lunn.ch>
 <20140909160635.GR30828@titan.lakedaemon.net>
 <cbad0fa9a53346c4a67863ce924189a4@IL-EXCH02.marvell.com>
Message-ID: <20140909171742.GT30828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eugene,

Please fix your mailer, I had to manually edit this to look legible.
Also, please don't top-post.

On Tue, Sep 09, 2014 at 04:44:07PM +0000, Eugene Sanivsky wrote:
> On .... Jason Cooper wrote:
> > On Mon, Sep 01, 2014 at 07:35:41PM +0200, Andrew Lunn wrote:
> > > During the conversion of boards to use DT to instantiate Distributed 
> > > Switch Architecture, nobody volunteered to test. As to be expected, 
> > > the conversion was flawed. Testers and access to hardware has now 
> > > become available, and this patch hopefully fixes the problems.
> > > 
> > > dsa,mii-bus must be a phandle to the top level mdio node, not the port 
> > > specific subnode of the mdio device.
> > > 
> > > dsa,ethernet must be a phandle to the port subnode within the ethernet 
> > > DT node, not the ethernet node.
> > > 
> > > Don't pinctrl hog the card detect gpio for mvsdio.
> > > 
> > > Rename the .dts files to make it clearer which file is for the Z0 
> > > stepping and which for the A0 or later stepping.
> > > 
> > > Fixes: e2eaa339af441b3d51cdaa16870065c4154ce13c
> > > Fixes: e7c8f3808be854379c9784745663a55371cbf232
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > Cc: seugene at marvell.com
> > > ---
> > > v2:
> > >   Fix duplex typo
> > >   Feedback after testing
> > >   Fix mvsdio card detect gpio
> > > ---
> > >  arch/arm/boot/dts/Makefile                         |  4 +-
> > >  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     | 16 +++-----
> > >  arch/arm/boot/dts/kirkwood-rd88f6281-a.dts         | 43 ++++++++++++++++++++++
> > >  arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts        | 26 -------------
> > >  ...-rd88f6281-a1.dts => kirkwood-rd88f6281-z0.dts} | 18 +++++----
> > >  arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          | 27 +++-----------
> > >  arch/arm/boot/dts/kirkwood.dtsi                    |  4 +-
> > >  7 files changed, 69 insertions(+), 69 deletions(-)  create mode 
> > > 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
> > >  delete mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
> > >  rename arch/arm/boot/dts/{kirkwood-rd88f6281-a1.dts => 
> > > kirkwood-rd88f6281-z0.dts} (57%)
> > 
> > Has anyone had a chance to test these changes?  If so, can we get some Tested-by's?
> 
> I've tested v2 of the patch and it worked fine.

Ok, I'll consider that a Tested-by...

> Though, I had a couple of comments:
> 
> 1) I have concerns regarding naming of the boards.
> Since distros use those names to identify boards, we should use
> shorter and consistent naming.

No, the filenames within the kernel source tree are *not* an ABI, and we
should avoid treating them as such.  That's why when we added the
dtbs_install target:

  f4d4ffc03efc8 kbuild: dtbs_install: new make target

We discussed this exact problem and settled on letting distros process
the dtb's in the install directory.

I personally think using fdtget to fetch the board compatible string is
much more reliable than file names.  My original version of the above
patch renamed the files as it installed them to
<most_specific_board_compatible>.dtb but that was deemed too heavy
weight and we settled on the above.

> 2) There is a problem with network throughput on those devices (maybe
> other too).  With 3.17rc2 I am not able to get more then ~50Mbps while
> same board with in same setup running v3.2 or v3.10 easily pass
> 650Mbps mark.

Is this with/without this particular patch?  Or is this a separate
issue?

> Since author (Andrew Lunn) is on vacation, maybe it's better to wait
> for his response before any action.

Yes, which will be near the end of the window for getting this in.  I'd
like to have everything hammered out _before_ he returns so he can Ack a
(potentially) new version that I can apply.

thx,

Jason.

> > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile 
> > > index 89b54fd77732..0ac6476bc312 100644
> > > --- a/arch/arm/boot/dts/Makefile
> > > +++ b/arch/arm/boot/dts/Makefile
> > > @@ -145,8 +145,8 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
> > >  	kirkwood-openrd-client.dtb \
> > >  	kirkwood-openrd-ultimate.dtb \
> > >  	kirkwood-rd88f6192.dtb \
> > > -	kirkwood-rd88f6281-a0.dtb \
> > > -	kirkwood-rd88f6281-a1.dtb \
> > > +	kirkwood-rd88f6281-z0.dtb \
> > > +	kirkwood-rd88f6281-a.dtb \
> > >  	kirkwood-rs212.dtb \
> > >  	kirkwood-rs409.dtb \
> > >  	kirkwood-rs411.dtb \
> > > diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts 
> > > b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
> > > index 8f76d28759a3..f82827d6fcff 100644
> > > --- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
> > > +++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
> > > @@ -123,11 +123,11 @@
> > >  
> > >  	dsa at 0 {
> > >  		compatible = "marvell,dsa";
> > > -		#address-cells = <2>;
> > > +		#address-cells = <1>;
> > >  		#size-cells = <0>;
> > >  
> > > -		dsa,ethernet = <&eth0>;
> > > -		dsa,mii-bus = <&ethphy0>;
> > > +		dsa,ethernet = <&eth0port>;
> > > +		dsa,mii-bus = <&mdio>;
> > >  
> > >  		switch at 0 {
> > >  			#address-cells = <1>;
> > > @@ -169,17 +169,13 @@
> > >  
> > >  &mdio {
> > >  	status = "okay";
> > > -
> > > -	ethphy0: ethernet-phy at ff {
> > > -		reg = <0xff>; 	/* No phy attached */
> > > -		speed = <1000>;
> > > -		duplex = <1>;
> > > -	};
> > >  };
> > >  
> > >  &eth0 {
> > >  	status = "okay";
> > > +
> > >  	ethernet0-port at 0 {
> > > -		phy-handle = <&ethphy0>;
> > > +		speed = <1000>;
> > > +		duplex = <1>;
> > >  	};
> > >  };
> > > diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts 
> > > b/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
> > > new file mode 100644
> > > index 000000000000..f2e08b3b33ea
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
> > > @@ -0,0 +1,43 @@
> > > +/*
> > > + * Marvell RD88F6181 A Board descrition
> > > + *
> > > + * Andrew Lunn <andrew@lunn.ch>
> > > + *
> > > + * This file is licensed under the terms of the GNU General Public
> > > + * License version 2.  This program is licensed "as is" without any
> > > + * warranty of any kind, whether express or implied.
> > > + *
> > > + * This file contains the definitions for the board with the A0 or
> > > + * higher stepping of the SoC. The ethernet switch does not have a
> > > + * "wan" port.
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "kirkwood-rd88f6281.dtsi"
> > > +
> > > +/ {
> > > +	model = "Marvell RD88f6281 Reference design, with A0 or higher SoC";
> > > +	compatible = "marvell,rd88f6281-a", 
> > > +"marvell,rd88f6281","marvell,kirkwood-88f6281", "marvell,kirkwood";
> > > +
> > > +	dsa at 0 {
> > > +		switch at 0 {
> > > +			reg = <10 0>;	 /* MDIO address 10, switch 0 in tree */
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&mdio {
> > > +	status = "okay";
> > > +
> > > +	ethphy1: ethernet-phy at 11 {
> > > +		 reg = <11>;
> > > +	};
> > > +};
> > > +
> > > +&eth1 {
> > > +	status = "okay";
> > > +
> > > +	ethernet1-port at 0 {
> > > +		 phy-handle = <&ethphy1>;
> > > +	};
> > > +};
> > > diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts 
> > > b/arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
> > > deleted file mode 100644
> > > index a803bbb70bc8..000000000000
> > > --- a/arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
> > > +++ /dev/null
> > > @@ -1,26 +0,0 @@
> > > -/*
> > > - * Marvell RD88F6181 A0 Board descrition
> > > - *
> > > - * Andrew Lunn <andrew@lunn.ch>
> > > - *
> > > - * This file is licensed under the terms of the GNU General Public
> > > - * License version 2.  This program is licensed "as is" without any
> > > - * warranty of any kind, whether express or implied.
> > > - *
> > > - * This file contains the definitions for the board with the A0 
> > > variant of
> > > - * the SoC. The ethernet switch does not have a "wan" port.
> > > - */
> > > -
> > > -/dts-v1/;
> > > -#include "kirkwood-rd88f6281.dtsi"
> > > -
> > > -/ {
> > > -	model = "Marvell RD88f6281 Reference design, with A0 SoC";
> > > -	compatible = "marvell,rd88f6281-a0", "marvell,rd88f6281","marvell,kirkwood-88f6281", "marvell,kirkwood";
> > > -
> > > -	dsa at 0 {
> > > -		switch at 0 {
> > > -			reg = <10 0>;    /* MDIO address 10, switch 0 in tree */
> > > -		};
> > > -	};
> > > -};
> > > \ No newline at end of file
> > > diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts 
> > > b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
> > > similarity index 57%
> > > rename from arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts
> > > rename to arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
> > > index baeebbf1d8c7..f4272b64ed7f 100644
> > > --- a/arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts
> > > +++ b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
> > > @@ -1,5 +1,5 @@
> > >  /*
> > > - * Marvell RD88F6181 A1 Board descrition
> > > + * Marvell RD88F6181 Z0 stepping descrition
> > >   *
> > >   * Andrew Lunn <andrew@lunn.ch>
> > >   *
> > > @@ -7,17 +7,17 @@
> > >   * License version 2.  This program is licensed "as is" without any
> > >   * warranty of any kind, whether express or implied.
> > >   *
> > > - * This file contains the definitions for the board with the A1 
> > > variant of
> > > - * the SoC. The ethernet switch has a "wan" port.
> > > - */
> > > + * This file contains the definitions for the board using the Z0
> > > + * stepping of the SoC. The ethernet switch has a "wan" port.
> > > +*/
> > >  
> > >  /dts-v1/;
> > >  
> > >  #include "kirkwood-rd88f6281.dtsi"
> > >  
> > >  / {
> > > -	model = "Marvell RD88f6281 Reference design, with A1 SoC";
> > > -	compatible = "marvell,rd88f6281-a1", "marvell,rd88f6281","marvell,kirkwood-88f6281", "marvell,kirkwood";
> > > +	model = "Marvell RD88f6281 Reference design, with Z0 SoC";
> > > +	compatible = "marvell,rd88f6281-z0", 
> > > +"marvell,rd88f6281","marvell,kirkwood-88f6281", "marvell,kirkwood";
> > >  
> > >  	dsa at 0 {
> > >  		switch at 0 {
> > > @@ -28,4 +28,8 @@
> > >  			};
> > >  		};
> > >  	};
> > > -};
> > > \ No newline at end of file
> > > +};
> > > +
> > > +&eth1 {
> > > +      status = "disabled";
> > > +};
> > > diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi 
> > > b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
> > > index 26cf0e0ccefd..d195e884b3b5 100644
> > > --- a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
> > > +++ b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
> > > @@ -37,7 +37,6 @@
> > >  
> > >  	ocp at f1000000 {
> > >  		pinctrl: pin-controller at 10000 {
> > > -			pinctrl-0 = <&pmx_sdio_cd>;
> > >  			pinctrl-names = "default";
> > >  
> > >  			pmx_sdio_cd: pmx-sdio-cd {
> > > @@ -69,8 +68,8 @@
> > >  		#address-cells = <2>;
> > >  		#size-cells = <0>;
> > >  
> > > -		dsa,ethernet = <&eth0>;
> > > -		dsa,mii-bus = <&ethphy1>;
> > > +		dsa,ethernet = <&eth0port>;
> > > +		dsa,mii-bus = <&mdio>;
> > >  
> > >  		switch at 0 {
> > >  			#address-cells = <1>;
> > > @@ -119,35 +118,19 @@
> > >  	};
> > >  
> > >  	partition at 300000 {
> > > -		label = "data";
> > > +		label = "rootfs";
> > >  		reg = <0x0300000 0x500000>;
> > >  	};
> > >  };
> > >  
> > >  &mdio {
> > >  	status = "okay";
> > > -
> > > -	ethphy0: ethernet-phy at 0 {
> > > -		reg = <0>;
> > > -	};
> > > -
> > > -	ethphy1: ethernet-phy at ff {
> > > -		reg = <0xff>; /* No PHY attached */
> > > -		speed = <1000>;
> > > -		duple = <1>;
> > > -	};
> > >  };
> > >  
> > >  &eth0 {
> > >  	status = "okay";
> > >  	ethernet0-port at 0 {
> > > -		phy-handle = <&ethphy0>;
> > > -	};
> > > -};
> > > -
> > > -&eth1 {
> > > -	status = "okay";
> > > -	ethernet1-port at 0 {
> > > -		phy-handle = <&ethphy1>;
> > > +		speed = <1000>;
> > > +		duplex = <1>;
> > >  	};
> > >  };
> > > diff --git a/arch/arm/boot/dts/kirkwood.dtsi 
> > > b/arch/arm/boot/dts/kirkwood.dtsi index afc640cd80c5..464f09a1a4a5 
> > > 100644
> > > --- a/arch/arm/boot/dts/kirkwood.dtsi
> > > +++ b/arch/arm/boot/dts/kirkwood.dtsi
> > > @@ -309,7 +309,7 @@
> > >  			marvell,tx-checksum-limit = <1600>;
> > >  			status = "disabled";
> > >  
> > > -			ethernet0-port at 0 {
> > > +			eth0port: ethernet0-port at 0 {
> > >  				compatible = "marvell,kirkwood-eth-port";
> > >  				reg = <0>;
> > >  				interrupts = <11>;
> > > @@ -342,7 +342,7 @@
> > >  			pinctrl-names = "default";
> > >  			status = "disabled";
> > >  
> > > -			ethernet1-port at 0 {
> > > +			eth1port: ethernet1-port at 0 {
> > >  				compatible = "marvell,kirkwood-eth-port";
> > >  				reg = <0>;
> > >  				interrupts = <15>;
> > > --
> > > 2.1.0
> > > 
