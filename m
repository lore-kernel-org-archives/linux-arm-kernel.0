From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 06 Sep 2016 17:37:53 +0100
Subject: [PATCH 5/8] ARM: sa1111: fix pcmcia interrupt mask polarity
In-Reply-To: <20160906163711.GB1041@n2100.armlinux.org.uk>
References: <20160906163711.GB1041@n2100.armlinux.org.uk>
Message-ID: <E1bhJNh-0008D8-OQ@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The polarity of the high IRQs was being calculated using
SA1111_IRQMASK_HI(), but this assumes a Linux interrupt number, not a
hardware interrupt number.  Hence, the resulting mask was incorrect.
Fix this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 332b92317fd8..cfa61b857cad 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -472,8 +472,8 @@ static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 	 * specifies that S0ReadyInt and S1ReadyInt should be '1'.
 	 */
 	sa1111_writel(0, irqbase + SA1111_INTPOL0);
-	sa1111_writel(SA1111_IRQMASK_HI(IRQ_S0_READY_NINT) |
-		      SA1111_IRQMASK_HI(IRQ_S1_READY_NINT),
+	sa1111_writel(BIT(IRQ_S0_READY_NINT & 31) |
+		      BIT(IRQ_S1_READY_NINT & 31),
 		      irqbase + SA1111_INTPOL1);
 
 	/* clear all IRQs */
-- 
2.1.0
