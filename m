From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 25 Jun 2014 18:18:32 +0200
Subject: [PATCH 0/2] Firmware-assisted suspend/resume of Exynos SoCs
Message-ID: <1403713114-18923-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos-based boards running secure firmware the sequence of low level
operations to enter and leave system-wide sleep mode is different than
on those without the firmware. Namely:
 - CP15 power control and diagnostic registers cannot be written directly,
 - the way of setting boot address and boot flag is different,
 - different resume handler needs to be used (generic cpu_resume() vs
   exynos_cpu_resume()),
 - dedicated SMC call needs to be performed instead of letting the CPU enter
   WFI.

This series introduces .suspend() and .resume() firmware operations to
perform low level firmware-specific suspend and resume and then leverages
them to provide suspend-resume path meeting the above requirements.

The series is based on Kgene's for-next branch and tested on
Exynos4412-based Trats2 board (with few board-specific fixes that will be
sent separately) and Exynos4210-based Trats board (without any extra
patches).
 
Tomasz Figa (2):
  ARM: firmware: Introduce suspend and resume operations
  ARM: EXYNOS: Add support for firmware-assisted suspend/resume

 Documentation/arm/firmware.txt  | 28 +++++-------------------
 arch/arm/include/asm/firmware.h |  8 +++++++
 arch/arm/mach-exynos/firmware.c | 47 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/pm.c       | 16 +++++++++-----
 4 files changed, 71 insertions(+), 28 deletions(-)

-- 
1.9.3
