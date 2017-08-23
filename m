From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Aug 2017 17:24:54 +0100
Subject: [GIT PULL] arm64: Late fixes for 4.13
Message-ID: <20170823162453.GC32528@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these late arm64 fixes for 4.13. They fix very early boot
failures with KASLR where the early mapping of the kernel is incorrect,
so the failure mode looks like a hang with no output. There's also a
signal-handling fix when a uaccess routine faults with a fatal signal
pending, which could be used to create unkillable user tasks using
userfaultfd and finally a state leak fix for the floating pointer registers
across a call to exec().

We're still seeing some random issues crop up (inode memory corruption
and spinlock recursion) but we've not managed to reproduce things reliably
enough to debug or bisect them yet.

Please pull,

Will

--->8

The following changes since commit 14ccee78fc82f5512908f4424f541549a5705b89:

  Linux 4.13-rc6 (2017-08-20 14:13:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to a067d94d37ed590fd17684d18c3edf52110d305a:

  arm64: kaslr: Adjust the offset to avoid Image across alignment boundary (2017-08-22 18:15:42 +0100)

----------------------------------------------------------------
Late arm64 fixes:

- Fix very early boot failures with KASLR enabled

- Fix fatal signal handling on userspace access from kernel

- Fix leakage of floating point register state across exec()

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: kaslr: ignore modulo offset when validating virtual displacement

Catalin Marinas (1):
      arm64: kaslr: Adjust the offset to avoid Image across alignment boundary

Dave Martin (1):
      arm64: fpsimd: Prevent registers leaking across exec

Mark Rutland (1):
      arm64: mm: abort uaccess retries upon fatal signal

 arch/arm64/kernel/fpsimd.c |  2 ++
 arch/arm64/kernel/head.S   |  1 -
 arch/arm64/kernel/kaslr.c  | 20 +++++++++++---------
 arch/arm64/mm/fault.c      |  5 ++++-
 4 files changed, 17 insertions(+), 11 deletions(-)
