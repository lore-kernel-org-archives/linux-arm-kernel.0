From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  8 Aug 2013 10:17:24 +0200
Subject: [PATCH v3 18/19] ARM: at91: move pit timer to common clk framework
In-Reply-To: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
References: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1375949844-10545-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use device tree to get the source clock of the PIT (Periodic Interval Timer).
If the clock is not found in device tree (or dt is not enabled) we'll try to
get it using clk_lookup definitions.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/mach-at91/at91sam926x_time.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 3a4bc2e..8ac976a 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -39,6 +39,7 @@
 static u32 pit_cycle;		/* write-once */
 static u32 pit_cnt;		/* access only w/system irq blocked */
 static void __iomem *pit_base_addr __read_mostly;
+static struct clk *mck;
 
 static inline unsigned int pit_read(unsigned int reg_offset)
 {
@@ -195,10 +196,14 @@ static int __init of_at91sam926x_pit_init(void)
 	if (!pit_base_addr)
 		goto node_err;
 
+	mck = of_clk_get(np, 0);
+
 	/* Get the interrupts property */
 	ret = irq_of_parse_and_map(np, 0);
 	if (!ret) {
 		pr_crit("AT91: PIT: Unable to get IRQ from DT\n");
+		if (!IS_ERR(mck))
+			clk_put(mck);
 		goto ioremap_err;
 	}
 	at91sam926x_pit_irq.irq = ret;
@@ -230,6 +235,8 @@ void __init at91sam926x_pit_init(void)
 	unsigned	bits;
 	int		ret;
 
+	mck = ERR_PTR(-ENOENT);
+
 	/* For device tree enabled device: initialize here */
 	of_at91sam926x_pit_init();
 
@@ -237,7 +244,12 @@ void __init at91sam926x_pit_init(void)
 	 * Use our actual MCK to figure out how many MCK/16 ticks per
 	 * 1/HZ period (instead of a compile-time constant LATCH).
 	 */
-	pit_rate = clk_get_rate(clk_get(NULL, "mck")) / 16;
+	if (IS_ERR(mck))
+		mck = clk_get(NULL, "mck");
+
+	if (IS_ERR(mck))
+		panic("AT91: PIT: Unable to get mck clk\n");
+	pit_rate = clk_get_rate(mck) / 16;
 	pit_cycle = (pit_rate + HZ/2) / HZ;
 	WARN_ON(((pit_cycle - 1) & ~AT91_PIT_PIV) != 0);
 
-- 
1.7.9.5
