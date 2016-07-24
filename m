From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:14 -0400
Subject: [PATCH v5 00/15] allow BFLT executables on systems with a MMU
Message-ID: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series provides the necessary changes to allow "flat" executable
binaries meant for no-MMU systems to actually run on systems with a MMU.
Also thrown in are various cleanups to binfmt_flat.c.

This can also be found in the following git repo:

	git://git.linaro.org/people/nicolas.pitre/linux binfmt_flat_with_mmu

*Why?*

Because developing and testing natively on a large system with lots of
RAM makes it so much more convenient to use all the existing profiling
tools and debugging facilities that a kernel with lots of RAM can give.
And incidentally, those systems with lots of RAM all have a MMU.

*Why not use elf_fdpic?*

The flat executable format is simple with very small footprint
overhead, either in the executables themselves or kernel support.
This makes the flat format more suitable than elf_fdpic for very small
single user-app embedded systems.

And while elf_fdpic binaries can run on MMU systems, flat binaries still
couldn't, which just felt wrong.

So here it is. The no-MMU support should remain unaffected, confirmed by
Greg Ungerer. Tested with MMU on ARM and M68K.

Changes since v4:

- Isolated architecture specific changes in their own patches for easier
  review through their own path to mainline.

- Added needed m68k register fixup from Greg Ungerer.

Changes since v3:

- Small cosmetic changes to pr_*().

- Addressed most important checkpatch complaints on the whole source file
  and patches in this seris.

Changes since  v2:

- Added protection against a corrupted header that could have caused nasty
  overflows etc. Suggested by Alan Cox.

- printk() modernization. Suggested by Greg Ungerer / Geert Uytterhoeven.

- Added Greg Ungerer's reviewed-by tag.

Changes since v1:

- Removed SuperH and Xtensa from the Kconfig rule as they fail to build
  due to lack of get/put_unaligned_user().

- Clarified some commit logs a bit.

diffstat:

 arch/arm/include/asm/flat.h       |   5 +-
 arch/m68k/include/asm/flat.h      |  11 +-
 arch/m68k/include/asm/processor.h |   2 -
 fs/Kconfig.binfmt                 |   3 +-
 fs/binfmt_elf_fdpic.c             |  38 +--
 fs/binfmt_flat.c                  | 525 ++++++++++++++++++--------------
 fs/exec.c                         |  33 ++
 include/linux/binfmts.h           |   2 +
 8 files changed, 345 insertions(+), 274 deletions(-)
