From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 31 Jul 2013 14:51:55 +0200
Subject: [PATCH v4 0/4] Device Tree support for CMA (Contiguous Memory
 Allocator)
Message-ID: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a fourth version of my proposal for device tree integration for
reserved memory and Contiguous Memory Allocator. After the comments from
Grant Likely I moved back memory region definitions back to /memory node
(as it was in the first version of this proposal). I've also extended
the code and made it more generic, added support for so called reserved
dma memory (special dma memory regions created by dma_alloc_coherent()
function, for exclusive usage for dma allocation for the given device).

Just a few words for those who see this code for the first time:

The proposed bindings allows to define contiguous memory regions of
specified base address and size. Then, the defined regions can be
assigned to the given device(s) by adding a property with a phanle to
the defined contiguous memory region. From the device tree perspective
that's all. Once the bindings are added, all the memory allocations from
dma-mapping subsystem will be served from the defined contiguous memory
regions.

Contiguous Memory Allocator is a framework, which lets to provide a
large contiguous memory buffers for (usually a multimedia) devices. The
contiguous memory is reserved during early boot and then shared with
kernel, which is allowed to allocate it for movable pages. Then, when
device driver requests a contigouous buffer, the framework migrates
movable pages out of contiguous region and gives it to the driver. When
device driver frees the buffer, it is added to kernel memory pool again.
For more information, please refer to commit c64be2bb1c6eb43c838b2c6d57
("drivers: add Contiguous Memory Allocator") and d484864dd96e1830e76895
(CMA merge commit).

Why we need device tree bindings for CMA at all?

Older ARM kernels used so called board-based initialization. Those board
files contained a definition of all hardware blocks available on the
target system and particular kernel and driver software configuration
selected by the board maintainer.

In the new approach the board files will be removed completely and
Device Tree approach is used to describe all hardware blocks available
on the target system. By definition, the bindings should be software
independent, so at least in theory it should be possible to use those
bindings with other operating systems than Linux kernel.

Reserved memory configuration belongs to the grey area. It might depend
on hardware restriction of the board or modules and low-level
configuration done by bootloader. Putting reserved and contiguous memory
regions to /memory node and having phandles to those regions in the
device nodes however matches well with the device-tree typical style of
linking devices with other resources like clocks, interrupts,
regulators, power domains, etc. This is the main reason to use such
approach instead of putting everything to /chosen node as it has been
proposed in v2 and v3.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Changelog:

v4:
- moved back contiguous-memory bindings from /chosen/contiguous-memory
  to /memory nodes as suggested by Grant (see 
  http://article.gmane.org/gmane.linux.drivers.devicetree/41030
  for more details)
- added support for DMA reserved memory with dma_declare_coherent()
- moved code to drivers/of/of_reserved_mem.c
- added generic code to scan specific path in flat device tree

v3: http://thread.gmane.org/gmane.linux.drivers.devicetree/40013/
- fixed issues pointed by Laura and updated documentation

v2: http://thread.gmane.org/gmane.linux.drivers.devicetree/34075
- moved contiguous-memory bindings from /memory to /chosen/contiguous-memory/
  node to avoid spreading Linux specific parameters over the whole device
  tree definitions
- added support for autoconfigured regions (use zero base)
- fixes minor bugs

v1: http://thread.gmane.org/gmane.linux.drivers.devicetree/30111/
- initial proposal

Patch summary:

Marek Szyprowski (4):
  drivers: dma-contiguous: clean source code and prepare for device
    tree
  drivers: of: add function to scan fdt nodes given by path
  drivers: of: add initialization code for dma reserved memory
  ARM: init: add support for reserved memory defined by device tree

 Documentation/devicetree/bindings/memory.txt |  152 ++++++++++++++++++++++
 arch/arm/mm/init.c                           |    3 +
 drivers/base/dma-contiguous.c                |  147 +++++++++++-----------
 drivers/of/Kconfig                           |    6 +
 drivers/of/Makefile                          |    1 +
 drivers/of/fdt.c                             |   76 +++++++++++
 drivers/of/of_reserved_mem.c                 |  175 ++++++++++++++++++++++++++
 include/asm-generic/dma-coherent.h           |    6 +
 include/asm-generic/dma-contiguous.h         |    2 -
 include/linux/dma-contiguous.h               |   49 +++++++-
 include/linux/of_fdt.h                       |    3 +
 11 files changed, 541 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory.txt
 create mode 100644 drivers/of/of_reserved_mem.c

-- 
1.7.9.5
