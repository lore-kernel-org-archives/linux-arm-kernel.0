From: alex.shi@linaro.org (Alex Shi)
Date: Sun, 26 Nov 2017 20:07:43 +0800
Subject: do page fault in atomic bug on arm
In-Reply-To: <20171124192700.GU31757@n2100.armlinux.org.uk>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
 <20171121132001.GH31757@n2100.armlinux.org.uk>
 <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
 <20171124192700.GU31757@n2100.armlinux.org.uk>
Message-ID: <bc36ecbb-0bec-3b89-4fed-199e440f2218@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC Masami Hiramatsu for ftracetest part.

Hi Russell King,

Thanks a lot for quick response!

Regards
Alex

On 11/25/2017 03:27 AM, Russell King - ARM Linux wrote:
> On Fri, Nov 24, 2017 at 11:09:30PM +0800, Alex Shi wrote:
>> Full agree with your analysis. Is it possible to stain PC value with
>> heavy stress on thermal or sth else? the ARM64 board run well with
>> ftracetest of LTP.
> 
> In your first email, you said "x15 platform, which is a armv7 board."
> Here you say "ARM64 board" which isn't armv7.  There's x15 DTS under
> arch/arm/boot/dts, so I guess you mean 32-bit ARM, but who knows...
> 
> Anyway, I've tried running ftracetest on an OMAP4430 SDP board, and
> after a while with the patch I sent you, I get:
> 
> Internal error: Oops - BUG: 0 [#1] SMP ARM
> Modules linked in:
> CPU: 1 PID: 2948 Comm: ftracetest Not tainted 4.14.0+ #557
> Hardware name: Generic OMAP4 (Flattened Device Tree)
> task: ce41c100 task.stack: cc7b8000
> PC is at oops+0x0/0x4
> LR is at trace_hardirqs_on_caller+0x154/0x1e0
> pc : [<c0015adc>]    lr : [<c0086840>]    psr: 20000193
> sp : cc7b9fb0  ip : cc7b9f80  fp : 00000000
> r10: 00000000  r9 : cc7b8000  r8 : c0015c28
> r7 : 00000006  r6 : 00000004  r5 : 0009fed4  r4 : 00000001
> r3 : 00000000  r2 : cc7b9fb0  r1 : 60000193  r0 : 00000001
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 8e7b804a  DAC: 00000055
> Process ftracetest (pid: 2948, stack limit = 0xcc7b8210)
> Stack: (0xcc7b9fb0 to 0xcc7ba000)
> 9fa0:                                     00000000 00000000 0009b008 0000000d
> 9fc0: 00000001 0009fed4 00000004 00000006 0009b3e0 000a17d4 00000000 beaf6e3c
> 9fe0: 0009fed0 beaf6e20 000319e0 b6e7199c 60000193 00000001 6b6b6b6b a56b6b6b
> Backtrace: no frame pointer
> Code: e9527fff e1a00000 e28dd048 e1b0f00e (e7f001f2)
> ---[ end trace 390efe5843605357 ]---
> 
> The other CPU also oopses:
> 
> Internal error: Oops - BUG: 0 [#3] SMP ARM
> Modules linked in:
> CPU: 1 PID: 1 Comm: init Tainted: G      D         4.14.0+ #557
> Hardware name: Generic OMAP4 (Flattened Device Tree)
> task: ced04c00 task.stack: ced06000
> PC is at oops+0x0/0x4
> LR is at trace_hardirqs_on+0x14/0x18
> pc : [<c0015adc>]    lr : [<c00868e0>]    psr: 20000193
> sp : ced07fb0  ip : ced07fa0  fp : 00000000
> r10: 00000000  r9 : ced06000  r8 : c0015c28
> r7 : 0000004e  r6 : bec0acd4  r5 : 000176b4  r4 : bec0ac3c
> r3 : 00000000  r2 : ced07fb0  r1 : 60000193  r0 : c0015aa8
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 8e2d804a  DAC: 00000055
> Process init (pid: 1, stack limit = 0xced06210)
> Stack: (0xced07fb0 to 0xced08000)
> 7fa0:                                     00000000 00000000 00000000 00000000
> 7fc0: bec0ac3c 000176b4 bec0acd4 0000004e 10000000 00000000 0000a1d0 bec0ac44
> 7fe0: bec0acd8 bec0ac28 b6e54544 b6e5456c 60000193 bec0ac28 005d5555 00020201
> Backtrace: no frame pointer
> Code: e9527fff e1a00000 e28dd048 e1b0f00e (e7f001f2)
> ---[ end trace 390efe5843605358 ]---
> 
> which is exactly your bug, but caught a bit earlier.
> 
> This happens while executing this ftrace test:
> 
> [28] Register/unregister many kprobe events
> 
> and needs a kernel with ftrace and kprobes enabled.
> 
> Unfortunately, the debug is immediately after a call to
> trace_hardirqs_on() in no_work_pending, so the LR value is
> meaningless.
> 
> So, now that we know it's tracing kprobes triggering it - it's
> trying to set tracepoints on the first 256 symbols in the kernel's
> kallsyms, which includes all sorts of things.
> 
> With some extra debug, this doesn't look clever:
> 
> trace_kprobe: Inserting kprobe at ret_fast_syscall+0
> trace_kprobe: Inserting kprobe at slow_work_pending+0
> trace_kprobe: Inserting kprobe at ret_slow_syscall+0
> trace_kprobe: Could not insert probe at ret_slow_syscall+0: -22
> trace_kprobe: Inserting kprobe at ret_to_user+0
> trace_kprobe: Could not insert probe at ret_to_user+0: -22
> trace_kprobe: Inserting kprobe at ret_to_user_from_irq+0
> trace_kprobe: Inserting kprobe at no_work_pending+0
> trace_kprobe: Inserting kprobe at oops+0
> trace_kprobe: Could not insert probe at oops+0: -22
> trace_kprobe: Inserting kprobe at ret_from_fork+0
> trace_kprobe: Inserting kprobe at vector_swi+0
> trace_kprobe: Inserting kprobe at local_restart+0
> trace_kprobe: Inserting kprobe at __sys_trace+0
> trace_kprobe: Inserting kprobe at __sys_trace_return+0
> trace_kprobe: Inserting kprobe at __sys_trace_return_nosave+0
> trace_kprobe: Could not insert probe at __sys_trace_return_nosave+0: -22
> trace_kprobe: Inserting kprobe at __cr_alignment+0
> trace_kprobe: Could not insert probe at __cr_alignment+0: -22
> trace_kprobe: Inserting kprobe at sys_call_table+0
> trace_kprobe: Inserting kprobe at sys_syscall+0
> trace_kprobe: Inserting kprobe at sys_sigreturn_wrapper+0
> trace_kprobe: Inserting kprobe at sys_rt_sigreturn_wrapper+0
> trace_kprobe: Inserting kprobe at sys_statfs64_wrapper+0
> trace_kprobe: Inserting kprobe at sys_fstatfs64_wrapper+0
> 
> I wouldn't be surprised if some of those were the cause of it -
> for example, what guarantee do we have that a trace kprobe inserted
> at ret_fast_syscall which starts with this:
> 
> c0015a40:       e5ad0008        str     r0, [sp, #8]!
> 
> will be handled correctly?  I can't say, I've virtually no knowledge
> about kprobes, but I guess it isn't - especially as there's this
> comment in the ARM kprobes code:
> 
>          * Never instrument insn like 'str r0, [sp, +/-r1]'. Also, insn likes
>          * 'str r0, [sp, #-68]' should also be prohibited.
> 
> Clearly, that's not the case as the kprobes insert on
> ret_fast_syscall succeeded.
> 
> Adding Tixy, as he's more knowledgable in this area - I suggest
> someone knowledgable in this area runs
> 
> 	ftracetest test.d/kprobe/multiple_kprobes.tc
> 
> and fixes these bugs... also running the entire ftracetest suite
> would probably also be a very good idea.
> 
