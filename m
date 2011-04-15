From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Apr 2011 21:08:08 +0200
Subject: [PATCH 03/10] clk: Make NULL a valid clock again
In-Reply-To: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1302894495-6879-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NULL used to be a valid clock. This patch makes the common struct
clk stuff work with this. Instead of crashing we return sane default
values for this dummy clock, that is: can always be prepared, enabled,
rate unkown and no set rate.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
---
 drivers/clk/clk.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0da0bb9..264c809 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -15,6 +15,9 @@ int clk_prepare(struct clk *clk)
 {
 	int ret = 0;
 
+	if (!clk)
+		return 0;
+
 	mutex_lock(&clk->prepare_lock);
 	if (clk->prepare_count == 0 && clk->ops->prepare)
 		ret = clk->ops->prepare(clk);
@@ -29,6 +32,9 @@ EXPORT_SYMBOL_GPL(clk_prepare);
 
 void clk_unprepare(struct clk *clk)
 {
+	if (!clk)
+		return;
+
 	mutex_lock(&clk->prepare_lock);
 
 	WARN_ON(clk->prepare_count == 0);
@@ -47,6 +53,9 @@ int clk_enable(struct clk *clk)
 	unsigned long flags;
 	int ret = 0;
 
+	if (!clk)
+		return 0;
+
 	WARN_ON(clk->prepare_count == 0);
 
 	spin_lock_irqsave(&clk->enable_lock, flags);
@@ -65,6 +74,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (!clk)
+		return;
+
 	spin_lock_irqsave(&clk->enable_lock, flags);
 
 	WARN_ON(clk->enable_count == 0);
@@ -78,6 +90,9 @@ EXPORT_SYMBOL_GPL(clk_disable);
 
 unsigned long clk_get_rate(struct clk *clk)
 {
+	if (!clk)
+		return 0;
+
 	if (clk->ops->get_rate)
 		return clk->ops->get_rate(clk);
 	return 0;
@@ -86,6 +101,9 @@ EXPORT_SYMBOL_GPL(clk_get_rate);
 
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
+	if (!clk)
+		return -ENOSYS;
+
 	if (clk->ops->round_rate)
 		return clk->ops->round_rate(clk, rate);
 	return -ENOSYS;
@@ -94,6 +112,9 @@ EXPORT_SYMBOL_GPL(clk_round_rate);
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
+	if (!clk)
+		return -ENOSYS;
+
 	might_sleep();
 
 	if (clk->ops->set_rate)
@@ -104,6 +125,9 @@ EXPORT_SYMBOL_GPL(clk_set_rate);
 
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
+	if (!clk)
+		return -ENOSYS;
+
 	if (clk->ops->set_parent)
 		return clk->ops->set_parent(clk, parent);
 	return -ENOSYS;
@@ -112,6 +136,9 @@ EXPORT_SYMBOL_GPL(clk_set_parent);
 
 struct clk *clk_get_parent(struct clk *clk)
 {
+	if (!clk)
+		return ERR_PTR(-ENOSYS);
+
 	if (clk->ops->get_parent)
 		return clk->ops->get_parent(clk);
 	return ERR_PTR(-ENOSYS);
-- 
1.7.4.1
