From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 15 Oct 2015 12:32:19 +0200
Subject: [PATCH v2 0/3] ARM: handle imprecise aborts from firmware in common
 code
Message-ID: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements the handling of a pending imprecise abort left behind
by the bootloader/firmware running before Linux in the common ARM startup code.

It turns pending imprecise aborts that may signal during the first unmasking
of such aborts on the boot CPU into a non-faulting event and warns the user
that the firmware of the machine might be buggy.

Handling this in the common code makes sure that we only ignore already pending
aborts and not those that may happen later during system boot/usage. It also
allows to remove the custom fault handler from the 3 architectures that are
known to have bad firmware/bootloaders.

V2 adapts patch 1 to suggestions from Russell and Hauke and drops former
patch 3 (ARM: mvebu: remove the workaround imprecise abort fault handler)
as it has already been applied.

Regards,
Lucas

Lucas Stach (3):
  ARM: catch pending imprecise abort on unmask
  ARM: OMAP2+: remove custom abort handler for t410
  ARM: BCM5301X: remove workaround imprecise abort fault handler

 arch/arm/mach-bcm/bcm_5301x.c      | 35 -----------------------------------
 arch/arm/mach-omap2/pdata-quirks.c | 29 -----------------------------
 arch/arm/mm/fault.c                | 22 ++++++++++++++++++++++
 arch/arm/mm/fault.h                |  1 +
 arch/arm/mm/mmu.c                  |  3 ++-
 5 files changed, 25 insertions(+), 65 deletions(-)

-- 
2.6.1
