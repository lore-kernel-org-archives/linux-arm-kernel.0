From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 18:04:52 +0100
Subject: [PATCH 0/6] MMU disabling code and kexec fixes
Message-ID: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

There's been some discussion on the lists recently concerning MMU-off
code and how best to do it safely. Since I believe this code should
exist in one place, where it can be accessed by the relevant subsystems
that need it, I had a crack at a patch series.

After applying this lot, I can successfully kexec a kernel on the
Realview-PBX board (although using SMP causes some issues in the new
kernel because the secondaries need throwing back to the bootloader).

Anyway, I'm posting this in the hope that it can be used by others who
are trying to disable the MMU for one reason or another.

All feedback welcome!

Will


Will Deacon (6):
  ARM: l2x0: fix disabling function to avoid livelock
  ARM: l2x0: fix invalidate-all function to avoid livelock
  ARM: proc-v7: add definition of cpu_reset for ARMv7 cores
  ARM: reset: add reset functionality for jumping to a physical address
  ARM: kexec: use arm_machine_reset for branching to the reboot buffer
  ARM: stop: execute platform callback from cpu_stop code

 arch/arm/Kconfig                |    2 +-
 arch/arm/include/asm/system.h   |    1 +
 arch/arm/kernel/machine_kexec.c |   14 +-----------
 arch/arm/kernel/process.c       |   42 ++++++++++++++++++++++++++++++++++----
 arch/arm/kernel/smp.c           |    4 +++
 arch/arm/mm/cache-l2x0.c        |   13 ++++++-----
 arch/arm/mm/proc-v7.S           |    7 ++++++
 7 files changed, 59 insertions(+), 24 deletions(-)
