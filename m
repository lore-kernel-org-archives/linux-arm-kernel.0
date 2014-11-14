From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 14 Nov 2014 11:52:01 +0100
Subject: [PATCH v4 0/6] Xilinx Zynq OCM support
Message-ID: <cover.1415962281.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is the next attepmt to add support for On Chip Memory
configuration via On Chip Memory Controller.
OCM can be divided into 4 independend blocks and placed to
two locations which this driver detects.

For everybody on-chip SRAM driver "mmio-sram"
is missing parity IRQ handling not sure how to write
in generic way and also the memory layout
can be changed at run time (not currently supported by this driver)

smp-sram trampoline allocation can be used from mmio-sram
and size allocated via DT but currently no reason for using
it.

Creating mmio-sram node with setting at run time based on current setting
is possible but it won't look good.
One way how to do it is here
"ARM: mvebu: Add quirk for i2c for the OpenBlocks AX3-4 board"
(sha1: 85e618a1be2b2092318178d1d66bdad49cbbeeeb)
but creating nodes at run-time or changing compact strings
will be just more hacky code.

Using device-tree overlays is another option but SMP
trampoline code is placed there and it will be used by PM code
that's why driver should be there before user-space.

Next option is to create driver which just create platform device
at run-time. This is doable but I expect sram driver has to be
updated.

Thanks,
Michal


Changes in v4:
- New patch in this series
- New patch in this series
- Move only slcr.h and smp.h and keep common.h in platform
  which is not needed by OCMC driver
  Based on Arnd request: https://lkml.org/lkml/2014/10/20/268
  Not all symbols from slcr.h/smp.h will be used by OCMC driver
  - no problem to remove them if it is needed
- Add record to MAINTAINERS file
- slcr.h has moved to soc/include/ folder. Move definition there too.
- Use }; instead of } ; in doc
- Use memory-controller at ... instead of ocmc at ...
- Create Kconfig entry for OCMC driver - enable GENERIC_ALLOCATOR here
- Add entry to MAINTAINERS file
- Use memory-controller at ... instead of ocmc at ...

Changes in v3:
- Move OCM to drivers/soc
- Update year
- Extract DTS node to be able to apply it out of driver
- Remove generic allocator enabling
- Extract SLCR part
- Use const in of_device_id
- OCM->OCMC
- Use ocmc-1.0 compatible string
- Extract from OCM driver

Changes in v2:
- Update pm.c added in 3.17 too - Soren pointed on it
- Change compatibility string to be in xilinx format
- Fix kernel-doc format

Michal Simek (6):
  ARM: zynq: Extract smp related functions out of common.h
  ARM: zynq: Extract slcr related functions out of common.h
  ARM: zynq: Move slcr.h and smp.h to generic location
  ARM: zynq: Extend SLCR driver to read OCM configuration
  ARM: zynq: Add OCM controller driver
  ARM: zynq: DT: Add OCM controller node

 .../bindings/arm/zynq/xlnx,zynq-ocmc.txt           |  17 ++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/zynq-7000.dtsi                   |   7 +
 arch/arm/mach-zynq/common.c                        |   2 +
 arch/arm/mach-zynq/common.h                        |  19 --
 arch/arm/mach-zynq/platsmp.c                       |   3 +
 arch/arm/mach-zynq/slcr.c                          |  17 ++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/zynq/Kconfig                           |  13 ++
 drivers/soc/zynq/Makefile                          |   1 +
 drivers/soc/zynq/zynq_ocmc.c                       | 247 +++++++++++++++++++++
 include/soc/zynq/slcr.h                            |  30 +++
 include/soc/zynq/smp.h                             |  30 +++
 14 files changed, 371 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocmc.txt
 create mode 100644 drivers/soc/zynq/Kconfig
 create mode 100644 drivers/soc/zynq/Makefile
 create mode 100644 drivers/soc/zynq/zynq_ocmc.c
 create mode 100644 include/soc/zynq/slcr.h
 create mode 100644 include/soc/zynq/smp.h

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/8d52f967/attachment-0001.sig>
