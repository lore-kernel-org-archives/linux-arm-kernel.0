From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 01 Oct 2014 11:18:58 +0530
Subject: [PATCH 0/2] Handle reboot for Exynos SoC via reboot_notifier
Message-ID: <1412142540-3667-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes restart hook from machine_desc of Exynos, and moves
respective code into reboot_notifiers.
Exynos5440 handles reboot via clock register so let's register a
reboot_notifier in Exynos5440 clock driver.
For reset Exynos SoC, reboot is handled via PMU SWRESET register so
let's register a reboot_notifier in PMU driver for handling this.

This patch is inspired and dependent on following patch series[1] from
Geunter Roeck.

Also this patch is dependent on PMU platform driver patch [2] by me, and
has been prepared on top of it.

[1]: kernel: Add support for kernel restart handler call chain
https://lkml.org/lkml/2014/8/19/652

[2]: ARM: Exynos: Convert PMU implementation into a platform driver
https://lkml.org/lkml/2014/9/30/219

I have tested reboot functionality on Exynos3250 based board, on
kgene/for-next as well as linux-next's next-20140925 tag.

Pankaj Dubey (2):
  clk: samsung: exynos5440: move restart code into clock driver
  ARM: EXYNOS: PMU: move restart code into pmu driver

 arch/arm/mach-exynos/common.h        |    1 -
 arch/arm/mach-exynos/exynos.c        |   23 ---------------------
 arch/arm/mach-exynos/pmu.c           |   28 +++++++++++++++++++++++++
 drivers/clk/samsung/clk-exynos5440.c |   37 ++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 24 deletions(-)

-- 
1.7.9.5
