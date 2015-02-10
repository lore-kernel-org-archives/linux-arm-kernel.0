From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Feb 2015 10:33:59 -0800
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150210154157.GL8656@n2100.arm.linux.org.uk>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org>
 <20150210154157.GL8656@n2100.arm.linux.org.uk>
Message-ID: <54DA4F17.2040705@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/15 07:41, Russell King - ARM Linux wrote:
> On Mon, Feb 09, 2015 at 05:24:08PM -0800, Stephen Boyd wrote:
>
>
>> Maybe we can do the same thing here by using a
>> spinlock for synchronization between the IPI handler and the dying CPU?
>> So lock/unlock around the IPI sending from the dying CPU and then do a
>> lock/unlock on the killing CPU before continuing.
> It would be nice, but it means exporting irq_controller_lock from irq_gic.c.
> It's doable, but it's really not nice - it creates a layering issue, buy
> making arch/arm/kernel/smp.c depend on symbols exported from
> drivers/irqchip/irq-gic.c.

I wasn't talking about the irq_controller_lock. I was saying we should
add another spinlock for synchronization purposes in arm/kernel/smp.c

---8<----

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 02c5da16c7ed..fe0386c751b2 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -225,6 +225,7 @@ int __cpu_disable(void)
 }
 
 static DECLARE_COMPLETION(cpu_died);
+static DEFINE_RAW_SPINLOCK(stop_lock);
 
 /*
  * called on the thread which is asking for a CPU to be shutdown -
@@ -232,10 +233,13 @@ static DECLARE_COMPLETION(cpu_died);
  */
 void __cpu_die(unsigned int cpu)
 {
+	unsigned long flags;
 	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
+	raw_spin_lock_irqsave(&stop_lock, flags);
+	raw_spin_unlock_irqrestore(&stop_lock, flags);
 	pr_notice("CPU%u: shutdown\n", cpu);
 
 	/*
@@ -280,7 +284,17 @@ void __ref cpu_die(void)
 	 * has been sent, power and/or clocks can be removed at any point
 	 * from this CPU and its cache by platform_cpu_kill().
 	 */
+	raw_spin_lock(&stop_lock);
 	__smp_cross_call(cpumask_of(cpumask_any(cpu_online_mask)), IPI_CPU_DEAD);
+	raw_spin_unlock(&stop_lock);
+
+	/*
+	 * Ensure that the cache lines associated with the stop_lock are
+	 * written out.  This covers the case where _this_ CPU is doing the
+	 * powering down, to ensure that the lock is visible to the
+	 * CPU waiting for this one.
+	 */
+	flush_cache_louis();
 
 	/*
 	 * The actual CPU shutdown procedure is@least platform (if not
@@ -517,8 +531,6 @@ void tick_broadcast(const struct cpumask *mask)
 }
 #endif
 
-static DEFINE_RAW_SPINLOCK(stop_lock);
-
 /*
  * ipi_cpu_stop - handle IPI from smp_send_stop()
  */

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
