From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Nov 2011 16:48:10 +0000
Subject: [PATCH 0/4] Consolidate identity mapping code in idmap.c
Message-ID: <1321462094-6647-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series consolidates the identity mapping code into idmap.c,
where a single set of page tables (idmap_pgd) are allocated and populated
at init time for use by subsystems such as soft reboot, kexec and CPU
suspend.

A new linker section (.idmap.text) is introduced so that code which
needs to be identity mapped can be annotated with __idmap or, if written
in assembly, placed there explicitly.

CPU suspend, cpu_*_reset and setup_mm_for_reboot are all updated to work
with the new mapping code.

This is currently based on 3.2-rc2, but will be based on Russell's reset
branch when it comes to merging (where the prototype of
setup_mm_for_reboot has changed slightly). Furthermore, I have rebased
my kexec series against this which I will post separately.

Comments welcome.

Cheers,

Will


Will Deacon (4):
  ARM: idmap: populate identity map pgd at init time using .init.text
  ARM: suspend: use idmap_pgd instead of suspend_pgd
  ARM: proc-*.S: place cpu_reset functions into .idmap.text section
  ARM: idmap: use idmap_pgd when setting up mm for reboot

 arch/arm/include/asm/idmap.h      |   11 ++++++++
 arch/arm/kernel/sleep.S           |    2 +
 arch/arm/kernel/suspend.c         |   17 ++----------
 arch/arm/kernel/vmlinux.lds.S     |    1 +
 arch/arm/mm/idmap.c               |   49 ++++++++++++++++++++++++++++++-------
 arch/arm/mm/proc-arm1020.S        |    3 ++
 arch/arm/mm/proc-arm1020e.S       |    3 ++
 arch/arm/mm/proc-arm1022.S        |    3 ++
 arch/arm/mm/proc-arm1026.S        |    3 ++
 arch/arm/mm/proc-arm6_7.S         |    4 +++
 arch/arm/mm/proc-arm720.S         |    3 ++
 arch/arm/mm/proc-arm740.S         |    3 ++
 arch/arm/mm/proc-arm7tdmi.S       |    3 ++
 arch/arm/mm/proc-arm920.S         |    3 ++
 arch/arm/mm/proc-arm922.S         |    3 ++
 arch/arm/mm/proc-arm925.S         |    3 ++
 arch/arm/mm/proc-arm926.S         |    3 ++
 arch/arm/mm/proc-arm940.S         |    3 ++
 arch/arm/mm/proc-arm946.S         |    3 ++
 arch/arm/mm/proc-arm9tdmi.S       |    3 ++
 arch/arm/mm/proc-fa526.S          |    3 ++
 arch/arm/mm/proc-feroceon.S       |    3 ++
 arch/arm/mm/proc-mohawk.S         |    3 ++
 arch/arm/mm/proc-sa110.S          |    3 ++
 arch/arm/mm/proc-sa1100.S         |    3 ++
 arch/arm/mm/proc-v6.S             |    3 ++
 arch/arm/mm/proc-v7.S             |    2 +
 arch/arm/mm/proc-xsc3.S           |    3 ++
 arch/arm/mm/proc-xscale.S         |    3 ++
 include/asm-generic/vmlinux.lds.h |    6 ++++
 30 files changed, 135 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/include/asm/idmap.h

-- 
1.7.4.1
