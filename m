From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 31 Aug 2016 16:14:05 +0300
Subject: [PATCH v3 0/8] drm/tilcdc: Address LCDC rev 2 color errata + other
 fixes
Message-ID: <cover.1472634657.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
- Fiddle with color wiring propety once more, now it follows this Tomi's
  comment:
  - No property set: driver advertises RG16 and RG24. This is
    wrong, but that's what the current status is, right?
  - Property set to "default" or "straight" or whatever: driver
    says RG16 and BG24
  - Property set to "crossed": driver says BG16 and RG24
- Add v2 version of "drm/tilcdc: Write DMA base and ceiling address with..."
  - The first version was sent individually, this second version has
    __iowmb(); and __cpu_to_le64(); added to tilcdc_write64()

Changes since v1:
- Change the blue-and-red-wiring property to boolean blue-and-red-crossed
  - This breaks to little backward compatibility the earlier series had, but
    makes the binding more straight forward
  - This changes requires changes to am335x-evm and am335x-evmsk dts-files
  - The old beaglebone-black dts files remain compatible, but the patch
    suggests in commenst on how to support 24-bit RGB mode with BBB

The first patch ("drm/tilcdc: Remove drm_helper_disable_unused_functions()
call") is completely independent fix.

The red and blue components are reversed between 24 and 16 bit modes
on am335x LCDC output pins. To get 24 RGB format the wires red and
blue wires has to be crossed and this in turn causes 16 colors output
to be in BGR format. With straight wiring the 16 color is RGB and 24
bit is BGR. These patches try to deal with the issue in reasonable
manner.

For more details see section 3.1.1 in AM335x Silicon Errata:
http://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=sprz360

Jyri Sarha (8):
  drm/tilcdc: Remove drm_helper_disable_unused_functions() call
  drm/tilcdc: Write DMA base and ceiling address with single instruction
  drm/tilcdc: Add blue-and-red-crossed devicetree property
  drm/tilcdc: Choose console BPP that supports RGB
  ARM: dts: am335x-boneblack: Add blue-and-red-wiring -property to LCDC
    node
  ARM: dts: am335x-evm: Add blue-and-red-wiring -property to lcdc node
  ARM: dts: am335x-evmsk: Whitespace cleanup of lcdc related nodes
  ARM: dts: am335x-evmsk: Add blue-and-red-wiring -property to lcdc node

 .../devicetree/bindings/display/tilcdc/tilcdc.txt  | 22 ++++++++
 arch/arm/boot/dts/am335x-boneblack.dts             | 11 ++++
 arch/arm/boot/dts/am335x-evm.dts                   |  2 +
 arch/arm/boot/dts/am335x-evmsk.dts                 | 42 ++++++++--------
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  9 +++-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                | 58 ++++++++++++++++++----
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |  5 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |  7 ++-
 drivers/gpu/drm/tilcdc/tilcdc_external.h           |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              |  2 -
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |  9 ++--
 drivers/gpu/drm/tilcdc/tilcdc_regs.h               | 14 ++++++
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c             |  2 -
 13 files changed, 136 insertions(+), 49 deletions(-)

-- 
1.9.1
