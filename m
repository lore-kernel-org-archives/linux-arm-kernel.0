From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:58:54 +0100
Subject: [PATCH 02/14] irqchip: st: use __maybe_unused to hide
 st_irq_syscfg_resume
In-Reply-To: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
Message-ID: <1456934350-1389172-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the st irqchip driver uses SIMPLE_DEV_PM_OPS to conditionally
set its power management functions, but we get a warning
about st_irq_syscfg_resume being unused when CONFIG_PM is not
set:

drivers/irqchip/irq-st.c:183:12: error: 'st_irq_syscfg_resume' defined but not used [-Werror=unused-function]

This adds a __maybe_unused annotation so the compiler knows
it can silently drop it instead of warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
index 9af48a85c16f..5e0e250db0be 100644
--- a/drivers/irqchip/irq-st.c
+++ b/drivers/irqchip/irq-st.c
@@ -180,7 +180,7 @@ static int st_irq_syscfg_probe(struct platform_device *pdev)
 	return st_irq_syscfg_enable(pdev);
 }
 
-static int st_irq_syscfg_resume(struct device *dev)
+static int __maybe_unused st_irq_syscfg_resume(struct device *dev)
 {
 	struct st_irq_syscfg *ddata = dev_get_drvdata(dev);
 
-- 
2.7.0
