From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 25 Jun 2014 15:37:25 +0200
Subject: [PATCH v2 0/6] Enable L2 cache support on Exynos4210/4x12 SoCs
Message-ID: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series intends to add support for L2 cache on Exynos4 SoCs on boards
running under secure firmware, which requires certain initialization steps
to be done with help of firmware, as selected registers are writable only
from secure mode.

First four patches extend existing support for secure write in L2C driver
to account for design of secure firmware running on Exynos. Namely:
 1) direct read access to certain registers is needed on Exynos, because
    secure firmware calls set several registers at once,
 2) not all boards are running secure firmware, so .write_sec callback
    needs to be installed in Exynos firmware ops initialization code,
 3) write access to {DATA,TAG}_LATENCY_CTRL registers fron non-secure world
    is not allowed and so must use l2c_write_sec as well,
 4) on certain boards, default value of prefetch register is incorrect
    and must be overridden at L2C initialization.
Patches 1-3 might affect other platforms using .write_sec callback, so
I'd like to kindly ask any interested people for testing.

Further two patches add impelmentation of .write_sec for Exynos secure
firmware and necessary DT nodes to enable L2 cache.

Tested on Exynos4210-based Universal C210 and Trats (both without secure
firmware) and Exynos4412-based TRATS2 and ODROID-U3 boards (both with secure
firmware).

Changes since v1:
(https://www.mail-archive.com/linux-omap at vger.kernel.org/msg106323.html)
 - rebased onto for-next branch of linux-samsung tree,
 - changed argument order of outer_cache.write_sec() callback to match
   l2c_write_sec() function in cache-l2x0.c,
 - added support of overriding of prefetch settings to work around incorrect
   default settings on certain Exynos4x12-based boards,
 - added call to firmware to invalidate whole L2 cache before setting enable
   bit in L2C control register (required by Exynos secure firmware).

Tomasz Figa (6):
  ARM: mm: cache-l2x0: Add base address argument to write_sec callback
  ARM: Get outer cache .write_sec callback from mach_desc only if not
    NULL
  ARM: mm: cache-l2x0: Use l2c_write_sec() for LATENCY_CTRL registers
  ARM: mm: l2x0: Add support for overriding prefetch settings
  ARM: EXYNOS: Add .write_sec outer cache callback for L2C-310
  ARM: dts: exynos4: Add nodes for L2 cache controller

 Documentation/devicetree/bindings/arm/l2cc.txt | 10 ++++
 arch/arm/boot/dts/exynos4210.dtsi              |  9 ++++
 arch/arm/boot/dts/exynos4x12.dtsi              | 14 ++++++
 arch/arm/include/asm/mach/arch.h               |  3 +-
 arch/arm/include/asm/outercache.h              |  2 +-
 arch/arm/kernel/irq.c                          |  3 +-
 arch/arm/mach-exynos/firmware.c                | 63 +++++++++++++++++++++++++
 arch/arm/mach-highbank/highbank.c              |  3 +-
 arch/arm/mach-omap2/omap4-common.c             |  3 +-
 arch/arm/mach-ux500/cache-l2x0.c               |  3 +-
 arch/arm/mm/cache-l2x0.c                       | 64 ++++++++++++++++++++++----
 11 files changed, 162 insertions(+), 15 deletions(-)

-- 
1.9.3
