From: alex.shi@linaro.org (Alex Shi)
Date: Sun, 26 Nov 2017 23:16:31 +0800
Subject: [PATCH 0/2] Fix ftracetest issues
In-Reply-To: <20171125113302.GY31757@n2100.armlinux.org.uk>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
Message-ID: <101d41c7-2096-295e-b978-05224e16073e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC Naresh,

Could you like to test the patch for our bug 3297?

BTW,
The 2nd has 2 build error on stm32_defconfig:

arch/arm/kernel/traps.o: In function `dump_backtrace_entry':
/mmkernels/kernel/arch/arm/kernel/traps.c:77: undefined reference to
`__entry_text_start'
/mmkernels/kernel/arch/arm/kernel/traps.c:77: undefined reference to
`__entry_text_end'

On 11/25/2017 07:33 PM, Russell King - ARM Linux wrote:
> ftracetest provokes the kernel to try and return to userspace addresses
> in kernel mode.  These two patches prevent that.
> 
> The first patch, which I intend merging with Linus tonight, ensures that
> we catch the condition before we hit userspace, meaning that there is no
> possibility of executing user code while in kernel mode.
> 
> The second patch fixes the ftracetest issue itself by ensuring that it
> is not possible to set a kprobe on any of the "special" assembler code.
> Such code includes:
> - the kernel primary/secondary CPU startup code
> - exception entry code
> - idmap code
> 
> This is because the conditions under which this code is executed does
> not meet the kprobes requirements, which is basically that the
> "function" is C-like - it does something and then returns to the parent,
> and has a stack.  This is just not universally true of the above code.
> 
> This patch is larger than one may desire as we re-organise the sections
> that some code ends up in, the way the unwinder works, and how we print
> stack frames.
> 
>  arch/arm/include/asm/assembler.h | 18 ++++++++++++++++++
>  arch/arm/include/asm/exception.h |  3 +--
>  arch/arm/include/asm/sections.h  | 21 +++++++++++++++++++++
>  arch/arm/include/asm/traps.h     | 12 ------------
>  arch/arm/kernel/entry-armv.S     |  6 +-----
>  arch/arm/kernel/entry-common.S   |  1 +
>  arch/arm/kernel/entry-header.S   |  6 ++++++
>  arch/arm/kernel/stacktrace.c     | 14 ++------------
>  arch/arm/kernel/traps.c          |  4 ++--
>  arch/arm/kernel/vmlinux.lds.S    |  6 +++---
>  arch/arm/mm/fault.c              |  5 ++---
>  arch/arm/probes/kprobes/core.c   | 14 +++++++++++---
>  12 files changed, 68 insertions(+), 42 deletions(-)
> 
