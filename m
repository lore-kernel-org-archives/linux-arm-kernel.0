From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Mon, 30 May 2016 05:46:21 +0000
Subject: [PATCH v3] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <CAL_Jsq+VL6jjo5QLwnsC8rEfgP4KN5hCSB7QicWWN-uvZU0GHw@mail.gmail.com>
References: <1464067268-35299-1-git-send-email-navam@xilinx.com>
 <C89496FEAE474D468F30D558A9468D9F26CED772@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160525173419.GA7510@rob-hp-laptop> <5392766.vCAWrASuOA@wuerfel>
 <CAL_Jsq+VL6jjo5QLwnsC8rEfgP4KN5hCSB7QicWWN-uvZU0GHw@mail.gmail.com>
Message-ID: <C89496FEAE474D468F30D558A9468D9F26CEEBAB@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Thursday, May 26, 2016 12:24 AM
> To: Arnd Bergmann <arnd@arndb.de>
> Cc: Nava kishore Manne <navam@xilinx.com>; pawel.moll at arm.com;
> mark.rutland at arm.com; ijc+devicetree at hellion.org.uk;
> galak at codeaurora.org; Michal Simek <michals@xilinx.com>; Soren
> Brinkmann <sorenb@xilinx.com>; balbi at ti.com;
> gregkh at linuxfoundation.org; Hyun Kwon <hyunk@xilinx.com>; Radhey
> Shyam Pandey <radheys@xilinx.com>; devicetree at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v3] Axi-usb: Add support for 64-bit addressing.
>
> On Wed, May 25, 2016 at 1:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday, May 25, 2016 12:34:19 PM CEST Rob Herring wrote:
> >> On Tue, May 24, 2016 at 11:47:31AM +0000, Nava kishore Manne wrote:
> >> >
> >> >
> >> > > -----Original Message-----
> >> > > From: Arnd Bergmann [mailto:arnd at arndb.de]
> >> > > Sent: Tuesday, May 24, 2016 2:21 PM
> >> > > To: Nava kishore Manne <navam@xilinx.com>
> >> > > Cc: robh+dt at kernel.org; pawel.moll at arm.com;
> mark.rutland at arm.com;
> >> > > ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> >> > > <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> >> > > balbi at ti.com; gregkh at linuxfoundation.org; Hyun Kwon
> >> > > <hyunk@xilinx.com>; Nava kishore Manne <navam@xilinx.com>;
> Radhey
> >> > > Shyam Pandey <radheys@xilinx.com>; devicetree at vger.kernel.org;
> >> > > linux- arm-kernel at lists.infradead.org;
> >> > > linux-kernel at vger.kernel.org
> >> > > Subject: Re: [PATCH v3] Axi-usb: Add support for 64-bit addressing.
> >> > >
> >> > > On Tuesday, May 24, 2016 10:51:08 AM CEST Nava kishore Manne
> wrote:
> >> > > > diff --git
> >> > > > a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> >> > > > b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> >> > > > index 47b4e39..09df757 100644
> >> > > > --- a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> >> > > > +++ b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> >> > > > @@ -1,18 +1,23 @@
> >> > > >  Xilinx USB2 device controller
> >> > > >
> >> > > >  Required properties:
> >> > > > -- compatible             : Should be "xlnx,usb2-device-4.00.a"
> >> > > > +- compatible             : Should be "xlnx,usb2-device-4.00.a" or
> >> > > > +                   "xlnx,usb2-device-5.00"
> >> > > >  - reg                    : Physical base address and size of the USB2
> >> > > >                     device registers map.
> >> > > >  - interrupts             : Should contain single irq line of USB2 device
> >> > > >                     controller
> >> > > >  - xlnx,has-builtin-dma   : if DMA is included
> >> > > > +- dma-ranges             : Should be as the following
> >> > > > +                   <child-bus-address, parent-bus-address,
> >> > > > +length>
> >> > >
> >> > > A USB host should not have any children that are DMA capable, I
> >> > > think, so this property doesn't make sense here. It should be part of
> the parent bus.
> >> > >
> >> > Will send next version (v4) by removing this property from the DT.
> >> >
> >> > > > +- xlnx,addrwidth : Should be the dma addressing size in
> >> > > > +bits(ex: 64
> >> > > bits)
> >> > >
> >> > > I'm still unconvinced about the property definition here. What
> >> > > are the possible options for the IP block? I don't think I ever
> >> > > saw a reply from you to my earlier questions.
> >> > >
> >> >
> >> > Sorry Let me clearly explain
> >> >
> >> > From the IP version 5.0 onwards The IP support both 32-bit and 64-bit
> addressing.
> >> > But the older version of the IP's supports only 32-bit addressing.
> >> >
> >> > This addrwidth property differentiates the address width for the
> >> > new IP (I mean 5.0 version on wards) For older IP it will be always 32-bit.
> >>
> >> Then I think you should have a simple boolean property for 64-bit
> >> configuration.
> >
> > I think matching on the version number is slightly better, as we have
> > the version already and it identifies whether the register exists.
> >
> > Having a boolean property of course works as well, it just duplicates
> > that information.
>
> It doesn't because v5.0 h/w can be configured for either 32 or 64-bit mode.
> Normally, we would encode configuration into the compatible strings, but I
> view FPGA based blocks to be an exception. Of course, since they can just
> "fix the h/w" we could just require h/w version and feature registers. ;)
>
The Axi-usb 5.00 IP is a FPGA based one. This IP needs to support two H/w designs one with 32 bit DMA addressing another one is 64 bit DMA addressing.
And also in the software point for view we don?t have any register to figure out whether it is supporting 32 bit DMA addressing or 64 bit DMA addressing.
To support both the designs I kept addrwidth property in the dt. I think here addrwidth property is make sense to differentiate the h/w configurations.
If you want me to changes it to boolean please let me know I will fix it in the next version.

Regards,
Navakishore.

> Rob


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
