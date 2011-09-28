From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 28 Sep 2011 11:41:39 +0100
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1317206507-18867-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a handler for the VIC that is suitable for MULTI_IRQ_HANDLER
platforms.  This can replace the ASM entry macros for platforms that use
the VIC.

v2:	- allow the handler be used for !CONFIG_OF
	- use irq_domain_to_irq()

Cc: Rob Herring <robherring2@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/common/vic.c               |   29 +++++++++++++++++++++++++++++
 arch/arm/include/asm/hardware/vic.h |    4 ++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 3f9c8f2..71adced 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -427,3 +427,32 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 	return -EIO;
 }
 #endif /* CONFIG OF */
+
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+static void vic_single_handle_irq(struct vic_device *vic, struct pt_regs *regs)
+{
+	u32 stat, irq;
+	bool handled = false;
+
+	while (!handled) {
+		stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
+		if (!stat)
+			break;
+
+		while (stat) {
+			irq = fls(stat) - 1;
+			handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
+			stat &= ~(1 << irq);
+			handled = true;
+		}
+	}
+}
+
+asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
+{
+	int i;
+
+	for (i = 0; i < vic_id; ++i)
+		vic_single_handle_irq(&vic_devices[i], regs);
+}
+#endif /* CONFIG_MULTI_IRQ_HANDLER */
diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
index 0135215..c02fd6f 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/arch/arm/include/asm/hardware/vic.h
@@ -45,11 +45,15 @@
 #include <linux/types.h>
 
 struct device_node;
+struct pt_regs;
+
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
 
 #ifdef CONFIG_OF
 int vic_of_init(struct device_node *node, struct device_node *parent);
 #endif /* CONFIG_OF */
 
+void vic_handle_irq(struct pt_regs *regs);
+
 #endif /* __ASSEMBLY__ */
 #endif
-- 
1.7.4.1
