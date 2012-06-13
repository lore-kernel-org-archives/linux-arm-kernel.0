From: xiechao.mail@gmail.com (Chao Xie)
Date: Wed, 13 Jun 2012 16:33:58 +0800
Subject: [PATCH] ARM: gic: add irq_set_affinity to gic_arch_extn
Message-ID: <1339576438-23638-1-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bin Wang <binw@marvell.com>

Some architectures would shut done the mp logic for certain low power
mode cases, thus it relies on an external interrupt controller to
wake up the cores. In order to keep the same interrupt distribute
mapping as in the gic, here export the irq_set_affinity hook in the
gic_arch_extn.

Signed-off-by: Bin Wang <binw@marvell.com>
---
 arch/arm/common/gic.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 5b60d5e..c3d5b31 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -54,6 +54,7 @@ struct irq_chip gic_arch_extn = {
 	.irq_retrigger	= NULL,
 	.irq_set_type	= NULL,
 	.irq_set_wake	= NULL,
+	.irq_set_affinity = NULL,
 };
 
 #ifndef MAX_GIC_NR
@@ -186,6 +187,10 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 
 	mask = 0xff << shift;
 	raw_spin_lock(&irq_controller_lock);
+
+	if (gic_arch_extn.irq_set_affinity)
+		gic_arch_extn.irq_set_affinity(d, mask_val, false);
+
 	d->node = cpu;
 #ifdef CONFIG_CPU_MMP3
 	cpu = smp_hardid[cpu];
-- 
1.7.0.4
