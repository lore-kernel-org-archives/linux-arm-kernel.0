From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 04 Feb 2014 13:09:28 +0100
Subject: [PATCH v2 0/5] reserved-memory regions/CMA in devicetree, again
Message-ID: <1391515773-6112-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all!

This is an updated version of the second attempt to add basic support
for dynamic allocation of memory reserved regions defined in device
tree.

The initial code for this feature were posted here [1], merged as commit
9d8eab7af79cb4ce2de5de39f82c455b1f796963 ("drivers: of: add
initialization code for dma reserved memory") and later reverted by
commit 1931ee143b0ab72924944bc06e363d837ba05063. For more information,
see [2]. Finally a new bindings has been proposed [3] and Josh
Cartwright a few days ago prepared some code which implements those
bindings [4]. This finally pushed me again to find some time to finish
this task and review the code. Josh agreed to give me the ownership of
this series to continue preparing them for mainline inclusion.

For more information please refer to the changlelog below.

[1]: http://lkml.kernel.org/g/1377527959-5080-1-git-send-email-m.szyprowski at samsung.com
[2]: http://lkml.kernel.org/g/1381476448-14548-1-git-send-email-m.szyprowski at samsung.com
[3]: http://lkml.kernel.org/g/20131030134702.19B57C402A0 at trevor.secretlab.ca
[4]: http://thread.gmane.org/gmane.linux.documentation/19579

Changelog:

v2:
- removed copying of the node name
- split shared-dma-pool handling into separate files (one for CMA and one
  for dma_declare_coherent based implementations) for making the code easier
  to understand
- added support for AMBA devices, changed prototypes to use struct decice
  instead of struct platform_device
- renamed some functions to better match other names used in drivers/of/
- restructured the rest of the code a bit for better readability
- added 'reusable' property to exmaple linux,cma node in documentation
- exclusive dma (dma_coherent) is used for only handling 'shared-dma-pool'
  regions without 'reusable' property and CMA is used only for handling
  'shared-dma-pool' regions with 'reusable' property.

v1: http://thread.gmane.org/gmane.linux.documentation/19579
- initial version prepared by Josh Cartwright

Summary:

Grant Likely (1):
  of: document bindings for reserved-memory nodes

Josh Cartwright (2):
  drivers: of: implement reserved-memory handling for dma
  drivers: of: implement reserved-memory handling for cma

Marek Szyprowski (2):
  drivers: of: add initialization code for reserved memory
  ARM: init: add support for reserved memory defined by device tree

 .../bindings/reserved-memory/reserved-memory.txt   |  138 ++++++++++++
 arch/arm/mm/init.c                                 |    3 +
 drivers/of/Kconfig                                 |   20 ++
 drivers/of/Makefile                                |    3 +
 drivers/of/of_reserved_mem.c                       |  219 ++++++++++++++++++++
 drivers/of/of_reserved_mem_cma.c                   |   75 +++++++
 drivers/of/of_reserved_mem_dma.c                   |   78 +++++++
 drivers/of/platform.c                              |    7 +
 include/asm-generic/vmlinux.lds.h                  |   11 +
 include/linux/of_reserved_mem.h                    |   62 ++++++
 10 files changed, 616 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
 create mode 100644 drivers/of/of_reserved_mem.c
 create mode 100644 drivers/of/of_reserved_mem_cma.c
 create mode 100644 drivers/of/of_reserved_mem_dma.c
 create mode 100644 include/linux/of_reserved_mem.h

-- 
1.7.9.5
