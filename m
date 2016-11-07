From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Sun,  6 Nov 2016 17:13:22 -0700
Subject: [PATCH 0/4] fpga mgr: Add support for capabilities & encrypted
 bistreams
Message-ID: <20161107001326.7395-1-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces FPGA capabilities, to model what operations
an FPGA Manager low level driver supports.
Exposing them via sysfs allows userland to make smart decisions which FPGA to deploy
an image to in case there are multiple FPGAs with different capabilities available.

As an example of a capability: Support for encrypted bitstreams to Zynq & SocFPGA.
Please note that [4/4] is separate as I couldn't find info on how encrypted bitstreams
work on socfpga platforms, however Alan mentioned during an offline discussion it should
'just work'.

On Zynq using the HMAC & AES units in the devcfg peripheral only work when the system
has been booted in Secure Mode, otherwise the boot rom will disable them.
The FPGA manager capability will only get exposed if available.

Thanks,

    Moritz

Moritz Fischer (4):
  fpga mgr: Introduce FPGA capabilities
  fpga mgr: Expose FPGA capabilities to userland via sysfs
  fpga mgr: zynq: Add support for encrypted bitstreams
  fpga mgr: socfpga: Expose support for encrypted bitstreams

 Documentation/ABI/testing/sysfs-class-fpga-manager | 16 +++++++
 drivers/fpga/fpga-mgr.c                            | 42 ++++++++++++++++++
 drivers/fpga/socfpga.c                             | 11 ++---
 drivers/fpga/zynq-fpga.c                           | 28 ++++++++++--
 include/linux/fpga/fpga-mgr.h                      | 50 +++++++++++++++++++++-
 5 files changed, 138 insertions(+), 9 deletions(-)

-- 
2.10.0
