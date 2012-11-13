From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 13 Nov 2012 12:13:20 -0600
Subject: [PATCH 5/8] ARM: OMAP: Remove unnecessary omap_dm_timer structure
 declaration
In-Reply-To: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1352830403-1706-6-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unnecessary declaration of structure omap_dm_timer from dmtimer.h and
move the actual declaration of structure omap_dm_timer towards top of dmtimer.h
to avoid any compilation errors.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/include/plat/dmtimer.h |   52 ++++++++++++++---------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index b60e2b6..b3cd91b 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -79,8 +79,6 @@ struct omap_timer_capability_dev_attr {
 	u32 timer_capability;
 };
 
-struct omap_dm_timer;
-
 struct timer_regs {
 	u32 tidr;
 	u32 tier;
@@ -101,6 +99,31 @@ struct timer_regs {
 	u32 towr;
 };
 
+struct omap_dm_timer {
+	int id;
+	int irq;
+	struct clk *fclk;
+
+	void __iomem	*io_base;
+	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
+	void __iomem	*irq_ena;	/* irq enable */
+	void __iomem	*irq_dis;	/* irq disable, only on v2 ip */
+	void __iomem	*pend;		/* write pending */
+	void __iomem	*func_base;	/* function register base */
+
+	unsigned long rate;
+	unsigned reserved:1;
+	unsigned posted:1;
+	struct timer_regs context;
+	int (*get_context_loss_count)(struct device *);
+	int ctx_loss_count;
+	int revision;
+	u32 capability;
+	u32 errata;
+	struct platform_device *pdev;
+	struct list_head node;
+};
+
 struct dmtimer_platform_data {
 	/* set_timer_src - Only used for OMAP1 devices */
 	int (*set_timer_src)(struct platform_device *pdev, int source);
@@ -260,31 +283,6 @@ int omap_dm_timers_active(void);
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
-struct omap_dm_timer {
-	int id;
-	int irq;
-	struct clk *fclk;
-
-	void __iomem	*io_base;
-	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
-	void __iomem	*irq_ena;	/* irq enable */
-	void __iomem	*irq_dis;	/* irq disable, only on v2 ip */
-	void __iomem	*pend;		/* write pending */
-	void __iomem	*func_base;	/* function register base */
-
-	unsigned long rate;
-	unsigned reserved:1;
-	unsigned posted:1;
-	struct timer_regs context;
-	int (*get_context_loss_count)(struct device *);
-	int ctx_loss_count;
-	int revision;
-	u32 capability;
-	u32 errata;
-	struct platform_device *pdev;
-	struct list_head node;
-};
-
 static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
 						int posted)
 {
-- 
1.7.9.5
