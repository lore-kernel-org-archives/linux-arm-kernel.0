From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 11 Sep 2015 15:50:05 -0700
Subject: [PATCH 4.1 64/78] irqchip/crossbar: Restore the irq_set_type()
 mechanism
In-Reply-To: <20150911224606.758437370@linuxfoundation.org>
References: <20150911224606.758437370@linuxfoundation.org>
Message-ID: <20150911224615.634002851@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>

commit e269ec42328783e51be08c191aa935dba56141fc upstream.

The conversion of the crossbar irqchip to hierarchical irq domains
failed to provide a mechanism to properly set the trigger type of an
interrupt.

The crossbar irq chip itself has no mechanism and therefor no
irq_set_type() callback. The code before the conversion relayed the
trigger configuration directly to the underlying GIC.

Restore the correct behaviour by setting the crossbar irq_set_type
callback to irq_chip_set_type_parent(). This propagates the
set_trigger() call to the underlying GIC irqchip.

[ tglx: Massaged changelog ]

Fixes: 783d31863fb8 ('irqchip: crossbar: Convert dra7 crossbar...')
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: <linux@arm.linux.org.uk>
Cc: <nsekhar@ti.com>
Cc: <jason@lakedaemon.net>
Cc: <balbi@ti.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <tony@atomide.com>
Cc: <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/1439554830-19502-4-git-send-email-grygorii.strashko at ti.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-crossbar.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -69,6 +69,7 @@ static struct irq_chip crossbar_chip = {
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_wake		= irq_chip_set_wake_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
