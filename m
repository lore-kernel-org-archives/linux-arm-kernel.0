From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 May 2017 15:00:51 +0100
Subject: [PATCH] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <1494508331-31644-1-git-send-email-mark.rutland@arm.com>
References: <1494508331-31644-1-git-send-email-mark.rutland@arm.com>
Message-ID: <f9cb7a24-534c-d7dd-412d-3722a90992cb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/17 14:12, Mark Rutland wrote:
> Currently, cpus_set_cap() calls static_branch_enable_cpuslocked(), which
> must take the jump_label mutex.
> 
> We call cpus_set_cap() in the secondary bringup path, from the idle
> thread where interrupts are disabled. Taking a mutex in this path "is a
> NONO" regardless of whether it's contended, and something we must avoid.
> Additionally, the secondary CPU doesn't hold the percpu rwsem (as this
> is held by the primary CPU), so this triggers a lockdep splat.
> 
> This patch fixes both issues by moving the static_key poking from
> cpus_set_cap() into enable_cpu_capabilities(). This means that there is
> a period between detecting an erratum and cpus_have_const_cap(erratum)
> being true, but largely this is fine. Features are only enabled later
> regardless, and most errata workarounds are best-effort.
> 
> This rework means that we can remove the *_cpuslocked() helpers added in
> commit d54bb72551b999dd ("arm64/cpufeature: Use
> static_branch_enable_cpuslocked()").
> 
> Fixes: efd9e03facd075f5 ("arm64: Use static keys for CPU features")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyniger <marc.zyngier@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Sewior <bigeasy@linutronix.de>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  3 +--
>  arch/arm64/kernel/cpu_errata.c      |  9 +--------
>  arch/arm64/kernel/cpufeature.c      | 16 +++++++++++++---
>  3 files changed, 15 insertions(+), 13 deletions(-)
> 
> I'm not sure what to do about ARM64_WORKAROUND_CAVIUM_23154.
> 
> This patch will defer enabling the workaround until all CPUs are up, and I
> can't see a good way of having the workaround on by default, then subsequently
> disabled if no CPUs are affected.

Yeah, this is pretty horrible.

The way I see it, we need an extra static key that would indicate that 
the errata have been applied. In the interval, we need to use the slow 
path and check the per-cpu state. Something like:

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c132f29322cc..b4cc5a3573eb 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -123,10 +123,17 @@ static void gic_redist_wait_for_rwp(void)
 
 static u64 __maybe_unused gic_read_iar(void)
 {
-	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_23154))
-		return gic_read_iar_cavium_thunderx();
-	else
-		return gic_read_iar_common();
+	if (static_branch_likely(&arm64_workarounds_enabled)) {
+		if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_23154))
+			return gic_read_iar_cavium_thunderx();
+		else
+			return gic_read_iar_common();
+	} else {
+		if (this_cpu_has_cap(ARM64_WORKAROUND_CAVIUM_23154))
+			return gic_read_iar_cavium_thunderx();
+		else
+			return gic_read_iar_common();
+	}
 }
 #endif
 
You can probably easily turn it into something that looks less shit though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
