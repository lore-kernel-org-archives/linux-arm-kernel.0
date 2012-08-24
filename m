From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Aug 2012 11:09:15 +0200
Subject: Add support for Aurora L2 Cache Controller
Message-ID: <1345799361-23735-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As I didn't receive any arguments against modify the l2x0 driver to
add Aurora Cache Controller support on the RFC, then I post it as a
patch series. I hope this time my patch series won't be bounced, as I
had no clue about the reason it happened last time.

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
 arch/arm/mm/cache-l2x0.c                        |  297 +++++++++++++++++++++--

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

Since the RFC patch I rebased the series on to V3.6-rc3, add missing
Signed-off-by, corrected a compilation warning that I have missed and
run benchmarks without seeing any regression:

https://github.com/MISL-EBU-System-SW/mainline-public/wiki/Non-official-cache-bench-results-on-the-mainline-Linux-port-%28-kernels-3.6-rc2-and-3.6-rc1-%29-of-Armada-XP-and-Armada-370

The git branch aurora-L2-cache-ctrl is visible at
https://github.com/MISL-EBU-System-SW/mainline-public.git

Regards,

Gregory
