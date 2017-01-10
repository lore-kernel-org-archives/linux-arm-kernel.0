From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 10 Jan 2017 10:47:49 +0000
Subject: [QUESTION] Early Write Acknowledge for PCIe configuration space
In-Reply-To: <3295d30c-0b71-d73b-fd53-c75a9e0b2bae@huawei.com>
References: <df407f39-ee05-d74d-6e5e-c5e502372032@huawei.com>
 <6092525.UgRCY3dpzP@wuerfel>
 <e085504e-74fd-e8be-8287-4baef88551c9@huawei.com>
 <1882721.jqIYnAaWfQ@wuerfel>
 <3295d30c-0b71-d73b-fd53-c75a9e0b2bae@huawei.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F9C0263@lhreml507-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: John Garry
> Sent: 10 January 2017 10:23
> To: Arnd Bergmann
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com; Will
> Deacon; Lorenzo Pieralisi; Gabriele Paoloni; Linuxarm; xuwei (O);
> Wangzhou (B); Shameerali Kolothum Thodi; Guohanjun (Hanjun Guo)
> Subject: Re: [QUESTION] Early Write Acknowledge for PCIe configuration
> space
> 
> On 09/01/2017 11:52, Arnd Bergmann wrote:
> > On Monday, January 9, 2017 10:59:47 AM CET John Garry wrote:
> >> On 06/01/2017 11:24, Arnd Bergmann wrote:
> >>> On Friday, January 6, 2017 11:15:22 AM CET John Garry wrote:
> >>>
> >>> Probably nobody thought about this properly in the Linux drivers.
> The
> >>> ARMv8 ARM sounds correct here.
> >>>
> >>> I/O space may have the same issue, as it also requires non-posted
> >>> accesses.
> >>
> >> Right, so our HW team's recommendation - from ARM's memory model and
> >> also PCIe order model - is that not only config space but also PCIe
> >> memory mapped IO has the same attribute (nE).
> >
> > Just to be sure we are talking about the same thing: "PCIe memory
> > mapped IO" could refer to either PCI I/O space or PCI memory space.
> >
> > As far as I can tell, PCI memory space should *not* be using the nE
> > attribute, while PCI I/O space and PCI config space should.
> > Does this match what your HW team recomments?
> >
> 
> Yes, right, the config and IO space recommendation is nE and memory
> space is E.
> 
> In response to Will:
>  > What's the rationale behind that recommendation?
> 
> As Arnd said, the reasoning is that one access type is non-posted
> (config and IO) and the other (memory) is posted writes.

I think that the problem here is that if the CPU writes data to ECAM
or IO space mapped using the E attribute, the ack will come back to the
CPU before the data has actually been written to the EP. So effectively
doing so I think that we break the PCIe specs... 

Cheers

Gab

> 
> Thanks,
> John
> 
> > 	Arnd
> >
> > .
> >
> 
