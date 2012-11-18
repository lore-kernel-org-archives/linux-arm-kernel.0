From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Nov 2012 16:39:32 +0000
Subject: [PATCH] Dove: Fix irq_to_pmu()
In-Reply-To: <20121118162944.GV3290@n2100.arm.linux.org.uk>
References: <20121118162944.GV3290@n2100.arm.linux.org.uk>
Message-ID: <20121118163932.GW3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMU interrupts start at IRQ_DOVE_PMU_START, not IRQ_DOVE_PMU_START + 1.
Fix the condition.  (It may have been less likely to occur had the code
been written "if (irq >= IRQ_DOVE_PMU_START" which imho is the easier
to understand notation, and matches the normal way of thinking about
these things.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
-- 
 arch/arm/mach-dove/include/mach/pm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-dove/include/mach/pm.h b/arch/arm/mach-dove/include/mach/pm.h
index 1c942c0..02a0073 100644
--- a/arch/arm/mach-dove/include/mach/pm.h
+++ b/arch/arm/mach-dove/include/mach/pm.h
@@ -184,7 +184,7 @@ static inline int pmu_to_irq(int pin)
 
 static inline int irq_to_pmu(int irq)
 {
-	if (IRQ_DOVE_PMU_START < irq && irq < NR_IRQS)
+	if (IRQ_DOVE_PMU_START <= irq && irq < NR_IRQS)
 		return irq - IRQ_DOVE_PMU_START;
 
 	return -EINVAL;
