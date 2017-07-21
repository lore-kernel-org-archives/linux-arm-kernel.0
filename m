From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:26 +0100
Subject: [PATCH 00/16] arm/arm64: Workaround misprogrammed CNTFRQ
Message-ID: <20170721171542.27639-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is an unfortunate situation that CNTFRQ{,_EL0} is often
misprogrammed from the firmware side, leaving it up to the kernel to
work around it. This is usually done by providing an alternative
frequency in the Device Tree.

Unfortunately, CNTFRQ is accessible from EL0, giving userspace the
wrong frequency, and potentially a different frequency per CPU, which
is definitely not what you want. A possible workaround is to trap this
into the kernel and to emulate it (together with the VDSO being
disabled), and this is what this series is achieving.

As it is obvious from the shortlog below, most of the required code is
actually architecture specific, and required to handle these traps
properly.

On arm64, we mostly have things in order already for AArch64 code. But
we lack the infrastructure to deal with cp15 traps from a 32bit
userspace. We could do it by reading userspace the userspace code and
use the undef_hook mechanism, but that's clearly very ugly.

Instead, we mimic the way we trap system register accesses for 64bit
code. An added complexity comes from the fact that we need to handle
condition execution in both ARM and Thumb modes (including the IT
state) when trapping such accesses.

32bit ARM is also lacking any form of conditional Thumb handling, so
we add that before adding the undef handlers.

This has been tested as KVM guests, using kvmtool and the
--override-bad-firmware-cntfrq option to trick the VM into using a
different frequency.

Marc Zyngier (16):
  arm64: Use arch_timer_get_rate when trapping CNTFRQ_EL0
  arm64: Add decoding macros for CP15_32 and CP15_64 traps
  arm64: compat: Add separate CP15 trapping hook
  arm64: compat: Add condition code checks and IT advance
  arm64: compat: Add cp15_32 and cp15_64 handler arrays
  arm64: compat: Add CNTVCT trap handler
  arm64: compat: Add CNTFRQ trap handler
  ARM: Let arm_check_condition work with Thumb
  ARM: Check condition code before trying to handle an UNDEF
  ARM: Add arm_advance_itstate helper
  ARM: Advance the IT state on successful emulation of an UNDEF
  ARM: Simplify condition checks in swp_handler
  ARM: Handle trapping of CNTVCT from userspace
  ARM: Handle trapping of CNTFRQ from userspace
  clocksource/arm_arch_timer: Add helper to disable VDSO fastpath
  clocksource/arm_arch_timer: Trap user access to CNT{VCT,FRQ} if CNTFRQ
    is invalid

 arch/arm/include/asm/opcodes.h       |   2 +
 arch/arm/kernel/opcodes.c            |  68 +++++++++++++++-
 arch/arm/kernel/swp_emulate.c        |  15 +---
 arch/arm/kernel/traps.c              |  64 ++++++++++++++-
 arch/arm64/include/asm/esr.h         |  58 +++++++++++++
 arch/arm64/kernel/entry.S            |  14 +++-
 arch/arm64/kernel/traps.c            | 152 ++++++++++++++++++++++++++++++++++-
 drivers/clocksource/arm_arch_timer.c |  56 +++++++++----
 8 files changed, 397 insertions(+), 32 deletions(-)

-- 
2.11.0
