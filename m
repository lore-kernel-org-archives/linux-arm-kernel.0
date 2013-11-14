From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Thu, 14 Nov 2013 16:34:04 +0530
Subject: [PATCH 0/2] ARM64: perf: add support for the perf registers and
 dwarf unwinding
In-Reply-To: <1382108078-8807-1-git-send-email-jean.pihet@linaro.org>
References: <1382108078-8807-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <CA+b37P0YCPm+4PWJobTOv02M0-mZyf4w02fDrBVYT0wfPL_hpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

I have applied this patchset on aarch64 upstream branch,cross-compiled
for arm64 and try running some tests for hardware breakpoints.

I cross-compiled perf using linaro toolchain
"gcc-linaro-aarch64-linux-gnu-4.7-2013.04-20130415_linux" as
 $ cd tools/perf/
 $ make LDFLAGS=-static ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-

Copied the static binary to my initrd image and tried running tests to
place hw_breakpoint on an kernel symbol as:

 # perf record -e "mem:0xffffffc00013f640:x"
737
738  usage: perf record [<options>] [<command>]
739     or: perf record [<options>] -- <command> [<options>]
740
741     -e, --event <event>   event selector. use 'perf list' to list
available events
742         --filter <filter>
743                           event filter
744     -p, --pid <pid>       record events on existing process id
.....

Somehow perf is not able run record, seems not accepting any
arguments. Do you have any idea what could be going wrong? How did you
verify/cross-compile perf? Is the tool-chain version wrong?

Thanks,
Sandeepa

On 18 October 2013 20:24, Jean Pihet <jean.pihet@linaro.org> wrote:
> From: Jean Pihet <jean.pihet@newoldbits.com>
>
> This patch implements the functions required for the perf registers API,
> allowing the perf tool to interface kernel register dumps with libunwind
> in order to provide userspace backtracing.
> Only the general purpose user space registers are exported, i.e.:
>  PERF_REG_ARM_X0,
>  ...
>  PERF_REG_ARM_X28,
>  PERF_REG_ARM_FP,
>  PERF_REG_ARM_LR,
>  PERF_REG_ARM_SP,
>  PERF_REG_ARM_PC
> and not the PERF_REG_ARM_V* registers.
>
> Dependencies:
>  . if present, libunwind >= 1.1 is needed to prevent a segfault when
>    parsing the dwarf info,
>  . libunwind needs to be configured with --enable-debug-frame. Note:
>    --enable-debug-frame is automatically selected on ARM, NOT on ARM64.
>
> The generated perf binary has been tested on ARMv8 (using the
> foundation model simulator) and x86_64, using the following commands:
>  perf record -g [fp,dwarf] -- <binary>
>  perf report --sort symbol --call-graph --stdio
>
>
> Jean Pihet (2):
>   ARM64: perf: add support for perf registers API
>   ARM64: perf: wire up perf_regs and unwind support
>
>  arch/arm64/Kconfig                        |  2 +
>  arch/arm64/include/uapi/asm/Kbuild        |  1 +
>  arch/arm64/include/uapi/asm/perf_regs.h   | 40 ++++++++++++++
>  arch/arm64/kernel/Makefile                |  1 +
>  arch/arm64/kernel/perf_regs.c             | 29 ++++++++++
>  tools/perf/arch/arm64/Makefile            |  7 +++
>  tools/perf/arch/arm64/include/perf_regs.h | 88 +++++++++++++++++++++++++++++++
>  tools/perf/arch/arm64/util/dwarf-regs.c   | 81 ++++++++++++++++++++++++++++
>  tools/perf/arch/arm64/util/unwind.c       | 82 ++++++++++++++++++++++++++++
>  tools/perf/config/Makefile                |  6 +++
>  10 files changed, 337 insertions(+)
>  create mode 100644 arch/arm64/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/arm64/kernel/perf_regs.c
>  create mode 100644 tools/perf/arch/arm64/Makefile
>  create mode 100644 tools/perf/arch/arm64/include/perf_regs.h
>  create mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/arm64/util/unwind.c
>
> --
> 1.7.11.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
