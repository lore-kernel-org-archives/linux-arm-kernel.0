From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 May 2014 16:59:31 +0200
Subject: [PATCHv4 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
 deadlock
Message-ID: <1400165974-9059-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Will, Catalin,

This patch series adresses a problem that affects the newer Marvell
Armada 375 and 38x SOCs, based on Cortex-A9+PL310, combined with the
Marvell PCIe hardware unit. When the hardware I/O coherency is
enabled, the combination of Cortex-A9/PL310/Marvell PCIe hardware unit
will quickly cause a deadlock when the PCIe bus is stressed.

The workaround for this problem has been suggested by ARM, and
consists in two things:

 (1) Map the PCIe regions as strongly-ordered

 (2) Disable the outer cache sync of the PL310 when hardware I/O
     coherency is used, since it is unneeded and causes the deadlock.

The following three patches address the problem in the following way:

 * PATCH 1/3 switches the PCI I/O mappings to always be mapped
   MT_UNCACHED instead of MT_DEVICE. As Arnd Bergmann said: "The PCI
   I/O space semantics require non-posted writes, which is the main
   difference between device and strongly-ordered mappings". This
   patch should be routed through Russell's tree.

 * PATCH 2/3 extends the l2x0 cache driver with a new property
   "arm,io-coherent", valid for the PL310, which makes the driver
   disable the outer cache sync operation. This patch should be routed
   through Russell's tree.

 * PATCH 3/3 actually implements the Armada 375/38x workaround, by
   using MT_UNCACHED for PCI memory mappings, and adding the
   "arm,io-coherent" property to the cache controller Device Tree node
   when appropriate (i.e, when hardware I/O coherency is
   enabled). This patch has no build dependency on the two previous
   patches. It should be routed through the mvebu maintainers tree.

Changes since v3:

 - Withdrawn all Acked-by tags since the changes compared to v3 are
   quite significant.

 - Instead of introducing a small mechanism to allow each
   sub-architecture to override the memory type used for PCI I/O
   mappings, simply make all of them mapped MT_UNCACHED instead of
   MT_DEVICE, as suggested by Arnd Bergmann. This also has the nice
   consequence that there is no longer a build dependency between
   PATCH 3/3 and PATCH 1/3. Suggested by Arnd Bergmann.

 - Change the name of the new property of the PL310 DT binding from
   the too generic 'dma-coherent' to 'arm,io-coherent'. Suggested by
   Rob Herring.

 - Instead of adding a complete set of L2 cache operations in
   cache-l2x0.c, simply nullify the outer_cache.sync operation when
   'arm,io-coherent' is specified. Suggested by Rob Herring.

 - Move the Armada 375/38x specific code from mach-mvebu/board-v7.c to
   mach-mvebu/coherency.c, which makes more sense. Suggested by Arnd
   Bergmann.

Changes since v2:

 - Added Acked-by from Catalin on "ARM: mm: allow sub-architectures to
   override PCI I/O memory type".

 - Dropped the patch fixing the of_update_property() function, since
   we're no longer using it.

 - Instead of using a different compatible string to identify PL310
   used in an I/O coherent configuration, use a separate boolean
   property. Suggested by Catalin.

 - Rework the mach-mvebu/coherency.c to add the boolean property
   "dma-coherent" when needed instead of updating the compatible
   string of the cache controller.

Changes since v1:

 - Instead of introducing separate l2x0 initialization functions, rely
   on a separate compatible string to identify whether we're coherent
   or not. The compatible string *has* to be modified at runtime,
   because Armada 375 and 38x are only I/O coherent when in SMP
   mode. In non-SMP mode, they are not I/O coherent, so we cannot
   change the DT to 'arm,pl310-coherent-cache'.

 - Addition of the drivers/of fix to be able to use
   of_update_property() early and fix up the PL310 compatible string,
   as explained in the previous item.

Thanks!

Thomas

Thomas Petazzoni (3):
  ARM: mm: use MT_UNCACHED as the memory type for PCI I/O mappings
  ARM: mm: add support for HW coherent systems in PL310
  ARM: mvebu: implement L2/PCIe deadlock workaround

 Documentation/devicetree/bindings/arm/l2cc.txt |  3 ++
 arch/arm/mach-mvebu/coherency.c                | 39 ++++++++++++++++++++++++++
 arch/arm/mm/cache-l2x0.c                       | 14 +++++++++
 arch/arm/mm/ioremap.c                          |  2 +-
 4 files changed, 57 insertions(+), 1 deletion(-)

-- 
1.9.3
