From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  3 Oct 2016 10:09:05 +0200
Subject: [PATCH v3 1/9] clk: sunxi-ng: Rename the internal structures
In-Reply-To: <20161003080913.24197-1-maxime.ripard@free-electrons.com>
References: <20161003080913.24197-1-maxime.ripard@free-electrons.com>
Message-ID: <20161003080913.24197-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the structures meant to be embedded in other structures to make it
consistent with the mux structure name

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_div.h  |  6 +++---
 drivers/clk/sunxi-ng/ccu_frac.c | 12 ++++++------
 drivers/clk/sunxi-ng/ccu_frac.h | 14 +++++++-------
 drivers/clk/sunxi-ng/ccu_mp.h   |  4 ++--
 drivers/clk/sunxi-ng/ccu_mult.h |  4 ++--
 drivers/clk/sunxi-ng/ccu_nk.h   |  4 ++--
 drivers/clk/sunxi-ng/ccu_nkm.h  |  6 +++---
 drivers/clk/sunxi-ng/ccu_nkmp.h |  8 ++++----
 drivers/clk/sunxi-ng/ccu_nm.h   |  6 +++---
 9 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index 34c338832c0d..06540f7cf41c 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -20,7 +20,7 @@
 #include "ccu_mux.h"
 
 /**
- * struct _ccu_div - Internal divider description
+ * struct ccu_div_internal - Internal divider description
  * @shift: Bit offset of the divider in its register
  * @width: Width of the divider field in its register
  * @max: Maximum value allowed for that divider. This is the
@@ -36,7 +36,7 @@
  * It is basically a wrapper around the clk_divider functions
  * arguments.
  */
-struct _ccu_div {
+struct ccu_div_internal {
 	u8			shift;
 	u8			width;
 
@@ -78,7 +78,7 @@ struct _ccu_div {
 struct ccu_div {
 	u32			enable;
 
-	struct _ccu_div		div;
+	struct ccu_div_internal		div;
 	struct ccu_mux_internal	mux;
 	struct ccu_common	common;
 };
diff --git a/drivers/clk/sunxi-ng/ccu_frac.c b/drivers/clk/sunxi-ng/ccu_frac.c
index 5c4b10cd15b5..8b5eb7756bf7 100644
--- a/drivers/clk/sunxi-ng/ccu_frac.c
+++ b/drivers/clk/sunxi-ng/ccu_frac.c
@@ -14,7 +14,7 @@
 #include "ccu_frac.h"
 
 bool ccu_frac_helper_is_enabled(struct ccu_common *common,
-				struct _ccu_frac *cf)
+				struct ccu_frac_internal *cf)
 {
 	if (!(common->features & CCU_FEATURE_FRACTIONAL))
 		return false;
@@ -23,7 +23,7 @@ bool ccu_frac_helper_is_enabled(struct ccu_common *common,
 }
 
 void ccu_frac_helper_enable(struct ccu_common *common,
-			    struct _ccu_frac *cf)
+			    struct ccu_frac_internal *cf)
 {
 	unsigned long flags;
 	u32 reg;
@@ -38,7 +38,7 @@ void ccu_frac_helper_enable(struct ccu_common *common,
 }
 
 void ccu_frac_helper_disable(struct ccu_common *common,
-			     struct _ccu_frac *cf)
+			     struct ccu_frac_internal *cf)
 {
 	unsigned long flags;
 	u32 reg;
@@ -53,7 +53,7 @@ void ccu_frac_helper_disable(struct ccu_common *common,
 }
 
 bool ccu_frac_helper_has_rate(struct ccu_common *common,
-			      struct _ccu_frac *cf,
+			      struct ccu_frac_internal *cf,
 			      unsigned long rate)
 {
 	if (!(common->features & CCU_FEATURE_FRACTIONAL))
@@ -63,7 +63,7 @@ bool ccu_frac_helper_has_rate(struct ccu_common *common,
 }
 
 unsigned long ccu_frac_helper_read_rate(struct ccu_common *common,
-					struct _ccu_frac *cf)
+					struct ccu_frac_internal *cf)
 {
 	u32 reg;
 
@@ -84,7 +84,7 @@ unsigned long ccu_frac_helper_read_rate(struct ccu_common *common,
 }
 
 int ccu_frac_helper_set_rate(struct ccu_common *common,
-			     struct _ccu_frac *cf,
+			     struct ccu_frac_internal *cf,
 			     unsigned long rate)
 {
 	unsigned long flags;
diff --git a/drivers/clk/sunxi-ng/ccu_frac.h b/drivers/clk/sunxi-ng/ccu_frac.h
index e4c670b1cdfe..7b1ee380156f 100644
--- a/drivers/clk/sunxi-ng/ccu_frac.h
+++ b/drivers/clk/sunxi-ng/ccu_frac.h
@@ -18,7 +18,7 @@
 
 #include "ccu_common.h"
 
-struct _ccu_frac {
+struct ccu_frac_internal {
 	u32		enable;
 	u32		select;
 
@@ -33,21 +33,21 @@ struct _ccu_frac {
 	}
 
 bool ccu_frac_helper_is_enabled(struct ccu_common *common,
-				struct _ccu_frac *cf);
+				struct ccu_frac_internal *cf);
 void ccu_frac_helper_enable(struct ccu_common *common,
-			    struct _ccu_frac *cf);
+			    struct ccu_frac_internal *cf);
 void ccu_frac_helper_disable(struct ccu_common *common,
-			     struct _ccu_frac *cf);
+			     struct ccu_frac_internal *cf);
 
 bool ccu_frac_helper_has_rate(struct ccu_common *common,
-			      struct _ccu_frac *cf,
+			      struct ccu_frac_internal *cf,
 			      unsigned long rate);
 
 unsigned long ccu_frac_helper_read_rate(struct ccu_common *common,
-					struct _ccu_frac *cf);
+					struct ccu_frac_internal *cf);
 
 int ccu_frac_helper_set_rate(struct ccu_common *common,
-			     struct _ccu_frac *cf,
+			     struct ccu_frac_internal *cf,
 			     unsigned long rate);
 
 #endif /* _CCU_FRAC_H_ */
diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
index edf9215ea8cc..915625e97d98 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.h
+++ b/drivers/clk/sunxi-ng/ccu_mp.h
@@ -29,8 +29,8 @@
 struct ccu_mp {
 	u32			enable;
 
-	struct _ccu_div		m;
-	struct _ccu_div		p;
+	struct ccu_div_internal		m;
+	struct ccu_div_internal		p;
 	struct ccu_mux_internal	mux;
 	struct ccu_common	common;
 };
diff --git a/drivers/clk/sunxi-ng/ccu_mult.h b/drivers/clk/sunxi-ng/ccu_mult.h
index 5d2c8dc14073..113780b7558e 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.h
+++ b/drivers/clk/sunxi-ng/ccu_mult.h
@@ -4,7 +4,7 @@
 #include "ccu_common.h"
 #include "ccu_mux.h"
 
-struct _ccu_mult {
+struct ccu_mult_internal {
 	u8	shift;
 	u8	width;
 };
@@ -18,7 +18,7 @@ struct _ccu_mult {
 struct ccu_mult {
 	u32			enable;
 
-	struct _ccu_mult	mult;
+	struct ccu_mult_internal	mult;
 	struct ccu_mux_internal	mux;
 	struct ccu_common	common;
 };
diff --git a/drivers/clk/sunxi-ng/ccu_nk.h b/drivers/clk/sunxi-ng/ccu_nk.h
index 4b52da0c29fe..437836b80696 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.h
+++ b/drivers/clk/sunxi-ng/ccu_nk.h
@@ -30,8 +30,8 @@ struct ccu_nk {
 	u32			enable;
 	u32			lock;
 
-	struct _ccu_mult	n;
-	struct _ccu_mult	k;
+	struct ccu_mult_internal	n;
+	struct ccu_mult_internal	k;
 
 	unsigned int		fixed_post_div;
 
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
index 35493fddd8ab..34580894f4d1 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.h
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -29,9 +29,9 @@ struct ccu_nkm {
 	u32			enable;
 	u32			lock;
 
-	struct _ccu_mult	n;
-	struct _ccu_mult	k;
-	struct _ccu_div		m;
+	struct ccu_mult_internal	n;
+	struct ccu_mult_internal	k;
+	struct ccu_div_internal		m;
 	struct ccu_mux_internal	mux;
 
 	struct ccu_common	common;
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.h b/drivers/clk/sunxi-ng/ccu_nkmp.h
index 5adb0c92a614..a82facbc6144 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.h
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.h
@@ -29,10 +29,10 @@ struct ccu_nkmp {
 	u32			enable;
 	u32			lock;
 
-	struct _ccu_mult	n;
-	struct _ccu_mult	k;
-	struct _ccu_div		m;
-	struct _ccu_div		p;
+	struct ccu_mult_internal	n;
+	struct ccu_mult_internal	k;
+	struct ccu_div_internal		m;
+	struct ccu_div_internal		p;
 
 	struct ccu_common	common;
 };
diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
index 0b7bcd33a2df..e87fd186da78 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.h
+++ b/drivers/clk/sunxi-ng/ccu_nm.h
@@ -30,9 +30,9 @@ struct ccu_nm {
 	u32			enable;
 	u32			lock;
 
-	struct _ccu_mult	n;
-	struct _ccu_div		m;
-	struct _ccu_frac	frac;
+	struct ccu_mult_internal	n;
+	struct ccu_div_internal		m;
+	struct ccu_frac_internal	frac;
 
 	struct ccu_common	common;
 };
-- 
2.9.3
