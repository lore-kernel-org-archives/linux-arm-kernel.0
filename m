From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Dec 2017 17:58:12 +0000
Subject: [GIT PULL] arm64: fixes for -rc3
Message-ID: <20171207175811.GL15393@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 fixes for 4.15-rc3.

Details in the tag, but they broadly fix some more FP register fallout
from the SVE patches and also some problems with the PGD tracking in our
software PAN emulation code, after we received a crash report from a 3.18
kernel running a backport.

Cheers,

Will

--->8

The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to cb968afc789821cdf9e17e79ef08ab90e5bae0f2:

  arm64/sve: Avoid dereference of dead task_struct in KVM guest entry (2017-12-06 19:08:05 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix SW PAN pgd shadowing for kernel threads, EFI and exiting user tasks

- Fix FP register leak when a task_struct is re-allocated

- Fix potential use-after-free in FP state tracking used by KVM

----------------------------------------------------------------
Dave Martin (3):
      arm64: fpsimd: Prevent registers leaking from dead tasks
      arm64: fpsimd: Abstract out binding of task's fpsimd context to the cpu.
      arm64/sve: Avoid dereference of dead task_struct in KVM guest entry

Will Deacon (2):
      arm64: SW PAN: Point saved ttbr0 at the zero page when switching to init_mm
      arm64: SW PAN: Update saved ttbr0 value on enter_lazy_tlb

 arch/arm64/include/asm/efi.h         |  4 +--
 arch/arm64/include/asm/mmu_context.h | 46 ++++++++++++++++----------------
 arch/arm64/kernel/fpsimd.c           | 51 +++++++++++++++++++++---------------
 arch/arm64/kernel/process.c          |  9 +++++++
 4 files changed, 63 insertions(+), 47 deletions(-)
