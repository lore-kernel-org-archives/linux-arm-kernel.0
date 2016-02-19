From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Feb 2016 16:29:29 +0000
Subject: [GIT PULL] arm64: fixes for -rc5
Message-ID: <20160219162928.GM27062@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are some more arm64 fixes for 4.5. This has mostly come from Yang
Shi, who saw some issues under -rt that also affect mainline. The rest
of it is pretty small, but still worth having.

We've got an old issue outstanding with valid_user_regs which will
likely wait until 4.6 (since it would really benefit from some time in
-next) and another issue with kasan and idle which should be fixed next
week.

Apart from that, pretty quiet here (and still no sign of the THP issue
reported on s390...)

Will

--->8

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 52d7523d84d534c241ebac5ac89f5c0a6cb51e41:

  arm64: mm: allow the kernel to handle alignment faults on user accesses (2016-02-19 12:20:37 +0000)

----------------------------------------------------------------
arm64 fixes:

- Allow EFI stub to use strnlen(), which is required by recent libfdt

- Avoid smp_processor_id() in preempt context during unwinding

- Avoid false Kasan warnings during unwinding

- Ensure early devices are picked up by the IOMMU DMA ops

- Avoid rebuilding the kernel for the 'install' target

- Run fixup handlers for alignment faults on userspace access

----------------------------------------------------------------
EunTaik Lee (1):
      arm64: mm: allow the kernel to handle alignment faults on user accesses

Jeremy Linton (1):
      arm/arm64: crypto: assure that ECB modes don't require an IV

Marek Szyprowski (1):
      arm64: dma-mapping: fix handling of devices registered before arch_initcall

Masahiro Yamada (1):
      arm64: kbuild: make "make install" not depend on vmlinux

Thierry Reding (1):
      arm64/efi: Make strnlen() available to the EFI namespace

Will Deacon (1):
      arm64: debug: re-enable irqs before sending breakpoint SIGTRAP

Yang Shi (2):
      arm64: disable kasan when accessing frame->fp in unwind_frame
      arm64: make irq_stack_ptr more robust

 arch/arm/crypto/aes-ce-glue.c      |  4 ++--
 arch/arm64/Makefile                |  2 +-
 arch/arm64/boot/Makefile           |  4 ++--
 arch/arm64/boot/install.sh         | 14 +++++++++++
 arch/arm64/crypto/aes-glue.c       |  4 ++--
 arch/arm64/kernel/debug-monitors.c | 48 +++++++++++++++++---------------------
 arch/arm64/kernel/image.h          |  1 +
 arch/arm64/kernel/stacktrace.c     | 17 +++++++-------
 arch/arm64/kernel/traps.c          | 11 ++++++++-
 arch/arm64/lib/strnlen.S           |  2 +-
 arch/arm64/mm/dma-mapping.c        |  4 ++++
 arch/arm64/mm/fault.c              |  9 ++++++-
 12 files changed, 75 insertions(+), 45 deletions(-)
