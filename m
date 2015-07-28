From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Jul 2015 15:41:33 +0100
Subject: [PATCH] arm64: pci: add support for pci_mmap_page_range
In-Reply-To: <20150728140347.GA9934@localhost.localdomain>
References: <1437717263-11979-1-git-send-email-jerin.jacob@caviumnetworks.com>
 <20150724144103.GC12569@arm.com>
 <20150727051025.GA5310@localhost.localdomain>
 <20150728112057.GI29209@arm.com>
 <20150728140347.GA9934@localhost.localdomain>
Message-ID: <20150728144132.GN29209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 03:03:52PM +0100, Jerin Jacob wrote:
> On Tue, Jul 28, 2015 at 12:20:57PM +0100, Will Deacon wrote:
> > On Mon, Jul 27, 2015 at 06:10:29AM +0100, Jerin Jacob wrote:
> > > On Fri, Jul 24, 2015 at 03:41:03PM +0100, Will Deacon wrote:
> > > > So pci_iomap_range chooses the memory attributes based on the BAR flags
> > > > (and even then it looks weird -- CACHEABLE => ioremap, else ioremap_nocache,
> > > > which is just the same as ioremap on arm64).
> > > > 
> > > > It would be good to understand (a) why this is different and (b) what
> > > 
> > > AFAIU, pci_iomap_range is the generic implementation and chooses to
> > > use only minimal attributes that works on all the architectures.
> > > The primary consumer of pci_iomap_range is virtio_pci driver,Which
> > > doesn't care about HW PCI memory attributes like Prefetchable.
> > 
> > pci_iomap calls pci_iomap_range.
> 
> Yes, I missed that.
> 
> > 
> > > > the consistent set of attributes should be.
> > > 
> > > PCI perspective, memory attributes are Prefetchable and non-Prefetchable
> > > for a given BAR.
> > > 
> > > Former one does have read side-effects or supports write
> > > merging(typically used
> > > by graphics memory) and latter one has read side effects and does not
> > > support write merging(typically used by register files)
> > > 
> > > IMO, In armv8 nomenclature, MT_NORMAL_NC and MT_DEVICE_nGnRnE map
> > > correctly to above PCI memory attribute definitions.
> > 
> > I agree with your choice of memory types (well, almost. We probably don't
> > need the nE), I'm just after some consistency within the kernel, because
> 
> I thought so, However, Since PCIe deals with off-chip peripherals,
> IMO it should be MT_DEVICE_nGnRnE(strongly ordered).
> Early write acknowledgment may have side effect based on the topology.
> (connected under Bridge etc).
> IMO, It make sense to mark as nGnRE for on-chip peripherals. But
> If you still think we need to mark as nGnRE then I can submit v2 with
> nGnRE else IMO, currect patch is fine for pci_mmap_page_range

It's the inconsistencies that I've pointed out previously that bother
me the most. I don't really care what attributes we use, as long as
there's a common way to translate a given BAR to a given MT_*.

Will
