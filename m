From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Feb 2011 16:33:58 -0000
Subject: [PATCHv2 1/2] ARM: perf_event: allow platform-specific interrupt
	handler
In-Reply-To: <1297137277-26889-1-git-send-email-rabin.vincent@stericsson.com>
References: <1297137277-26889-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <000801cbca09$7bc956a0$735c03e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,

> Allow a platform-specific IRQ handler to be specified via platform data.  This
> will be used to implement the single-irq workaround for the DB8500.
> 
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> ---
>  arch/arm/include/asm/pmu.h   |   14 ++++++++++++++
>  arch/arm/kernel/perf_event.c |   17 ++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletions(-)

If you're happy with this as a workaround for your platform, then
it looks alright to me.

Acked-by: Will Deacon <will.deacon@arm.com>

One thing you could try is using the GIC patch I posted the other day:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041496.html

If you then do:

    ARM: gic: allow per-cpu SPIs to be affine to multiple CPUs
    
    The concept of a per-cpu SPI is somewhat a contradiction, but can occur in
    systems where SPIs from different CPUs are ORd together into a single line.
    
    An example of this is the PMU interrupt on the u8500 platform.
    
    This patch allows SPIs with the IRQF_PERCPU flag to be affine to multiple
    CPUs in a CPU mask. This, of course, assumes that the driver knows what it
    is doing and can handle such a configuration.
    
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 9def30b..512f55f 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -145,7 +145,7 @@ gic_set_cpu(struct irq_data *d, const struct cpumask *mask_val, bool force)
 {
        void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
        unsigned int shift = (d->irq % 4) * 8;
-       unsigned int cpu = cpumask_first(mask_val);
+       unsigned int cpu_map, cpu = cpumask_first(mask_val);
        u32 val;
        struct irq_desc *desc;
 
@@ -155,9 +155,19 @@ gic_set_cpu(struct irq_data *d, const struct cpumask *mask_val, bool force)
                spin_unlock(&irq_controller_lock);
                return -EINVAL;
        }
+
        d->node = cpu;
+
+       if (CHECK_IRQ_PER_CPU(desc->status)) {
+               cpu_map = 0;
+               for_each_cpu(cpu, mask_val)
+                       cpu_map |= 1 << (cpu + shift);
+       } else {
+               cpu_map = 1 << (cpu + shift);
+       }
+
        val = readl(reg) & ~(0xff << shift);
-       val |= 1 << (cpu + shift);
+       val |= cpu_map;
        writel(val, reg);
        spin_unlock(&irq_controller_lock);
 

You'll be able to target the PMU IRQ to both CPUs and avoid the need for
ping-ponging the affinity. This is a bit weird though as usually you'd have
a PPI for a percpu interrupt so this might be better off staying inside
platform code and leaving the GIC code alone. I also think this approach
is more invasive from the perf point of view.

Unless this approach gives markedly better profiling results than your
proposal, I think we should go with what you've got.

Will
