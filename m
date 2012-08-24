From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 24 Aug 2012 15:01:04 +0200
Subject: [PATCH] ARM: ux500: set proper GIC flags
Message-ID: <1345813264-4896-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The Ux500 will be able to wake up on any IRQ, so flag it with
IRQCHIP_SKIP_SET_WAKE, and we want to mask off the IRQs when
going to suspend to avoid transient effects so also flag
this with IRQCHIP_MASK_ON_SUSPEND.

Cc: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e2360e7..2957432 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -51,6 +51,8 @@ void __init ux500_init_irq(void)
 	void __iomem *dist_base;
 	void __iomem *cpu_base;
 
+	gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
+
 	if (cpu_is_u8500_family()) {
 		dist_base = __io_address(U8500_GIC_DIST_BASE);
 		cpu_base = __io_address(U8500_GIC_CPU_BASE);
-- 
1.7.11.3
