From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Feb 2014 14:01:47 +0100
Subject: [PATCH] ARM: ux500: skip GIC CPU and dist address checks
Message-ID: <1393592507-2466-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ux500 is initializing its IRQs from the device tree and
does not need to figure out any static base addresses anymore,
this is just dead code so delete it.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index d11ac4bf336c..db16b5a04ad5 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -52,17 +52,7 @@ void ux500_restart(enum reboot_mode mode, const char *cmd)
 */
 void __init ux500_init_irq(void)
 {
-	void __iomem *dist_base;
-	void __iomem *cpu_base;
-
 	gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
-
-	if (cpu_is_u8500_family() || cpu_is_ux540_family()) {
-		dist_base = __io_address(U8500_GIC_DIST_BASE);
-		cpu_base = __io_address(U8500_GIC_CPU_BASE);
-	} else
-		ux500_unknown_soc();
-
 	irqchip_init();
 
 	/*
-- 
1.8.5.3
