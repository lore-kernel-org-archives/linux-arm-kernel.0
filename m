From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Sep 2012 18:02:44 +0200
Subject: [PATCH V5] Add support for Aurora L2 Cache Controller
Message-ID: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This a the 5th version of the patch set (the sixth if we include the
RFC). This last series add the ultimate change asked by Russell after
his review. See the end of this email for the changelog.

The purpose of this patch set is to add support for Aurora L2 Cache
Controller used by Armada 370 and Armada XP SoCs. As it was initially
designed by Marvell engineer to be compatible with the ARM L2 Cache
Controller, we chose to reuse the existing code and to just extend it
to support the differences and improvements brought by the Aurora
controller.The diffstat looks like:

 Documentation/devicetree/bindings/arm/l2cc.txt |    9 +
 arch/arm/boot/dts/armada-370.dtsi              |    6 +
 arch/arm/boot/dts/armada-xp.dtsi               |    7 +
 arch/arm/include/asm/hardware/cache-l2x0.h     |    5 +
 arch/arm/mach-mvebu/Kconfig                    |    1 +
 arch/arm/mach-mvebu/irq-armada-370-xp.c        |    4 +
 arch/arm/mm/cache-aurora-l2.h                  |   55 +++++
 arch/arm/mm/cache-l2x0.c                       |  277 +++++++++++++++++++++---
 8 files changed, 336 insertions(+), 28 deletions(-)

The main differences and improvements are:

- no cache id part number available through hardware (need to get it
  by the DT).
- always write through mode available.
- two flavors of the controller 'outer cache' and 'system cache' (the
  last one meaning maintenance operations on L1 are broadcasted to the
  L2 and L2 performs the same operation).
- in outer cache mode, the cache maintenance operations are improved
  and can be done on a range inside a page and are not limited to a
  cache line.
- during resume the controller need to restore the ctrl register.

The first patch adds some modifications in the driver
infrastructure. As most of the outer cache functions can use the
Aurora improvements, we had to introduce new functions. So we thought
it was better to use a outer_cache_fns field inside l2x0_of_data and
just memcopy it into outer_cache depending of the type of the l2x0
cache.

Changelog:
V4 -> V5:
- Rebased L2 pach set onto v3.6-rc7.
- The header file cache-aurora-l2.h was co-located with its only user:
  moved from arch/arm/include/asm/hardware/ to arch/arm/mm/.
- Removed additional unnecessary blank lines in cache-l2x0.c.

V3 -> V4:
- Rebased L2 pach set onto v3.6-rc6.
- The assignment of outer_cache in l2x0_init, don't depend of
  CONFIG_OF but of variable. The value of this boolean variable is
  changed in l2x0_of_init. Then, if a system enable CONFIG_OF don't
  supply a DT file, relying on the old way to initialize the L2 cache,
  the assignment won't be disable.
- Removed unnecessary check in calc_range_end(). The alignment tested
  was already made before calling this function.

V2 -> V3:
- Use define instead of literal value for AURORA_CTRL_FW,
  AURORA_WAY_SIZE_SHIFT, L2X0_WAY_SIZE_SHIFT and L2X0_CTRL_EN.
- Used ALIGN, IS_ALUGNED and PAGE_ALIGN macro instead of bitwise
  operation.
- Calculate the number of way for Aurora instead of using a switch
  case.
- removed inaccurate BUG() call and replaced them by a pr_warn if
  needed.
- In aurora_inv_range round the start and end addresses to cache line
  size. The initial code was supposed to invalidate partial line cache
  but actually invalidate the full line, so there was no point to do
  it outside the aurora_pa_range call.
- Removed the dsb call in the aurora_*_range function: the
  cache_sync() call inside aurora_pa_range() is enough.
- And as usual tested on Armada 370 and Armada XP boards and ran
  benchmark without seeing any regression. Results are updated on the
  wiki page.

V1 -> V2:
- Rebased L2 pach set onto v3.6-rc4.
- Changed the compatible names to be more explicit, from
  aurora-cache-with-outer to aurora-outer-cache , and from
  aurora-cache-without-outer to aurora-system-cache.
- Add an isb() after the call to mcr in aurora_broadcast_l2_commands().
- Added the tested and reviewed-by from Lior Amsalem and Yehuda
  Yitschak.
- Tested on Armada 370 and Armada XP boards and ran benchmark without
  seeing any regression.

RFC -> V1:
- Rebased the series on to V3.6-rc3
- Added missing Signed-off-by
- Corrected a compilation warning that I have missed
- Ran benchmarks without seeing any regression

Benchmarks results are visible here:
https://github.com/MISL-EBU-System-SW/mainline-public/wiki/Non-official-cache-bench-results-on-the-mainline-Linux-port-%28-kernels-3.6-rcX%29-of-Armada-XP-and-Armada-370

The git branch aurora-L2-cache-ctrl is visible at
https://github.com/MISL-EBU-System-SW/mainline-public.git

Regards,

Gregory
