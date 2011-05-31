From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 31 May 2011 10:55:03 -0700
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <4DE403C5.7060003@firmworks.com>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
	<BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
	<20110530033826.GE4130@opensource.wolfsonmicro.com>
	<20110530061155.GC23517@ponder.secretlab.ca>
	<4DE336A1.5040509@firmworks.com>
	<20110530070138.GA5036@opensource.wolfsonmicro.com>
	<8d2515b13c817cc956b185d043bcef00@kernel.crashing.org>
	<BANLkTi=hkScxYpt449CQCky+bLU3UvkC_A@mail.gmail.com>
	<4DE403C5.7060003@firmworks.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498E1C22D@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mitch Bradley wrote at Monday, May 30, 2011 2:53 PM:
> ...
> GPIOs share the need to "point across the tree to different nodes", but
> it is unclear that there is a need for a entirely different hierarchy.
> 
> That suggests the possibility of using the device tree addressing
> mechanism as much as possible.  Normal device tree addresses could be
> used to specify GPIO numbers.
> 
> Suppose we have:
> 
>     gpio-controller1: gpio-controller {
>         #address-cells = <2>;
>         #mode-cells = <2>;
>         gpio1: gpio at 12,0 {
>             reg = <12 0>;
>             mode = <55 66>;
>             usage = "Audio Codec chip select";  /* Optional */
>         }
>     };
>     gpio-controller2: gpio-controller {
>         #address-cells = <1>;
>         #mode-cells = <1>;
>         gpio2: gpio at 4 {
>             reg = <4>;
>             #mode-cells = <1>;
>         }
>     };

A quick note on the way that Tegra's devicetree files are broken up in
Grant's devicetree/test branch:

* There's "tegra250.dtsi" which defines everything on the Tegra SoC
  itself.
* There's a per-board e.g. harmony.dts which includes tegra250.dtsi,
  And additionally:
  ** Defines all devices on the board
  ** Hence, defines the usage of e.g. all the Tegra GPIOs for the
     board.

I like this model, because it shares the complete definition of the
Tegra SoC in a single file, rather than duplicating it with cut/paste
into every board file.

As such, the code quoted above would be in tegra250.dtsi.

This has two relevant implications here:

1) The names "gpio1" and "gpio2" would be driven by the Tegra SoC's
naming of those GPIO pins, and not any board-specific naming, e.g.
"tegra_gpio_px1", "tegra_gpio_pb5". Equally, the usage comment would
be at the client/reference site, not the GPIO definition site.

2) The GPIO mode should be defined by the client/user of the GPIO, not
the SoC's definition of that GPIO.

Without those two conditions, we couldn't share anything through
tegra250.dtsi.

Re-iteration of these implications below.

>     [...]
>     chipsel-gpio =  <&gpio1>,
>         <&gpio-controller1 13 0 55 77>,
>         <0>, /* holes are permitted, means no GPIO 2 */
>         <&gpio2 88>,
>         <&gpio-controller2 5 1>;

> A GPIO spec consist of:
> 
> 1) A reference to either a gpio-controller or a gpio device node.
> 
> 2) 0 or more address cells, according to the value of #address-cells in
> the referenced node.  If the node has no #address-cells property, the
> value is assumed to be 0.

I'd expect address cells only if referencing a gpio-controller; if
referencing a gpio device node, the address would be implicit.

> 3) 0 or more mode cells, according to the value of #mode-cells in the
> referenced node.

Yes, I agree. Although, I think your (3) is inconsistent with the gpio
controller definitions you wrote above, which include the mode
definitions in the controller instead of the user.

> In the example, the chipsel-gpio specs are interpreted as:
> 
> <&gpio1>  -  refers to a pre-bound gpio device node, in which the
> address (12 0) and mode (55 66) are specified within that node.

Just re-iterating: I'd prefer mode to be solely in the reference, and
not in the gpio controller.

Does this SoC/board segregation make sense to everyone? Obviously it
does to me:-)

-- 
nvpublic
