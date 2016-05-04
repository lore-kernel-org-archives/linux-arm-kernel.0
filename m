From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 4 May 2016 11:35:55 +0200
Subject: [PATCH v7 2/2] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <CAL_Jsq+cTvW=wUUQmD2R-nZ9m3U5E00yEfLy=-Z_X6EQZRO4NQ@mail.gmail.com>
References: <1461845007-23139-1-git-send-email-boris.brezillon@free-electrons.com>
 <1461845007-23139-2-git-send-email-boris.brezillon@free-electrons.com>
 <20160503164019.GA1604@rob-hp-laptop>
 <20160503185153.5cfddc32@bbrezillon>
 <CAL_Jsq+cTvW=wUUQmD2R-nZ9m3U5E00yEfLy=-Z_X6EQZRO4NQ@mail.gmail.com>
Message-ID: <20160504113555.20f0c622@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, 3 May 2016 14:11:04 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, May 3, 2016 at 11:51 AM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > Hi Rob,
> >
> > On Tue, 3 May 2016 11:40:19 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >
> >> On Thu, Apr 28, 2016 at 02:03:27PM +0200, Boris Brezillon wrote:
> >> > The EBI (External Bus Interface) is used to access external peripherals
> >> > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
> >> > Each device is assigned a CS line and an address range and can have its
> >> > own configuration (timings, access mode, bus width, ...).
> >> > This driver provides a generic DT binding to configure a device according
> >> > to its requirements.
> >> > For specific device controllers (like the NAND one) the SMC timings
> >> > should be configured by the controller driver through the matrix and smc
> >> > syscon regmaps.
> >> >
> >> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> >> > ---
> >> >  .../bindings/memory-controllers/atmel,ebi.txt      | 136 +++++++++++++++++++++
> >> >  1 file changed, 136 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> >> > new file mode 100644
> >> > index 0000000..a6dca5c
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> >> > @@ -0,0 +1,136 @@
> >> > +* Device tree bindings for Atmel EBI
> >> > +
> >> > +The External Bus Interface (EBI) controller is a bus where you can connect
> >> > +asynchronous (NAND, NOR, SRAM, ....) and synchronous memories (SDR/DDR SDRAMs).
> >> > +The EBI provides a glue-less interface to asynchronous memories through the SMC
> >> > +(Static Memory Controller).
> >> > +
> >> > +Required properties:
> >> > +
> >> > +- compatible:              "atmel,at91sam9260-ebi"
> >> > +                   "atmel,at91sam9261-ebi"
> >> > +                   "atmel,at91sam9263-ebi0"
> >> > +                   "atmel,at91sam9263-ebi1"
> >>
> >> What are the differences between 0 and 1?
> >
> > Because this SoC has 2 EBI busses with different capabilities.
> 
> Okay, correct answer. :)
> 
> [...]
> 
> >>
> >> > +                   of the memory region requested by the device.
> >> > +
> >> > +EBI bus configuration associated with specific chip-select will be defined in
> >> > +the configs subnode. This configs node will in turn contain several subnodes
> >> > +named config-<cs-id>, each of them containing the following properties.
> >>
> >> This is a bit unusual. Why not just part of the child device nodes?
> >
> > Oh, come on! I reworked the binding because Mark complained about the
> > previous binding which was doing exactly what you're suggesting. Can
> > you please be consistent in your reviews...
> 
> No, Mark and I both have our opinions. Which part of this patch
> explains the history?

Hm, it's in patch 1/2 (just dropped the cover letter, which might not
be such a good idea).

> If the revision history is not in the patch, I'm
> not looking at it.
> 
> My issue with it this way is that it has invented yet another way to
> describe timings. I would like to be consistent across external bus
> descriptions, but we're not very consistent to begin with though. The
> most common seems to be the way you first did it. But I agree that it
> is kind of screwy to have an intermediate node unless the controller
> itself has sub-blocks within it and is not the established way to
> describe a bus with chip selects. I would either put the properties
> directly in the child nodes (e.g. flash at 0,0) or put your config nodes
> in the device node. I'd call it timings instead of config, but that's
> just bikeshedding.

Well, it's not only describing timings (see atmel,bus-width,
atmel,byte-access-type, ...), but I'm fine with either names :).

> 
> memory-controller at 1000 {
>   ...
>   flash at 0,0 {
>     timings {
>       ...
>     };
>   };
> };

Okay. Mark, what do you think of this approach?

Note that one of my previous version was defining timings directly in
the EBI device node, and Arnd noted that doing so may cause problems
if one of the EBI property (or the config/timing node name) conflict
with the sub-device binding, which is why I decided to put the EBI
config definitions in a separate subnode.

> 
> >> > +
> >> > +Optional config-<cs-id> node properties:
> >> > +
> >> > +- atmel,bus-width:         width of the asynchronous device's data bus
> >> > +                           8, 16 or 32.
> >> > +                           Default to 8 when undefined.
> >> > +
> >> > +- atmel,byte-access-type   "write" or "select" (see Atmel datasheet).
> >> > +                           Default to "select" when undefined.
> >> > +
> >> > +- atmel,read-mode          "nrd" or "ncs".
> >> > +                           Default to "ncs" when undefined.
> >> > +
> >> > +- atmel,write-mode         "nwe" or "ncs".
> >> > +                           Default to "ncs" when undefined.
> >> > +
> >> > +- atmel,exnw-mode          "disabled", "frozen" or "ready".
> >> > +                           Default to "disabled" when undefined.
> >> > +
> >> > +- atmel,page-mode          enable page mode if present. The provided value
> >> > +                           defines the page size (supported values: 4, 8,
> >> > +                           16 and 32).
> >> > +
> >> > +- atmel,tdf-mode:          "normal" or "optimized". When set to
> >>
> >> This should be boolean.
> >
> > It was a formerly defined as a boolean, and when it's done like that we
> > have no way to identify whether the property was forgotten or
> > intentionally set to normal mode. What's the problem with this approach?
> 
> Only preference to use boolean when that is sufficient. With your
> argument, then we should never have booleans. You state that missing
> means "normal", not forgotten, so all these properties should be
> required with no default.
> 
> BTW, I debated the same thing on the other properties, but I could see
> them being expanded to a 3rd mode. I don't see that here though.

Well, another reason I switched to a string property is because I
implemented hardware readout in v4, and decided to retrieve the current
state from the hardware and only overload the config with what was
defined in the DT. In this case, if we move to a boolean property we
can't know whether the property is missing because we want to put the
bus in "normal" mode or because we want to keep this config unchanged
(keep the bootloader/bootstrap config).

This is not true in v5, so maybe we should go back to the boolean
atmel,tdf-optimized property.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
