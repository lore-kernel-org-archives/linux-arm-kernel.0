From: ccross@android.com (Colin Cross)
Date: Sun,  5 Dec 2010 15:09:02 -0800
Subject: [PATCH 15/21] ARM: tegra: irq: Implement retrigger
In-Reply-To: <1291590548-7341-1-git-send-email-ccross@android.com>
References: <1291590548-7341-1-git-send-email-ccross@android.com>
Message-ID: <1291590548-7341-16-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/irq.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 8f0ddc6..458f9c8 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -208,9 +208,21 @@ static int tegra_set_type(unsigned int irq, unsigned int flow_type)
 	return 0;
 }
 
+static void tegra_ack(unsigned int irq)
+{
+	tegra_legacy_force_irq_clr(irq);
+	gic_ack_irq(irq);
+}
+
+static int tegra_retrigger(unsigned int irq)
+{
+	tegra_legacy_force_irq_set(irq);
+	return 1;
+}
+
 static struct irq_chip tegra_irq = {
 	.name		= "PPI",
-	.ack		= gic_ack_irq,
+	.ack		= tegra_ack,
 	.mask		= tegra_mask,
 	.unmask		= tegra_unmask,
 	.set_wake	= tegra_set_wake,
@@ -218,6 +230,7 @@ static struct irq_chip tegra_irq = {
 #ifdef CONFIG_SMP
 	.set_affinity	= gic_set_cpu,
 #endif
+	.retrigger	= tegra_retrigger,
 };
 
 void __init tegra_init_irq(void)
-- 
1.7.3.1
