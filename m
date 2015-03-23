From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Mar 2015 15:44:58 +0000
Subject: [PATCH] arm64: efi: don't restore TTBR0 if active_mm points at
 init_mm
In-Reply-To: <1427116945.2693.10.camel@linaro.org>
References: <1426779780-4706-1-git-send-email-will.deacon@arm.com>
 <1427116945.2693.10.camel@linaro.org>
Message-ID: <20150323154458.GC12757@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 01:22:25PM +0000, Jon Medhurst (Tixy) wrote:
> On Thu, 2015-03-19 at 15:43 +0000, Will Deacon wrote:
> > init_mm isn't a normal mm: it has swapper_pg_dir as its pgd (which
> > contains kernel mappings) and is used as the active_mm for the idle
> > thread.
> > 
> > When restoring the pgd after an EFI call, we write current->active_mm
> > into TTBR0. If the current task is actually the idle thread (e.g. when
> > initialising the EFI RTC before entering userspace), then the TLB can
> > erroneously populate itself with junk global entries as a result of
> > speculative table walks.
> > 
> > When we do eventually return to userspace, the task can end up hitting
> > these junk mappings leading to lockups, corruption or crashes.
> > 
> > This patch fixes the problem in the same way as the CPU suspend code by
> > ensuring that we never switch to the init_mm in efi_set_pgd and instead
> > point TTBR0 at the zero page. A check is also added to cpu_switch_mm to
> > BUG if we get passed swapper_pg_dir.
> 
> Which seems to happen in idle_task_exit() when you offline a cpu. This
> patch is now in 4.0-rc5 and I get ...
> 
> # echo 0 > cpu1/online
> [   51.750107] BUG: failure at ./arch/arm64/include/asm/mmu_context.h:74/switch_new_context()!
> [   51.750111] Kernel panic - not syncing: BUG!
> [   51.750116] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.0.0-rc5+ #3
> [   51.750118] Hardware name: ARM Juno development board (r0) (DT)
> [   51.750120] Call trace:
> [   51.750131] [<ffffffc00008a4cc>] dump_backtrace+0x0/0x138
> [   51.750136] [<ffffffc00008a620>] show_stack+0x1c/0x28
> [   51.750143] [<ffffffc0006f8ed4>] dump_stack+0x80/0xc4
> [   51.750146] [<ffffffc0006f58b8>] panic+0xe8/0x220
> [   51.750151] [<ffffffc0000c70bc>] idle_task_exit+0x220/0x274
> [   51.750155] [<ffffffc0000919bc>] cpu_die+0x20/0x7c
> [   51.750159] [<ffffffc0000869fc>] arch_cpu_idle_dead+0x10/0x1c
> [   51.750163] [<ffffffc0000d4de4>] cpu_startup_entry+0x2c4/0x36c
> [   51.750167] [<ffffffc00009185c>] secondary_start_kernel+0x12c/0x13c

It's good that we now trap on this, otherwise we wouldn't have noticed
any issue for a long time.

> There seems to be quite a number of uses of cpu_switch_mm in the kernel.
> I don't know if they have bugs which need fixing, or if it makes more
> sense to replace the
> 	BUG_ON(pgd == swapper_pg_dir);
> with 
> 	if (pgd != swapper_pg_dir)

That's not always correct since the previous pgd may be freed, so we
need to make sure we move away from it. I think for stable, we can do
with the patch below. We could clean up the cpu_switch_mm() uses through
the arch/arm64 and set the reserved ttbr0 but we only have two at the
moment (__cpu_suspend and efi_set_pgd).

-----------------8<-------------------------

>From 5d9e3540b6480558528612dd3672543fa8ab3528 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 23 Mar 2015 15:06:50 +0000
Subject: [PATCH] arm64: Use the reserved TTBR0 if context switching to the
 init_mm

The idle_task_exit() function may call switch_mm() with next ==
&init_mm. On arm64, init_mm.pgd cannot be used for user mappings, so
this patch simply sets the reserved TTBR0.

Cc: <stable@vger.kernel.org>
Reported-by: Jon Medhurst (Tixy) <tixy@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/mmu_context.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index a9eee33dfa62..101a42bde728 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -151,6 +151,15 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 	unsigned int cpu = smp_processor_id();
 
+	/*
+	 * init_mm.pgd does not contain any user mappings and it is always
+	 * active for kernel addresses in TTBR1. Just set the reserved TTBR0.
+	 */
+	if (next == &init_mm) {
+		cpu_set_reserved_ttbr0();
+		return;
+	}
+
 	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next)
 		check_and_switch_context(next, tsk);
 }
