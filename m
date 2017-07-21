From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jul 2017 17:22:48 +0200
Subject: [PATCH v2 3/3] ARM: w90x900: normalize clk API
In-Reply-To: <20170721152250.3310552-1-arnd@arndb.de>
References: <20170721152250.3310552-1-arnd@arndb.de>
Message-ID: <20170721152250.3310552-4-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

w90x900 still provides its own variant of the clk API rather than using
the generic COMMON_CLK API. This generally works, but it causes some link
errors with drivers using the clk_set_rate, clk_get_parent, clk_set_parent
or clk_round_rate functions when a platform lacks those interfaces.

This adds empty stub implementations for each of them, and I don't even
try to do something useful here but instead just print a WARN() message
to make it obvious what is going on if they ever end up being called.

The drivers that call these won't be used on these platforms (otherwise
we'd get a link error today), so the added code is harmless bloat and
will warn about accidental use.

A while ago there was a proposal to change w90x900 to use the common-clk
implementation, which would be the way it should be handled properly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-w90x900/clock.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
index ac6fd1a2cb59..3f93fac98d97 100644
--- a/arch/arm/mach-w90x900/clock.c
+++ b/arch/arm/mach-w90x900/clock.c
@@ -93,3 +93,32 @@ void nuc900_subclk_enable(struct clk *clk, int enable)
 
 	__raw_writel(clken, W90X900_VA_CLKPWR + SUBCLK);
 }
+
+/* dummy functions, should not be called */
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	WARN_ON(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	WARN_ON(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	WARN_ON(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	WARN_ON(clk);
+	return NULL;
+}
+EXPORT_SYMBOL(clk_get_parent);
-- 
2.9.0
