From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Mar 2015 18:38:06 +0100
Subject: [RFT/RFC PATCH 0/6] ARM kernel size fixes
Message-ID: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a suggested approach to preventing linker failures on large
kernels. It is somewhat unpolished, and posted for comments/testing primarily.

The issues were found and reported by Arnd Bergmann, and these patches are
loosely based on his initial approach to work around them.

Ard Biesheuvel (6):
  ARM: replace PROCINFO embedded branch with relative offset
  ARM: move HYP text to end of .text section
  ARM: add macro to perform far branches (b/bl)
  ARM: use bl_far to call __hyp_stub_install_secondary from the .data
    section
  ARM: move the .idmap.text section closer to .head.text
  ARM: keep .text and .fixup regions together

 arch/arm/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
 arch/arm/kernel/head.S           | 14 ++++++++------
 arch/arm/kernel/sleep.S          |  2 +-
 arch/arm/kernel/vmlinux.lds.S    | 16 ++++++++++------
 arch/arm/kvm/init.S              |  5 +----
 arch/arm/kvm/interrupts.S        |  4 +---
 arch/arm/mm/proc-arm1020.S       |  4 ++--
 arch/arm/mm/proc-arm1020e.S      |  4 ++--
 arch/arm/mm/proc-arm1022.S       |  4 ++--
 arch/arm/mm/proc-arm1026.S       |  4 ++--
 arch/arm/mm/proc-arm720.S        |  4 ++--
 arch/arm/mm/proc-arm740.S        |  4 ++--
 arch/arm/mm/proc-arm7tdmi.S      |  4 ++--
 arch/arm/mm/proc-arm920.S        |  4 ++--
 arch/arm/mm/proc-arm922.S        |  4 ++--
 arch/arm/mm/proc-arm925.S        |  4 ++--
 arch/arm/mm/proc-arm926.S        |  4 ++--
 arch/arm/mm/proc-arm940.S        |  4 ++--
 arch/arm/mm/proc-arm946.S        |  4 ++--
 arch/arm/mm/proc-arm9tdmi.S      |  4 ++--
 arch/arm/mm/proc-fa526.S         |  4 ++--
 arch/arm/mm/proc-feroceon.S      |  5 +++--
 arch/arm/mm/proc-macros.S        |  4 ++++
 arch/arm/mm/proc-mohawk.S        |  4 ++--
 arch/arm/mm/proc-sa110.S         |  4 ++--
 arch/arm/mm/proc-sa1100.S        |  4 ++--
 arch/arm/mm/proc-v6.S            |  4 ++--
 arch/arm/mm/proc-v7.S            |  4 ++--
 arch/arm/mm/proc-v7m.S           |  4 ++--
 arch/arm/mm/proc-xsc3.S          |  4 ++--
 arch/arm/mm/proc-xscale.S        |  4 ++--
 31 files changed, 103 insertions(+), 68 deletions(-)

-- 
1.8.3.2
