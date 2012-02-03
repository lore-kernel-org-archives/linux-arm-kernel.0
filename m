From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:54:54 +0000
Subject: [PATCH 01/20] ARM: sa1111: fix memory request/grant setup on PM events
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPDi-00043Y-D8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We weren't re-enabling the memory request/grant signals on resume,
causing DMA devices on the sa1111 to fail.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 61691cd..c7bed30 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -87,7 +87,8 @@
 #define IRQ_S0_BVD1_STSCHG	(53)
 #define IRQ_S1_BVD1_STSCHG	(54)
 
-extern void __init sa1110_mb_enable(void);
+extern void sa1110_mb_enable(void);
+extern void sa1110_mb_disable(void);
 
 /*
  * We keep the following data for the overall SA1111.  Note that the
@@ -926,6 +927,10 @@ static int sa1111_suspend(struct platform_device *dev, pm_message_t state)
 
 	spin_unlock_irqrestore(&sachip->lock, flags);
 
+#ifdef CONFIG_ARCH_SA1100
+	sa1110_mb_disable();
+#endif
+
 	return 0;
 }
 
@@ -966,6 +971,11 @@ static int sa1111_resume(struct platform_device *dev)
 	 */
 	sa1111_wake(sachip);
 
+#ifdef CONFIG_ARCH_SA1100
+	/* Enable the memory bus request/grant signals */
+	sa1110_mb_enable();
+#endif
+
 	/*
 	 * Only lock for write ops. Also, sa1111_wake must be called with
 	 * released spinlock!
-- 
1.7.4.4
