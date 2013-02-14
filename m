From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Feb 2013 13:45:26 +0100
Subject: [PATCH 0/2] Device Tree support for CMA (Contiguous Memory Allocator)
Message-ID: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is my initial proposal for device tree integration for Contiguous
Memory Allocator. The code is quite straightforward, however I expect
that the memory bindings require some discussion.

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

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (2):
  drivers: dma-contiguous: clean source code and prepare for device
    tree
  drivers: dma-contiguous: add initialization from device tree

 Documentation/devicetree/bindings/memory.txt |  101 ++++++++++
 arch/arm/boot/dts/skeleton.dtsi              |    7 +-
 drivers/base/dma-contiguous.c                |  278 +++++++++++++++++++-------
 include/asm-generic/dma-contiguous.h         |    4 +-
 include/linux/dma-contiguous.h               |   32 ++-
 5 files changed, 338 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory.txt

-- 
1.7.9.5
