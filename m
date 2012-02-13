From: rabin@rab.in (Rabin Vincent)
Date: Mon, 13 Feb 2012 21:36:35 +0530
Subject: [PATCH] Optimize multi-CPU tlb flushing a little more
In-Reply-To: <20110823110602.GG19622@n2100.arm.linux.org.uk>
References: <20110823110602.GG19622@n2100.arm.linux.org.uk>
Message-ID: <CAH+eYFC_mkdObV0NfN5Jtv0L6fM9e0YGOBghTEVSqf=TAFxdXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 16:36, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> @@ -352,29 +359,22 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
> ? ? ? ?if (tlb_flag(TLB_WB))
> ? ? ? ? ? ? ? ?dsb();
>
> - ? ? ? if (cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
> - ? ? ? ? ? ? ? if (tlb_flag(TLB_V3_FULL))
> - ? ? ? ? ? ? ? ? ? ? ? asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (zero) : "cc");
> - ? ? ? ? ? ? ? if (tlb_flag(TLB_V4_U_FULL))
> - ? ? ? ? ? ? ? ? ? ? ? asm("mcr p15, 0, %0, c8, c7, 0" : : "r" (zero) : "cc");
> - ? ? ? ? ? ? ? if (tlb_flag(TLB_V4_D_FULL))
> - ? ? ? ? ? ? ? ? ? ? ? asm("mcr p15, 0, %0, c8, c6, 0" : : "r" (zero) : "cc");
> - ? ? ? ? ? ? ? if (tlb_flag(TLB_V4_I_FULL))
> - ? ? ? ? ? ? ? ? ? ? ? asm("mcr p15, 0, %0, c8, c5, 0" : : "r" (zero) : "cc");
> + ? ? ? if (possible_tlb_flags & (TLB_V3_FULL|TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL) &&
> + ? ? ? ? ? cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
> + ? ? ? ? ? ? ? tlb_op(TLB_V3_FULL, "c6, c0, 0", zero);
> + ? ? ? ? ? ? ? tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
> + ? ? ? ? ? ? ? tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
> + ? ? ? ? ? ? ? tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
> ? ? ? ?}
> ? ? ? ?put_cpu();

This part conditionally calls get_cpu() but unconditionally calls
put_cpu():

 ------------[ cut here ]------------
 WARNING: at /home/rabin/kernel/arm/kernel/sched/core.c:3051
sub_preempt_count+0xa0/0xe0()
 Modules linked in:
 [<c0013c4c>] (unwind_backtrace+0x0/0xec) from [<c028b2e4>]
(dump_stack+0x20/0x24)
 [<c028b2e4>] (dump_stack+0x20/0x24) from [<c001f808>]
(warn_slowpath_common+0x5c/0x74)
 [<c001f808>] (warn_slowpath_common+0x5c/0x74) from [<c001f84c>]
(warn_slowpath_null+0x2c/0x34)
 [<c001f84c>] (warn_slowpath_null+0x2c/0x34) from [<c004d588>]
(sub_preempt_count+0xa0/0xe0)
 [<c004d588>] (sub_preempt_count+0xa0/0xe0) from [<c0012e54>]
(flush_tlb_mm+0x64/0xa4)
 [<c0012e54>] (flush_tlb_mm+0x64/0xa4) from [<c00e25b8>]
(setup_arg_pages+0x260/0x39c)
 [<c00e25b8>] (setup_arg_pages+0x260/0x39c) from [<c012000c>]
(load_elf_binary+0x3ec/0x11d8)
 [<c012000c>] (load_elf_binary+0x3ec/0x11d8) from [<c00e1e78>]
(search_binary_handler+0xd8/0x2c8)
 [<c00e1e78>] (search_binary_handler+0xd8/0x2c8) from [<c00e3b5c>]
(do_execve+0x29c/0x3b4)
 [<c00e3b5c>] (do_execve+0x29c/0x3b4) from [<c0011080>]
(kernel_execve+0x48/0x90)
 [<c0011080>] (kernel_execve+0x48/0x90) from [<c0037274>]
(____call_usermodehelper+0x118/0x130)
 [<c0037274>] (____call_usermodehelper+0x118/0x130) from [<c000e784>]
(kernel_thread_exit+0x0/0x8)
 ---[ end trace 309cd09e6562b6c8 ]---
