From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 2 Feb 2018 11:16:50 +0300
Subject: [PATCH v8 00/20] ILP32 for ARM64
In-Reply-To: <20170619155003.13218-1-ynorov@caviumnetworks.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
Message-ID: <20180202081650.k3lrxravxicorfyo@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, all

(Exclude Bamvor as his email became invalid)

This is 4.15-based kernel.
https://github.com/norov/linux/commits/ilp32-4.15

I tested it with LTP, no regressions found.

Kernel v4.15 incorporates SVE series from Dave Martin, so I updated ILP32
patches to agree with it. SVE-related changes are mostly in patches:
arm64: ilp32: introduce ilp32-specific handlers for sigframe and ucontext
arm64: signal32: move ilp32 and aarch32 common code to separated file
arm64: signal: share lp64 signal structures and routines to ilp32
arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it

Dave kindly reviewed that patches and proposed improvements:
https://www.spinics.net/lists/arm-kernel/msg629221.html

There's no ABI-related changes proposed, or urgent fixes; so I'll rework
signal subsystem during 4.16 cycle.

Are there any news with upstreaming this series?

Thanks,
Yury

On Mon, Jun 19, 2017 at 06:49:43PM +0300, Yury Norov wrote:
> This series enables aarch64 with ilp32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> This version is based on linux-next from 2017-06-16. It works with
> glibc-2.25, and tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> Patches 1, 2, 3 and 8 are general, and may be applied separately.
> 
> Kernel, GLIBC and OpenSUSE-based distro:
> https://github.com/norov/linux/tree/ilp32-20170616.0
> https://github.com/norov/glibc/tree/dev9
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
> 
> (GLIBC patches are managed by Steve Ellcey, so my tree is only for
> reference.)
> 
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: https://lkml.org/lkml/2017/1/9/213
> v8: - off_t referred in patches 2 and 13 stands for userspace type which is
>       underlined in corresponding patch comments and ARCH_32BIT_OFF_T config
>       option description;
>     - __IGNORE_getrlimit and __IGNORE_setrlimit are added to
>       scripts/checksyscalls.sh (patch 3);
>     - for CONFIG_COMPAT, bool changed to def_bool y and 'select COMPAT' is
>       dropped for AARCH32_EL0 and ARM64_ILP32 optiond (patches 5 and 20);
>     - x19 register is used to load TSK_TI_FLAGS in svc path in
>       arch/arm64/kernel/entry.S to avoid register clobbering (patch 14).
>     - ilp32 vdso-related files are syncronized wirh lp64 ones, mostly Makefiles
>       (patch 19);
>     - in arch/arm64/mm/mmap.c, arch_mmap_rnd() swithed to use is_compat_task()
>       (patch 9);
>     - rebased on next-20170616.
> 
> Andrew Pinski (6):
>   arm64: rename COMPAT to AARCH32_EL0 in Kconfig
>   arm64: ensure the kernel is compiled for LP64
>   arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
>   arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
>     it
>   arm64: ilp32: introduce ilp32-specific handlers for sigframe and
>     ucontext
>   arm64:ilp32: add ARM64_ILP32 to Kconfig
> 
> Philipp Tomsich (1):
>   arm64:ilp32: add vdso-ilp32 and use for signal return
> 
> Yury Norov (13):
>   compat ABI: use non-compat openat and open_by_handle_at variants
>   32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
>   asm-generic: Drop getrlimit and setrlimit syscalls from default list
>   arm64: ilp32: add documentation on the ILP32 ABI for ARM64
>   thread: move thread bits accessors to separated file
>   arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
>   arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
>   arm64: introduce binfmt_elf32.c
>   arm64: ilp32: introduce binfmt_ilp32.c
>   arm64: ilp32: share aarch32 syscall handlers
>   arm64: signal: share lp64 signal routines to ilp32
>   arm64: signal32: move ilp32 and aarch32 common code to separated file
>   arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32
> 
>  Documentation/arm64/ilp32.txt                 |  45 +++++++
>  arch/Kconfig                                  |  15 +++
>  arch/arc/Kconfig                              |   1 +
>  arch/arc/include/uapi/asm/unistd.h            |   1 +
>  arch/arm/Kconfig                              |   1 +
>  arch/arm64/Kconfig                            |  17 ++-
>  arch/arm64/Makefile                           |   8 ++
>  arch/arm64/include/asm/compat.h               |  19 +--
>  arch/arm64/include/asm/elf.h                  |  40 ++----
>  arch/arm64/include/asm/fpsimd.h               |   2 +-
>  arch/arm64/include/asm/ftrace.h               |   2 +-
>  arch/arm64/include/asm/hwcap.h                |   6 +-
>  arch/arm64/include/asm/is_compat.h            |  90 ++++++++++++++
>  arch/arm64/include/asm/memory.h               |   5 +-
>  arch/arm64/include/asm/processor.h            |  11 +-
>  arch/arm64/include/asm/ptrace.h               |   2 +-
>  arch/arm64/include/asm/seccomp.h              |   2 +-
>  arch/arm64/include/asm/signal32.h             |   9 +-
>  arch/arm64/include/asm/signal32_common.h      |  27 ++++
>  arch/arm64/include/asm/signal_common.h        |  33 +++++
>  arch/arm64/include/asm/signal_ilp32.h         |  38 ++++++
>  arch/arm64/include/asm/syscall.h              |   2 +-
>  arch/arm64/include/asm/thread_info.h          |   4 +-
>  arch/arm64/include/asm/unistd.h               |   6 +-
>  arch/arm64/include/asm/vdso.h                 |   6 +
>  arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
>  arch/arm64/include/uapi/asm/unistd.h          |  13 ++
>  arch/arm64/kernel/Makefile                    |   8 +-
>  arch/arm64/kernel/asm-offsets.c               |   9 +-
>  arch/arm64/kernel/binfmt_elf32.c              |  37 ++++++
>  arch/arm64/kernel/binfmt_ilp32.c              |  85 +++++++++++++
>  arch/arm64/kernel/cpufeature.c                |   8 +-
>  arch/arm64/kernel/cpuinfo.c                   |   8 +-
>  arch/arm64/kernel/entry.S                     |  34 +++++-
>  arch/arm64/kernel/entry32.S                   |  80 ------------
>  arch/arm64/kernel/entry32_common.S            | 107 ++++++++++++++++
>  arch/arm64/kernel/entry_ilp32.S               |  22 ++++
>  arch/arm64/kernel/head.S                      |   2 +-
>  arch/arm64/kernel/hw_breakpoint.c             |   8 +-
>  arch/arm64/kernel/perf_regs.c                 |   2 +-
>  arch/arm64/kernel/process.c                   |   7 +-
>  arch/arm64/kernel/ptrace.c                    |  80 ++++++++++--
>  arch/arm64/kernel/signal.c                    | 102 ++++++++++------
>  arch/arm64/kernel/signal32.c                  | 107 ----------------
>  arch/arm64/kernel/signal32_common.c           | 135 ++++++++++++++++++++
>  arch/arm64/kernel/signal_ilp32.c              | 170 ++++++++++++++++++++++++++
>  arch/arm64/kernel/sys_ilp32.c                 | 100 +++++++++++++++
>  arch/arm64/kernel/traps.c                     |   5 +-
>  arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
>  arch/arm64/kernel/vdso-ilp32/Makefile         |  80 ++++++++++++
>  arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 +++++
>  arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  95 ++++++++++++++
>  arch/arm64/kernel/vdso.c                      |  63 ++++++++--
>  arch/arm64/kernel/vdso/gettimeofday.S         |  20 ++-
>  arch/arm64/kernel/vdso/vdso.S                 |   6 +-
>  arch/arm64/mm/mmap.c                          |   2 +-
>  arch/blackfin/Kconfig                         |   1 +
>  arch/c6x/include/uapi/asm/unistd.h            |   1 +
>  arch/cris/Kconfig                             |   1 +
>  arch/frv/Kconfig                              |   1 +
>  arch/h8300/Kconfig                            |   1 +
>  arch/h8300/include/uapi/asm/unistd.h          |   1 +
>  arch/hexagon/Kconfig                          |   1 +
>  arch/hexagon/include/uapi/asm/unistd.h        |   1 +
>  arch/m32r/Kconfig                             |   1 +
>  arch/m68k/Kconfig                             |   1 +
>  arch/metag/Kconfig                            |   1 +
>  arch/metag/include/uapi/asm/unistd.h          |   1 +
>  arch/microblaze/Kconfig                       |   1 +
>  arch/mips/Kconfig                             |   1 +
>  arch/mn10300/Kconfig                          |   1 +
>  arch/nios2/Kconfig                            |   1 +
>  arch/nios2/include/uapi/asm/unistd.h          |   1 +
>  arch/openrisc/Kconfig                         |   1 +
>  arch/openrisc/include/uapi/asm/unistd.h       |   1 +
>  arch/parisc/Kconfig                           |   1 +
>  arch/powerpc/Kconfig                          |   1 +
>  arch/score/Kconfig                            |   1 +
>  arch/score/include/uapi/asm/unistd.h          |   1 +
>  arch/sh/Kconfig                               |   1 +
>  arch/sparc/Kconfig                            |   1 +
>  arch/tile/Kconfig                             |   1 +
>  arch/tile/include/uapi/asm/unistd.h           |   1 +
>  arch/tile/kernel/compat.c                     |   3 +
>  arch/unicore32/Kconfig                        |   1 +
>  arch/unicore32/include/uapi/asm/unistd.h      |   1 +
>  arch/x86/Kconfig                              |   1 +
>  arch/x86/um/Kconfig                           |   1 +
>  arch/xtensa/Kconfig                           |   1 +
>  drivers/clocksource/arm_arch_timer.c          |   2 +-
>  include/linux/fcntl.h                         |   2 +-
>  include/linux/thread_bits.h                   |  63 ++++++++++
>  include/linux/thread_info.h                   |  65 ++--------
>  include/uapi/asm-generic/unistd.h             |  10 +-
>  scripts/checksyscalls.sh                      |   5 +
>  95 files changed, 1606 insertions(+), 407 deletions(-)
>  create mode 100644 Documentation/arm64/ilp32.txt
>  create mode 100644 arch/arm64/include/asm/is_compat.h
>  create mode 100644 arch/arm64/include/asm/signal32_common.h
>  create mode 100644 arch/arm64/include/asm/signal_common.h
>  create mode 100644 arch/arm64/include/asm/signal_ilp32.h
>  create mode 100644 arch/arm64/kernel/binfmt_elf32.c
>  create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
>  create mode 100644 arch/arm64/kernel/entry32_common.S
>  create mode 100644 arch/arm64/kernel/entry_ilp32.S
>  create mode 100644 arch/arm64/kernel/signal32_common.c
>  create mode 100644 arch/arm64/kernel/signal_ilp32.c
>  create mode 100644 arch/arm64/kernel/sys_ilp32.c
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
>  create mode 100644 include/linux/thread_bits.h
> 
> -- 
> 2.11.0
