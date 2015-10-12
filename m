From: james.morse@arm.com (James Morse)
Date: Mon, 12 Oct 2015 14:17:32 +0100
Subject: [PATCH 0/6] arm64: kernel: Add support for hibernate/suspend-to-disk
Message-ID: <1444655858-26083-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series adds hibernate support for arm64.
The first two patches are borrowed from kexec-v8 [0] and the related
patches [1]. (Patch 2 is superseded by a v5 [2], but its changes to the
cpu hotplug hook are causing a problem.)

Patches 3 and 4 provide some cleanup to the cpu_suspend() API:
* allowing it to be used with a 'finisher' that needs to return success,
* and turn the MMU on early to allow sleep_save_sp to be accessed by VA.

The last patch adds hibernate support, following the x86 approach, it creates
a temporary set of page tables and copies the hibernate_exit code. The
implementation requires that exactly the same kernel is booted on the
same hardware, and that the kernel is loaded at the same physical address.

The amount of user-space cache cleaning code in hibernate.c is annoying.
None of this is arch specific, all modified-harvard architectures will need
to do this. Ideally I would like to move this to the hibernate core code
(and make use of the fancy memory-bitmaps), and use flush_cache_range()
to clean the caches.

This has only been tested on one board - I look forward to hearing how it
works for others!


Thanks,

James


[0] http://lists.infradead.org/pipermail/kexec/2015-March/013432.html
[1] http://lists.infradead.org/pipermail/kexec/2015-May/013709.html
[2] https://lists.linaro.org/pipermail/linaro-kernel/2015-May/021575.html

AKASHI Takahiro (1):
  arm64: kvm: add a cpu tear-down function

Geoff Levand (1):
  arm64: Fold proc-macros.S into assembler.h

James Morse (4):
  arm64: kernel: Rework finisher callback out of __cpu_suspend_enter().
  arm64: Change cpu_resume() to enable mmu early then access sleep_sp by
    va
  arm64: kernel: Include _AC definition in page.h
  arm64: kernel: Add support for hibernate/suspend-to-disk.

 arch/arm/include/asm/kvm_asm.h     |   1 +
 arch/arm/include/asm/kvm_host.h    |   7 +
 arch/arm/include/asm/kvm_mmu.h     |   7 +
 arch/arm/kvm/arm.c                 |  18 ++
 arch/arm/kvm/init.S                |   5 +
 arch/arm/kvm/mmu.c                 |   7 +-
 arch/arm64/Kconfig                 |   3 +
 arch/arm64/include/asm/assembler.h |  48 +++-
 arch/arm64/include/asm/kvm_asm.h   |   1 +
 arch/arm64/include/asm/kvm_host.h  |   8 +
 arch/arm64/include/asm/kvm_mmu.h   |   7 +
 arch/arm64/include/asm/page.h      |   2 +
 arch/arm64/include/asm/suspend.h   |  16 +-
 arch/arm64/kernel/Makefile         |   1 +
 arch/arm64/kernel/asm-offsets.c    |   9 +-
 arch/arm64/kernel/head.S           |   3 +-
 arch/arm64/kernel/hibernate-asm.S  | 133 +++++++++++
 arch/arm64/kernel/hibernate.c      | 441 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c          |   1 -
 arch/arm64/kernel/sleep.S          | 142 ++++--------
 arch/arm64/kernel/suspend.c        | 110 +++++----
 arch/arm64/kernel/vmlinux.lds.S    |  15 ++
 arch/arm64/kvm/hyp-init.S          |  38 +++-
 arch/arm64/mm/cache.S              |   2 -
 arch/arm64/mm/proc-macros.S        |  64 ------
 arch/arm64/mm/proc.S               |  30 +--
 26 files changed, 860 insertions(+), 259 deletions(-)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.1.4
