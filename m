From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 17 Jul 2014 17:56:09 +0200
Subject: [PATCH v2 0/2] Firmware-assisted suspend/resume of Exynos SoCs
Message-ID: <1405612571-32598-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos-based boards running secure firmware the sequence of low level
operations to enter and leave system-wide sleep mode is different than
on those without the firmware. Namely:
 - CP15 power control and diagnostic registers cannot be written directly,
 - the way of setting boot address and boot flag is different,
 - different resume handler needs to be used,
 - dedicated SMC call needs to be performed instead of letting the CPU enter
   WFI.

This series introduces .suspend() and .resume() firmware operations to
perform low level firmware-specific suspend and resume and then leverages
them to provide suspend-resume path meeting the above requirements.

The series is based on Kgene's for-next branch and tested on:
 - Exynos4412-based Trats2 board running in non-secure mode (under secure
   firmware) with few board-specific fixes that will be sent separately soon,
 - Exynos4210-based Trats board running in secure mode,
 - Exynos4412-based ODROID-U3 board running in non-secure mode with one minor
   board-specific fix which will be send shortly.

Depends on:
 - [PATCH v3] ARM: save/restore Cortex-A9 CP15 registers on suspend/resume
   (http://www.spinics.net/lists/arm-kernel/msg346212.html)
 - [PATCH v3] ARM: EXYNOS: Fix suspend/resume sequences
   (https://lkml.org/lkml/2014/7/15/319)
 - [PATCH] ARM: make it easier to check the CPU part number correctly
   (http://thread.gmane.org/gmane.linux.ports.arm.kernel/335126
    already in linux-next)

Changes since v1:
 - dropped outer_resume() - will be handled in assembly in further patches,
   as support for L2C in non-secure mode gets added,
 - moved CP15 resume to assembly as it needs to be done before MMU is enabled,
 - surrounded CP15 save with a check for cpuid part, because it is valid only
   on Cortex A9,
 - rebased on next-20140717 tag of linux-next tree.

Tomasz Figa (2):
  ARM: firmware: Introduce suspend and resume operations
  ARM: EXYNOS: Add support for firmware-assisted suspend/resume

 Documentation/arm/firmware.txt  | 28 +++++--------------------
 arch/arm/include/asm/firmware.h |  8 ++++++++
 arch/arm/mach-exynos/Makefile   |  1 +
 arch/arm/mach-exynos/common.h   |  4 ++++
 arch/arm/mach-exynos/firmware.c | 45 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/pm.c       | 16 ++++++++++-----
 arch/arm/mach-exynos/sleep.S    | 28 +++++++++++++++++++++++++
 arch/arm/mach-exynos/smc.h      |  4 ++++
 8 files changed, 106 insertions(+), 28 deletions(-)

-- 
1.9.3
