From: chaos.youn@samsung.com (Changhwan Youn)
Date: Mon, 20 Jun 2011 16:34:14 +0900
Subject: [PATCH 3/7] ARM: EXYNOS4: set the affinity of mct1 interrupt using
	IRQ_MCT_L1
In-Reply-To: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
Message-ID: <1308555258-4322-4-git-send-email-chaos.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ_MCT_L1 is connected directly to GIC in external GIC mapping,
while in internal GIC mapping, it is connected to GIC through
interrupt combiner. Therfore the affinity for mct1 event timer
interrupt should be changed through IRQ_MCT_L1.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
---
 arch/arm/mach-exynos4/mct.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos4/mct.c
index 14ac10b..1ae059b 100644
--- a/arch/arm/mach-exynos4/mct.c
+++ b/arch/arm/mach-exynos4/mct.c
@@ -383,8 +383,8 @@ static void exynos4_mct_tick_init(struct clock_event_device *evt)
 		setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
 	} else {
 		mct_tick1_event_irq.dev_id = &mct_tick[cpu];
-		irq_set_affinity(IRQ_MCT1, cpumask_of(1));
 		setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
+		irq_set_affinity(IRQ_MCT_L1, cpumask_of(1));
 	}
 }
 
-- 
1.7.1
