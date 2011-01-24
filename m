From: ccross@android.com (Colin Cross)
Date: Sun, 23 Jan 2011 18:01:21 -0800
Subject: [PATCH v2 16/28] ARM: tegra: irq: Implement retrigger
In-Reply-To: <1295834493-5019-1-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
Message-ID: <1295834493-5019-17-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/irq.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 12c62a8..2bd5be5 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -208,9 +208,21 @@ static int tegra_set_type(struct irq_data *d, unsigned int flow_type)
 	return 0;
 }
 
+static void tegra_ack(struct irq_data *d)
+{
+	tegra_legacy_force_irq_clr(d->irq);
+	gic_ack_irq(d);
+}
+
+static int tegra_retrigger(struct irq_data *d)
+{
+	tegra_legacy_force_irq_set(d->irq);
+	return 1;
+}
+
 static struct irq_chip tegra_irq = {
 	.name			= "PPI",
-	.irq_ack		= gic_ack_irq,
+	.irq_ack		= tegra_ack,
 	.irq_mask		= tegra_mask,
 	.irq_unmask		= tegra_unmask,
 	.irq_set_wake		= tegra_set_wake,
@@ -218,6 +230,7 @@ static struct irq_chip tegra_irq = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= gic_set_cpu,
 #endif
+	.irq_retrigger		= tegra_retrigger,
 };
 
 void __init tegra_init_irq(void)
-- 
1.7.3.1
