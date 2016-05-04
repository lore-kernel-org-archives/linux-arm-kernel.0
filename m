From: robh@kernel.org (Rob Herring)
Date: Wed, 4 May 2016 07:43:18 -0500
Subject: [PATCH v7 2/2] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <CACh+v5O2XpJyYWz70pVgtU5-g9td6J7EdmNtJwk0s5SUkAywaQ@mail.gmail.com>
References: <1461845007-23139-1-git-send-email-boris.brezillon@free-electrons.com>
 <1461845007-23139-2-git-send-email-boris.brezillon@free-electrons.com>
 <20160503164019.GA1604@rob-hp-laptop> <20160503185153.5cfddc32@bbrezillon>
 <CAL_Jsq+cTvW=wUUQmD2R-nZ9m3U5E00yEfLy=-Z_X6EQZRO4NQ@mail.gmail.com>
 <CACh+v5O2XpJyYWz70pVgtU5-g9td6J7EdmNtJwk0s5SUkAywaQ@mail.gmail.com>
Message-ID: <CAL_JsqKe2q+k7XEHA0QDs7cj_nkRQj3ZKPEd5Y56Npk1uDi1hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2016 at 5:06 AM, Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> 2016-05-03 21:11 GMT+02:00 Rob Herring <robh@kernel.org>:
>> On Tue, May 3, 2016 at 11:51 AM, Boris Brezillon
>> <boris.brezillon@free-electrons.com> wrote:
>>> Hi Rob,
>>>
>>> On Tue, 3 May 2016 11:40:19 -0500
>>> Rob Herring <robh@kernel.org> wrote:
>>>
>>>> On Thu, Apr 28, 2016 at 02:03:27PM +0200, Boris Brezillon wrote:
>>>> > The EBI (External Bus Interface) is used to access external peripherals
>>>> > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
>>>> > Each device is assigned a CS line and an address range and can have its
>>>> > own configuration (timings, access mode, bus width, ...).
>>>> > This driver provides a generic DT binding to configure a device according
>>>> > to its requirements.
>>>> > For specific device controllers (like the NAND one) the SMC timings
>>>> > should be configured by the controller driver through the matrix and smc
>>>> > syscon regmaps.
>>>> >
>>>> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>>> > ---
>>>> >  .../bindings/memory-controllers/atmel,ebi.txt      | 136 +++++++++++++++++++++
>>>> >  1 file changed, 136 insertions(+)
>>>> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
>>>> >
>>>> > diff --git a/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
>>>> > new file mode 100644
>>>> > index 0000000..a6dca5c
>>>> > --- /dev/null
>>>> > +++ b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
>>>> > @@ -0,0 +1,136 @@
>>>> > +* Device tree bindings for Atmel EBI
>>>> > +
>>>> > +The External Bus Interface (EBI) controller is a bus where you can connect
>>>> > +asynchronous (NAND, NOR, SRAM, ....) and synchronous memories (SDR/DDR SDRAMs).
>>>> > +The EBI provides a glue-less interface to asynchronous memories through the SMC
>>>> > +(Static Memory Controller).
>>>> > +
>>>> > +Required properties:
>>>> > +
>>>> > +- compatible:              "atmel,at91sam9260-ebi"
>>>> > +                   "atmel,at91sam9261-ebi"
>>>> > +                   "atmel,at91sam9263-ebi0"
>>>> > +                   "atmel,at91sam9263-ebi1"
>>>>
>>>> What are the differences between 0 and 1?
>>>
>>> Because this SoC has 2 EBI busses with different capabilities.
>>
>> Okay, correct answer. :)
>>
>> [...]
>>
>>>>
>>>> > +                   of the memory region requested by the device.
>>>> > +
>>>> > +EBI bus configuration associated with specific chip-select will be defined in
>>>> > +the configs subnode. This configs node will in turn contain several subnodes
>>>> > +named config-<cs-id>, each of them containing the following properties.
>>>>
>>>> This is a bit unusual. Why not just part of the child device nodes?
>>>
>>> Oh, come on! I reworked the binding because Mark complained about the
>>> previous binding which was doing exactly what you're suggesting. Can
>>> you please be consistent in your reviews...
>>
>> No, Mark and I both have our opinions. Which part of this patch
>> explains the history? If the revision history is not in the patch, I'm
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
>>
>> memory-controller at 1000 {
>>   ...
>>   flash at 0,0 {
>>     timings {
>>       ...
>>     };
>>   };
>> };
>>
>
> I don't think the timings belong in the child node as they really are
> for the chip select and the chip select may select several devices at
> once. I'm thinking (again) of a FPGA here that could implement or
> example 4 serial ports at different addresses.

It is an established pattern already in i.MX WEIM and OMAP GPMC
bindings. The timings are a function of the device attached, so having
them in the device's node makes some sense. Arguably we should define
the timings in a generic way, but that's hard and no one wants to do
that.

Rob
