From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 29 Mar 2010 12:26:26 +0300
Subject: [RFC 00/10] Initial implementation of kdump for ARM
Message-ID: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series implements initial support for crashdumps on ARM. Mostly this stuff
is adapted from other architectures (namely x86). I've been testing this on my
N900 which is OMAP3430 based. I've used LKDTM module to crash the kernel in
different places.

This works as follows (see also Documentation/kdump/kdump.txt):

	1. Memory is reserved for the dump capture kernel by using kernel command
	   line option: crashkernel=size at start
	2. Userspace tool prepares vmcore header based on /proc/iomem and passes
	   this and the dump capture kernel using kexec system call. We also
	   reserve primary kernel memory by passing mem=size$start options to
	   the dump capture kernel.
	3. When crash happens, primary kernel saves current machine state and
	   passes control to the dump capture kernel
	4. Dump capture kernel makes /proc/vmcore available to userspace which
	   can use it as it likes (for example copying it to some media etc.).

I also have rough modifications for kexec-tools which makes it possible to load
the dump capture kernel and related information. I've planned to clean those and
send them to kexec mailing list after this kernel part is finished. I also have
some gdb macros adapted from Documentation/kdump/gdbmacros.txt that work on ARM
kernel crashdumps, in case someone is interested.

When ARM switches to use LMB, some of the patches that reserve bootmem need
to be reworked.

Note that these probably don't work with SMP systems (I don't have such hardware
available).

I would really appreciate any comments and suggestions.

Thanks,
MW

Mika Westerberg (10):
  arm: kdump: reserve memory for crashkernel
  arm: kdump: implement crash_setup_regs()
  arm: kdump: implement machine_crash_shutdown()
  arm: kdump: skip indirection page when crashing
  arm: kdump: make kexec work in interrupt context
  arm: kdump: implement copy_oldmem_page()
  arm: allow passing an ELF64 header to elf_check_arch()
  arm: kdump: add support for elfcorehdr= parameter
  arm: implement reserve memory early parameter
  arm: kdump: add CONFIG_CRASH_DUMP Kconfig option

 arch/arm/Kconfig                  |   11 ++++
 arch/arm/Makefile                 |   10 ++++
 arch/arm/include/asm/elf.h        |    4 +-
 arch/arm/include/asm/kexec.h      |   35 ++++++++++++-
 arch/arm/include/asm/setup.h      |    4 ++
 arch/arm/kernel/Makefile          |    1 +
 arch/arm/kernel/crash_dump.c      |   82 +++++++++++++++++++++++++++++++
 arch/arm/kernel/elf.c             |    6 ++-
 arch/arm/kernel/machine_kexec.c   |    4 ++
 arch/arm/kernel/relocate_kernel.S |    6 ++
 arch/arm/kernel/setup.c           |   98 ++++++++++++++++++++++++++++++++++--
 arch/arm/mm/init.c                |   25 +++++++++-
 arch/arm/mm/mmu.c                 |   10 ++--
 13 files changed, 277 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/kernel/crash_dump.c
