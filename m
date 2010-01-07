From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 08 Jan 2010 10:44:12 +1100
Subject: [RFC,PATCH 2/7] arm: generic support for fixed-rate clocks
In-Reply-To: <1262907852.736281.78480196040.1.gpush@pororo>
Message-ID: <1262907852.736710.514100290928.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have a few fixed rate clocks, define a simple clk_fixed
with a single rate property.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/common/clk.c      |    8 ++++++++
 arch/arm/include/asm/clk.h |   13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/common/clk.c b/arch/arm/common/clk.c
index 0357d02..699bb28 100644
--- a/arch/arm/common/clk.c
+++ b/arch/arm/common/clk.c
@@ -76,3 +76,11 @@ struct clk *clk_get_parent(struct clk *clk)
 	return ERR_PTR(-ENOSYS);
 }
 EXPORT_SYMBOL(clk_get_parent);
+
+#define to_clk_fixed(clk) (container_of(clk, struct clk_fixed, clk))
+
+unsigned long clk_fixed_get_rate(struct clk *clk)
+{
+	return to_clk_fixed(clk)->rate;
+}
+EXPORT_SYMBOL(clk_fixed_get_rate);
diff --git a/arch/arm/include/asm/clk.h b/arch/arm/include/asm/clk.h
index 87fcfae..1547fa5 100644
--- a/arch/arm/include/asm/clk.h
+++ b/arch/arm/include/asm/clk.h
@@ -28,6 +28,19 @@ struct clk {
        struct clk*     (*get_parent)(struct clk *);
 };
 
+/* Simple fixed-rate clock */
+struct clk_fixed {
+	struct clk	clk;
+	unsigned long	rate;
+};
+
+extern unsigned long clk_fixed_get_rate(struct clk *clk);
+
+#define DEFINE_CLK_FIXED(r) { \
+	.clk = { .get_rate = clk_fixed_get_rate }, \
+	.rate = (r) \
+};
+
 #else /* CONFIG_HAVE_COMMON_STRUCT_CLK */
 
 struct clk;
