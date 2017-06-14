From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 14 Jun 2017 23:16:11 +0300
Subject: your mail
In-Reply-To: <20170604120009.342-1-ynorov@caviumnetworks.com>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
Message-ID: <20170614201611.skc6k26nmnc254vw@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, all.

Thank you for your time on reviewing the series. I really appreciate it.

This is the updated version where I tried to address all comments:
https://github.com/norov/linux/commits/ilp32-20170613.4

(3 last patches here is the Andrew Pinski's rework of vdso rebased on
ilp32 series)

If nothing will come here on review, I'll send v8 at the beginning of
the next week. Is this plan OK?

And this is the backport on the v4.11 kernel:
https://github.com/norov/linux/commits/ilp32-4.11.4

Yury

On Sun, Jun 04, 2017 at 02:59:49PM +0300, Yury Norov wrote:
> Subject: [PATCH v7 resend 2 00/20] ILP32 for ARM64
> 
> Hi Catalin,
>  
> Here is a rebase of latest kernel patchset against next-20170602. There's almost
> no changes, but there are some conflicts that are not trivial, and I'd like to
> refresh the submission therefore.
> 
> How are your experiments with testing and benchmarking of ILP32 are going? In
> my current tests I see 0 failures on LTP. Benchmarking on SPEC CPU2006 and
> LMBench shows no difference for LP64 and expected performance boost for ILP32
> (compared to LP64 results).
> 
> Steve Ellcey is handling upstream submission of Glibc patches. The patches are
> ready and have been reviewed and reworked per community?s comments. There are
> no outstanding userspace ABI issues from Glibc. Glibc submission is now waiting
> on ILP32 kernel submission.
> 
> Catalin, regarding rootfs, is OpenSuSe?s build sufficient for your experiments?
> I?ve also seen Wookey merging patches for ILP32 triplet to binutils and pushing
> them to Debian.
> 
> One last thing I wanted to check with you about is ILP32 PCS - does, in your
> view, ARM Ltd. needs to publish any additional docs for ABI to become official?
> 
> Below is the regular description.
> 
> Thanks.
> Yury
> 
> --------
> 
> This series enables aarch64 with ilp32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t is is used by new userspace). Also it
> deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> This version is based on linux-next from 2017-03-01. It works with
> glibc-2.25, and tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> Patches 1, 2, 3 and 8 are general, and may be applied separately.
> 
> This is the rebase of v7 - still no major changes has been made.
> 
> Kernel and GLIBC trees:
> https://github.com/norov/linux/tree/ilp32-20170602
> https://github.com/norov/glibc/tree/dev9
> 
> (GLIBC patches are managed by Steve Ellcey, so my tree is only for
> reference.)
> 
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: RFC nowrap:  https://lkml.org/lkml/2016/6/17/990
> v7: RFC2 nowrap: https://lkml.org/lkml/2016/8/17/245
> v7: RFC3 nowrap: https://lkml.org/lkml/2016/10/21/883
> v7: https://lkml.org/lkml/2017/1/9/213
> v7: Resend: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/490801.html
> v7: Resend 2:
>     - vdso-ilp32 Makefile synced with lp64 Makefile (patch 19);
>     - rebased on next-20170602.
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
>   32-bit ABI: introduce ARCH_32BIT_OFF_T config option
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
>  arch/Kconfig                                  |   4 +
>  arch/arc/Kconfig                              |   1 +
>  arch/arc/include/uapi/asm/unistd.h            |   1 +
>  arch/arm/Kconfig                              |   1 +
>  arch/arm64/Kconfig                            |  19 ++-
>  arch/arm64/Makefile                           |   8 ++
>  arch/arm64/include/asm/compat.h               |  19 +--
>  arch/arm64/include/asm/elf.h                  |  37 ++----
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
>  arch/arm64/kernel/binfmt_elf32.c              |  38 ++++++
>  arch/arm64/kernel/binfmt_ilp32.c              |  85 +++++++++++++
>  arch/arm64/kernel/cpufeature.c                |   8 +-
>  arch/arm64/kernel/cpuinfo.c                   |  20 +--
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
>  arch/arm64/kernel/vdso.c                      |  69 +++++++++--
>  arch/arm64/kernel/vdso/gettimeofday.S         |  20 ++-
>  arch/arm64/kernel/vdso/vdso.S                 |   6 +-
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
>  include/linux/thread_info.h                   |  66 ++--------
>  include/uapi/asm-generic/unistd.h             |  10 +-
>  93 files changed, 1601 insertions(+), 413 deletions(-)
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
