From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  8 Aug 2012 17:05:00 +0200
Subject: [RFC] Add support for Aurora L2 Cache Controller
Message-ID: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

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
 8 files changed, 362 insertions(+), 14 deletions(-)

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

If the change we have made in the l2x0 driver are judged too invasive
we are perfectly fine to submit a dedicated driver for the Aurora
Cache Controller.

For interested people you can find the results of the cache benchmarks
which was ran for validate the driver:
htps://github.com/MISL-EBU-System-SW/mainline-public/wiki/Cache-bench-results-for-Aurora-L2-cache-controller-on-Armada-XP-and-Armada-370

All the data related to this benchmark are hosted at:
http://free-electrons.com/%7Egregory/pub/Armada-370-xp/cachebench-results/

The git branch aurora-L2-cache-ctrl is visible at
https://github.com/MISL-EBU-System-SW/mainline-public.git

Regards,

Gregory
