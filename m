From: wmb@firmworks.com (Mitch Bradley)
Date: Wed, 01 Jun 2011 11:32:39 -1000
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498E1C3F5@HQMAIL01.nvidia.com>
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
	<4DE536AD.5080200@firmworks.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498E1C3F5@HQMAIL01.nvidia.com>
Message-ID: <4DE6AFF7.3040905@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/1/2011 5:59 AM, Stephen Warren wrote:
> Mitch Bradley wrote at Tuesday, May 31, 2011 12:43 PM:
>> On 5/31/2011 7:55 AM, Stephen Warren wrote:
>>> Mitch Bradley wrote at Monday, May 30, 2011 2:53 PM:
>>>> ...
>>>> GPIOs share the need to "point across the tree to different nodes", but
>>>> it is unclear that there is a need for a entirely different hierarchy.
>>>>
>>>> That suggests the possibility of using the device tree addressing
>>>> mechanism as much as possible.  Normal device tree addresses could be
>>>> used to specify GPIO numbers.
>>>>
>>>> Suppose we have:
>>>>
>>>>       gpio-controller1: gpio-controller {
>>>>           #address-cells =<2>;
>>>>           #mode-cells =<2>;
>>>>           gpio1: gpio at 12,0 {
>>>>               reg =<12 0>;
>>>>               mode =<55 66>;
>>>>               usage = "Audio Codec chip select";  /* Optional */
>>>>           }
>>>>       };
>>>>       gpio-controller2: gpio-controller {
>>>>           #address-cells =<1>;
>>>>           #mode-cells =<1>;
>>>>           gpio2: gpio at 4 {
>>>>               reg =<4>;
>>>>               #mode-cells =<1>;
>>>>           }
>>>>       };
>>>
>>> A quick note on the way that Tegra's devicetree files are broken up in
>>> Grant's devicetree/test branch:
>>>
>>> * There's "tegra250.dtsi" which defines everything on the Tegra SoC
>>>     itself.
>>> * There's a per-board e.g. harmony.dts which includes tegra250.dtsi,
>>>     And additionally:
>>>     ** Defines all devices on the board
>>>     ** Hence, defines the usage of e.g. all the Tegra GPIOs for the
>>>        board.
>>>
>>> I like this model, because it shares the complete definition of the
>>> Tegra SoC in a single file, rather than duplicating it with cut/paste
>>> into every board file.
>>>
>>> As such, the code quoted above would be in tegra250.dtsi.
>>>
>>> This has two relevant implications here:
>>>
>>> 1) The names "gpio1" and "gpio2" would be driven by the Tegra SoC's
>>> naming of those GPIO pins, and not any board-specific naming, e.g.
>>> "tegra_gpio_px1", "tegra_gpio_pb5". Equally, the usage comment would
>>> be at the client/reference site, not the GPIO definition site.
>>>
>>> 2) The GPIO mode should be defined by the client/user of the GPIO, not
>>> the SoC's definition of that GPIO.
>>>
>>> Without those two conditions, we couldn't share anything through
>>> tegra250.dtsi.
>>>
>>> Re-iteration of these implications below.
>>>
>>>>       [...]
>>>>       chipsel-gpio =<&gpio1>,
>>>>           <&gpio-controller1 13 0 55 77>,
>>>>           <0>, /* holes are permitted, means no GPIO 2 */
>>>>           <&gpio2 88>,
>>>>           <&gpio-controller2 5 1>;
>>>
>>>> A GPIO spec consist of:
>>>>
>>>> 1) A reference to either a gpio-controller or a gpio device node.
>>>>
>>>> 2) 0 or more address cells, according to the value of #address-cells in
>>>> the referenced node.  If the node has no #address-cells property, the
>>>> value is assumed to be 0.
>>>
>>> I'd expect address cells only if referencing a gpio-controller; if
>>> referencing a gpio device node, the address would be implicit.
>>
>> Yes.  But I think it's better if there is a single rule for interpreting
>> the GPIO spec, namely look at the #address-cells property, rather than
>> deciding implicitly based on the type of the referent node.
>>
>>>> 3) 0 or more mode cells, according to the value of #mode-cells in the
>>>> referenced node.
>>>
>>> Yes, I agree. Although, I think your (3) is inconsistent with the gpio
>>> controller definitions you wrote above, which include the mode
>>> definitions in the controller instead of the user.
>>
>> Hmmm.  I think I got the example right.
>
> You're right. The examples are consistent. I think what threw me was that
> the example code itself contained "<&gpio2 88>" whereas the description
> later referred to just "<gpio2>".
>
> Also, I hadn't noticed that the gpio2 definition repeated
> "#mode-cells =<1>;" whereas the gpio1 definition didn't.
>
> I have to say, I don't like that aspect; i.e. having to repeat
> #mode-cells in every gpio definition that's inside/underneath the
> controller definition; in my mind, "passing on" the requirement to
> define the mode would be the default state, so forcing the namer of
> GPIOs (i.e. whoever writes the "gpio1: gpio at 12,0 {" definitions) to
> do this seems almost like busy work. Is there a way in *.dts to mark
> the #mode-cells field as inherited by children unless overridden?


That is a very good point.  Addressing it led me to a revised scheme 
that I like much better.  (Notice that in the notes below I address your 
reasonable desire for an immutable SoC core definition.)

The example:

     gpio-controller1: gpio-controller {
         #address-cells = <2>;
         #mode-cells = <2>;
         unbound_gpio1: gpio {
             /* No reg property */
             /* No mode property */
         }
         fully_bound_gpio1: audio-chipsel at 12,0 {
             reg = <12 0>;
             mode = <55 66>;
             usage = "Audio Codec chip select";  /* Optional */
         }
         address_bound_gpio1: gpio at 13,0 {
             reg = <13 0>;
             /* No mode property */
         }
         mode_bound_gpio1: open-drain-gpio {
             /* No reg property */
             mode = <77 88>;
         }
     };
     gpio-controller2: gpio-controller {
          #address-cells = <1>;
          #mode-cells = <1>;
          unbound_gpio2: gpio {
              /* No reg property */
              /* No mode property */
          }
          address_bound_gpio2: gpio at 4 {
              reg = <4>;
              /* No mode property */
          }
     };
     [...]
     chipsel-gpio =
         <&fully_bound_gpio1>,
         <&unbound_gpio1 13 0 55 77>,
         <&mode_bound_gpio1 14 0>,
         <&address_bound_gpio2 88>,
         <&unbound_gpio2 5 1>;

Notes:

a) A reference to a GPIO always points to the child of a 
gpio-controller, i.e. to an individual gpio node.

b) If that gpio node has a "reg" property, the number of address cells 
in the reference is 0, otherwise it is #address-cells from the parent 
(gpio-controller) node.

c) If that gpio node has a "mode" property, the number of mode cells in 
the reference is 0, otherwise it is #mode-cells from the parent 
(gpio-controller) node.

d) It's unnecessary for all children of a gpio controller to be named 
just "gpio".  The important thing is that the semantics of the node - 
the set of properties (and, for Open Firmware systems, the set of 
methods) - meet the usage needs of the node's "client".

e) gpios that are mode-bound but not address-bound must have distinct
names from each other and from the unbound node name ("gpio"), because 
of the device tree rule that the combination of name+address must be 
unique among the children of a given node.  It is okay to have both 
"gpio" and "gpio at 12", but you cannot have two nodes both named just "gpio".

f) SoC device tree blobs would probably use only the unbound form.  A 
given platform might choose to specialize the tree by adding additional 
bound nodes to the tree established by the unmodified SoC core blob.

g) reg-less nodes have been part of the Open Firmware spec forever; they 
are called "wildcard nodes".  Their intended use is to refer to a class 
of similar objects, potentially so numerous that full enumeration is 
undesireable.


>
>>>> In the example, the chipsel-gpio specs are interpreted as:
>>>>
>>>> <&gpio1>    -  refers to a pre-bound gpio device node, in which the
>>>> address (12 0) and mode (55 66) are specified within that node.
>>>
>>> Just re-iterating: I'd prefer mode to be solely in the reference, and
>>> not in the gpio controller.
>>
>> I agree that it doesn't make much sense for a controller node to specify
>> the mode.  My example doesn't do that.  The only mode value is in an
>> individual gpio node, not a controller node.
>
> Yes, I suppose that's true.
>
> But, in my mind at least, the controller definition would be part of the
> SoC definition, and provided by the SoC vendor in a separate and
> basically immutable file. As such, any gpio node inside the controller
> node really is part of the controller's/SoC's definition.
>
>>  From the standpoint of a SoC manufacturer, specifying modes in the
>> reference is probably a good idea.  But it's not necessarily best in all
>> cases.  If the focus of attention is a board design with numerous
>> variants and revisions, "binding" the modes of specific gpio pins
>> according to the board wiring may be the right thing.
>>
>> The way I specified it lets you choose.
>
> Granted.
>
> However, I'm still not convinced that's a great idea; just because a
> board vendor might want to cut/paste the entire SoC definition into their
> DTS file and hack it, rather than just including it, doesn't mean it's
> a good idea. If we agreed on that (which I'll grant we probably don't)
> it seems like we shouldn't aim to add features that are probably only
> needed to make the life of people who do that easier.
>
> My perspective is that cut/pasting the entire SoC definition into a board
> definition is the devicetree equivalent of having more than one driver
> per chip, not sharing gpio/pinmux/... code, etc. in the kernel; the very
> stuff that caused Linus to complain about the state of ARM Linux.
>
> Equally, a separation of SoC vs. board should make incorporating bugfixes
> to the SoC definition into board definitions easier; simply replace the
> file and recompile. And, it'll make it more obvious to board vendors which
> changes need to be upstreamed to the SoC vendor, i.e. if a board vendor
> finds a bug in the SoC definition file.
>
> I suppose the one area this flexibility might make sense is if a board
> vendor has N similar boards, they can setup a set of include files:
>
> board-a.dts:
> include board-common.dtsi
> Do board-a customizations
>
> board-b-dts:
> include board-common.dtsi
> Do board-b customizations
>
> board-common.dtsi: include soc.dtsi
> Could add the gpio definitions to the controller definition from
> soc.dtsi
>
> soc.dtsi:
> base SoC definition; gpio controller, etc.
>
> But I still don't entirely see the advantage of board-common.dtsi
> defining GPIOs and having board-*.dts use those GPIOs as parameters to
> HW modules, e.g. as a GPIO list for an SDHCI controller, rather than
> simply having board-common.dtsi simply specify the SDHCI controller
> directly, thus avoiding the new syntax.
>
>>> Does this SoC/board segregation make sense to everyone? Obviously it
>>> does to me:-)
>>
>> It makes perfect sense from one viewpoint, but I think that board
>> vendors may have a different focus.  The flexibility to specify a mode
>> in either place costs little, as the parsing rule is definite and
>> straightforward.  SoC vendors are free to defer mode decisions until
>> later, by omitting "mode" and supplying "#mode-cells" in their device
>> tree templates.  Board vendors could choose either to use the SoC
>> vendor's template verbatim, or to amend it with additional
>> board-specific information.
>
>
