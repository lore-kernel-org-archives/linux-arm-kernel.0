From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 05 Feb 2010 20:15:25 +0900
Subject: [PATCH 05/06] sh: Let INTC set IRQF_VALID on ARM platforms V2
In-Reply-To: <20100205111440.17065.33296.sendpatchset@rxone.opensource.se>
References: <20100205111440.17065.33296.sendpatchset@rxone.opensource.se>
Message-ID: <20100205111525.17065.35884.sendpatchset@rxone.opensource.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Reuse the SuperH INTC code on ARM by using set_irq_flags()
to set IRQF_VALID on ARM platforms. (V2)

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - wrap with CONFIG_ARM instead of CONFIG_ARCH_SHMOBILE
 - use set_irq_flags() in create_irq_nr() as well

 drivers/sh/intc.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- 0001/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2010-02-05 14:11:53.000000000 +0900
@@ -658,6 +658,10 @@ static void __init intc_register_irq(str
 
 	if (desc->ack_regs)
 		ack_handle[irq] = intc_ack_data(desc, d, enum_id);
+
+#ifdef CONFIG_ARM
+	set_irq_flags(irq, IRQF_VALID); /* Enable IRQ on ARM systems */
+#endif
 }
 
 static unsigned int __init save_reg(struct intc_desc_int *d,
@@ -906,8 +910,12 @@ unsigned int create_irq_nr(unsigned int 
 out_unlock:
 	spin_unlock_irqrestore(&vector_lock, flags);
 
-	if (irq > 0)
+	if (irq > 0) {
 		dynamic_irq_init(irq);
+#ifdef CONFIG_ARM
+		set_irq_flags(irq, IRQF_VALID); /* Enable IRQ on ARM systems */
+#endif
+	}
 
 	return irq;
 }
