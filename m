From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 26 Jun 2013 15:40:07 +0200
Subject: [PATCH v3 0/2] Device Tree support for CMA (Contiguous Memory
 Allocator)
Message-ID: <1372254009-25307-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a third version of my proposal for device tree integration for
Contiguous Memory Allocator. Over 2 month has passed from the time I've
posted the second version, but now some things about using /chosen
device tree node has been clarified, so I expect to get this code merged
soon this time.

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

However we also need to pass somehow the information about kernel and
device driver software-only configuration data, which were earlier
encoded in the board file. For such data I decided to use /chosen node,
where kernel command line has been already stored. Future bootloaders
will allow to modify or replace particular nodes and one will be able to
use custom /chosen node to configure his system. The proposed patches
introduce /chosen/contiguous-memory node and related bindings, to avoid
complicated encoding of CMA related configuration to kernel command
line.

Some rationale for using /chosen/ node for kernel configuration entities
has been already suggested by Grant Likely in the following thread:
http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/155296/focus=34363

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Changelog:

v3:
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

Marek Szyprowski (2):
  drivers: dma-contiguous: clean source code and prepare for device
    tree
  drivers: dma-contiguous: add initialization from device tree

 .../devicetree/bindings/contiguous-memory.txt      |   94 ++++++
 arch/arm/boot/dts/skeleton.dtsi                    |    7 +-
 drivers/base/dma-contiguous.c                      |  325 +++++++++++++-------
 include/asm-generic/dma-contiguous.h               |    2 -
 include/linux/dma-contiguous.h                     |   32 +-
 5 files changed, 352 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/contiguous-memory.txt

-- 
1.7.9.5
