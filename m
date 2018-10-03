From: leedom@chelsio.com (Casey Leedom)
Date: Wed, 3 Oct 2018 18:36:14 +0000
Subject: How is the Linux kernel API dma_alloc_coherent() typically
 implemented for the ARM Architecture?
In-Reply-To: <866a698a-aa61-6c48-0258-f2dd97973e87@arm.com>
References: <BYAPR12MB2791F73EC1033F998FF533BAC8E90@BYAPR12MB2791.namprd12.prod.outlook.com>,
 <866a698a-aa61-6c48-0258-f2dd97973e87@arm.com>
Message-ID: <BYAPR12MB2791A35A45209A6D3D448A87C8E90@BYAPR12MB2791.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[[ Sorry if there's a duplicate: the mailing list complained about HTML email. ]]

  Thanks Robin and Russell!

| From: Russell King - ARM Linux <linux@armlinux.org.uk>
| Sent: Wednesday, October 3, 2018 11:08 AM
| 
| If you are writing at the level where you need to know exactly how coherent
| memory is implemented, then you're doing it wrong - and your driver will
| never be reliable.  You will be writing it based upon implementation
| semantics, rather than the API definition.

  Ah, sorry, no, that's not what's happening.  Our current software uses all
of the appropriate Linux kernel APIs for all of this.  I am asking because
I'm trying to offer advice to a Hardware Team which has been tasked with
adding an embedded ARM Cluster to an existing chip.  The Hardware Team
wanted to know whether they needed to extend the ARM's CPU Coherency Domain
to include DMA I/O from a different portion of the chip (it's sort of
emulated PCIe DMA).  My initial response was "no" because I had thought that
ARM systems were, in general, not I/O coherent.  (Though I've seen cases
where tightly coupled co-processors like Graphics Engines are made to be
coherent in the CPU Coherency Domain.)

  That was all fine until someone dragged my attention over to the Linux
kernel API dma_alloc_coherent() which in fact we do use for our TX/RX
"Descriptor Rings".  Before I signed off on my recommendation to the
Hardware Team I wanted to make sure I wasn't blowing smoke out my ... er, I
wasn't directing them incorrectly ... :-)

| Also note that there is no dma_map_coherent() API, and "direction" is not
| relevant for memory which is inherently coherent.

  The reason that I thought that there might be a need for a "direction" in
the dma_map_coherent() API is because RX and TX Descriptor Rings might
benefit under some Architectural Implementations from different
treatments/mappings.  For instance, for RX Rings, UNCACHED is the right
answer.  But for TX Rings where a Write Combining Buffer is implemented, an
UNCACHED/WRITE-COMBINING mapping might be best.

Casey
