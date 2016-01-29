From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Fri, 29 Jan 2016 17:59:33 +0800
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <56AB3805.1040308@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 1:22 2016/1/15, Yury Norov wrote:
> This is still RFC because we have no glibc yet, that correspnds new ABI
> introduced here. And so we cannot run tests. LP64 and AARCH32 tests show
> no regression though.
Hi,

Glad to see this version. I hope I could test it. Where could I find the
corresponding glibc? I could not find it in
http://github.com/norov/glibc.git. Or is there a plan to do it?

Besides compat wrappers discussed in these series, is there any other
blockers for upstream? I would suppose everyone is intestested in the
result of LTP...

Regards

Bamvor

>
>   v3: https://lkml.org/lkml/2014/9/3/704
>   v4: https://lkml.org/lkml/2015/4/13/691
>   v5: https://lkml.org/lkml/2015/9/29/911
>
>   v6:
>   - time_t, __kenel_off_t and other types turned to be 32-bit
>     for compatibility reasons (after v5 discussion);
>   - related changes applied to ILP32 syscall table and handlers;
>   - ILP32 VDSO code excluded. It's not mandatory, and caused questions
>     during review process. We definitely make sure we will follow up
>     with a VDSO later on because it is needed for performance reasons;
>   - fixed build issues with different combinations of AARCH32 / ILP32
>     enabling in config;
>   - ILP32 TLS bug fixed;
>   - entry32-common.S introduced to hold wrappers needed for both ILP32
>     and AARCH32_EL0;
>   - documentation updated according to latest changes;
>   - rebased to the current head;
>   - coding style re-checked;
>   - ILP32 syscall table turned around.
>
>     rfc3:
>   - all structures and system calls are just like AARCH32 ones now. with 2
>     exceptions: syscalls that take 64-bit parameter in 2 32-bit regosters
>     are replaced with LP64 version; struct rt_sigframe is constructed both
>     from LP64 and AARCH32 fields to be consistent with AARCH64 register set;
>   - documentation rewritten accordingly;
>   - common code for all 3 ABIs is moved to separated files for easy use,
>     new headers and objects are introduced, incl: is_compat.h, thread_bits.h,
>     signal_common.h, signal32_common.h.
>   - ILP32 VDSO code restored, Nathans comments are addressed;
>   - patch "arm64: ilp32: force IPC_64 in msgctl, shmctl, semctl" removed, as
>     Arnd suggested general solution for IPC_64 problem.
>
>     rfc4:
>   - sys_ilp32.c syscall list is fixed according to comments;
>   - binfmt_elf32.c and binfmt_ilp32.c are introduced to host the code handling
>     corresponding formats;
>   - statfs64, fstsatfs64 and mmap wrappers are removed;
>   - rebased on v4.4-rc8 + http://www.spinics.net/lists/kernel/msg2151759.html
>
>   rfc5:
>   - addressed rfc4 comments;
>   - turned s390 compat wrappers to be generic and applied it to arm64/ilp32.
>     Heiko Carsten and Martin Schwidefsky added to CC as s390 maintainers.
>
>
> Andrew Pinski (6):
>    arm64: ensure the kernel is compiled for LP64
>    arm64: rename COMPAT to AARCH32_EL0 in Kconfig
>    arm64: change some CONFIG_COMPAT over to use CONFIG_AARCH32_EL0
>      instead
>    arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
>    arm64:ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
>      it
>    arm64:ilp32: add ARM64_ILP32 to Kconfig
>
> Bamvor Jian Zhang (1):
>    arm64: compat: change config dependences to aarch32
>
> Philipp Tomsich (1):
>    arm64:ilp32: add vdso-ilp32 and use for signal return
>
> Yury Norov (13):
>    arm64: ilp32: add documentation on the ILP32 ABI for ARM64
>    thread: move thread bits accessors to separated file
>    arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
>    arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
>    arm64: introduce binfmt_elf32.c
>    arm64: ilp32: introduce binfmt_ilp32.c
>    arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32
>    arm64: signal: wrap struct ucontext, fp and lr with struct sigframe
>    arm64: signal: share lp64 signal routines to ilp32
>    arm64: signal32: move ilp32 and aarch32 common code to separated file
>    arm64: ilp32: introduce ilp32-specific handlers for sigframe
>    all: s390: make compat wrappers the generic solution
>    arm64: ilp32: wrap syscalls to remove top 32-bit vulnerability
>
>   Documentation/arm64/ilp32.txt                 |  13 ++
>   arch/Kconfig                                  |   4 +
>   arch/arm64/Kconfig                            |  17 +-
>   arch/arm64/Makefile                           |   5 +
>   arch/arm64/include/asm/compat.h               |  19 +-
>   arch/arm64/include/asm/compat_wrapper.h       |  14 ++
>   arch/arm64/include/asm/elf.h                  |  32 +--
>   arch/arm64/include/asm/fpsimd.h               |   2 +-
>   arch/arm64/include/asm/hwcap.h                |   6 +-
>   arch/arm64/include/asm/is_compat.h            |  84 ++++++++
>   arch/arm64/include/asm/memory.h               |   3 +-
>   arch/arm64/include/asm/processor.h            |  11 +-
>   arch/arm64/include/asm/ptrace.h               |   2 +-
>   arch/arm64/include/asm/signal32.h             |   6 +-
>   arch/arm64/include/asm/signal32_common.h      |  25 +++
>   arch/arm64/include/asm/signal_common.h        |  39 ++++
>   arch/arm64/include/asm/signal_ilp32.h         |  34 ++++
>   arch/arm64/include/asm/thread_info.h          |   3 +-
>   arch/arm64/include/asm/unistd.h               |  11 +-
>   arch/arm64/include/asm/unistd32.h             |   2 +-
>   arch/arm64/include/asm/vdso.h                 |   6 +
>   arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
>   arch/arm64/kernel/Makefile                    |  12 +-
>   arch/arm64/kernel/asm-offsets.c               |   2 +-
>   arch/arm64/kernel/binfmt_elf32.c              |  33 ++++
>   arch/arm64/kernel/binfmt_ilp32.c              |  91 +++++++++
>   arch/arm64/kernel/cpufeature.c                |   8 +-
>   arch/arm64/kernel/cpuinfo.c                   |   4 +-
>   arch/arm64/kernel/entry.S                     |  18 +-
>   arch/arm64/kernel/entry_ilp32.S               |  23 +++
>   arch/arm64/kernel/head.S                      |   2 +-
>   arch/arm64/kernel/hw_breakpoint.c             |  10 +-
>   arch/arm64/kernel/perf_regs.c                 |   2 +-
>   arch/arm64/kernel/process.c                   |   5 +-
>   arch/arm64/kernel/ptrace.c                    |  65 ++++++-
>   arch/arm64/kernel/signal.c                    |  47 +++--
>   arch/arm64/kernel/signal32.c                  |  85 --------
>   arch/arm64/kernel/signal32_common.c           | 115 +++++++++++
>   arch/arm64/kernel/signal_ilp32.c              | 128 ++++++++++++
>   arch/arm64/kernel/sys32.c                     |   1 +
>   arch/arm64/kernel/sys_ilp32.c                 |  69 +++++++
>   arch/arm64/kernel/traps.c                     |   5 +-
>   arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
>   arch/arm64/kernel/vdso-ilp32/Makefile         |  72 +++++++
>   arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 ++++
>   arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  95 +++++++++
>   arch/arm64/kernel/vdso.c                      |  65 +++++--
>   arch/s390/Kconfig                             |   1 +
>   arch/s390/include/asm/compat_wrapper.h        |  25 +++
>   arch/s390/kernel/Makefile                     |   2 +-
>   arch/s390/kernel/compat_linux.c               |   6 +
>   arch/s390/kernel/compat_wrapper.c             | 179 -----------------
>   drivers/clocksource/arm_arch_timer.c          |   2 +-
>   include/linux/compat_wrapper.h                | 270 ++++++++++++++++++++++++++
>   include/linux/ptrace.h                        |   6 +
>   include/linux/thread_bits.h                   |  55 ++++++
>   include/linux/thread_info.h                   |  44 +----
>   include/uapi/asm-generic/unistd.h             | 224 ++++++++++-----------
>   kernel/Makefile                               |   1 +
>   kernel/compat_wrapper.c                       | 167 ++++++++++++++++
>   kernel/ptrace.c                               |  10 +-
>   61 files changed, 1777 insertions(+), 554 deletions(-)
>   create mode 100644 Documentation/arm64/ilp32.txt
>   create mode 100644 arch/arm64/include/asm/compat_wrapper.h
>   create mode 100644 arch/arm64/include/asm/is_compat.h
>   create mode 100644 arch/arm64/include/asm/signal32_common.h
>   create mode 100644 arch/arm64/include/asm/signal_common.h
>   create mode 100644 arch/arm64/include/asm/signal_ilp32.h
>   create mode 100644 arch/arm64/kernel/binfmt_elf32.c
>   create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
>   create mode 100644 arch/arm64/kernel/entry_ilp32.S
>   create mode 100644 arch/arm64/kernel/signal32_common.c
>   create mode 100644 arch/arm64/kernel/signal_ilp32.c
>   create mode 100644 arch/arm64/kernel/sys_ilp32.c
>   create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
>   create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
>   create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
>   create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
>   create mode 100644 arch/s390/include/asm/compat_wrapper.h
>   delete mode 100644 arch/s390/kernel/compat_wrapper.c
>   create mode 100644 include/linux/compat_wrapper.h
>   create mode 100644 include/linux/thread_bits.h
>   create mode 100644 kernel/compat_wrapper.c
>
