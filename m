From: luis.henriques@canonical.com (Luis Henriques)
Date: Wed, 30 Apr 2014 13:55:12 +0100
Subject: [3.11.y.z extended stable] Patch "irqchip: Gic: Support forced
 affinity setting" has been added to staging queue
Message-ID: <1398862512-14612-1-git-send-email-luis.henriques@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a note to let you know that I have just added a patch titled

    irqchip: Gic: Support forced affinity setting

to the linux-3.11.y-queue branch of the 3.11.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.11.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.11.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 037df6b7446f354f2d802e3930c79cabbf0ff4a0 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 16 Apr 2014 14:36:44 +0000
Subject: irqchip: Gic: Support forced affinity setting

commit ffde1de64012c406dfdda8690918248b472f24e4 upstream.

To support the affinity setting of per cpu timers in the early startup
of a not yet online cpu, implement the force logic, which disables the
cpu online check.

Tagged for stable to allow a simple fix of the affected SoC clock
event drivers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>,
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org,
Link: http://lkml.kernel.org/r/20140416143315.916984416 at linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/irqchip/irq-gic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ee7c503..0ebd24d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -246,10 +246,14 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
 	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
-	unsigned int shift = (gic_irq(d) % 4) * 8;
-	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
 	u32 val, mask, bit;

+	if (!force)
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	else
+		cpu = cpumask_first(mask_val);
+
 	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
 		return -EINVAL;

--
1.9.1
