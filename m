From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Dec 2012 10:18:37 -0800
Subject: [PATCH v2 2/7] arm: zynq: timer: Remove unnecessary register write
In-Reply-To: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
References: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
Message-ID: <9a66d197-21b2-478d-9439-6f6b121a0d9e@VA3EHSMHS024.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acknowedging an interrupt requires to read the interrupt register
only. The write was only required to work around a bug in
the QEMU implementation of the TTC, which is fixed.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Reviewed-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/mach-zynq/timer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index 570491d..f1d224b 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -121,8 +121,7 @@ static irqreturn_t xttcps_clock_event_interrupt(int irq, void *dev_id)
 	struct xttcps_timer *timer = &xttce->xttc;
 
 	/* Acknowledge the interrupt and call event handler */
-	__raw_writel(__raw_readl(timer->base_addr + XTTCPS_ISR_OFFSET),
-			timer->base_addr + XTTCPS_ISR_OFFSET);
+	__raw_readl(timer->base_addr + XTTCPS_ISR_OFFSET);
 
 	xttce->ce.event_handler(&xttce->ce);
 
-- 
1.8.0.2
