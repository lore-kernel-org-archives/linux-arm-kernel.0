From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Nov 2015 09:54:11 +0000
Subject: [PATCH 11/15] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <5641472C.9080201@linaro.org>
References: <cover.1446836442.git.geoff@infradead.org>
 <2880455fc4abe385d5ed3919efa02177f96f4d93.1446836443.git.geoff@infradead.org>
 <5641472C.9080201@linaro.org>
Message-ID: <20151110095411.GB31947@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 10:23:56AM +0900, AKASHI Takahiro wrote:
> On 11/07/2015 04:14 AM, Geoff Levand wrote:
> >From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >
> >kdump calls machine_crash_shutdown() to shut down non-boot cpus and
> >save registers' status in per-cpu ELF notes before starting the crash
> >dump kernel. See kernel_kexec().
> >
> >ipi_cpu_stop() is a bit modified and used to support this behavior.
> 
> I've got some concerns of using ipi_cpu_stop().
> 
> >Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >---
> >  arch/arm64/include/asm/kexec.h    | 34 +++++++++++++++++++++++++++++++++-
> >  arch/arm64/kernel/machine_kexec.c | 31 +++++++++++++++++++++++++++++--
> >  arch/arm64/kernel/smp.c           | 16 ++++++++++++++--
> >  3 files changed, 76 insertions(+), 5 deletions(-)

[...]

> >diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> >index dbdaacd..88aec66 100644
> >--- a/arch/arm64/kernel/smp.c
> >+++ b/arch/arm64/kernel/smp.c
> >@@ -37,6 +37,7 @@
> >  #include <linux/completion.h>
> >  #include <linux/of.h>
> >  #include <linux/irq_work.h>
> >+#include <linux/kexec.h>
> >
> >  #include <asm/alternative.h>
> >  #include <asm/atomic.h>
> >@@ -54,6 +55,8 @@
> >  #include <asm/ptrace.h>
> >  #include <asm/virt.h>
> >
> >+#include "cpu-reset.h"
> >+
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/ipi.h>
> >
> >@@ -679,8 +682,12 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
> >  /*
> >   * ipi_cpu_stop - handle IPI from smp_send_stop()
> >   */
> >-static void ipi_cpu_stop(unsigned int cpu)
> >+static void ipi_cpu_stop(unsigned int cpu, struct pt_regs *regs)
> >  {
> >+#ifdef CONFIG_KEXEC
> >+	/* printing messages may slow down the shutdown. */
> >+	if (!in_crash_kexec)
> >+#endif
> >  	if (system_state == SYSTEM_BOOTING ||
> >  	    system_state == SYSTEM_RUNNING) {
> >  		raw_spin_lock(&stop_lock);
> >@@ -693,6 +700,11 @@ static void ipi_cpu_stop(unsigned int cpu)
> >
> >  	local_irq_disable();
> >
> >+#ifdef CONFIG_KEXEC
> >+	if (in_crash_kexec)
> >+		crash_save_cpu(regs, cpu);
> >+#endif /* CONFIG_KEXEC */
> >+
> >  	while (1)
> >  		cpu_relax();
> >  }
> 
> cpu_relax() is defined as asm("yield"), and this puts all but boot cpu into
> a infinite loop of nop (actually, whether nop or other depends on hw implementation).
> Thus all the secondary cpus are still running busy loop even after crash dump kernel
> has started up, and the chip can potentially get overheated.
> I ran into this situation when I tested the code on Hikey, and the system was
> forced to be shut down by thermal driver.
> 
> So I'd like to modify the code a bit like:
> if (in_crash_kernel {
>     crash_save_cpu(regs, cpu);
>     while (1)
>         asm("wfi"); /* irq is disabled here. */
> }
> 
> Does this make sense?

It would be even better if we could hotplug them off.

Will
