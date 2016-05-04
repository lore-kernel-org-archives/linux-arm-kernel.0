From: robh@kernel.org (Rob Herring)
Date: Wed, 4 May 2016 08:06:10 -0500
Subject: [PATCH v7 2/2] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <20160504113852.10a2dd84@bbrezillon>
References: <1461845007-23139-1-git-send-email-boris.brezillon@free-electrons.com>
 <1461845007-23139-2-git-send-email-boris.brezillon@free-electrons.com>
 <20160503164019.GA1604@rob-hp-laptop> <20160503185153.5cfddc32@bbrezillon>
 <CAL_Jsq+cTvW=wUUQmD2R-nZ9m3U5E00yEfLy=-Z_X6EQZRO4NQ@mail.gmail.com>
 <20160504113852.10a2dd84@bbrezillon>
Message-ID: <CAL_Jsq+4aL5znA3zOKdcJb+pEXhVOQthkFF6DN2+P6U37t2o6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2016 at 4:38 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> Hi Rob,
>
> On Tue, 3 May 2016 14:11:04 -0500
> Rob Herring <robh@kernel.org> wrote:
>
>> On Tue, May 3, 2016 at 11:51 AM, Boris Brezillon
>> <boris.brezillon@free-electrons.com> wrote:
>> > Hi Rob,
>> >
>> > On Tue, 3 May 2016 11:40:19 -0500
>> > Rob Herring <robh@kernel.org> wrote:
>> >
>> >> On Thu, Apr 28, 2016 at 02:03:27PM +0200, Boris Brezillon wrote:
>> >> > The EBI (External Bus Interface) is used to access external peripherals
>> >> > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
>> >> > Each device is assigned a CS line and an address range and can have its
>> >> > own configuration (timings, access mode, bus width, ...).
>> >> > This driver provides a generic DT binding to configure a device according
>> >> > to its requirements.
>> >> > For specific device controllers (like the NAND one) the SMC timings
>> >> > should be configured by the controller driver through the matrix and smc
>> >> > syscon regmaps.

[...]

>> >> > +EBI bus configuration associated with specific chip-select will be defined in
>> >> > +the configs subnode. This configs node will in turn contain several subnodes
>> >> > +named config-<cs-id>, each of them containing the following properties.
>> >>
>> >> This is a bit unusual. Why not just part of the child device nodes?
>> >
>> > Oh, come on! I reworked the binding because Mark complained about the
>> > previous binding which was doing exactly what you're suggesting. Can
>> > you please be consistent in your reviews...
>>
>> No, Mark and I both have our opinions. Which part of this patch
>> explains the history?
>
> Hm, it's in patch 1/2 (just dropped the cover letter, which might not
> be such a good idea).
>
>> If the revision history is not in the patch, I'm
>> not looking at it.
>>
>> My issue with it this way is that it has invented yet another way to
>> describe timings. I would like to be consistent across external bus
>> descriptions, but we're not very consistent to begin with though. The
>> most common seems to be the way you first did it. But I agree that it
>> is kind of screwy to have an intermediate node unless the controller
>> itself has sub-blocks within it and is not the established way to
>> describe a bus with chip selects. I would either put the properties
>> directly in the child nodes (e.g. flash at 0,0) or put your config nodes
>> in the device node. I'd call it timings instead of config, but that's
>> just bikeshedding.
>
> Well, it's not only describing timings (see atmel,bus-width,
> atmel,byte-access-type, ...), but I'm fine with either names :).
>
>>
>> memory-controller at 1000 {
>>   ...
>>   flash at 0,0 {
>>     timings {
>>       ...
>>     };
>>   };
>> };
>
> Okay. Mark, what do you think of this approach?
>
> Note that one of my previous version was defining timings directly in
> the EBI device node, and Arnd noted that doing so may cause problems
> if one of the EBI property (or the config/timing node name) conflict
> with the sub-device binding, which is why I decided to put the EBI
> config definitions in a separate subnode.

You have vendor prefixes on all the properties so I don't think a
collision is really a problem. It's also an established pattern in
i.MX WEIM and OMAP GPMC (which are hiding in bindings/bus/) and I
prefer consistency.

>> >> > +
>> >> > +Optional config-<cs-id> node properties:
>> >> > +
>> >> > +- atmel,bus-width:         width of the asynchronous device's data bus
>> >> > +                           8, 16 or 32.
>> >> > +                           Default to 8 when undefined.
>> >> > +
>> >> > +- atmel,byte-access-type   "write" or "select" (see Atmel datasheet).
>> >> > +                           Default to "select" when undefined.
>> >> > +
>> >> > +- atmel,read-mode          "nrd" or "ncs".
>> >> > +                           Default to "ncs" when undefined.
>> >> > +
>> >> > +- atmel,write-mode         "nwe" or "ncs".
>> >> > +                           Default to "ncs" when undefined.
>> >> > +
>> >> > +- atmel,exnw-mode          "disabled", "frozen" or "ready".
>> >> > +                           Default to "disabled" when undefined.
>> >> > +
>> >> > +- atmel,page-mode          enable page mode if present. The provided value
>> >> > +                           defines the page size (supported values: 4, 8,
>> >> > +                           16 and 32).
>> >> > +
>> >> > +- atmel,tdf-mode:          "normal" or "optimized". When set to
>> >>
>> >> This should be boolean.
>> >
>> > It was a formerly defined as a boolean, and when it's done like that we
>> > have no way to identify whether the property was forgotten or
>> > intentionally set to normal mode. What's the problem with this approach?
>>
>> Only preference to use boolean when that is sufficient. With your
>> argument, then we should never have booleans. You state that missing
>> means "normal", not forgotten, so all these properties should be
>> required with no default.
>>
>> BTW, I debated the same thing on the other properties, but I could see
>> them being expanded to a 3rd mode. I don't see that here though.
>
> Well, another reason I switched to a string property is because I
> implemented hardware readout in v4, and decided to retrieve the current
> state from the hardware and only overload the config with what was
> defined in the DT. In this case, if we move to a boolean property we
> can't know whether the property is missing because we want to put the
> bus in "normal" mode or because we want to keep this config unchanged
> (keep the bootloader/bootstrap config).

Now you are giving yet another definition of what missing means.
Please pick and document one:
- Error, property missing
- Normal mode
- Retain firmware/bootloader settings (this should probably apply to
all or none)

The last is really the only reason I agree with for not doing a boolean.

Rob
