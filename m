From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Apr 2013 11:03:32 +0100
Subject: ARM: 7684/1: errata: Workaround for Cortex-A15 erratum 798181
 (TLBI/DSB operations)
In-Reply-To: <alpine.LFD.2.03.1304221641340.17375@syhkavp.arg>
References: <alpine.LFD.2.03.1304221641340.17375@syhkavp.arg>
Message-ID: <20130423100332.GA23407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 10:29:32PM +0100, Nicolas Pitre wrote:
> I notice that commit 93dc68876b60 ( "ARM: 7684/1: errata: Workaround for 
> Cortex-A15 erratum 798181 (TLBI/DSB operations)") is in mainline, but it 
> is causing a flood of warnings with CONFIG_DEBUG_PREEMPT active, making 
> the system unusable. Unfortunately, I failed to find it in the list 
> archives, so I couldn't reply to the original patch.

It wasn't on the list (and I'll reply in private why).

> The kernel spits out this on every fork():
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: bash/1419
> caller is broadcast_tlb_mm_a15_erratum+0x94/0xfc
> [<c0014640>] (unwind_backtrace+0x0/0xf8) from [<c02074ec>] (debug_smp_processor_id+0xc4/0xe8)
> [<c02074ec>] (debug_smp_processor_id+0xc4/0xe8) from [<c0013a3c>] (broadcast_tlb_mm_a15_erratum+0x94/0xfc)
> [<c0013a3c>] (broadcast_tlb_mm_a15_erratum+0x94/0xfc) from [<c0020f28>] (dup_mm+0x30c/0x41c)
> [<c0020f28>] (dup_mm+0x30c/0x41c) from [<c00217a4>] (copy_process.part.56+0x724/0xe20)
> [<c00217a4>] (copy_process.part.56+0x724/0xe20) from [<c0021f54>] (do_fork+0x90/0x320)
> [<c0021f54>] (do_fork+0x90/0x320) from [<c000e240>] (ret_fast_syscall+0x0/0x30)

So it needs preemption disabled, see below.

I'll double-check with the hardware guys whether the dummy TLBI can
happen on any CPU (if we get preempted), otherwise I'll have to disable
the preemption around both the local_flush_tlb_*() and broadcast_tlb_*()
functions.

Thanks,

Catalin

----------------------8<----------------------------------------

>From 8655f0d38ae4057dcca8e1f6b4878d1c87604f90 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 23 Apr 2013 10:05:06 +0100
Subject: [PATCH] arm: Disable preemption in broadcast_tlb*_a17_erratum()

Commit 93dc688 (ARM: 7684/1: errata: Workaround for Cortex-A15 erratum
798181 (TLBI/DSB operations)) introduces calls to smp_processor_id() and
smp_call_function_many() with preemption enabled. This patch disables
preemption and also optimises the smp_processor_id() call in
broadcast_tlb_mm_a15_erratum(). The broadcast_tlb_a15_erratum() function
is changed to use smp_call_function() which disables preemption.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Geoff Levand <geoff@infradead.org>
Reported-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/smp_tlb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index e82e1d2..9a52a07 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -98,21 +98,21 @@ static void broadcast_tlb_a15_erratum(void)
 		return;
 
 	dummy_flush_tlb_a15_erratum();
-	smp_call_function_many(cpu_online_mask, ipi_flush_tlb_a15_erratum,
-			       NULL, 1);
+	smp_call_function(ipi_flush_tlb_a15_erratum, NULL, 1);
 }
 
 static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
 {
-	int cpu;
+	int cpu, this_cpu;
 	cpumask_t mask = { CPU_BITS_NONE };
 
 	if (!erratum_a15_798181())
 		return;
 
 	dummy_flush_tlb_a15_erratum();
+	this_cpu = get_cpu();
 	for_each_online_cpu(cpu) {
-		if (cpu == smp_processor_id())
+		if (cpu == this_cpu)
 			continue;
 		/*
 		 * We only need to send an IPI if the other CPUs are running
@@ -127,6 +127,7 @@ static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
 			cpumask_set_cpu(cpu, &mask);
 	}
 	smp_call_function_many(&mask, ipi_flush_tlb_a15_erratum, NULL, 1);
+	put_cpu();
 }
 
 void flush_tlb_all(void)
