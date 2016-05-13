From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 12 May 2016 21:22:55 -0700
Subject: arm build failures in -next due to 'sched/core: Add
 switch_mm_irqs_off() and use it in the scheduler'
Message-ID: <20160513042255.GA28453@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

I see various arm build failures in -next. One example is spitz_defconfig.
Bisect points to commit 'sched/core: Add switch_mm_irqs_off() and use it
in the scheduler'. Reverting the commit fixes the problem.

In file included from include/linux/mmu_context.h:4:0,
                 from drivers/usb/gadget/legacy/inode.c:27:
./arch/arm/include/asm/mmu_context.h:
	In function 'finish_arch_post_lock_switch':
./arch/arm/include/asm/mmu_context.h:88:3: error:
	implicit declaration of function 'preempt_enable_no_resched'

This has been going on for a while, so maybe it has been reported already.
If so, sorry for the noise.

Bisect log is attached.

Guenter

---
# bad: [dd1071fe27ec200ddc49a494e1275a8269248843] x86/rwsem: Save and restore all callee-clobbered regs in 32-bit ____down_write()
# good: [44549e8f5eea4e0a41b487b63e616cb089922b99] Linux 4.6-rc7
git bisect start 'HEAD' 'v4.6-rc7'
# good: [b6cf27d48f370bf2d42888921632ae05340aaca9] Merge remote-tracking branch 'crypto/master'
git bisect good b6cf27d48f370bf2d42888921632ae05340aaca9
# bad: [607563e7793b7c4f3ab134dc200552a555ca5cb2] Merge remote-tracking branch 'tip/auto-latest'
git bisect bad 607563e7793b7c4f3ab134dc200552a555ca5cb2
# good: [05454bc3dd6d8c4cff684ea881d79db952030075] Merge remote-tracking branch 'block/for-next'
git bisect good 05454bc3dd6d8c4cff684ea881d79db952030075
# good: [3ed15da0d55d9147f6434fe57db60a5b4059cbfd] Merge remote-tracking branch 'spi/for-next'
git bisect good 3ed15da0d55d9147f6434fe57db60a5b4059cbfd
# good: [25ea4e608611c03ad9829a727f6cc198db952d06] Merge branch 'perf/core'
git bisect good 25ea4e608611c03ad9829a727f6cc198db952d06
# bad: [df9f17497431a073c33aea6994f3b5b53fd89806] manual merge of x86/asm
git bisect bad df9f17497431a073c33aea6994f3b5b53fd89806
# bad: [d10c98b20678fb22506d6c712d7a0af6885001a1] Merge branch 'timers/core'
git bisect bad d10c98b20678fb22506d6c712d7a0af6885001a1
# bad: [b52fad2db5d792d89975cebf2fe1646a7af28ed0] sched/fair: Update rq clock before updating nohz CPU load
git bisect bad b52fad2db5d792d89975cebf2fe1646a7af28ed0
# good: [1f41906a6fda1114debd3898668bd7ab6470ee41] sched/fair: Correctly handle nohz ticks CPU load accounting
git bisect good 1f41906a6fda1114debd3898668bd7ab6470ee41
# bad: [64b7aad5798478ffff52e110878ccaae4c3aaa34] Merge branch 'sched/urgent' into sched/core, to pick up fixes before applying new changes
git bisect bad 64b7aad5798478ffff52e110878ccaae4c3aaa34
# good: [8efd755ac2fe262d4c8d5c9bbe054bb67dae93da] mm/mmu_context, sched/core: Fix mmu_context.h assumption
git bisect good 8efd755ac2fe262d4c8d5c9bbe054bb67dae93da
# bad: [e1074888c326038340a1ada9129d679e661f2ea6] x86/mm: Build arch/x86/mm/tlb.c even on !SMP
git bisect bad e1074888c326038340a1ada9129d679e661f2ea6
# bad: [f98db6013c557c216da5038d9c52045be55cd039] sched/core: Add switch_mm_irqs_off() and use it in the scheduler
git bisect bad f98db6013c557c216da5038d9c52045be55cd039
# first bad commit: [f98db6013c557c216da5038d9c52045be55cd039] sched/core: Add switch_mm_irqs_off() and use it in the scheduler
