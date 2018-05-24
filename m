From: daniel@zonque.org (Daniel Mack)
Date: Thu, 24 May 2018 22:40:46 +0200
Subject: [PATCH] ARM: pxa3xx: enable external wakeup pins
Message-ID: <20180524204046.21494-1-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PXA3xx SoCs feature dedicated pins for wakeup functionality. These pins
have no alternate functions, so let's always enable them as wakeup source on
DT enabled boards. The WAKEUP1 pin is only available on PXA320.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/mach-pxa/pxa3xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 2a5044dd463e..9e05f92cd97a 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -442,6 +442,10 @@ static int __init pxa3xx_init(void)
 
 		pxa3xx_init_pm();
 
+		enable_irq_wake(IRQ_WAKEUP0);
+		if (cpu_is_pxa320())
+			enable_irq_wake(IRQ_WAKEUP1);
+
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa3xx_mfp_syscore_ops);
 
-- 
2.14.3
