From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 17 Mar 2015 10:47:38 +0100
Subject: [PATCH 3/5] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <20150316070339.GA25487@pengutronix.de>
References: <1426485311-31428-1-git-send-email-s.hauer@pengutronix.de>
 <1426485311-31428-4-git-send-email-s.hauer@pengutronix.de>
 <20150316070339.GA25487@pengutronix.de>
Message-ID: <20150317094738.GF4927@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 08:03:39AM +0100, Uwe Kleine-K?nig wrote:
> Hello Sascha,
> 
> On Mon, Mar 16, 2015 at 06:55:09AM +0100, Sascha Hauer wrote:
> > +static const char *axi_parents[] __initconst = {
> > +	"clk26m",
> > +	"syspll_d3",
> > +	"syspll_d4",
> > +	"syspll_d6",
> > +	"univpll_d5",
> > +	"univpll2_d2",
> > +	"syspll_d3p5"
> > +};
> __initconst should only be used for const data, but this array isn't
> const. Only the strings the pointer in this array point to are constant.

That may be true, but the way it's currently done compiles through
without warnings with CONFIG_DEBUG_SECTION_MISMATCH enabled.

> 
> So you have to use either
> 
> 	static const char *axi_parents[] __initdata = {

This results in:

drivers/clk/mediatek/clk-mt8173.c:515:20: error: i2s3_b_ck_parents causes a section type conflict with infra_clks
 static const char *i2s3_b_ck_parents[] __initdata = {

which can be avoided with static const char * const axi_parents[] __initdata

> 
> or
> 
> 	static const char * const axi_parents[] __initconst = {

Which results in:

drivers/clk/mediatek/clk-mt8173.c:568:2: warning: initialization discards 'const' qualifier from pointer target type
  MUX_GATE(TOP_HDCP_24M_SEL, "hdcp_24m_sel", hdcp_24m_parents, 0x00d0, 16, 2, 23),

With the following patch this can also be resolved. Until this is merged
(or I have the OK from Mike to add this in front of this series) I
prefer to keep it like it is at the moment.

(BTW I compile tested this with ARM multi_v7_defconfig, no additional
warnings are introduced with this patch)

Sascha

-------------------------------8<-----------------------------------

>From 49f76867545d2f402c9684bb26339054b2151977 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 17 Mar 2015 10:43:41 +0100
Subject: [PATCH] clk: make initialization arrays const char * const *

Not only the initialization arrays should be const, but also the
strings inside the arrays. This allows users to put the parent_name
arrays into __initdata or __initconst.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/clk-composite.c  | 2 +-
 drivers/clk/clk-mux.c        | 4 ++--
 include/linux/clk-provider.h | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 956b7e5..077f4c714 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -188,7 +188,7 @@ static void clk_composite_disable(struct clk_hw *hw)
 }
 
 struct clk *clk_register_composite(struct device *dev, const char *name,
-			const char **parent_names, int num_parents,
+			const char * const *parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 69a094c..1fa2a8d 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -114,7 +114,7 @@ const struct clk_ops clk_mux_ro_ops = {
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
+		const char * const *parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
 {
@@ -166,7 +166,7 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 EXPORT_SYMBOL_GPL(clk_register_mux_table);
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
+		const char * const *parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5591ea7..3bdae71 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -209,7 +209,7 @@ struct clk_ops {
 struct clk_init_data {
 	const char		*name;
 	const struct clk_ops	*ops;
-	const char		**parent_names;
+	const char * const	*parent_names;
 	u8			num_parents;
 	unsigned long		flags;
 };
@@ -426,12 +426,12 @@ extern const struct clk_ops clk_mux_ops;
 extern const struct clk_ops clk_mux_ro_ops;
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
+		const char * const *parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
-		const char **parent_names, u8 num_parents, unsigned long flags,
+		const char * const *parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
 
@@ -518,7 +518,7 @@ struct clk_composite {
 };
 
 struct clk *clk_register_composite(struct device *dev, const char *name,
-		const char **parent_names, int num_parents,
+		const char * const *parent_names, int num_parents,
 		struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
-- 
2.1.4


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
