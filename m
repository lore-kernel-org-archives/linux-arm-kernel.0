From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 10 Aug 2011 11:13:38 +0100
Subject: [RFC PATCH 0/5] Fix Thumb-2 undef handling for mixed-arch kernels
Message-ID: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In kernels which support v6 and v7 platforms in a single binary
such as omap2plus_defconfig for example, undefined instruction
exceptions taken on Thumb instructions are not processed correctly,
because the kernel assumes at build-time that Thumb-2 won't be
supported in userspace.

This series implements a workaround, by allowing the __und_usr
handler to check the CPU architecture at runtime, in affected
kernels.

As a side-effect, this also changes cpu_architecture from a
function into a global variable initialised at boot-time, which is
probably a sensible idea anyway.

While I think the approach in this series is roughly correct, it's
not very pretty -- in anyone was a cleaner solution to suggest, I'm
open to ideas.

Note that much of the actual diffstat comes from changing
references to cpu_architecture().

Dave Martin (5):
  ARM: Make cpu_alignment into a global variable
  ARM: s3c24xx: Reference cpu_architecture as a global variable
  ARM: kprobes: Reference cpu_architecture as a global variable
  ARM: entry: Remove unnecessary masking when decoding Thumb-2
    instructions
  ARM: entry: Fix Thumb-2 undef handling for multi-CPU kernels

 arch/arm/include/asm/system.h    |    2 +-
 arch/arm/kernel/elf.c            |    4 ++-
 arch/arm/kernel/entry-armv.S     |   44 +++++++++++++++++++++++++++++++++----
 arch/arm/kernel/kprobes-common.c |   11 ++++-----
 arch/arm/kernel/setup.c          |   12 ++++++----
 arch/arm/kernel/thumbee.c        |    4 +-
 arch/arm/mm/alignment.c          |    9 ++++---
 arch/arm/mm/fault.c              |    4 +-
 arch/arm/mm/idmap.c              |    3 +-
 arch/arm/mm/ioremap.c            |    3 +-
 arch/arm/mm/mmu.c                |   31 ++++++++++++++------------
 arch/arm/plat-s3c24xx/cpu.c      |    3 +-
 arch/arm/vfp/vfpmodule.c         |    4 +-
 13 files changed, 89 insertions(+), 45 deletions(-)

-- 
1.7.4.1
