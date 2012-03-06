From: will.deacon@arm.com (Will Deacon)
Date: Tue,  6 Mar 2012 16:54:00 +0000
Subject: [PATCH 0/6] Miscellaneous nommu fixes
Message-ID: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of patches is a series of fixes for kernels built without
CONFIG_MMU selected. It seems that this isn't a particularly popular
choice amongst users of mainline kernels, but I was feeling brave and
gave it a go.

The first patch is already in the patch system as 7337/1 but is unlikely
to be merged unless it can be shown to work correctly. I tried the latest
Codesourcery / Mentor uclinux GDB but that doesn't appear to issue the
relevant ptrace requests:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086219.html

If anybody has a working uclinux environment, it would *make my day* if
they could take GDB for a spin.

The second patch has been picked up by Andrew Morton from the kexec list.

The remaining patches are largely straightforward with the exception of
the CPU suspend changes. I actually managed to test this with a rather
weird and wonderful configuration, although this was using software
models which tend to hide some of the issues you may experience with
real hardware.

All feedback welcome.

Will


Jonathan Austin (1):
  ARM: nommu: Use VECTORS_BASE for vector copying with !MMU

Will Deacon (5):
  ARM: ptrace: fix ptrace_read_user for !CONFIG_MMU platforms
  kexec: crash: don't save swapper_pg_dir for !CONFIG_MMU
    configurations
  ARM: nommu: fix typo in mm/Kconfig
  ARM: suspend: fix CPU suspend code for !CONFIG_MMU configurations
  ARM: mm: truncate memory banks to fit in 4GB space for classic MMU

 arch/arm/kernel/ptrace.c  |    4 ++-
 arch/arm/kernel/setup.c   |   11 ++++++++-
 arch/arm/kernel/suspend.c |   52 ++++++++++++++++++++++++++-------------------
 arch/arm/kernel/traps.c   |    2 +-
 arch/arm/mm/Kconfig       |    2 +-
 arch/arm/mm/proc-v6.S     |    6 ++++-
 arch/arm/mm/proc-v7.S     |   14 +++++++----
 kernel/kexec.c            |    2 +
 8 files changed, 61 insertions(+), 32 deletions(-)

-- 
1.7.4.1
