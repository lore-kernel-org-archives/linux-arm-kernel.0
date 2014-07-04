From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 4 Jul 2014 19:09:17 +0800
Subject: [PATCH] ARM: convert all "mov.* pc, reg" to "bx reg" for ARMv6+
In-Reply-To: <E1X20Rs-00082S-KI@rmk-PC.arm.linux.org.uk>
References: <E1X20Rs-00082S-KI@rmk-PC.arm.linux.org.uk>
Message-ID: <CAN1soZz=VoUnhVs3JV5qdtizKnV7rYTv6Gp_zhRywRG5wPUwdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 11:58 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> ARMv6 and greater introduced a new instruction ("bx") which can be used
> to return from function calls.  Recent CPUs perform better when the
> "bx lr" instruction is used rather than the "mov pc, lr" instruction,
> and this sequence is strongly recommended to be used by the ARM
> architecture manual (section A.4.1.1).
>
> We provide a new macro "ret" with all its variants for the condition
> code which will resolve to the appropriate instruction.
>
> Rather than doing this piecemeal, and miss some instances, change all
> the "mov pc" instances to use the new macro, with the exception of
> the "movs" instruction and the kprobes code.  This allows us to detect
> the "mov pc, lr" case and fix it up - and also gives us the possibility
> of deploying this for other registers depending on the CPU selection.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/crypto/aes-armv4.S              |  3 ++-
>  arch/arm/include/asm/assembler.h         | 21 +++++++++++++++
>  arch/arm/include/asm/entry-macro-multi.S |  2 +-
>  arch/arm/kernel/debug.S                  | 10 ++++----
>  arch/arm/kernel/entry-armv.S             | 42 +++++++++++++++---------------
>  arch/arm/kernel/entry-common.S           | 13 +++++-----
>  arch/arm/kernel/entry-header.S           | 14 ----------
>  arch/arm/kernel/fiqasm.S                 |  4 +--
>  arch/arm/kernel/head-common.S            |  7 ++---
>  arch/arm/kernel/head-nommu.S             |  8 +++---
>  arch/arm/kernel/head.S                   | 18 ++++++-------
>  arch/arm/kernel/hyp-stub.S               |  6 ++---
>  arch/arm/kernel/iwmmxt.S                 | 10 ++++----
>  arch/arm/kernel/relocate_kernel.S        |  3 ++-
>  arch/arm/kernel/sleep.S                  |  2 +-
>  arch/arm/kvm/init.S                      |  3 ++-
>  arch/arm/lib/ashldi3.S                   |  3 ++-
>  arch/arm/lib/ashrdi3.S                   |  3 ++-
>  arch/arm/lib/backtrace.S                 |  2 +-
>  arch/arm/lib/bitops.h                    |  5 ++--
>  arch/arm/lib/bswapsdi2.S                 |  5 ++--
>  arch/arm/lib/call_with_stack.S           |  4 +--
>  arch/arm/lib/csumpartial.S               |  2 +-
>  arch/arm/lib/csumpartialcopygeneric.S    |  5 ++--
>  arch/arm/lib/delay-loop.S                | 18 ++++++-------
>  arch/arm/lib/div64.S                     | 13 +++++-----
>  arch/arm/lib/findbit.S                   | 10 ++++----
>  arch/arm/lib/getuser.S                   |  8 +++---
>  arch/arm/lib/io-readsb.S                 |  2 +-
>  arch/arm/lib/io-readsl.S                 |  6 ++---
>  arch/arm/lib/io-readsw-armv3.S           |  4 +--
>  arch/arm/lib/io-readsw-armv4.S           |  2 +-
>  arch/arm/lib/io-writesb.S                |  2 +-
>  arch/arm/lib/io-writesl.S                | 10 ++++----
>  arch/arm/lib/io-writesw-armv3.S          |  4 +--
>  arch/arm/lib/io-writesw-armv4.S          |  4 +--
>  arch/arm/lib/lib1funcs.S                 | 26 +++++++++----------
>  arch/arm/lib/lshrdi3.S                   |  3 ++-
>  arch/arm/lib/memchr.S                    |  2 +-
>  arch/arm/lib/memset.S                    |  2 +-
>  arch/arm/lib/memzero.S                   |  2 +-
>  arch/arm/lib/muldi3.S                    |  3 ++-
>  arch/arm/lib/putuser.S                   | 10 ++++----
>  arch/arm/lib/strchr.S                    |  2 +-
>  arch/arm/lib/strrchr.S                   |  2 +-
>  arch/arm/lib/ucmpdi2.S                   |  5 ++--
>  arch/arm/mach-davinci/sleep.S            |  2 +-
>  arch/arm/mach-ep93xx/crunch-bits.S       |  6 ++---
>  arch/arm/mach-imx/suspend-imx6.S         |  5 ++--
>  arch/arm/mach-mvebu/coherency_ll.S       | 10 ++++----
>  arch/arm/mach-mvebu/headsmp-a9.S         |  3 ++-
>  arch/arm/mach-omap2/sleep44xx.S          |  3 ++-
>  arch/arm/mach-omap2/sram242x.S           |  6 ++---
>  arch/arm/mach-omap2/sram243x.S           |  6 ++---
>  arch/arm/mach-pxa/mioa701_bootresume.S   |  2 +-
>  arch/arm/mach-pxa/standby.S              |  4 +--
>  arch/arm/mach-s3c24xx/sleep-s3c2410.S    |  2 +-
>  arch/arm/mach-s3c24xx/sleep-s3c2412.S    |  2 +-
>  arch/arm/mach-shmobile/headsmp.S         |  3 ++-
>  arch/arm/mach-tegra/sleep-tegra20.S      | 24 ++++++++---------
>  arch/arm/mach-tegra/sleep-tegra30.S      | 14 +++++-----
>  arch/arm/mach-tegra/sleep.S              |  8 +++---
>  arch/arm/mm/cache-fa.S                   | 19 +++++++-------
>  arch/arm/mm/cache-nop.S                  |  5 ++--
>  arch/arm/mm/cache-v4.S                   | 13 +++++-----
>  arch/arm/mm/cache-v4wb.S                 | 15 ++++++-----
>  arch/arm/mm/cache-v4wt.S                 | 13 +++++-----
>  arch/arm/mm/cache-v6.S                   | 20 +++++++--------
>  arch/arm/mm/cache-v7.S                   | 30 +++++++++++-----------
>  arch/arm/mm/l2c-l2x0-resume.S            |  7 ++---
>  arch/arm/mm/proc-arm1020.S               | 34 ++++++++++++------------
>  arch/arm/mm/proc-arm1020e.S              | 34 ++++++++++++------------
>  arch/arm/mm/proc-arm1022.S               | 34 ++++++++++++------------
>  arch/arm/mm/proc-arm1026.S               | 34 ++++++++++++------------
>  arch/arm/mm/proc-arm720.S                | 16 ++++++------
>  arch/arm/mm/proc-arm740.S                |  8 +++---
>  arch/arm/mm/proc-arm7tdmi.S              |  8 +++---
>  arch/arm/mm/proc-arm920.S                | 34 ++++++++++++------------
>  arch/arm/mm/proc-arm922.S                | 34 ++++++++++++------------
>  arch/arm/mm/proc-arm925.S                | 34 ++++++++++++------------
>  arch/arm/mm/proc-arm926.S                | 34 ++++++++++++------------
>  arch/arm/mm/proc-arm940.S                | 24 ++++++++---------
>  arch/arm/mm/proc-arm946.S                | 30 +++++++++++-----------
>  arch/arm/mm/proc-arm9tdmi.S              |  8 +++---
>  arch/arm/mm/proc-fa526.S                 | 16 ++++++------
>  arch/arm/mm/proc-feroceon.S              | 44 ++++++++++++++++----------------
>  arch/arm/mm/proc-mohawk.S                | 34 ++++++++++++------------
>  arch/arm/mm/proc-sa110.S                 | 16 ++++++------
>  arch/arm/mm/proc-sa1100.S                | 16 ++++++------
>  arch/arm/mm/proc-v6.S                    | 16 ++++++------
>  arch/arm/mm/proc-v7-2level.S             |  4 +--
>  arch/arm/mm/proc-v7-3level.S             |  5 ++--
>  arch/arm/mm/proc-v7.S                    | 14 +++++-----
>  arch/arm/mm/proc-v7m.S                   | 18 ++++++-------
>  arch/arm/mm/proc-xsc3.S                  | 32 +++++++++++------------
>  arch/arm/mm/proc-xscale.S                | 34 ++++++++++++------------
>  arch/arm/mm/tlb-fa.S                     |  7 ++---
>  arch/arm/mm/tlb-v4.S                     |  5 ++--
>  arch/arm/mm/tlb-v4wb.S                   |  7 ++---
>  arch/arm/mm/tlb-v4wbi.S                  |  7 ++---
>  arch/arm/mm/tlb-v6.S                     |  5 ++--
>  arch/arm/mm/tlb-v7.S                     |  4 +--
>  arch/arm/nwfpe/entry.S                   |  8 +++---
>  arch/arm/vfp/entry.S                     |  4 +--
>  arch/arm/vfp/vfphw.S                     | 26 +++++++++----------
>  arch/arm/xen/hypercall.S                 |  6 ++---
>  106 files changed, 644 insertions(+), 607 deletions(-)
>

I tested on PXA3xx platform.

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Regards
Haojian
