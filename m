From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 30 Mar 2015 17:53:21 +0200
Subject: [RFC PATCH v3 1/2] clk: samsung: Add a clock lookup function
In-Reply-To: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1427730803-28635-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung helpers functions to register clocks, add the clock instance
returned by the common clock framework to a lookup table that is used by
OF to lookup the clocks.

But this table could also be useful to clock drivers if they need to get
a clock instance since the helper functions don't return them.

The common clock framework __clk_lookup() function from the clk provider
API could be used by drivers as well. But it's more efficient to use the
Samsung specific lookup table that returns the clock instance in constant
time, than using the __clk_lookup() function that uses the clock name as
an index so it has a linear search time.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/clk/samsung/clk.c | 6 ++++++
 drivers/clk/samsung/clk.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 9e1f88c04fd4..3b2868a70774 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -96,6 +96,12 @@ void samsung_clk_add_lookup(struct samsung_clk_provider *ctx, struct clk *clk,
 		ctx->clk_data.clks[id] = clk;
 }
 
+struct clk *samsung_clk_lookup(struct samsung_clk_provider *ctx,
+				unsigned int id)
+{
+	return ctx->clk_data.clks ? ctx->clk_data.clks[id] : NULL;
+}
+
 /* register a list of aliases */
 void __init samsung_clk_register_alias(struct samsung_clk_provider *ctx,
 				struct samsung_clock_alias *list,
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index e4c75383cea7..ad04220bd733 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -368,6 +368,9 @@ extern void __init samsung_clk_of_register_fixed_ext(
 extern void samsung_clk_add_lookup(struct samsung_clk_provider *ctx,
 			struct clk *clk, unsigned int id);
 
+extern struct clk *samsung_clk_lookup(struct samsung_clk_provider *ctx,
+			unsigned int id);
+
 extern void samsung_clk_register_alias(struct samsung_clk_provider *ctx,
 			struct samsung_clock_alias *list,
 			unsigned int nr_clk);
-- 
2.1.4
