From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed,  9 Nov 2016 15:58:14 -0700
Subject: [PATCH fpga 0/9] Zynq FPGA Manager Improvements
Message-ID: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is all the changes I made while reviewing the Zynq driver.

The first five patches are independent straight forward changes.

The next four patches rework the FPGA manager core code and all drivers to
only use scatter lists for bitfile storage. This is an essential change
looking forward as the high order physical and vmalloc allocations currently
used are simply unreliable and unusable in many cases.

This does not fully fix the request_firmware path, as that needs changes to
the firmware core, but does all the low level work needed in this
subsystem. Zynq sees a significant improvement as it no longer needs large
amounts of physically contiguous DMA coherent memory.

Other users who can use the new sg interface have no limitations, and could
zero-copy DMA directly out of the page cache, for instance.

I do not have socfpga hardware, so those straightfoward changes are untested,
but I have tested the Zynq driver extensively now.

Jason Gunthorpe (9):
  fpga zynq: Add missing \n to messages
  fpga zynq: Check the bitstream for validity
  fpga zynq: Fix incorrect ISR state on bootup
  fpga zynq: Check for errors after completing DMA
  fpga zynq: Remove priv->dev
  fpga: Add scatterlist based write ops to the driver ops
  fpga zynq: Use the scatterlist interface
  fpga socfpga: Use the scatterlist interface
  fpga: Remove support for non-sg drivers

 drivers/fpga/fpga-mgr.c       |  87 +++++++++++--
 drivers/fpga/socfpga.c        |  56 ++++++---
 drivers/fpga/zynq-fpga.c      | 278 ++++++++++++++++++++++++++++++------------
 include/linux/fpga/fpga-mgr.h |  14 ++-
 4 files changed, 327 insertions(+), 108 deletions(-)

-- 
2.1.4
