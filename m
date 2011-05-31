From: wmb@firmworks.com (Mitch Bradley)
Date: Tue, 31 May 2011 08:42:53 -1000
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
Message-ID: <4DE536AD.5080200@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/31/2011 7:55 AM, Stephen Warren wrote:
> Mitch Bradley wrote at Monday, May 30, 2011 2:53 PM:
>> ...
>> GPIOs share the need to "point across the tree to different nodes", but
>> it is unclear that there is a need for a entirely different hierarchy.
>>
>> That suggests the possibility of using the device tree addressing
>> mechanism as much as possible.  Normal device tree addresses could be
>> used to specify GPIO numbers.
>>
>> Suppose we have:
>>
>>      gpio-controller1: gpio-controller {
>>          #address-cells =<2>;
>>          #mode-cells =<2>;
>>          gpio1: gpio at 12,0 {
>>              reg =<12 0>;
>>              mode =<55 66>;
>>              usage = "Audio Codec chip select";  /* Optional */
>>          }
>>      };
>>      gpio-controller2: gpio-controller {
>>          #address-cells =<1>;
>>          #mode-cells =<1>;
>>          gpio2: gpio at 4 {
>>              reg =<4>;
>>              #mode-cells =<1>;
>>          }
>>      };
>
> A quick note on the way that Tegra's devicetree files are broken up in
> Grant's devicetree/test branch:
>
> * There's "tegra250.dtsi" which defines everything on the Tegra SoC
>    itself.
> * There's a per-board e.g. harmony.dts which includes tegra250.dtsi,
>    And additionally:
>    ** Defines all devices on the board
>    ** Hence, defines the usage of e.g. all the Tegra GPIOs for the
>       board.
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
>
> Re-iteration of these implications below.
>
>>      [...]
>>      chipsel-gpio =<&gpio1>,
>>          <&gpio-controller1 13 0 55 77>,
>>          <0>, /* holes are permitted, means no GPIO 2 */
>>          <&gpio2 88>,
>>          <&gpio-controller2 5 1>;
>
>> A GPIO spec consist of:
>>
>> 1) A reference to either a gpio-controller or a gpio device node.
>>
>> 2) 0 or more address cells, according to the value of #address-cells in
>> the referenced node.  If the node has no #address-cells property, the
>> value is assumed to be 0.
>
> I'd expect address cells only if referencing a gpio-controller; if
> referencing a gpio device node, the address would be implicit.


Yes.  But I think it's better if there is a single rule for interpreting 
the GPIO spec, namely look at the #address-cells property, rather than 
deciding implicitly based on the type of the referent node.

>
>> 3) 0 or more mode cells, according to the value of #mode-cells in the
>> referenced node.
>
> Yes, I agree. Although, I think your (3) is inconsistent with the gpio
> controller definitions you wrote above, which include the mode
> definitions in the controller instead of the user.

Hmmm.  I think I got the example right.

Both of the gpio controller definitions have explicit "#address-cells" 
and "#mode-cells" properties, and neither has "mode".  Both references 
to controller nodes have mode values in the user spec.

gpio1 has "mode" but not "#mode-cells", and the reference to it has no 
mode value.

gpio2 has "#mode-cells=1" but not "mode", and the reference to it has 
one mode value.

Am I missing something?

>
>> In the example, the chipsel-gpio specs are interpreted as:
>>
>> <&gpio1>   -  refers to a pre-bound gpio device node, in which the
>> address (12 0) and mode (55 66) are specified within that node.
>
> Just re-iterating: I'd prefer mode to be solely in the reference, and
> not in the gpio controller.

I agree that it doesn't make much sense for a controller node to specify 
the mode.  My example doesn't do that.  The only mode value is in an 
individual gpio node, not a controller node.

 From the standpoint of a SoC manufacturer, specifying modes in the 
reference is probably a good idea.  But it's not necessarily best in all 
cases.  If the focus of attention is a board design with numerous 
variants and revisions, "binding" the modes of specific gpio pins 
according to the board wiring may be the right thing.

The way I specified it lets you choose.


>
> Does this SoC/board segregation make sense to everyone? Obviously it
> does to me:-)

It makes perfect sense from one viewpoint, but I think that board 
vendors may have a different focus.  The flexibility to specify a mode 
in either place costs little, as the parsing rule is definite and 
straightforward.  SoC vendors are free to defer mode decisions until 
later, by omitting "mode" and supplying "#mode-cells" in their device 
tree templates.  Board vendors could choose either to use the SoC 
vendor's template verbatim, or to amend it with additional 
board-specific information.
