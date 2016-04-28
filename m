From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 28 Apr 2016 14:18:25 +0200
Subject: [PATCH v6 2/2] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <20160428104925.7eb12ca2@bbrezillon>
References: <1461767754-12189-1-git-send-email-boris.brezillon@free-electrons.com>
 <1461767754-12189-3-git-send-email-boris.brezillon@free-electrons.com>
 <CACh+v5OO+UQ_EiWVyewdMHnMB-p3nd6N=R5P7K4V_4=ymy-YuQ@mail.gmail.com>
 <20160428104925.7eb12ca2@bbrezillon>
Message-ID: <CACh+v5Mi2Qd58SZkwW0mZ3ZJx3Rv3mwSkRqzgHwBTxpUbwjVFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-04-28 10:49 GMT+02:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
> Hi Jean-Jacques,
>
> On Thu, 28 Apr 2016 10:32:49 +0200
> Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:
>
>> Hi Boris,
>>
>> i haven't seen this code in a while :) I'm glad you're working on it
>>
>> 2016-04-27 16:35 GMT+02:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
>> > The EBI (External Bus Interface) is used to access external peripherals
>> > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
>> > Each device is assigned a CS line and an address range and can have its
>> > own configuration (timings, access mode, bus width, ...).
>> > This driver provides a generic DT binding to configure a device according
>> > to its requirements.
>> > For specific device controllers (like the NAND one) the SMC timings
>> > should be configured by the controller driver through the matrix and smc
>> > syscon regmaps.
>> >
>> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> > ---
>> >  .../bindings/memory-controllers/atmel,ebi.txt      | 146 +++++++++++++++++++++
>> >  1 file changed, 146 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
>> > new file mode 100644
>> > index 0000000..0f332d2
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
>> > @@ -0,0 +1,146 @@
>> > +* Device tree bindings for Atmel EBI
>> > +
>> > +The External Bus Interface (EBI) controller is a bus where you can connect
>> > +asynchronous (NAND, NOR, SRAM, ....) and synchronous memories (SDR/DDR SDRAMs).
>> > +The EBI provides a glue-less interface to asynchronous memories though the SMC
>> > +(Static Memory Controller).
>> > +Synchronous memories (and some asynchronous memories like NANDs) can be
>> > +attached to specialized controllers which are responsible for configuring the
>> > +bus appropriately according to the connected device.
>> > +In the other hand, the bus interface can be automated for simple asynchronous
>> > +devices.
>> > +
>> > +Required properties:
>> > +
>> > +- compatible:          "atmel,at91sam9260-ebi"
>> > +                       "atmel,at91sam9261-ebi"
>> > +                       "atmel,at91sam9263-ebi0"
>> > +                       "atmel,at91sam9263-ebi1"
>> > +                       "atmel,at91sam9rl-ebi"
>> > +                       "atmel,at91sam9g45-ebi"
>> > +                       "atmel,at91sam9x5-ebi"
>> > +                       "atmel,sama5d3-ebi"
>> > +
>> > +- reg:                 Contains offset/length value for EBI memory mapping.
>> > +                       This property might contain several entries if the EBI
>> > +                       memory range is not contiguous
>> > +
>> > +- #address-cells:      Must be 2.
>> > +                       The first cell encodes the CS.
>> > +                       The second cell encode the offset into the CS memory
>> > +                       range.
>> > +
>> > +- #size-cells:         Must be set to 1.
>> > +
>> > +- ranges:              Encodes CS to memory region association.
>> > +
>> > +- clocks:              Clock feeding the EBI controller.
>> > +                       See clock-bindings.txt
>> > +
>> > +Child chip-select (cs) nodes contain the memory devices nodes connected to
>> > +such as NOR (e.g. cfi-flash) and NAND.
>> > +There might be board specific devices like FPGAs.
>> > +You'll define you device requirements in these child nodes.
>> > +
>> > +Required child cs node properties:
>> > +
>> > +- #address-cells:      Must be 2.
>> > +
>> > +- #size-cells:         Must be 1.
>> > +
>> > +- ranges:              Empty property indicating that child nodes can inherit
>> > +                       memory layout.
>> > +
>> > +Optional child cs node properties:
>> > +- atmel,bus-width:             width of the asynchronous device's data bus
>> > +                               8, 16 or 32.
>> > +                               8 if not present.
>> > +
>> > +- atmel,byte-access-type       "write" or "select" (see Atmel datasheet).
>> > +                               "select" if not present.
>> > +
>> > +- atmel,read-mode              "nrd" or "ncs".
>> > +                               "ncs" is not present.
>> > +
>> > +- atmel,write-mode             "nwe" or "ncs".
>> > +                               "ncs" is not present.
>> > +
>> > +- atmel,exnw-mode              "disabled", "frozen" or "ready".
>> > +                               "disabled" if not present.
>> > +
>> > +- atmel,page-mode              enable page mode if present. The provided value
>> > +                               defines the page size (supported values: 4, 8,
>> > +                               16 and 32).
>> > +
>> > +Optional device timings expressed in nanoseconds (if the property is not
>> > +present 0 is assumed):
>>
>> IMO If no timing information is provided, it's probably better not to
>> change it. It may have been configured by the bootloader or romboot.
>> It may not be the perfect timings but at least it could work, whereas
>> filling up with 0 is most probably going to break the access: it's a
>> kind of very agressive timing optimization
>
> Yes, probably. I'll make all those timings mandatory in the next
> version.
>
>>
>> > +
>> > +- atmel,ncs-rd-setup-ns
>> > +- atmel,nrd-setup-ns
>> > +- atmel,ncs-wr-setup-ns
>> > +- atmel,nwe-setup-ns
>> > +- atmel,ncs-rd-pulse-ns
>> > +- atmel,nrd-pulse-ns
>> > +- atmel,ncs-wr-pulse-ns
>> > +- atmel,nwe-pulse-ns
>> > +- atmel,nwe-cycle-ns
>> > +- atmel,nrd-cycle-ns
>> > +- atmel,tdf-ns
>>
>> One thought about the configuration in 'ns' unit: Some devices may
>> have requirements expressed in clock cycles (I'm thinking of FPGA
>> here). At  a fixed frequency one can always convert manually from 'ns'
>> to 'clocks' but it's a bit tedious and prone to rounding errors. And
>> It 'll  break when the EBI frequency is changed
>
> If you don't mind, I'd like to first get this version accepted, and
> we'll extend it with timings expressed in clock cycles afterward.
>
> BTW, could you describe a real use case where timings should be
> expressed in clock cycles? I mean, usually the devices have some timing
> constraints (tXX_min = Y ns), and I don't see why it would differ for
> FPGA interfaces, but I'm clearly not an FPGA expert.

I'm not either, I only toyed with FPGA. That's just what experienced
FPGA designer told me.
I guess that it boils down to: FPGA are more suited for a synchronous
design than an asynchronous one.

JJ

>
> Thanks,
>
> Boris
>
> --
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
