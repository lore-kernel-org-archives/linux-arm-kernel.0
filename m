From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 2 Jun 2011 08:59:10 -0600
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498E1C22D@HQMAIL01.nvidia.com>
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
	<74CDBE0F657A3D45AFBB94109FB122FF0498E1C22D@HQMAIL01.nvidia.com>
Message-ID: <BANLkTi=vdMg+KbtyS+WiG44S4i34zzWwsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 11:55 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Mitch Bradley wrote at Monday, May 30, 2011 2:53 PM:
>> ...
>> GPIOs share the need to "point across the tree to different nodes", but
>> it is unclear that there is a need for a entirely different hierarchy.
>>
>> That suggests the possibility of using the device tree addressing
>> mechanism as much as possible. ?Normal device tree addresses could be
>> used to specify GPIO numbers.
>>
>> Suppose we have:
>>
>> ? ? gpio-controller1: gpio-controller {
>> ? ? ? ? #address-cells = <2>;
>> ? ? ? ? #mode-cells = <2>;
>> ? ? ? ? gpio1: gpio at 12,0 {
>> ? ? ? ? ? ? reg = <12 0>;
>> ? ? ? ? ? ? mode = <55 66>;
>> ? ? ? ? ? ? usage = "Audio Codec chip select"; ?/* Optional */
>> ? ? ? ? }
>> ? ? };
>> ? ? gpio-controller2: gpio-controller {
>> ? ? ? ? #address-cells = <1>;
>> ? ? ? ? #mode-cells = <1>;
>> ? ? ? ? gpio2: gpio at 4 {
>> ? ? ? ? ? ? reg = <4>;
>> ? ? ? ? ? ? #mode-cells = <1>;
>> ? ? ? ? }
>> ? ? };
>
> A quick note on the way that Tegra's devicetree files are broken up in
> Grant's devicetree/test branch:
>
> * There's "tegra250.dtsi" which defines everything on the Tegra SoC
> ?itself.
> * There's a per-board e.g. harmony.dts which includes tegra250.dtsi,
> ?And additionally:
> ?** Defines all devices on the board
> ?** Hence, defines the usage of e.g. all the Tegra GPIOs for the
> ? ? board.
>
> I like this model, because it shares the complete definition of the
> Tegra SoC in a single file, rather than duplicating it with cut/paste
> into every board file.
>
> As such, the code quoted above would be in tegra250.dtsi.
>
> This has two relevant implications here:
>
> 1) The names "gpio1" and "gpio2" would be driven by the Tegra SoC's
> naming of those GPIO pins, and not any board-specific naming, e.g.
> "tegra_gpio_px1", "tegra_gpio_pb5". Equally, the usage comment would
> be at the client/reference site, not the GPIO definition site.
>
> 2) The GPIO mode should be defined by the client/user of the GPIO, not
> the SoC's definition of that GPIO.
>
> Without those two conditions, we couldn't share anything through
> tegra250.dtsi.

It's worth noting that the board file can override anything in
tegra250.dtsi, even in the SoC nodes, so if needed properties can be
added or modified in the SoC's description of the gpio controller.

>
> Just re-iterating: I'd prefer mode to be solely in the reference, and
> not in the gpio controller.
>
> Does this SoC/board segregation make sense to everyone? Obviously it
> does to me:-)

It certainly does to me.  :-)

g.
