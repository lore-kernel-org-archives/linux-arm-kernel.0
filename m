From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 2 Mar 2017 15:41:16 +0000
Subject: BCM5301X: GIC: PPI11 is secure or misconfigured (same for PPI13)
In-Reply-To: <dc74d33c-aa3c-ec26-313e-d5f5cef76e6f@milecki.pl>
References: <dc74d33c-aa3c-ec26-313e-d5f5cef76e6f@milecki.pl>
Message-ID: <0d18fe40-76ff-4703-d766-e895ddd36fba@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/17 14:32, Rafa? Mi?ecki wrote:
> Hi,
> 
> I just updated kernel on my SmartRG SR400ac (bcm4708-smartrg-sr400ac.dts) from
> 4.4 to 4.9 and noticed following warnings in the boot log:
> [    0.000000] GIC: PPI11 is secure or misconfigured
> [    0.000007] sched_clock: 64 bits at 400MHz, resolution 2ns, wraps every 4398046511103ns
> [    0.008553] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles: 0x5c4093a7d1, max_idle_ns: 440795210635 ns
> [    0.020380] GIC: PPI11 is secure or misconfigured
> [    0.025446] GIC: PPI13 is secure or misconfigured
> [    0.030498] GIC: PPI13 is secure or misconfigured
> [    0.035690] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
> [    0.123484] pid_max: default: 32768 minimum: 301
> [    0.128511] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.135591] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.143687] CPU: Testing write buffer coherency: ok
> [    0.149226] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.155371] Setting up static identity map for 0x82a0 - 0x82d4
> [    0.163390] GIC: PPI11 is secure or misconfigured
> [    0.163407] GIC: PPI13 is secure or misconfigured
> 
> This is caused by following commits:
> 992345a58e0c ("irqchip/gic: WARN if setting the interrupt type for a PPI fails")
> 4b357daed698 ("genirq: Look-up trigger type if not specified by caller")
> f35ad083783e ("genirq: Look-up percpu trigger type if not specified by caller")
> 
> There warnings are coming from the following (forward) traces:
> request_percpu_irq ? __setup_irq ? (...) ? gic_set_type ? gic_configure_irq
> cpuhp_setup_state ? (...) ? gt_starting_cpu ? enable_percpu_irq ? __irq_set_trigger ? chip->irq_set_type
> (see e.g. global_timer_of_register).
> Later ones are coming e.g. from twd_local_timer_of_register.
> 
> Before adding mentioned commits gic_set_type was never called for there IRQs.

Which was a nasty bug the first place.

> 
> AFAIU we need to update following entries in the bcm5301x.dtsi:
> 
> timer at 20200 {
> 	compatible = "arm,cortex-a9-global-timer";
> 	reg = <0x20200 0x100>;
> 	interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
> 	clocks = <&periph_clk>;
> };
> 
> local-timer at 20600 {
> 	compatible = "arm,cortex-a9-twd-timer";
> 	reg = <0x20600 0x100>;
> 	interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> 	clocks = <&periph_clk>;
> };
> 
> Does anyone happen to know how to define these IRQs properly?

It looks like the GIC's PPI configuration differs from what you have in 
your DT. Since the PPI configuration is write-only on A9, you get a 
warning. Try dumping the values in gic_configure_irq() with this 
patchlet:

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 9ae71804b5dd..887be33dd6b1 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -76,12 +76,14 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	 * non-secure mode, and hence it may not be catastrophic.
 	 */
 	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);
-	if (readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val) {
+	oldval = val;
+	val = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
+	if (oldval != val) {
 		if (WARN_ON(irq >= 32))
 			ret = -EINVAL;
 		else
-			pr_warn("GIC: PPI%d is secure or misconfigured\n",
-				irq - 16);
+			pr_warn("GIC: PPI%d is secure or misconfigured %x %x\n",
+				irq - 16, oldval, val);
 	}
 
 	if (sync_access)

The difference between the two values will tell you what the GIC thinks
of the interrupt trigger. Odds are that these interrupts are edge-triggered,
if I trust the following document:

http://infocenter.arm.com/help/topic/com.arm.doc.ddi0407f/CCHEIGIC.html

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
