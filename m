From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Dec 2014 13:43:41 +0100
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
Message-ID: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of patches bring a number of fixes to the mvebu-mbus and I/O
coherency code:

 - Fix the MBus window n?13, which is a remappable window on Armada
   XP, 375 and 38x (but not 370), and was incorrectly handled as a
   non-remappable window by the mvebu-mbus driver. Due to this,
   whenever this window was used (for example if you have many PCIe
   devices), the device using this window would not work at all due to
   the window being badly configured.

 - Fix for the DRAM CS information exposed to device drivers by the
   mvebu-mbus driver to make sure the listed ranges do not overlap
   with the MBus bridge window. This is not causing any major issue
   right now, but is causing problems for an improved version of the
   mv_cesa crypto driver (which will be submitted in the future).

 - Switch to using automatic I/O synchronization barriers. This
   simultaneously fixes two problems:

    * The explicit I/O sync barriers could not work properly, because
      they are also needed for coherent DMA mappings, while the kernel
      do not expect any maintenance operation to be needed for such
      mappings. Since such barriers were never added for coherent DMA
      mappings, one could get rare but nonetheless existing cases of
      stale data seen by the CPU in the cache instead of the real data
      pushed by the device through DMA.

    * It allows to switch to use the existing arm_coherent_dma_ops
      instead of mvebu specific DMA operations. arm_coherent_dma_ops
      make sure that DMA coherent mappings are mapped cacheable (which
      is possible in a cache-coherent platform), which is a necessary
      to make sure that both CPU-side and device-side accesses are
      done in a cacheable way. Without this, CPU-side accesses to DMA
      coherent mappings were made uncached, while device-side accesses
      were made in a cacheable way, leading to potentially
      unpredictable behavior.

Patches are marked with the (hopefully) appropriate stable tags.

Best regards,

Thomas

Michal Mazur (1):
  bus: mvebu-mbus: fix support of MBus window 13 on Armada XP/375/38x

Thomas Petazzoni (5):
  dt: bindings: update mvebu-mbus DT binding with new compatible
    properties
  ARM: mvebu: fix compatible strings of MBus on Armada 375 and Armada
    38x
  bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus
    bridge window
  bus: mvebu-mbus: use automatic I/O synchronization barriers
  ARM: mvebu: use arm_coherent_dma_ops

 .../devicetree/bindings/bus/mvebu-mbus.txt         |   4 +-
 arch/arm/boot/dts/armada-375.dtsi                  |   2 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |   3 +-
 arch/arm/mach-mvebu/coherency.c                    |  51 +---
 drivers/bus/mvebu-mbus.c                           | 275 ++++++++++++++++-----
 5 files changed, 225 insertions(+), 110 deletions(-)

-- 
2.1.0
