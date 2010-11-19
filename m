From: AMartin@nvidia.com (Allen Martin)
Date: Fri, 19 Nov 2010 14:50:50 -0800
Subject: [PATCH] ARM: tegra: irq: protect irq suspend with CONFIG_PM
Message-ID: <3C7A7ACA8617D24290826EC008B5CD0817D747F9E6@HQMAIL03.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Protect irq suspend/resume functions behind #ifdef CONFIG_PM.
This prevents a link error if CONFIG_PM is turned off.

Signed-off-by: Allen Martin <amartin@nvidia.com>
---
 arch/arm/mach-tegra/irq.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 458f9c8..47b7064 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -146,6 +146,7 @@ void tegra_set_lp0_wake_pads(u32 wake_enb, u32 wake_level, u32 wake_any)
        writel(wake_enb, pmc + PMC_WAKE_MASK);
 }

+#ifdef CONFIG_PM
 static void tegra_irq_handle_wake(void)
 {
        int wake;
@@ -174,6 +175,7 @@ static void tegra_irq_handle_wake(void)
                generic_handle_irq(irq);
        }
 }
+#endif

 static void tegra_mask(unsigned int irq)
 {
@@ -251,6 +253,7 @@ void __init tegra_init_irq(void)
        }
 }

+#ifdef CONFIG_PM
 void tegra_irq_suspend(void)
 {
        tegra_legacy_irq_suspend();
@@ -261,6 +264,7 @@ void tegra_irq_resume(void)
        tegra_legacy_irq_resume();
        tegra_irq_handle_wake();
 }
+#endif

 #ifdef CONFIG_DEBUG_FS
 static int tegra_wake_irq_debug_show(struct seq_file *s, void *data)
--
1.7.2.3
