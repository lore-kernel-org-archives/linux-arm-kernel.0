From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:55:14 +0000
Subject: [PATCH 02/20] ARM: sa1111: fix PWM state on suspend
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPE2-00043c-H6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should not write to the SA1111 registers after setting the SLEEP
bit.  Moreover, the manual says that the PWM registers should be
disabled before we enter sleep.  So, move the clearing of these
registers earlier in the suspend sequence.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index c7bed30..f0d9faa 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -905,6 +905,9 @@ static int sa1111_suspend(struct platform_device *dev, pm_message_t state)
 	save->skpwm0   = sa1111_readl(base + SA1111_SKPWM0);
 	save->skpwm1   = sa1111_readl(base + SA1111_SKPWM1);
 
+	sa1111_writel(0, sachip->base + SA1111_SKPWM0);
+	sa1111_writel(0, sachip->base + SA1111_SKPWM1);
+
 	base = sachip->base + SA1111_INTC;
 	save->intpol0  = sa1111_readl(base + SA1111_INTPOL0);
 	save->intpol1  = sa1111_readl(base + SA1111_INTPOL1);
@@ -920,8 +923,6 @@ static int sa1111_suspend(struct platform_device *dev, pm_message_t state)
 	 */
 	val = sa1111_readl(sachip->base + SA1111_SKCR);
 	sa1111_writel(val | SKCR_SLEEP, sachip->base + SA1111_SKCR);
-	sa1111_writel(0, sachip->base + SA1111_SKPWM0);
-	sa1111_writel(0, sachip->base + SA1111_SKPWM1);
 
 	clk_disable(sachip->clk);
 
-- 
1.7.4.4
