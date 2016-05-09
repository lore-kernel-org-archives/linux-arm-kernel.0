From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  9 May 2016 17:49:44 +0100
Subject: [PATCH 0/6] arm64: Extend Cortex-A53 errata workaround
Message-ID: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the errata documentation for the ARM errata 819472, 826319,
827319 and 824069, in addition to the already covered promotion of
"dc cvac" cache maintenance instructions to "dc civac"[1], we also need
to promote "dc cvau" operations.
Also as cache maintenance instructions on ARMv8 can be issued by EL0 as
well, we unfortunately have to promote them too, which is only possible
by means of trap-and-emulate.

These patches cover all in-kernel users of "dc cvau" and make sure
they are using "dc civac" if run on an affected core.
In addition if at least one core in the system has one of the above
mentioned erratas, we set the respective bit in SCTLR to trap cache
maintenance instructions from EL0 to EL1 on all CPUs, where we "emulate"
them by executing the potentially fixed instruction on behalf of userspace.

Apart from the actual patches 2/6 and 6/6, which do the main work, the
other patches are cleanups and do refactoring to make the promotion and
trapping of EL0 cache maintenance easier.

Tested on a Juno R0 with an userspace tool to issue various cache
maintenance instructions (including one with triggers a SIGSEGV) and
verified with some debugfs entries.
At least one LTP test also issues around 100 cache maintenance
instructions, which this code survived happily.

Cheers,
Andre.

[1] commit 301bcfac4289 ("arm64: add Cortex-A53 cache errata workaround")

Andre Przywara (6):
  arm64: alternatives: drop enable parameter from _else and _endif macro
  arm64: fix "dc cvau" cache operation on errata-affected core
  arm64: include alternative handling in dcache_by_line_op
  arm64: errata: Calling enable functions for CPU errata too
  arm64: consolidate signal injection on emulation errors
  arm64: trap userspace "dc cvau" cache operation on errata-affected
    core

 arch/arm64/include/asm/alternative.h |  28 +++++++--
 arch/arm64/include/asm/cpufeature.h  |   2 +
 arch/arm64/include/asm/processor.h   |   1 +
 arch/arm64/include/asm/sysreg.h      |   2 +-
 arch/arm64/include/asm/traps.h       |   3 +
 arch/arm64/kernel/armv8_deprecated.c |  13 ++--
 arch/arm64/kernel/cpu_errata.c       |   7 +++
 arch/arm64/kernel/cpufeature.c       |   4 +-
 arch/arm64/kernel/entry.S            |  12 +++-
 arch/arm64/kernel/traps.c            | 111 +++++++++++++++++++++++++++++++----
 arch/arm64/mm/cache.S                |   2 +-
 arch/arm64/mm/proc-macros.S          |   9 ++-
 12 files changed, 164 insertions(+), 30 deletions(-)

-- 
2.7.3
