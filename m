From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 08 Nov 2016 08:44:22 +0530
Subject: [PATCH v2 0/2] Remove static mapping of SCU from mach-exynos
Message-ID: <1478574864-24683-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is part of patch series [1], which adds support of SCU
device node for Cortex-A9 based Exynos4 SoC. First two patches of the same
has been accepted and hence not included them in v2.

This patch series does some cleanup for Exynos4 SoC based boards.
We are currently statically mapping SCU SFRs in mach-exynos/exynos.c
which can be avoided if map this from device node of SCU. 

This patch introduces exynos_scu_enable in firmware.c file,
which will be called from exynos_resume, which in turn called by pm.c and
suspend.c as firmware_ops.

[1]: https://www.spinics.net/lists/arm-kernel/msg540498.html


This patch series is prepared on Krzysztof's for-next
(SHA_ID: b33c7bb9d59c3f4100d4)

I have tested these patches on Exynos4210 based on Origen board for SMP boot.
Patchset v1 was tested by Marek Szyprowski on Exynos4412-based Odroid U3
for SMP boot and S2R.

To confirm concern raised by Alim, I intentionally removed SCU device node
from exynos4.dtsi and tested on Origen board, I can see code handles this
case gracefully without any crash and system boot was fine. Of-course in such
case only single core will be able to boot.

Following boot message observed on Origen in case of missing SCU node
-------------
[    0.000864] CPU: Testing write buffer coherency: ok
[    0.001068] CPU0: thread -1, cpu 0, socket 9, mpidr 80000900
[    0.001456] exynos_smp_prepare_cpus failed to map scu_base
[    0.001477] Setting up static identity map for 0x40100000 - 0x40100058
[    1.120003] CPU1: failed to come online
[    1.120059] Brought up 1 CPUs
[    1.120068] SMP: Total of 1 processors activated (48.00 BogoMIPS).
[    1.120076] CPU: All CPU(s) started in SVC mode.
-------------

Changes since v1:
 - Address review comments from Krzysztof
 - Moved scu_enable from pm.c and suspend.c to single place in firmware.c,
   as both pm.c and suspend.c needs scu_enable during exynos_resume call. 
 - Added error handling during scu_enable in platsmp.c.
 - Added Reviewed-by tag from Alim.


This patch series is tested on Exynos4210 based Origen board for SMP boot.

Pankaj Dubey (2):
  ARM: EXYNOS: Remove static mapping of SCU SFR
  ARM: EXYNOS: Remove unused soc_is_exynos{4,5}

 arch/arm/mach-exynos/common.h                |  5 -----
 arch/arm/mach-exynos/exynos.c                | 22 ----------------------
 arch/arm/mach-exynos/firmware.c              | 17 +++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h      |  2 --
 arch/arm/mach-exynos/platsmp.c               | 20 +++++++++++++-------
 arch/arm/mach-exynos/pm.c                    |  4 +---
 arch/arm/mach-exynos/suspend.c               |  5 -----
 arch/arm/plat-samsung/include/plat/map-s5p.h |  4 ----
 8 files changed, 31 insertions(+), 48 deletions(-)

-- 
2.7.4
