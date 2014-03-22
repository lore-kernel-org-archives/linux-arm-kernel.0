From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 23 Mar 2014 00:44:09 +0100
Subject: IXP4xx fixes
Message-ID: <m3siq9iyt2.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm attaching 3 IXP4xx fixes:

1. Fix Goramo Multilink GPIO conversion (regression in v3.13)
   This platform is not included by default and it seems it escaped
   testing when the GPIO was converted.

   I've noticed a patch fixing the same problem from Arnd Bergmann,
   however the other IXP4xx platforms now use the GPIO API and
   I think this single platform shouldn't be an exception.

2. Fix DMA masks (regression in v3.7)
   This patch makes IXP4xx conform to the DMA API. Newly created devices
   will have 32-bit DMA and coherent DMA masks (effectively 28-bit for
   PCI devices). dma_set_coherent_mask() will now really set the mask,
   not only test for its validity as it used to.

   A subsequent cosmetic patch for specific devices (e.g. built-in
   Ethernet and sync serial) setting DMA and coherent DMA masks may be
   needed, however it won't have any effect on the regression. Simply
   speaking, it's the core IXP4xx code that is broken (since the
   beginning I think), and it's where the fix must go.

3. Fix DMA-bounce code to allow sync from_device and to_device with
   bidirectional mappings.

   This is an issue on (probably) E100 Ethernet only. A known problem
   but few people ever cared. Fixed on X86 long ago.

   BTW this passes cleanly through DMA API debug. And it obviously
   works correctly.

This stuff is tested on Goramo Multilink and on Gateworks Cambria with
both on-chip and PCI DMA-able devices.
-- 
Krzysztof Halasa
