From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Oct 2016 16:44:06 +0200
Subject: [PATCH] Documentation: DMA-API: Clarify semantics of
 dma_set_mask_and_coherent
In-Reply-To: <20161021150916.0d274e9f@lwn.net>
References: <20161017152623.7649-1-punit.agrawal@arm.com>
 <20161021150916.0d274e9f@lwn.net>
Message-ID: <41835351.zyFxfDAMp5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 21, 2016 3:09:16 PM CEST Jonathan Corbet wrote:
> On Mon, 17 Oct 2016 16:26:23 +0100
> Punit Agrawal <punit.agrawal@arm.com> wrote:
> 
> > The dma mapping api howto gives the impression that using the
> > dma_set_mask_and_coherent (and related DMA APIs) will cause the kernel
> > to check all the components in the path from the device to memory for
> > addressing restrictions. In systems with address translations between
> > the device and memory (e.g., when using IOMMU), this implies that a
> > successful call to set set dma mask has checked the addressing
> > constraints of the intermediaries as well.
> > 
> > For the IOMMU drivers in the tree, the check is actually performed while
> > allocating the DMA buffer rather than when the DMA mask is
> > configured. For MMUs that do not support the full device addressing
> > capability, the allocations are made from a reduced address space.
> > 
> > Update the documentation to clarify that even though the call to
> > dma_set_mask_and_coherent succeeds, it may not be possible to use the
> > full addressing capability of the device.
> 
> OK, so I guess I can buy this.  But...
> 
> > Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > ---
> >  Documentation/DMA-API-HOWTO.txt | 39 +++++++++++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 16 deletions(-)
> > 
> > diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
> > index 979228b..240d1ee 100644
> > --- a/Documentation/DMA-API-HOWTO.txt
> > +++ b/Documentation/DMA-API-HOWTO.txt
> > @@ -159,39 +159,46 @@ support 64-bit addressing (DAC) for all transactions.  And at least
> >  one platform (SGI SN2) requires 64-bit consistent allocations to
> >  operate correctly when the IO bus is in PCI-X mode.
> >  
> > -For correct operation, you must interrogate the kernel in your device
> > -probe routine to see if the DMA controller on the machine can properly
> > -support the DMA addressing limitation your device has.  It is good
> > +For correct operation, you must inform the kernel in your device probe
> > +routine to see if the DMA controller on the machine can properly
> > +support the DMA addressing capabilities your device has.  It is good
> 
> Here it's still saying "to see if the DMA controller on the machine can
> properly support the DMA addressing capabilities your device has".  So
> you've not really changed the sense of this sentence here.
> 
> If I understand things correctly, the calls in question are storing the
> device's limitations; they will only fail if the kernel is entirely
> unable to work within the indicated range, right?  I don't think there's
> ever been any guarantee that the system as a whole could use the entire
> range that is addressable by the device.  I have no objection to making
> that more clear, but let's actually make it more clear by saying what the
> functions are actually doing.
> 
> Make sense, or am I missing something here?

The call is a two-way interface, and the existing text tries to convey
that already: The device tells the kernel whether it is limited (< 32
bit mask) or if it can support extended addresses (> 32 bit mask),
or just handles the default 32bit mask, and the kernel should come
back saying whether that mask allows a correct operation of the device
on the given platform, as well as set it up correctly that way.

What exactly happens in dma_set_mask() and the related interfaces
is highly platform specific, including:

- if the mask is smaller than the smallest memory zone and the
  swiotlb bounce buffers (if any) don't fit inside it, it has to
  fail

- if the device claims to support larger mask, but the bus it
  connects to does not (e.g. a 32-bit PCI host), it may
  also fail (or succeed if there is no RAM outside of the
  intersection of the two masks)

- if the mask is large enough to cover all RAM, we can bypass
  the IOMMU and use a direct mapping

- if swiotlb is enabled or an IOMMU is present, any mask that
  includes the bounce buffer area (or the virtual address space
  of the IOMMU) should succeed.

	Arnd
