From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 12 Jan 2017 15:30:44 +0100
Subject: [PATCH] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <20170112001957.GA5458@nuc>
References: <1481233595-22112-1-git-send-email-abelvesa@linux.com>
 <20161208224655.GA6319@gce> <20170110155112.GB14894@pathway.suse.cz>
 <20170112001957.GA5458@nuc>
Message-ID: <CACh+v5M-BDru3OyhrROBqPKJuSN=yoxVstN-fqZGh8SU1EHQiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-12 1:19 GMT+01:00 Abel Vesa <abelvesa@gmail.com>:
> On Tue, Jan 10, 2017 at 04:51:12PM +0100, Petr Mladek wrote:
>> On Thu 2016-12-08 22:46:55, Abel Vesa wrote:
>> > On Thu, Dec 08, 2016 at 09:46:35PM +0000, Abel Vesa wrote:
>> > > From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> > >
>> > > From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> >
>> > >From statement twice in the commit message. Will resend.
>> > >
>> > > The DYNAMIC_FTRACE_WITH_REGS configuration makes it possible for a ftrace
>> > > operation to specify if registers need to saved/restored by the ftrace handler.
>> > > This is needed by kgraft and possibly other ftrace-based tools, and the ARM
>> > > architecture is currently lacking this feature. It would also be the first step
>> > > to support the "Kprobes-on-ftrace" optimization on ARM.
>> > >
>> > > This patch introduces a new ftrace handler that stores the registers on the
>> > > stack before calling the next stage. The registers are restored from the stack
>> > > before going back to the instrumented function.
>> > >
>> > > A side-effect of this patch is to activate the support for ftrace_modify_call()
>> > > as it defines ARCH_SUPPORTS_FTRACE_OPS for the ARM architecture
>> > >
>> > > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> > > Signed-off-by: Abel Vesa <abelvesa@linux.com>
>> > > ---
>> > >  arch/arm/Kconfig               |  2 ++
>> > >  arch/arm/include/asm/ftrace.h  |  4 +++
>> > >  arch/arm/kernel/entry-ftrace.S | 78 ++++++++++++++++++++++++++++++++++++++++++
>> > >  arch/arm/kernel/ftrace.c       | 33 ++++++++++++++++++
>> > >  4 files changed, 117 insertions(+)
>> > >
>> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > > index b5d529f..87f1a9f 100644
>> > > --- a/arch/arm/Kconfig
>> > > +++ b/arch/arm/Kconfig
>> > > @@ -50,6 +50,7 @@ config ARM
>> > >   select HAVE_DMA_API_DEBUG
>> > >   select HAVE_DMA_CONTIGUOUS if MMU
>> > >   select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
>> > > + select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>> > >   select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
>> > >   select HAVE_EXIT_THREAD
>> > >   select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
>> > > @@ -90,6 +91,7 @@ config ARM
>> > >   select PERF_USE_VMALLOC
>> > >   select RTC_LIB
>> > >   select SYS_SUPPORTS_APM_EMULATION
>> > > + select FRAME_POINTER if DYNAMIC_FTRACE_WITH_REGS && FUNCTION_GRAPH_TRACER
> Hi Petr,
>>
>> FRAME_POINTER is not for free. It takes space on the stack. Also there
>> is a performance penalty. Do we really need to depend on it? If so,
>> it might be worth a note in the commit message.
>

FRAME_POINTER is not needed. the dependency is wrong and should be removed.
The code must be modified to not use fp register:

--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -130,7 +130,8 @@ ftrace_graph_regs_call:
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 .macro __ftrace_graph_regs_caller

-       sub     r0, fp, #4                      @ lr of instrumented
routine (parent)
+       add     r0, sp, #64             @ r0 is now a pointer to lr of
+                                       @ instrumented routine

        @ called from __ftrace_regs_caller
        ldr     r1, [sp, #56]                   @ instrumented routine (func)
@@ -139,8 +140,9 @@ ftrace_graph_regs_call:
        mov     r2, fp                          @ frame pointer
        bl      prepare_ftrace_return

-       ldr     lr, [fp, #-4]                   @ restore lr from the stack
-       ldmia   sp, {r0-r11, ip, sp}            @ restore r0 through sp
+       ldr     lr, [sp, #64]           @ get the previous LR value from stack
+       ldmia   sp, {r0-r11, ip, sp}    @ pop the saved registers INCLUDING
+                                       @ the stack pointer
        ret     ip
 .endm
 #endif


Jean-Jacques


> I was trying to create my own patch when I found this work done by
> Jean-Jacques, so I haven't looked specifically for the FRAME_POINTER
> part. I looked now at it and you seem to be right, FRAME_POINTER is
> not needed.
>
> I will get rid of the FRAME_POINTER part, change the authorship and
> send it again in the following days.
>>
>> I made only a quick look at the patch. It looks reasonable. But I do
>> not have enough knowledge about the arm architecture, assembly, and
>> ftrace-specifics. Also I cannot test it easily. So issues might
>> be hidden to my eyes.
>>
>> Best Regards,
>> Petr
> Thanks,
> Abel
