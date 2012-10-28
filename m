From: josh.cartwright@ni.com (Josh Cartwright)
Date: Sun, 28 Oct 2012 17:26:05 -0600
Subject: [PATCH v4 0/5] zynq subarch cleanups
Message-ID: <cover.1351466765.git.josh.cartwright@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal-

Here is a v5 of the zynq cleanup patchset that addresses your feedback.  I've
intentionally left patches 4 and 5 in the set until we figure out the
appropriate way to get them in tree (feel free to just apply 1-3)

I've also moved the uart mapping in patch 5 to a known working address, until
we can work out what is happening there.  This should allow this patchset to be
applied and have the zc702 boot.

You had suggested removing/renaming the zynq-ep107.dts; it wasn't clear whether
you had wanted that in this patchset or not.  I'm going to assume not.  I'll
follow up with this, after this patchset is applied, if that works for you.

Thanks,
   Josh

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
Changes since v4:
  - Fixed uart interrupt spec in zynq-ep107.dtb (patch 1)
  - Moved early uart mapping to a known working address (patch 5)

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
 arch/arm/boot/dts/zynq-ep107.dts           | 19 ++++++++++++++----
 arch/arm/include/asm/pgtable.h             |  2 +-
 arch/arm/mach-zynq/common.c                | 23 ++++++++++-----------
 arch/arm/mach-zynq/include/mach/clkdev.h   | 32 ------------------------------
 arch/arm/mach-zynq/include/mach/zynq_soc.h | 31 ++++++++++++++---------------
 7 files changed, 41 insertions(+), 68 deletions(-)
 delete mode 100644 arch/arm/mach-zynq/include/mach/clkdev.h

-- 
1.8.0
