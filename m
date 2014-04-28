From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 17:57:57 +0100
Subject: [PATCH 02/16] ARM: l2c: add platform independent core L2 cache
 initialisation
In-Reply-To: <20140428165631.GM26756@n2100.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
Message-ID: <E1WeosP-0002PO-5m@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a hook into the core ARM code to perform L2 cache initialisation
in a platform independent manner.  Platforms still get to indicate
their auxiliary control register values and mask, but the
initialisation call will now be made from generic code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/arch.h |  3 +++
 arch/arm/kernel/irq.c            | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 17a3fa2979e8..5249cc3c52f4 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -45,6 +45,9 @@ struct machine_desc {
 	unsigned char		reserve_lp1 :1;	/* never has lp1	*/
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
 	enum reboot_mode	reboot_mode;	/* default restart mode	*/
+	unsigned		l2c_aux_val;	/* L2 cache aux value	*/
+	unsigned		l2c_aux_mask;	/* L2 cache aux mask	*/
+	void			(*l2c_write_sec)(unsigned long, unsigned);
 	struct smp_operations	*smp;		/* SMP operations	*/
 	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **,
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 9723d17b8f38..2c4257604513 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -37,6 +37,7 @@
 #include <linux/proc_fs.h>
 #include <linux/export.h>
 
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/exception.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
@@ -115,10 +116,21 @@ EXPORT_SYMBOL_GPL(set_irq_flags);
 
 void __init init_IRQ(void)
 {
+	int ret;
+
 	if (IS_ENABLED(CONFIG_OF) && !machine_desc->init_irq)
 		irqchip_init();
 	else
 		machine_desc->init_irq();
+
+	if (IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_CACHE_L2X0) &&
+	    (machine_desc->l2c_aux_mask || machine_desc->l2c_aux_val)) {
+		outer_cache.write_sec = machine_desc->l2c_write_sec;
+		ret = l2x0_of_init(machine_desc->l2c_aux_val,
+				   machine_desc->l2c_aux_mask);
+		if (ret)
+			pr_err("L2C: failed to init: %d\n", ret);
+	}
 }
 
 #ifdef CONFIG_MULTI_IRQ_HANDLER
-- 
1.8.3.1
