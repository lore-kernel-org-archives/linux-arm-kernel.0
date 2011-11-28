From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Nov 2011 18:28:51 +0000
Subject: [PATCH v2 0/6] Consolidate identity mapping code in idmap.c
Message-ID: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 2 of the patch series originally posted here:

 http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073033.html

Changes from v1 include:
	* Updated following Catalin's comments
	* Rebased onto rmk/devel-stable
	* Includes update to SMP booting so that the idmap_pgd can be
	  used there too

This is a pre-requisite for my kexec patches, which I will post separately.

All feedback welcome.

Thanks,

Will


Will Deacon (6):
  ARM: idmap: populate identity map pgd at init time using .init.text
  ARM: suspend: use idmap_pgd instead of suspend_pgd
  ARM: proc-*.S: place cpu_reset functions into .idmap.text section
  ARM: idmap: use idmap_pgd when setting up mm for reboot
  ARM: head.S: only include __turn_mmu_on in the initial identity
    mapping
  ARM: SMP: use idmap_pgd for mapping MMU enable during secondary
    booting

 arch/arm/include/asm/idmap.h   |   14 +++++++++
 arch/arm/include/asm/pgtable.h |    3 --
 arch/arm/kernel/head.S         |   18 ++++++-----
 arch/arm/kernel/sleep.S        |    2 +
 arch/arm/kernel/smp.c          |   32 +-------------------
 arch/arm/kernel/suspend.c      |   18 ++---------
 arch/arm/kernel/vmlinux.lds.S  |    7 ++++
 arch/arm/mm/idmap.c            |   63 +++++++++++++++++++---------------------
 arch/arm/mm/proc-arm1020.S     |    3 ++
 arch/arm/mm/proc-arm1020e.S    |    3 ++
 arch/arm/mm/proc-arm1022.S     |    3 ++
 arch/arm/mm/proc-arm1026.S     |    3 ++
 arch/arm/mm/proc-arm6_7.S      |    4 ++
 arch/arm/mm/proc-arm720.S      |    3 ++
 arch/arm/mm/proc-arm740.S      |    3 ++
 arch/arm/mm/proc-arm7tdmi.S    |    3 ++
 arch/arm/mm/proc-arm920.S      |    3 ++
 arch/arm/mm/proc-arm922.S      |    3 ++
 arch/arm/mm/proc-arm925.S      |    3 ++
 arch/arm/mm/proc-arm926.S      |    3 ++
 arch/arm/mm/proc-arm940.S      |    3 ++
 arch/arm/mm/proc-arm946.S      |    3 ++
 arch/arm/mm/proc-arm9tdmi.S    |    3 ++
 arch/arm/mm/proc-fa526.S       |    3 ++
 arch/arm/mm/proc-feroceon.S    |    3 ++
 arch/arm/mm/proc-mohawk.S      |    3 ++
 arch/arm/mm/proc-sa110.S       |    3 ++
 arch/arm/mm/proc-sa1100.S      |    3 ++
 arch/arm/mm/proc-v6.S          |    3 ++
 arch/arm/mm/proc-v7.S          |    2 +
 arch/arm/mm/proc-xsc3.S        |    3 ++
 arch/arm/mm/proc-xscale.S      |    3 ++
 32 files changed, 140 insertions(+), 89 deletions(-)
 create mode 100644 arch/arm/include/asm/idmap.h

-- 
1.7.4.1
