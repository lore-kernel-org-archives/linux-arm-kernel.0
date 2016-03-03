From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  3 Mar 2016 19:44:13 +0100
Subject: [PATCH v2 0/3] arm64: more granular KASLR
Message-ID: <1457030656-29584-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out we can squeeze out 5 bits of additional KASLR entropy in the
new arm64 implementation. This is based on the observation that the minimal
2 MB alignment of the kernel image is only required for kernels that are
non-relocatable, and since KASLR already implies a relocatable kernel
anyway, we get this additional wiggle room for free.

This v2 has been updated to only randomize to the extent that it does not
affect mapping efficiency, i.e., 64 KB unless CONFIG_DEBUG_ALIGN_RODATA is
set, in which case the original 2 MB alignment is retained. This series now
applies on top of my series 'arm64: simplify and optimize kernel mapping'
that I sent out today as well [1]

The idea is that, since we need to fix up all absolute symbol references
anyway, the hardcoded virtual start address of the kernel does not need to
be 2 MB aligned (+ TEXT_OFFSET), and the only thing we need to ensure is
that the physical misalignment and the virtual misalignment are equal modulo
the swapper block size.

Patch #1 removes the explicit mapping of the TEXT_OFFSET region below the
kernel, and only maps it if the rounding to swapper block size of the kernel
start address ends up covering it.

Patch #2 updates the early boot code to treat the physical misalignment as
the initial KASLR displacement. Note that this only affects code that is
compiled conditionally, if CONFIG_RANDOMIZE_BASE=y

Patch #3 updates the stub allocation strategy to allow a more granular mapping.
Note that the allocation itself is still rounded to 2 MB as before, to prevent
the early mapping to cover adjacent regions inadvertently. As is the case for
patch #2, this only affects the new code under CONFIG_RANDOMIZE_BASE=y

Sample output from a 4k/4 levels kernel, where we have 30 bits of entropy
in the kernel addresses:

Virtual kernel memory layout:
    modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
    vmalloc : 0xffff000008000000 - 0xffff7bffbfff0000   (126974 GB)
      .init : 0xffff1ef5bbc80000 - 0xffff1ef5bbfc0000   (  3328 KB)
      .text : 0xffff1ef5bb3f0000 - 0xffff1ef5bb9e0000   (  6080 KB)
    .rodata : 0xffff1ef5bb9e0000 - 0xffff1ef5bbc80000   (  2688 KB)
      .data : 0xffff1ef5bbfc0000 - 0xffff1ef5bc050a00   (   579 KB)
    vmemmap : 0xffff7bffc0000000 - 0xffff7fffc0000000   (  4096 GB maximum)
              0xffff7bffc1000000 - 0xffff7bffc5000000   (    64 MB actual)
    fixed   : 0xffff7ffffe7fd000 - 0xffff7ffffec00000   (  4108 KB)
    PCI I/O : 0xffff7ffffee00000 - 0xffff7fffffe00000   (    16 MB)
    memory  : 0xffffc8c000000000 - 0xffffc8c100000000   (  4096 MB)

Changes since v1:
- fixed inverted preprocessor conditional in patch #2
- use 64 KB granularity for all page sizes, to align with the kernel segment
  alignment
- revert to 2 MB granularity if CONFIG_DEBUG_ALIGN_RODATA=y

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/483711

Ard Biesheuvel (3):
  arm64: don't map TEXT_OFFSET bytes below the kernel if we can avoid it
  arm64: kaslr: deal with physically misaligned kernel images
  arm64: kaslr: increase randomization granularity

 arch/arm64/kernel/head.S                  | 20 ++++++++++++++------
 arch/arm64/kernel/image.h                 |  2 +-
 arch/arm64/kernel/kaslr.c                 |  6 +++---
 drivers/firmware/efi/libstub/arm64-stub.c | 14 +++++++++++---
 4 files changed, 29 insertions(+), 13 deletions(-)

-- 
2.5.0
