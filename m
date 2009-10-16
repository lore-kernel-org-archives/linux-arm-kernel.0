From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:17 -0700
Subject: [PATCH 13/46] davinci: support re-parenting a clock in the clock
	framework
In-Reply-To: <1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

The clk_set_parent() API is implemented to enable re-parenting
clocks in the clock tree.

This is useful in DVFS and helps by shifting clocks to an asynchronous
domain where supported by hardware

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 09e0e1c..12ceeea 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -141,6 +141,29 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL(clk_set_rate);
 
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	unsigned long flags;
+
+	if (clk == NULL || IS_ERR(clk))
+		return -EINVAL;
+
+	mutex_lock(&clocks_mutex);
+	clk->parent = parent;
+	list_del_init(&clk->childnode);
+	list_add(&clk->childnode, &clk->parent->children);
+	mutex_unlock(&clocks_mutex);
+
+	spin_lock_irqsave(&clockfw_lock, flags);
+	if (clk->recalc)
+		clk->rate = clk->recalc(clk);
+	propagate_rate(clk);
+	spin_unlock_irqrestore(&clockfw_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
 int clk_register(struct clk *clk)
 {
 	if (clk == NULL || IS_ERR(clk))
-- 
1.6.4.3
