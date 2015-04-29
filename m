From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Apr 2015 14:54:27 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <5540D421.2020502@topic.nl>
References: <5538DD02.6050401@topic.nl> <45324330.YETo6pO2cB@wuerfel>
 <5540D421.2020502@topic.nl>
Message-ID: <2173396.gGMeX7Q3cp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015 14:52:49 Mike Looijmans wrote:
> On 29-04-15 14:35, Arnd Bergmann wrote:
> > On Wednesday 29 April 2015 13:09:05 Mike Looijmans wrote:
> >> On 29-04-15 12:07, Arnd Bergmann wrote:
> >>> On Wednesday 29 April 2015 11:47:37 Mike Looijmans wrote:
> >>>> I currently use dma_alloc_coherent() to allocate buffers and
> >>>> dma_mmap_coherent() to map them to user space. I was under the assumption that
> >>>> these would do the right thing. Is that correct? If not, then what should I use?
> >>>
> >>> dma_mmap_coherent() is the right interface, but I've just looked at the
> >>> implementation of arm_dma_mmap() and I'm not sure that it actually uses the
> >>> correct vma->vm_page_prot value here, because I don't see where it takes
> >>> into account whether the device is coherent or not. Most ARM machines have
> >>> only noncoherent devices, and dma_mmap_coherent() is used rarely by drivers,
> >>> so it's quite possible that this interface got broken without anybody
> >>> noticing.
> >>
> >> My driver also supports 'classic' read/write by copying data to/from userspace
> >> using a DMA ringbuffer, which is also allocated using dma_alloc_coherent. That
> >> would suggest that the kernel mapping for this memory is also incorrect, I
> >> also get corrupted data in these transfers. These buffers are not being mapped
> >> to userspace at all. These tests all use page aligned transfer sizes.
> >
> > Ok, if it's broken when you only use a kernel mapping and no user space
> > mapping, arm_dma_mmap() is not your (only) problem, but we should probably
> > still fix that if it's broken.
> 
> The only difference in arm_coherent_dma_alloc() and arm_dma_alloc() is that 
> the former passes a "true" to __dma_alloc(). That looks prettry suspicious, 
> I'd at least expect different "prot" values.
> 
> 

No, if coherent=true is passed as the argument, the prot value is not used.

If we had this part wrong, we would notice very quickly.

	Arnd
