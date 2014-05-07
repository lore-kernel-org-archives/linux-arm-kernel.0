From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 7 May 2014 15:29:50 +0200
Subject: [PATCH] ARM: Kirkwood: DT versions of OpenRD boards
In-Reply-To: <5369E35C.2020006@gmail.com>
References: <1399416504-19140-1-git-send-email-andrew@lunn.ch>
 <5369E35C.2020006@gmail.com>
Message-ID: <20140507132950.GB23936@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 09:40:12AM +0200, Sebastian Hesselbarth wrote:
> On 05/07/2014 12:48 AM, Andrew Lunn wrote:
> > Create DTS files to describe the Marvell OpenRD boards.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Tested-by: Francois Lorrain <francois.lorrain@gmail.com>
> > ---
> [...]
> > diff --git a/arch/arm/boot/dts/kirkwood-openrd-base.dts b/arch/arm/boot/dts/kirkwood-openrd-base.dts
> > new file mode 100644
> > index 000000000000..03cb87cd4bbe
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/kirkwood-openrd-base.dts
> > @@ -0,0 +1,42 @@
> > +/*
> > + * Marvell OpenRD Base Board descrition
> 
> s/descrition/description/
> 
> > + * Andrew Lunn <andrew@lunn.ch>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + *
> > + * This file contains the definitions that are specific to OpenRD
> > + * base variant of the Marvell Kirkwood Development Board.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "kirkwood-openrd.dtsi"
> > +
> > +/ {
> > +	model = "OpenRD Base";
> > +	compatible = "marvell,openrd-base", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> > +
> > +	ocp at f1000000 {
> > +		serial at 12100 {
> > +			status = "okay";
> 
> Andrew,
> 
> I see you used the "good template" this time ;) I again have some nits,
> that either you can take care of or me in the cleanup patches. I guess
> it depends on whatever goes in first. ;)

The patch already depends on your patches, so i may as well do the
cleanup. I need to fix "description" anyway.


> 
> > +		};
> > +	};
> > +};
> > +
> > +&mdio {
> > +	status = "okay";
> > +
> > +	ethphy0: ethernet-phy at 8 {
> > +		reg = <8>;
> > +	};
> > +};
> > +
> > +&eth0 {
> > +	status = "okay";
> > +	ethernet0-port at 0 {
> > +		phy-handle = <&ethphy0>;
> > +	};
> > +};
> > diff --git a/arch/arm/boot/dts/kirkwood-openrd-client.dts b/arch/arm/boot/dts/kirkwood-openrd-client.dts
> > new file mode 100644
> > index 000000000000..6179542c860f
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/kirkwood-openrd-client.dts
> > @@ -0,0 +1,75 @@
> > +/*
> > + * Marvell OpenRD Client Board descrition
> 
> s/descrition/description/
> 
> > + * Andrew Lunn <andrew@lunn.ch>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + *
> > + * This file contains the definitions that are specific to OpenRD
> > + * client variant of the Marvell Kirkwood Development Board.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "kirkwood-openrd.dtsi"
> > +
> > +/ {
> > +	model = "OpenRD Client";
> > +	compatible = "marvell,openrd-client", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> > +
> > +	ocp at f1000000 {
> > +		i2c at 11000 {
> > +			status = "okay";
> > +			clock-frequency = <400000>;
> > +			pinctrl-0 = <&pmx_twsi0>;
> > +			pinctrl-names = "default";
> 
> The default pinctrl should have been set by the SoC dtsi already.

You only pointed this out for i2c. What else is it true for? I should
go look at your patches.

> > +		mvsdio at 90000 {
> > +			status = "okay";
> > +			cd-gpios = <&gpio0 29 9>;
> > +			status = "disabled";
> 
> Any reason not to enable sdio?

Only client and ultimate have an SD slot. Base does not. If i have it
right, client.dts and ultimate.dts should be enabling it. I will
double check.

> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Thanks
	Andrew
