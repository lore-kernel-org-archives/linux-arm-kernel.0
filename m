From: robh@kernel.org (Rob Herring)
Date: Wed, 25 May 2016 13:53:32 -0500
Subject: [PATCH v3] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <5392766.vCAWrASuOA@wuerfel>
References: <1464067268-35299-1-git-send-email-navam@xilinx.com>
 <C89496FEAE474D468F30D558A9468D9F26CED772@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160525173419.GA7510@rob-hp-laptop> <5392766.vCAWrASuOA@wuerfel>
Message-ID: <CAL_Jsq+VL6jjo5QLwnsC8rEfgP4KN5hCSB7QicWWN-uvZU0GHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 1:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, May 25, 2016 12:34:19 PM CEST Rob Herring wrote:
>> On Tue, May 24, 2016 at 11:47:31AM +0000, Nava kishore Manne wrote:
>> >
>> >
>> > > -----Original Message-----
>> > > From: Arnd Bergmann [mailto:arnd at arndb.de]
>> > > Sent: Tuesday, May 24, 2016 2:21 PM
>> > > To: Nava kishore Manne <navam@xilinx.com>
>> > > Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
>> > > ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
>> > > <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
>> > > balbi at ti.com; gregkh at linuxfoundation.org; Hyun Kwon
>> > > <hyunk@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Radhey
>> > > Shyam Pandey <radheys@xilinx.com>; devicetree at vger.kernel.org; linux-
>> > > arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
>> > > Subject: Re: [PATCH v3] Axi-usb: Add support for 64-bit addressing.
>> > >
>> > > On Tuesday, May 24, 2016 10:51:08 AM CEST Nava kishore Manne wrote:
>> > > > diff --git a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
>> > > > b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
>> > > > index 47b4e39..09df757 100644
>> > > > --- a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
>> > > > +++ b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
>> > > > @@ -1,18 +1,23 @@
>> > > >  Xilinx USB2 device controller
>> > > >
>> > > >  Required properties:
>> > > > -- compatible             : Should be "xlnx,usb2-device-4.00.a"
>> > > > +- compatible             : Should be "xlnx,usb2-device-4.00.a" or
>> > > > +                   "xlnx,usb2-device-5.00"
>> > > >  - reg                    : Physical base address and size of the USB2
>> > > >                     device registers map.
>> > > >  - interrupts             : Should contain single irq line of USB2 device
>> > > >                     controller
>> > > >  - xlnx,has-builtin-dma   : if DMA is included
>> > > > +- dma-ranges             : Should be as the following
>> > > > +                   <child-bus-address, parent-bus-address, length>
>> > >
>> > > A USB host should not have any children that are DMA capable, I think, so
>> > > this property doesn't make sense here. It should be part of the parent bus.
>> > >
>> > Will send next version (v4) by removing this property from the DT.
>> >
>> > > > +- xlnx,addrwidth : Should be the dma addressing size in bits(ex: 64
>> > > bits)
>> > >
>> > > I'm still unconvinced about the property definition here. What are the
>> > > possible options for the IP block? I don't think I ever saw a reply from you to
>> > > my earlier questions.
>> > >
>> >
>> > Sorry Let me clearly explain
>> >
>> > From the IP version 5.0 onwards The IP support both 32-bit and 64-bit addressing.
>> > But the older version of the IP's supports only 32-bit addressing.
>> >
>> > This addrwidth property differentiates the address width for the new IP (I mean 5.0 version on wards)
>> > For older IP it will be always 32-bit.
>>
>> Then I think you should have a simple boolean property for 64-bit
>> configuration.
>
> I think matching on the version number is slightly better, as we have the version
> already and it identifies whether the register exists.
>
> Having a boolean property of course works as well, it just duplicates that
> information.

It doesn't because v5.0 h/w can be configured for either 32 or 64-bit
mode. Normally, we would encode configuration into the compatible
strings, but I view FPGA based blocks to be an exception. Of course,
since they can just "fix the h/w" we could just require h/w version
and feature registers. ;)

Rob
