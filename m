From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 07 Mar 2012 19:38:24 -0700
Subject: [PATCH 02/12] ARM: OMAP2+: hwmod: add function to iterate over struct
 omap_hwmod_ocp_if
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Message-ID: <20120308023823.8205.84120.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To reduce the number of lines of data in the OMAP portion of the Linux
code base, subsequent patches will remove the lists of hwmod
interconnect links from the static hwmod data.  These lists will be
built dynamically during boot.  To ease this transition, this patch
centralizes the way that interconnect links are iterated into a single
function, _fetch_next_ocp_if().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  115 ++++++++++++++++++++++----------------
 1 files changed, 67 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 503047a..96a03d7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -169,6 +169,29 @@ static struct omap_hwmod *mpu_oh;
 /* Private functions */
 
 /**
+ * _fetch_next_ocp_if - return @i'th OCP interface in an array
+ * @p: ptr to a ptr to the list_head inside the ocp_if to return (not yet used)
+ * @old: ptr to an array of struct omap_hwmod_ocp_if records
+ * @i: pointer to the index into the @old array
+ *
+ * Return a pointer to the next struct omap_hwmod_ocp_if record in a
+ * sequence.  Currently returns a struct omap_hwmod_ocp_if record
+ * corresponding to the element index pointed to by @i in the @old
+ * array, and increments the index pointed to by @i.
+ */
+static struct omap_hwmod_ocp_if *_fetch_next_ocp_if(struct list_head **p,
+						    struct omap_hwmod_ocp_if **old,
+						    int *i)
+{
+	struct omap_hwmod_ocp_if *oi;
+
+	oi = old[*i];
+	*i = *i + 1;
+
+	return oi;
+}
+
+/**
  * _update_sysc_cache - return the module OCP_SYSCONFIG register, keep copy
  * @oh: struct omap_hwmod *
  *
@@ -582,16 +605,13 @@ static int _init_main_clk(struct omap_hwmod *oh)
  */
 static int _init_interface_clks(struct omap_hwmod *oh)
 {
+	struct omap_hwmod_ocp_if *os;
 	struct clk *c;
-	int i;
+	int i = 0;
 	int ret = 0;
 
-	if (oh->slaves_cnt == 0)
-		return 0;
-
-	for (i = 0; i < oh->slaves_cnt; i++) {
-		struct omap_hwmod_ocp_if *os = oh->slaves[i];
-
+	while (i < oh->slaves_cnt) {
+		os = _fetch_next_ocp_if(NULL, oh->slaves, &i);
 		if (!os->clk)
 			continue;
 
@@ -643,21 +663,19 @@ static int _init_opt_clks(struct omap_hwmod *oh)
  */
 static int _enable_clocks(struct omap_hwmod *oh)
 {
-	int i;
+	struct omap_hwmod_ocp_if *os;
+	int i = 0;
 
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
 
 	if (oh->_clk)
 		clk_enable(oh->_clk);
 
-	if (oh->slaves_cnt > 0) {
-		for (i = 0; i < oh->slaves_cnt; i++) {
-			struct omap_hwmod_ocp_if *os = oh->slaves[i];
-			struct clk *c = os->_clk;
+	while (i < oh->slaves_cnt) {
+		os = _fetch_next_ocp_if(NULL, oh->slaves, &i);
 
-			if (c && (os->flags & OCPIF_SWSUP_IDLE))
-				clk_enable(c);
-		}
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+			clk_enable(os->_clk);
 	}
 
 	/* The opt clocks are controlled by the device driver. */
@@ -673,21 +691,19 @@ static int _enable_clocks(struct omap_hwmod *oh)
  */
 static int _disable_clocks(struct omap_hwmod *oh)
 {
-	int i;
+	struct omap_hwmod_ocp_if *os;
+	int i = 0;
 
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
 
 	if (oh->_clk)
 		clk_disable(oh->_clk);
 
-	if (oh->slaves_cnt > 0) {
-		for (i = 0; i < oh->slaves_cnt; i++) {
-			struct omap_hwmod_ocp_if *os = oh->slaves[i];
-			struct clk *c = os->_clk;
+	while (i < oh->slaves_cnt) {
+		os = _fetch_next_ocp_if(NULL, oh->slaves, &i);
 
-			if (c && (os->flags & OCPIF_SWSUP_IDLE))
-				clk_disable(c);
-		}
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+			clk_disable(os->_clk);
 	}
 
 	/* The opt clocks are controlled by the device driver. */
@@ -997,8 +1013,9 @@ static int _get_addr_space_by_name(struct omap_hwmod *oh, const char *name,
 	struct omap_hwmod_ocp_if *os;
 	bool found = false;
 
-	for (i = 0; i < oh->slaves_cnt; i++) {
-		os = oh->slaves[i];
+	i = 0;
+	while (i < oh->slaves_cnt) {
+		os = _fetch_next_ocp_if(NULL, oh->slaves, &i);
 
 		if (!os->addr)
 			return -ENOENT;
@@ -1035,15 +1052,15 @@ static int _get_addr_space_by_name(struct omap_hwmod *oh, const char *name,
  */
 static int __init _find_mpu_port_index(struct omap_hwmod *oh)
 {
-	int i;
+	struct omap_hwmod_ocp_if *os;
+	int i = 0;
 	int found = 0;
 
-	if (!oh || oh->slaves_cnt == 0)
+	if (!oh)
 		return -EINVAL;
 
-	for (i = 0; i < oh->slaves_cnt; i++) {
-		struct omap_hwmod_ocp_if *os = oh->slaves[i];
-
+	while (i < oh->slaves_cnt) {
+		os = _fetch_next_ocp_if(NULL, oh->slaves, &i);
 		if (os->user & OCP_USER_MPU) {
 			found = 1;
 			break;
@@ -1052,12 +1069,12 @@ static int __init _find_mpu_port_index(struct omap_hwmod *oh)
 
 	if (found)
 		pr_debug("omap_hwmod: %s: MPU OCP slave port ID  %d\n",
-			 oh->name, i);
+			 oh->name, i - 1);
 	else
 		pr_debug("omap_hwmod: %s: no MPU OCP slave port found\n",
 			 oh->name);
 
-	return (found) ? i : -EINVAL;
+	return (found) ? (i - 1) : -EINVAL;
 }
 
 /**
@@ -1956,23 +1973,22 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
  */
 static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
-	int i;
-
+	struct omap_hwmod_ocp_if *os;
+	int i = 0;
 	if (oh->_state != _HWMOD_STATE_INITIALIZED)
 		return;
 
-	for (i = 0; i < oh->slaves_cnt; i++) {
-		struct omap_hwmod_ocp_if *os = oh->slaves[i];
-		struct clk *c = os->_clk;
 
-		if (!c)
+	while (i < oh->slaves_cnt) {
+		os = _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		if (!os->_clk)
 			continue;
 
 		if (os->flags & OCPIF_SWSUP_IDLE) {
 			/* XXX omap_iclk_deny_idle(c); */
 		} else {
 			/* XXX omap_iclk_allow_idle(c); */
-			clk_enable(c);
+			clk_enable(os->_clk);
 		}
 	}
 
@@ -2585,12 +2601,16 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
  */
 int omap_hwmod_count_resources(struct omap_hwmod *oh)
 {
-	int ret, i;
+	struct omap_hwmod_ocp_if *os;
+	int ret;
+	int i = 0;
 
 	ret = _count_mpu_irqs(oh) + _count_sdma_reqs(oh);
 
-	for (i = 0; i < oh->slaves_cnt; i++)
-		ret += _count_ocp_if_addr_spaces(oh->slaves[i]);
+	while (i < oh->slaves_cnt) {
+		os = _fetch_next_ocp_if(NULL, oh->slaves, &i);
+		ret += _count_ocp_if_addr_spaces(os);
+	}
 
 	return ret;
 }
@@ -2607,7 +2627,8 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh)
  */
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 {
-	int i, j, mpu_irqs_cnt, sdma_reqs_cnt;
+	struct omap_hwmod_ocp_if *os;
+	int i, j, mpu_irqs_cnt, sdma_reqs_cnt, addr_cnt;
 	int r = 0;
 
 	/* For each IRQ, DMA, memory area, fill in array.*/
@@ -2630,11 +2651,9 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 		r++;
 	}
 
-	for (i = 0; i < oh->slaves_cnt; i++) {
-		struct omap_hwmod_ocp_if *os;
-		int addr_cnt;
-
-		os = oh->slaves[i];
+	i = 0;
+	while (i < oh->slaves_cnt) {
+		os = _fetch_next_ocp_if(NULL, oh->slaves, &i);
 		addr_cnt = _count_ocp_if_addr_spaces(os);
 
 		for (j = 0; j < addr_cnt; j++) {
