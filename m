From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 14 Jun 2016 13:55:53 +0000
Subject: ARM physical memory map recommendation? (was RE: [RFC] arm64:
 defconfig: enable 48-bit VA by default)
In-Reply-To: <CAKv+Gu-Ra0sAbx1mmuN9o2LZ3Ccs7TsBRm7WyV8SxU6Y3fsEUA@mail.gmail.com>
References: <HE1PR04MB16416EEC1B49328C2C6F43FB8D500@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <CAKv+Gu9-p9_B-KbQ0Kh3VOrDXGj-5eHur-aEpostzu1L2Hgugw@mail.gmail.com>
 <HE1PR04MB1641BF6DC3931FEBEF9716998D530@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <CAKv+Gu-Ra0sAbx1mmuN9o2LZ3Ccs7TsBRm7WyV8SxU6Y3fsEUA@mail.gmail.com>
Message-ID: <HE1PR04MB1641A898ACEE35C35064F0838D540@HE1PR04MB1641.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
> Sent: Tuesday, June 14, 2016 3:52 AM
> To: Stuart Yoder <stuart.yoder@nxp.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>; Mark Rutland <mark.rutland@arm.com>; Marc Zyngier
> <marc.zyngier@arm.com>; Will Deacon <Will.Deacon@arm.com>; Peter Newton <Peter.Newton@freescale.com>;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: ARM physical memory map recommendation? (was RE: [RFC] arm64: defconfig: enable 48-bit VA
> by default)
> 
> On 13 June 2016 at 20:41, Stuart Yoder <stuart.yoder@nxp.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
> >> Sent: Saturday, June 11, 2016 6:38 AM
> >> To: Stuart Yoder <stuart.yoder@nxp.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>; Mark Rutland <mark.rutland@arm.com>; Marc Zyngier
> >> <marc.zyngier@arm.com>; Will Deacon <Will.Deacon@arm.com>; Peter Newton <Peter.Newton@freescale.com>;
> >> linux-arm-kernel at lists.infradead.org
> >> Subject: Re: ARM physical memory map recommendation? (was RE: [RFC] arm64: defconfig: enable 48-bit
> VA
> >> by default)
> >>
> >> On 10 June 2016 at 18:34, Stuart Yoder <stuart.yoder@nxp.com> wrote:
> >> >
> >> >> -----Original Message-----
> >> >> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> >> >> Sent: Friday, July 31, 2015 8:23 AM
> >> >> To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> >> Cc: Mark Rutland <mark.rutland@arm.com>; Marc Zyngier <marc.zyngier@arm.com>; Will Deacon
> >> >> <Will.Deacon@arm.com>; Stuart Yoder <stuart.yoder@freescale.com>; Peter Newton
> >> >> <Peter.Newton@freescale.com>; linux-arm-kernel at lists.infradead.org
> >> >> Subject: Re: [RFC] arm64: defconfig: enable 48-bit VA by default
> >> >>
> >> >> On Fri, Jul 31, 2015 at 03:10:39PM +0200, Ard Biesheuvel wrote:
> >> >> > On 31 July 2015 at 14:53, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> >> > > On Thu, Jul 30, 2015 at 09:27:03PM +0200, Ard Biesheuvel wrote:
> >> >> > >> On 30 July 2015 at 12:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> >> > >> > On Wed, Jul 29, 2015 at 08:49:57PM +0000, Stuart Yoder wrote:
> >> >> > >> >> > From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
> >> >> > >> [...]
> >> >> > >> >> > To be honest, I think this is poorly designed, and I am not sure we
> >> >> > >> >> > should cater for such configurations in the defconfig.
> >> >> > >> >>
> >> >> > >> >> Agree, if this is a one-off weird platform then we shouldn't.
> >> >> > >> >>
> >> >> > >> >> But, the 'Principles of ARM Memory Maps' doc proposes this:
> >> >> > >> >> 2 GB at 0x8000_0000
> >> >> > >> >> 30 GB at 0x8_8000_0000
> >> >> > >> >> 480 GB at 0x88_0000_0000
> >> >> > >> >
> >> >> > >> > I'm not particularly recommending this layout, at least not without some
> >> >> > >> > clarifications on DRAM aliases (I'll ping people internally about it
> >> >> > >> > again). The original layout pre-dates ARMv8, it was meant for ARMv7/LPAE
> >> >> > >> > and all the memory beyond 32-bit was highmem anyway. It was later
> >> >> > >> > updated for AArch64 but only to allow 44/48-bit PA (a few sections
> >> >> > >> > added).
> >> >> > >>
> >> >> > >> As an aside, is there any reason why the direct mapping *must* be a
> >> >> > >> linear mapping?
> >> >> > >> Other than the performance concerns regarding
> >> >> > >> phys_to_virt/virt_to_phys, I mean?
> >> >> > >
> >> >> > > Mostly performance concerns. You could compact the physical range into a
> >> >> > > smaller virtual one but the conversion will be costly, especially if you
> >> >> > > want to make it multi-platform (having to look-up memory ranges,
> >> >> > > memblock offsets). This would affect page table entry setup, code that
> >> >> > > requires a page structure (like virt_to_page) and anything else doing
> >> >> > > the virt/phys conversion.
> >> >> > >
> >> >> > > I tried something like that for RealView PBX in the past but it was
> >> >> > > hard-coded (no multi-platform at the time). See
> >> >> > > arch/arm/mach-realview/include/mach/memory.h.
> >> >> >
> >> >> > Yes, that looks vaguely like what I had in mind.
> >> >> >
> >> >> > IOW, we could partition the direct mapping just like the ARM
> >> >> > recommendation, i.e.,
> >> >> >
> >> >> > 0 - 2 GB
> >> >> > 2 - 32 GB
> >> >> > 32 - 512 GB
> >> >> >
> >> >> > but default to 1:1 correspondence, so that
> >> >> >
> >> >> > PHYS_OFFSET = PHYS_OFFSET0 = memstart_addr
> >> >> > PHYS_OFFSET1 = memstart_addr + 2 GB
> >> >> > PHYS_OFFSET2 = memstart_addr + 32 GB
> >> >> >
> >> >> > and only if the ARM recommended physical memory map is detected (with
> >> >> > memstart_addr @ 0x8000_0000), switch to
> >> >> >
> >> >> > PHYS_OFFSET = PHYS_OFFSET0 = memstart_addr
> >> >> > PHYS_OFFSET1 = memstart_addr + 30 GB
> >> >> > PHYS_OFFSET2 = memstart_addr + 480 GB
> >> >>
> >> >> I don't really like such complexity when all you need on arm64 is to
> >> >> enable 48-bit VA (though it would be interesting to benchmark it).
> >> >>
> >> >> > I guess such a special case would be out of the question for one-off
> >> >> > crazy designs like Freescale, but since this is the layout recommended
> >> >> > by ARM itself, I suppose we could try and support it a bit better.
> >> >>
> >> >> I'm trying to get the layout fixed before it spreads any further ;).
> >> >
> >> > Hi Catalin, in this very old thread there was the intent on your side
> >> > to revisit the physical address layout recommended in the 'Principles of ARM
> >> > Memory Maps' whitepaper.  Has anything happened or changed in the
> >> > last ~1 year.  Does ARM have recommendations?  SBSA doesn't
> >> > mandate anything as far as I can see.
> >> >
> >> > We have the opportunity to influences some future designs and wanted to
> >> > see if ARM has recommendations.  In particular, what is the status of
> >> > the recommendations in 'Principles of ARM Memory Maps'?
> >> >
> >>
> >> Frankly, I don't understand why anyone would use this document as a
> >> definitive recommendation for how to lay out the physical address
> >> space of a new SOC. From the doc itself:
> >>
> >> """
> >> ARM creates a variety of development systems to support A-class cortex
> >> CPUs, ranging from cycle accurate RTL models, to fast software models,
> >> onto FPGAs and full custom SoCs. ARM has been harmonizing the memory
> >> maps in these systems to provide internal consistency and software
> >> portability, and to address the constraints that come with mixing
> >> 32-bit components within larger address spaces.
> >> """
> >>
> >> IOW, the document explains why ARM systems are configured the way they
> >> are, taking into consideration that they need to serve as references
> >> for a variety of hardware and software development, using both 32-bit
> >> and 64-bit components. The fact that neither the SBSA nor the document
> >> itself present it as a recommendation for server platforms means that
> >> it should not be mistaken for that.
> >
> > I guess how definitive someone might read it is open to interpretation
> > but our hardware guys intepreted it as the "ARM recommendation".
> > There are lot's of "must" statements in there, so its easy for me to
> > see how it can be intepreted to be fairly definitive.  It doesn't
> > say a 64GB DRAM part _could_ be sub-divided like...  It says "For example
> > a 64GB DRAM part _will_ be sub-divided into three regions."
> >
> 
> Whether or not you interpret the tone as normative is only one side of
> it. The reason I quoted the paragraph above is to emphasize that the
> definition of an 'ARM system' is not clear either, i.e., whether it
> means 'any system that implements the ARM architecture' or simply 'a
> system created by ARM Ltd.'. The fact that the paragraph mentions
> software models and FPGA implementations leans to the latter IMO.
> 
> > In any case, we are not going to follow that document as definitive.
> > But, my question is whether there are any updated ARM recommendations?
> 
> That again suggests that the document in question is intended as a
> general recommendation, which I believe may not be the case. So if we
> could get some clarification on that as well from any of the ARM Ltd.
> cc'ees, that would be great.

One specific definitive guideline should be something related to
normal memory and systems using 39-bit VA.  If the Linux kernel cannot
create a mapping to span all your DDR you are kind of screwed.  IIUC, Ubuntu
and Debian use 39-bit VAs and fall into this case.

But, is that the only guideline?

Thanks,
Stuart
