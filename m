From: josh.cartwright@ni.com (Josh Cartwright)
Date: Wed, 24 Oct 2012 15:02:22 -0500
Subject: [PATCH v4 0/5] zynq subarch cleanups
Message-ID: <20121024200222.GA6713@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey all-

I think everything is in a good state to merge now, from here its a
discussion of process.

Thanks to everyone involved.

---
Things have been relatively quiet on the Zynq front lately.  This patchset does
a bit of cleanup of the Zynq subarchitecture.  It was the necessary set of
things I had to do to get a zynq target booting with the upstream qemu model.

Patches 1 and 2 move zynq to use the GIC and pl310 L2 cache controller device
tree bindings respectively.

Patch 3 removes unused clock infrastructure.  The plan is to rework the
out-of-tree Xilinx generic clk support into something suitable for merging.
What's in tree now just isn't used at all, and can be removed.

Patch 4 and 5 move around the static peripheral mappings into the vmalloc area.

---
Changes since v3:
  - Patch 3 also removes the zynq "use" of versatile

Changes since v2:
  - Reordered patchset to prevent remapping peripherals that were subsequently
    removed from the static map
  - Use DT bindings for the L2 cache controller

Changes since v1:
  - Make sure arm at kernel.org was included
  - Rebased on arm-soc/for-next
  - Added a cover letter
  - Elaborated a bit on why I removed CLKDEV_LOOKUP

---
Josh Cartwright (5):
  zynq: use GIC device tree bindings
  zynq: use pl310 device tree bindings
  zynq: remove use of CLKDEV_LOOKUP
  ARM: annotate VMALLOC_END definition with _AC
  zynq: move static peripheral mappings

 arch/arm/Kconfig                           |  1 -
 arch/arm/Makefile                          |  1 -
 arch/arm/boot/dts/zynq-ep107.dts           | 17 +++++++++++++---
 arch/arm/include/asm/pgtable.h             |  2 +-
 arch/arm/mach-zynq/common.c                | 23 ++++++++++-----------
 arch/arm/mach-zynq/include/mach/clkdev.h   | 32 ------------------------------
 arch/arm/mach-zynq/include/mach/zynq_soc.h | 29 ++++++++++++---------------
 7 files changed, 38 insertions(+), 67 deletions(-)
 delete mode 100644 arch/arm/mach-zynq/include/mach/clkdev.h

-- 
1.8.0
