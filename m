From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Tue, 10 May 2016 15:08:20 +0200
Subject: [PATCH v7 2/2] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <20160510144143.1965ee5e@bbrezillon>
References: <1461845007-23139-1-git-send-email-boris.brezillon@free-electrons.com>
 <1461845007-23139-2-git-send-email-boris.brezillon@free-electrons.com>
 <20160503164019.GA1604@rob-hp-laptop> <20160503185153.5cfddc32@bbrezillon>
 <CAL_Jsq+cTvW=wUUQmD2R-nZ9m3U5E00yEfLy=-Z_X6EQZRO4NQ@mail.gmail.com>
 <20160504113852.10a2dd84@bbrezillon>
 <CAL_Jsq+4aL5znA3zOKdcJb+pEXhVOQthkFF6DN2+P6U37t2o6g@mail.gmail.com>
 <20160504153547.60d736bb@bbrezillon> <20160510100448.49834120@bbrezillon>
 <20160510110742.GI687@leverpostej> <20160510144143.1965ee5e@bbrezillon>
Message-ID: <CACh+v5M2yZ403+VwvRMYeGwfhpP+aCGnnNhiQ1wjrxS5fVGVEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-05-10 14:41 GMT+02:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
> On Tue, 10 May 2016 12:07:42 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
>
>> On Tue, May 10, 2016 at 10:04:48AM +0200, Boris Brezillon wrote:
>> > On Wed, 4 May 2016 15:35:47 +0200
>> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>> >
>> > > On Wed, 4 May 2016 08:06:10 -0500
>> > > Rob Herring <robh@kernel.org> wrote:
>> > >
>> > > > On Wed, May 4, 2016 at 4:38 AM, Boris Brezillon
>> > > > <boris.brezillon@free-electrons.com> wrote:
>> > > > > Hi Rob,
>> > > > >
>> > > > > On Tue, 3 May 2016 14:11:04 -0500
>> > > > > Rob Herring <robh@kernel.org> wrote:
>> > > > >
>> > > > >> On Tue, May 3, 2016 at 11:51 AM, Boris Brezillon
>> > > > >> <boris.brezillon@free-electrons.com> wrote:
>> > > > >> > Hi Rob,
>> > > > >> >
>> > > > >> > On Tue, 3 May 2016 11:40:19 -0500
>> > > > >> > Rob Herring <robh@kernel.org> wrote:
>> > > > >> >
>> > > > >> >> On Thu, Apr 28, 2016 at 02:03:27PM +0200, Boris Brezillon wrote:
>> > > > >> >> > The EBI (External Bus Interface) is used to access external peripherals
>> > > > >> >> > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
>> > > > >> >> > Each device is assigned a CS line and an address range and can have its
>> > > > >> >> > own configuration (timings, access mode, bus width, ...).
>> > > > >> >> > This driver provides a generic DT binding to configure a device according
>> > > > >> >> > to its requirements.
>> > > > >> >> > For specific device controllers (like the NAND one) the SMC timings
>> > > > >> >> > should be configured by the controller driver through the matrix and smc
>> > > > >> >> > syscon regmaps.
>> > > >
>> > > > [...]
>> > > >
>> > > > >> >> > +EBI bus configuration associated with specific chip-select will be defined in
>> > > > >> >> > +the configs subnode. This configs node will in turn contain several subnodes
>> > > > >> >> > +named config-<cs-id>, each of them containing the following properties.
>> > > > >> >>
>> > > > >> >> This is a bit unusual. Why not just part of the child device nodes?
>> > > > >> >
>> > > > >> > Oh, come on! I reworked the binding because Mark complained about the
>> > > > >> > previous binding which was doing exactly what you're suggesting. Can
>> > > > >> > you please be consistent in your reviews...
>> > > > >>
>> > > > >> No, Mark and I both have our opinions. Which part of this patch
>> > > > >> explains the history?
>> > > > >
>> > > > > Hm, it's in patch 1/2 (just dropped the cover letter, which might not
>> > > > > be such a good idea).
>> > > > >
>> > > > >> If the revision history is not in the patch, I'm
>> > > > >> not looking at it.
>> > > > >>
>> > > > >> My issue with it this way is that it has invented yet another way to
>> > > > >> describe timings. I would like to be consistent across external bus
>> > > > >> descriptions, but we're not very consistent to begin with though. The
>> > > > >> most common seems to be the way you first did it. But I agree that it
>> > > > >> is kind of screwy to have an intermediate node unless the controller
>> > > > >> itself has sub-blocks within it and is not the established way to
>> > > > >> describe a bus with chip selects. I would either put the properties
>> > > > >> directly in the child nodes (e.g. flash at 0,0) or put your config nodes
>> > > > >> in the device node. I'd call it timings instead of config, but that's
>> > > > >> just bikeshedding.
>> > > > >
>> > > > > Well, it's not only describing timings (see atmel,bus-width,
>> > > > > atmel,byte-access-type, ...), but I'm fine with either names :).
>> > > > >
>> > > > >>
>> > > > >> memory-controller at 1000 {
>> > > > >>   ...
>> > > > >>   flash at 0,0 {
>> > > > >>     timings {
>> > > > >>       ...
>> > > > >>     };
>> > > > >>   };
>> > > > >> };
>> > > > >
>> > > > > Okay. Mark, what do you think of this approach?
>> > > > >
>> > > > > Note that one of my previous version was defining timings directly in
>> > > > > the EBI device node, and Arnd noted that doing so may cause problems
>> > > > > if one of the EBI property (or the config/timing node name) conflict
>> > > > > with the sub-device binding, which is why I decided to put the EBI
>> > > > > config definitions in a separate subnode.
>> > > >
>> > > > You have vendor prefixes on all the properties so I don't think a
>> > > > collision is really a problem. It's also an established pattern in
>> > > > i.MX WEIM and OMAP GPMC (which are hiding in bindings/bus/) and I
>> > > > prefer consistency.
>> > >
>> > > So let's summarize that.
>> > >
>> > > memory-controller at 1000 {
>> > >   ...
>> > >   flash at 0,0 {
>> > >           atmel,<ebi-prop-name> = <value>;
>> > >           ...
>> > >           <flash-device-prop> = <value>;
>> > >   };
>> > > };
>> > >
>> > > Would everyone agree on this representation?
>> > >
>> > > With this approach, it's a bit more complicated to detect the case
>> > > where we want to keep bootloader/firmware config, but it should be
>> > > doable (it's much more easier to test for the presence of a
>> > > config/timing node than verifying that either all or none of the
>> > > mandatory properties are here).
>> > >
>> > > Still remains the problem mentioned by Jean-Jacques: what if the
>> > > sub-device takes 2 CS lines. Should we apply the same setting to those
>> > > slots?
>> > >
>> >
>> > Rob, Mark, Arnd, can you take a decision regarding this binding? This
>> > driver is floating around for quite some time, and we were asked to
>> > rework the binding several times (in time in an opposite direction).
>> >
>> > For the record, here is the thread I mentioned earlier [1]. In his
>> > answer, Arnd suggests to put timing and bus config description
>> > outside of the sub-device node. Mark recently complained about this
>> > representation, which led me to the configs/config-X appraoch, and now
>> > Rob suggests to go back to the first proposal.
>> >
>> > I'm fine doing that, but can you please all confirm that you agree on
>> > this binding?
>>
>> Sorry for the delay in getting round to this, and sorry that this
>> appears to be going in circles.
>>
>> Please go with Rob's suggestion.
>
> Okay. This changes a bit the constraints defined in the binding doc
> (no default values for undefined properties: we just keep the
> bootloader/firmware config), but otherwise should be easy to implement.
>
>>
>> I'm not sure about the case where a device takes 2 CS lines. I would
>> assume that in practice that a sub-device covered my multiple CS lines
>> expects the same timings for all its MMIO space, and so having that
>> uniform makes sense. Do we have a counter-example?
>
> Nope, I don't. JJH had one (interfacing with an FPGA), maybe he can
> detail this use case.
>
I don't either. It makes sense that a single device with 2 CS uses the
same timings.
My use case was the other way around: 1 CS for several devices.

>
> --
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
