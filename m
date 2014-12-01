From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  2 Dec 2014 02:47:25 +0300
Subject: [PATCH v2 3/4] ARM: sa1100: provide OSTIMER0 clock for pxa_timer
In-Reply-To: <1417477646-14278-1-git-send-email-dbaryshkov@gmail.com>
References: <1417477646-14278-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1417477646-14278-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pxa_timer clocksource requires OSTIMER0 clock to be provided.
Add dummy clock returning proper rate.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/clock.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index 9434766..32fc5ab 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -97,9 +97,21 @@ const struct clkops clk_gpio27_ops = {
 
 static DEFINE_CLK(gpio27, &clk_gpio27_ops);
 
+static unsigned long clk_36864_get_rate(struct clk *clk)
+{
+	return 36864000;
+}
+
+static struct clkops clk_36864_ops = {
+	.get_rate	= clk_36864_get_rate,
+};
+
+static DEFINE_CLK(36864, &clk_36864_ops);
+
 static struct clk_lookup sa11xx_clkregs[] = {
 	CLKDEV_INIT("sa1111.0", NULL, &clk_gpio27),
 	CLKDEV_INIT("sa1100-rtc", NULL, NULL),
+	CLKDEV_INIT(NULL, "OSTIMER0", &clk_36864),
 };
 
 static int __init sa11xx_clk_init(void)
-- 
2.1.3
