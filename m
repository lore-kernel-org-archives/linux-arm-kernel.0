From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 26 Aug 2013 16:39:15 +0200
Subject: [PATCH v7 0/4] Device Tree support for CMA (Contiguous Memory
 Allocator)
Message-ID: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I thought that v6 series is really ready for merging, but I found today
a stupid bug which broke compilation when CONFIG_CMA was not enabled, so
another respin is needed. I've also took the opportunity and fixed
some minor issues in the documentation (renamed all nodes to 'region')
and rebased the patches onto Aneesh Kumar K.V patch queued earlier for
merging.

For more information, please refer to the V6 patches thread:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/261518

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Changelog:

v7:
- fixed compilation break when CMA support has been disabled
- rebased onto Aneesh Kumar K.V CMA patches queued earlier for merging
- more cleanups in the binding documentation (thanks to Stephen Warren)

v6: http://thread.gmane.org/gmane.linux.ports.arm.kernel/261518
- added support for 'status' property, so memory regions can be disabled
  like any other nodes
- fixed issues pointed by Rob: removed annotations from function
  declarations and replaced macros with static inline functions.
- restored of_scan_flat_dt_by_path() function to simplify reserved memory
  scanning function
- the code now uses #size-cells/#address-cells properties from root node
  for interpreting 'reg' property in reserved memory regions
- fixed some issues in dt binding documentation

v5: http://thread.gmane.org/gmane.linux.ports.arm.kernel/259278
- renamed "contiguous-memory-region" compatibility string to
  "linux,contiguous-memory-region" (this one is really specific to Linux
  kernel implementation)
- renamed "dma-memory-region" property to "memory-region" (suggested by 
  Kumar Gala)
- added support for #address-cells, #size-cells for memory regions
  (thanks to Rob Herring for suggestion)
- removed generic code to scan specific path in flat device tree (cannot
  be used to fdt one-pass scan based initialization of memory regions with
  #address-cells and #size-cells parsing)
- replaced dma_contiguous_set_default_area() and dma_contiguous_add_device()
  functions with dev_set_cma_area() call

v4: http://thread.gmane.org/gmane.linux.ports.arm.kernel/256491
- corrected Devcie Tree mailing list address (resend)
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

 Documentation/devicetree/bindings/memory.txt |  168 +++++++++++++++++++++++++
 arch/arm/include/asm/dma-contiguous.h        |    1 -
 arch/arm/mm/init.c                           |    3 +
 arch/x86/include/asm/dma-contiguous.h        |    1 -
 drivers/base/dma-contiguous.c                |  119 +++++++-----------
 drivers/of/Kconfig                           |    6 +
 drivers/of/Makefile                          |    1 +
 drivers/of/fdt.c                             |   76 +++++++++++
 drivers/of/of_reserved_mem.c                 |  175 ++++++++++++++++++++++++++
 drivers/of/platform.c                        |    4 +
 include/asm-generic/dma-contiguous.h         |   28 -----
 include/linux/device.h                       |    2 +-
 include/linux/dma-contiguous.h               |   62 ++++++++-
 include/linux/of_fdt.h                       |    3 +
 include/linux/of_reserved_mem.h              |   14 +++
 15 files changed, 555 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory.txt
 create mode 100644 drivers/of/of_reserved_mem.c
 delete mode 100644 include/asm-generic/dma-contiguous.h
 create mode 100644 include/linux/of_reserved_mem.h

-- 
1.7.9.5
