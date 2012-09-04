From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  4 Sep 2012 12:40:26 +0200
Subject: [PATCH V2] Add support for Aurora L2 Cache Controller
Message-ID: <1346755232-26006-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This a the 2nd version of the patch set (the third if we include the
RFC). See the end of this email for the changelog.

The purpose of this patch set is to add support for Aurora L2 Cache
Controller used by Armada 370 and Armada XP SoCs. As it was initially
designed by Marvell engineer to be compatible with the ARM L2 Cache
Controller, we chose to reuse the existing code and to just extend it
to support the differences and improvements brought by the Aurora
controller.The diffstat looks like:

 Documentation/devicetree/bindings/arm/l2cc.txt  |    9 +
 arch/arm/boot/dts/armada-370.dtsi               |    6 +
 arch/arm/boot/dts/armada-xp.dtsi                |    7 +
 arch/arm/include/asm/hardware/cache-aurora-l2.h |   51 ++++
 arch/arm/include/asm/hardware/cache-l2x0.h      |    1 +
 arch/arm/mach-mvebu/Kconfig                     |    1 +
 arch/arm/mach-mvebu/irq-armada-370-xp.c         |    4 +
 arch/arm/mm/cache-l2x0.c                        |  298 +++++++++++++++++++++--
 8 files changed, 363 insertions(+), 14 deletions(-)

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
V2 -> V1:
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
