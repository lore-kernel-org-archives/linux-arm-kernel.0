From: atull@opensource.altera.com (Alan Tull)
Date: Wed, 28 Sep 2016 13:21:48 -0500
Subject: [PATCH v19 00/12] Device Tree support for FPGA Programming
Message-ID: <20160928182200.15800-1-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset support FPGA programming under the control
of Device Tree overlays.

A few patches that were acked have been left out of the
patchset, but continued development has caused this
patchset to swell a bit.

I'm proposing a minor change to the FPGA Manager API. The
change is to substitute the 'flags' paramater with a pointer
to a 'struct fpga_image_info'.  The reason for this: I'm
running into cases where an FPGA image has properties that
affect how it is programmed into the FPGA.  These properties
are specific to the design in the image and would be useful
to pass in a struct to the FPGA manager and bridges.  The DT
overlays support can populate the struct from DT properties
in the overlay.

The first examples I've run against are that depending on
the complexity of the design in an image, the time that a
bridge takes to be enabled or disabled can vary.  These
patches add the timeouts for bridge enable/disable into the
device tree overlay and add a FPGA image info struct to the
API.  Changes to the existing socfpga and zynq driver are
tiny; a couple lines each.  Other future additions to the
FPGA image info struct may include timeout values for the
FPGA to go to operating mode after programming and other
bridge specifics such as width.

Rob suggested that fpga-regions be children of bridges so
that is supported here.  Since a region may need >1 bridge,
a list additional bridges can be added with the fpga-bridges
property.  I've cleaned up the bindings doc to be correct
DT-wise.  Hopefully!

This patch set includes:
 * Support fpga-regions being children of fpga-bridges
 * fixes and rewrites for the FPGA Regions DT binding doc
 * fpga image info struct support
 * support the bridges and region built as modules
 * fix the hps bridges from stomping on each others' use
   of a shared register.  Note that the register has no
   other bits than those used by the hps bridge driver.
 * fix a potential race condition in hps bridge driver probe
 * remove an unneeded pr_err from fpga-region.c
 * remove some clk_puts - incorrect due to devm_clk_get
 * add altera freeze bridge

The following were acked so they are no longer in this patch set:
 * bindings for Altera SOCFPGA bridges
   https://patchwork.kernel.org/patch/9226093/
 * bindings for Arria 10 FPGA Mgr
   https://patchwork.kernel.org/patch/9226111/
 * "[PATCH v3] of/overlay: add of overlay notifications"
   https://lkml.org/lkml/2016/4/19/704

The patchset is dependent on:
 * Pantelis Antonious's dtc changes for dynamic device tree.
    https://github.com/pantoniou/dtc.git
 * Pantelis' configfs interface patches and fixes
    https://github.com/pantoniou/linux-beagle-track-mainline

Alan


Alan Tull (12):
  fpga: add bindings document for fpga region
  doc: fpga-mgr: add fpga image info to api
  add bindings document for altera freeze bridge
  add sysfs document for fpga bridge class
  fpga-mgr: add fpga image information struct
  fpga: add fpga image information struct for socfpga support
  fpga: add fpga image information struct for zynq support
  fpga: add fpga bridge framework
  fpga: fpga-region: device tree control for FPGA
  ARM: socfpga: fpga bridge driver support
  fpga: add altera freeze bridge support
  fpga-manager: Add Socfpga Arria10 support

 Documentation/ABI/testing/sysfs-class-fpga-bridge  |  11 +
 .../bindings/fpga/altera-freeze-bridge.txt         |  23 +
 .../devicetree/bindings/fpga/fpga-region.txt       | 494 +++++++++++++++++
 Documentation/fpga/fpga-mgr.txt                    |  32 +-
 drivers/fpga/Kconfig                               |  36 ++
 drivers/fpga/Makefile                              |   9 +
 drivers/fpga/altera-fpga2sdram.c                   | 180 ++++++
 drivers/fpga/altera-freeze-bridge.c                | 273 ++++++++++
 drivers/fpga/altera-hps2fpga.c                     | 221 ++++++++
 drivers/fpga/fpga-bridge.c                         | 398 ++++++++++++++
 drivers/fpga/fpga-mgr.c                            |  17 +-
 drivers/fpga/fpga-region.c                         | 603 +++++++++++++++++++++
 drivers/fpga/socfpga-a10.c                         | 572 +++++++++++++++++++
 drivers/fpga/socfpga.c                             |   7 +-
 drivers/fpga/zynq-fpga.c                           |  10 +-
 include/linux/fpga/fpga-bridge.h                   |  60 ++
 include/linux/fpga/fpga-mgr.h                      |  25 +-
 17 files changed, 2941 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-bridge
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.txt
 create mode 100644 drivers/fpga/altera-fpga2sdram.c
 create mode 100644 drivers/fpga/altera-freeze-bridge.c
 create mode 100644 drivers/fpga/altera-hps2fpga.c
 create mode 100644 drivers/fpga/fpga-bridge.c
 create mode 100644 drivers/fpga/fpga-region.c
 create mode 100644 drivers/fpga/socfpga-a10.c
 create mode 100644 include/linux/fpga/fpga-bridge.h

-- 
2.9.3
