From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 4 Jul 2015 13:19:30 +0800
Subject: [PATCH v2 2/2] irqchip: dw-apb-ictl: add irq_set_affinity support
In-Reply-To: <1435987170-3962-1-git-send-email-jszhang@marvell.com>
References: <1435987170-3962-1-git-send-email-jszhang@marvell.com>
Message-ID: <1435987170-3962-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell Berlin SoCs, the cpu's local timer is shutdown when the cpu
goes to a deep idle state, then the timer framework will be notified to
use a broadcast timer instead. The broadcast timer uses dw-apb-ictl as
interrupt chip, this patch adds irq_set_affinity support so that the
going to deep idle state cpu can set the interrupt affinity of the
broadcast interrupt to avoid unnecessary wakeups and IPIs.

A simple test:
~ # rm /tmp/test.sh
~ # cat > /tmp/test.sh
cat /proc/interrupts
for i in `seq 10` ; do sleep $i; done
cat /proc/interrupts
~ # chmod +x /tmp/test.sh
~ # taskset 0x2 /tmp/test.sh

without the patch:

           CPU0       CPU1
 27:        115         36       GIC  27  arch_timer
 45:         62          0       GIC  45  mmc0
160:         88          0  interrupt-controller   8  timer
227:          0          0  interrupt-controller   4  f7e81400.i2c
228:          0          0  interrupt-controller   5  f7e81800.i2c
229:          0          0  interrupt-controller   7  dw_spi65535
230:          0          0  interrupt-controller  21  f7e84000.i2c
231:          0          0  interrupt-controller  20  f7e84800.i2c
265:        445          0  interrupt-controller   8  serial
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0         11  Timer broadcast interrupts
IPI2:         56        104  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:          0          4  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:         25         27  IRQ work interrupts
IPI7:          0          0  completion interrupts
IPI8:          0          0  CPU backtrace
Err:          0
           CPU0       CPU1
 27:        115         38       GIC  27  arch_timer
 45:         62          0       GIC  45  mmc0
160:        160          0  interrupt-controller   8  timer
227:          0          0  interrupt-controller   4  f7e81400.i2c
228:          0          0  interrupt-controller   5  f7e81800.i2c
229:          0          0  interrupt-controller   7  dw_spi65535
230:          0          0  interrupt-controller  21  f7e84000.i2c
231:          0          0  interrupt-controller  20  f7e84800.i2c
265:        514          0  interrupt-controller   8  serial
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0         83  Timer broadcast interrupts
IPI2:         56        104  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:          0          4  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:         25         46  IRQ work interrupts
IPI7:          0          0  completion interrupts
IPI8:          0          0  CPU backtrace
Err:          0

cpu0 get 160-88=72 timer interrupts, CPU1 got 83-11=72 broadcast timer
IPIs. So, overall system got 72+72=144 wake ups and 72 broadcast timer IPIs

With the patch:
           CPU0       CPU1
 27:        107         37       GIC  27  arch_timer
 45:         62          0       GIC  45  mmc0
160:         66          7  interrupt-controller   8  timer
227:          0          0  interrupt-controller   4  f7e81400.i2c
228:          0          0  interrupt-controller   5  f7e81800.i2c
229:          0          0  interrupt-controller   7  dw_spi65535
230:          0          0  interrupt-controller  21  f7e84000.i2c
231:          0          0  interrupt-controller  20  f7e84800.i2c
265:        311          0  interrupt-controller   8  serial
IPI0:          0          0  CPU wakeup interrupts
IPI1:          2          4  Timer broadcast interrupts
IPI2:         58        100  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:          0          4  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:         21         24  IRQ work interrupts
IPI7:          0          0  completion interrupts
IPI8:          0          0  CPU backtrace
Err:          0
           CPU0       CPU1
 27:        107         39       GIC  27  arch_timer
 45:         62          0       GIC  45  mmc0
160:         69         75  interrupt-controller   8  timer
227:          0          0  interrupt-controller   4  f7e81400.i2c
228:          0          0  interrupt-controller   5  f7e81800.i2c
229:          0          0  interrupt-controller   7  dw_spi65535
230:          0          0  interrupt-controller  21  f7e84000.i2c
231:          0          0  interrupt-controller  20  f7e84800.i2c
265:        380          0  interrupt-controller   8  serial
IPI0:          0          0  CPU wakeup interrupts
IPI1:          3          6  Timer broadcast interrupts
IPI2:         60        100  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:          0          4  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:         21         45  IRQ work interrupts
IPI7:          0          0  completion interrupts
IPI8:          0          0  CPU backtrace
Err:          0

cpu0 got 69-66=3, cpu1 got 75-7=68 timer interrupts. cpu0 got 3-2=1
broadcast timer IPIs, cpu1 got 6-4=2 broadcast timer IPIs. So, overall
system got 3+68+1+2=74 wakeups and 1+2=3 broadcast timer IPIs.

This patch removes 50% wakeups and almost 100% broadcast timer IPIs!
I believe this patch will also benefit other dw-apb-ictl users.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/irqchip/irq-dw-apb-ictl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 8bef7f7..efc0aec 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -29,6 +29,7 @@
 
 struct dw_apb_ictl_priv {
 	struct irq_domain *domain;
+	unsigned int parent_irq;
 };
 
 static void dw_apb_ictl_handler(unsigned int irq, struct irq_desc *desc)
@@ -56,6 +57,21 @@ static void dw_apb_ictl_handler(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int dw_apb_ictl_set_affinity(struct irq_data *d,
+				    const struct cpumask *mask_val,
+				    bool force)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct dw_apb_ictl_priv *priv = gc->private;
+	struct irq_chip *chip = irq_get_chip(priv->parent_irq);
+	struct irq_data *data = irq_get_irq_data(priv->parent_irq);
+
+	if (chip && chip->irq_set_affinity)
+		return chip->irq_set_affinity(data, mask_val, force);
+	else
+		return -EINVAL;
+}
+
 #ifdef CONFIG_PM
 static void dw_apb_ictl_resume(struct irq_data *d)
 {
@@ -95,6 +111,8 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 		goto err_free;
 	}
 
+	priv->parent_irq = irq;
+
 	ret = of_address_to_resource(np, 0, &r);
 	if (ret) {
 		pr_err("%s: unable to get resource\n", np->full_name);
@@ -160,6 +178,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
 	gc->chip_types[0].chip.irq_resume = dw_apb_ictl_resume;
+	gc->chip_types[0].chip.irq_set_affinity = dw_apb_ictl_set_affinity;
 
 	if (nrirqs > 32) {
 		gc->chip_types[1].regs.mask = APB_INT_MASK_H;
@@ -167,6 +186,8 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 		gc->chip_types[1].chip.irq_mask = irq_gc_mask_set_bit;
 		gc->chip_types[1].chip.irq_unmask = irq_gc_mask_clr_bit;
 		gc->chip_types[1].chip.irq_resume = dw_apb_ictl_resume;
+		gc->chip_types[1].chip.irq_set_affinity =
+						dw_apb_ictl_set_affinity;
 	}
 
 	irq_set_handler_data(irq, gc);
-- 
2.1.4
