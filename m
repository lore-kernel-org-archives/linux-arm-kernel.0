From: albert_herranz@yahoo.es (Albert Herranz)
Date: Sun, 28 Feb 2010 15:07:53 +0100
Subject: [RFC PATCH v2 0/9] wii: add usb 2.0 support
Message-ID: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series adds USB 2.0 support for the Wii PowerPC
platform via the EHCI controller present in the "Hollywood" chipset
of the video game console.

v1 -> v2
- enable per-device DMA coherent support on the Wii
- add a generic dmabounce based on ARM dmabounce
- make PowerPC and ARM use the generic dmabounce support
  (ARM just compile-tested)
- do not bounce buffers at the USB layer
- handle bounce buffers on the Wii at the platform support layer via the
  DMA API
- introduce a flag HCD_NO_COHERENT_MEM to avoid using coherent memory for
  USB buffers
- make the "Hollywood" EHCI controller use HCD_NO_COHERENT_MEM and honor
  MEM2 DMA constraints to solve the platform restrictions accessing
  coherent memory.

Albert Herranz (9):
  powerpc: add per-device dma coherent support
  wii: have generic dma coherent
  dma-coherent: fix bitmap access races
  add generic dmabounce support
  arm: use generic dmabounce support
  powerpc: add optional per-device dmabounce support
  wii: add mem2 dma mapping ops
  USB: add HCD_NO_COHERENT_MEM host controller driver flag
  wii: hollywood ehci controller support

 arch/Kconfig                                 |    3 +
 arch/arm/Kconfig                             |    4 +-
 arch/arm/common/Kconfig                      |    6 +-
 arch/arm/common/dmabounce.c                  |  376 +++--------------
 arch/arm/include/asm/device.h                |    2 +-
 arch/powerpc/boot/wii.c                      |   34 ++
 arch/powerpc/include/asm/device.h            |    3 +
 arch/powerpc/include/asm/dma-mapping.h       |    1 +
 arch/powerpc/include/asm/wii.h               |   25 ++
 arch/powerpc/kernel/dma.c                    |    5 +
 arch/powerpc/platforms/embedded6xx/Kconfig   |    3 +
 arch/powerpc/platforms/embedded6xx/Makefile  |    2 +-
 arch/powerpc/platforms/embedded6xx/wii-dma.c |  557 ++++++++++++++++++++++++++
 drivers/base/dma-coherent.c                  |   11 +
 drivers/usb/core/buffer.c                    |   15 +-
 drivers/usb/core/hcd.c                       |   50 ++-
 drivers/usb/core/hcd.h                       |   13 +-
 drivers/usb/host/Kconfig                     |    8 +
 drivers/usb/host/ehci-hcd.c                  |    5 +
 drivers/usb/host/ehci-hlwd.c                 |  233 +++++++++++
 drivers/usb/host/ehci.h                      |   23 +
 include/linux/dmabounce.h                    |   71 ++++
 lib/Kconfig                                  |   10 +
 lib/Makefile                                 |    2 +
 lib/dmabounce.c                              |  389 ++++++++++++++++++
 25 files changed, 1512 insertions(+), 339 deletions(-)
 create mode 100644 arch/powerpc/include/asm/wii.h
 create mode 100755 arch/powerpc/platforms/embedded6xx/wii-dma.c
 create mode 100644 drivers/usb/host/ehci-hlwd.c
 create mode 100644 include/linux/dmabounce.h
 create mode 100644 lib/dmabounce.c
