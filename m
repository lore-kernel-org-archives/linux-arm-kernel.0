From: slash.tmp@free.fr (Mason)
Date: Sat, 4 Mar 2017 15:33:47 +0100
Subject: Using the generic host PCIe driver
In-Reply-To: <CAKv+Gu_SG9ynmBKCpQyLgVcU2_cxWoHHeoyAhxN+cKQuR+su3Q@mail.gmail.com>
References: <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
 <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
 <98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr>
 <20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
 <258cd6f3-ef17-6705-ff48-ae06f26778c2@free.fr>
 <20170303154628.GA21522@bhelgaas-glaptop.roam.corp.google.com>
 <8e1a0b5d-8dfb-4be1-a049-b16892a6c0d0@free.fr>
 <20170303200407.GB30375@bhelgaas-glaptop.roam.corp.google.com>
 <5c899946-4220-a63e-fe98-6a103200c2ad@free.fr>
 <CAKv+Gu-QxUYZcg4DPwuhhfqKCp4eJEWXCh43ZyvDe12=exEhWw@mail.gmail.com>
 <8daa1f79-8fda-bef9-e216-3c15f53c4f32@free.fr>
 <CAKv+Gu_fLKvruKy2Aoa95ThPAJ2XDJVUCjeuAWaRwpifsn_A_w@mail.gmail.com>
 <c6d21078-b2f0-8dd3-adf7-13fc6456c1aa@free.fr>
 <CAKv+Gu_SG9ynmBKCpQyLgVcU2_cxWoHHeoyAhxN+cKQuR+su3Q@mail.gmail.com>
Message-ID: <d239ee02-111c-ea76-ab5f-6907b1db4dc7@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2017 14:49, Ard Biesheuvel wrote:

> On 4 March 2017 at 13:07, Mason wrote:
>
>> My current understanding is that I must find a large area in the memory
>> map where there is NOTHING (no RAM, no registers). Then I can specify
>> this area in the "ranges" prop of my DT node, to be used as a
>> non-prefetchable memory address range.
> 
> 'Finding' a memory area suggests that you could pick a range at random
> and put that in the DT. This is *not* the case.
> 
> The PCIe controller hardware needs to know that it needs to decode
> that range, i.e., it needs to forward memory accesses that hit this
> window. You need to figure out how this is configured on the h/w that
> you are using.

My confusion level is at 11 :-)

I'll sleep on it, then take a fresh look at the PCIe controller
register map. I know there is a way to configure mappings in
the RC BAR0, e.g. the MSI doorbell is in MMIO space, and devices
need to write there to request an interrupt. But I thought all
the range stuff was configured at run-time by the PCI framework
itself, using standard registers.

I still need to investigate "I/O and prefetchable mem behind bridge",
as pointed out by Bjorn.

>>> The DT node that describes the host bridge should simply describe
>>> which MMIO regions are used by the device. This is no different from
>>> any other MMO peripheral.
>>
>> In my limited experience, the DT node for PCI is, by far, the most
>> complex node I've had to write.
> 
> Yes, but that is not the point. My point is that the information you
> put in the DT should reflect *reality* in one way or the other. Every
> value you put there should match the current configuration of the h/w
> IP block.

The HW designers are never sure how SW will use the block,
so they often make everything under the sun SW-configurable.
For example, the RC BAR0 is actually split into 8 "regions"
which can map to arbitrary areas in the physical address space.

So I don't think there is an actual "current configuration of
the h/w IP block".

Regards.
