From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 27 Sep 2011 13:16:42 +0100
Subject: [PATCH 2/2] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <1317125802-14386-1-git-send-email-jamie@jamieiles.com>
References: <1317125802-14386-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1317125802-14386-2-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a handler for the VIC that is suitable for MULTI_IRQ_HANDLER
platforms.  This only works for platforms with CONFIG_OF=y as we can
determine which controllers are the primary controllers (no parent).

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/common/vic.c               |   48 +++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/hardware/vic.h |    1 +
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 3658579..e9b72d3 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -63,6 +63,22 @@ static struct vic_device vic_devices[CONFIG_ARM_VIC_NR];
 
 static int vic_id;
 
+#if defined(CONFIG_OF) && defined(CONFIG_MULTI_IRQ_HANDLER)
+/*
+ * The root VIC's.  We keep track of these so that we can do the IRQ demuxing
+ * as we can have more than one root VIC.
+ */
+static struct vic_device *vic_root_devices[CONFIG_ARM_VIC_NR];
+static int nr_root_vics;
+
+static void vic_register_root_controller(struct vic_device *vic)
+{
+	vic_root_devices[nr_root_vics++] = vic;
+}
+#else /* CONFIG_OF && CONFIG_MULTI_IRQ_HANDLER */
+static inline void vic_register_root_controller(struct vic_device *vic) {}
+#endif /* CONFIG_OF && CONFIG_MULTI_IRQ_HANDLER */
+
 /**
  * vic_init2 - common initialisation code
  * @base: Base of the VIC.
@@ -439,6 +455,9 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 	vic->domain.ops = &vic_irq_domain_ops;
 	irq_domain_add(&vic->domain);
 
+	if (!parent)
+		vic_register_root_controller(vic);
+
 	return 0;
 
 out_unmap:
@@ -447,4 +466,33 @@ out_unmap:
 	return -EIO;
 }
 
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
+			handle_IRQ(irq + vic->irq, regs);
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
+	for (i = 0; i < nr_root_vics; ++i)
+		vic_single_handle_irq(vic_root_devices[i], regs);
+}
+#endif /* CONFIG_MULTI_IRQ_HANDLER */
+
 #endif /* CONFIG OF */
diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
index df1d895..451788c 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/arch/arm/include/asm/hardware/vic.h
@@ -53,6 +53,7 @@ static inline int vic_of_init(struct device_node *node,
 	return -ENOSYS;
 }
 #endif /* CONFIG_OF */
+void vic_handle_irq(struct pt_regs *regs);
 #endif /* __ASSEMBLY__ */
 
 #endif
-- 
1.7.4.1
