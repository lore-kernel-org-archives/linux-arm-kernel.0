From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Jan 2010 11:20:35 +0000
Subject: [PATCH 06/18] ARM: PNX4008: convert i2c clocks to match by device only
In-Reply-To: <20100102111849.GA2529@n2100.arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
Message-ID: <6e3e30172aff6ba6b502b281e656bf8461c49bd4.1262431163.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Vitaly Wool <vitalywool@gmail.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pnx4008/clock.c |    6 +++---
 arch/arm/mach-pnx4008/i2c.c   |    8 ++------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index 270c254..26659cd 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -797,9 +797,9 @@ static struct clk_lookup onchip_clkreg[] = {
 	{ .clk = &jpeg_ck,	.con_id = "jpeg_ck"	},
 	{ .clk = &ms_ck,	.con_id = "ms_ck"	},
 	{ .clk = &touch_ck,	.con_id = "touch_ck"	},
-	{ .clk = &i2c0_ck,	.con_id = "i2c0_ck"	},
-	{ .clk = &i2c1_ck,	.con_id = "i2c1_ck"	},
-	{ .clk = &i2c2_ck,	.con_id = "i2c2_ck"	},
+	{ .clk = &i2c0_ck,	.dev_id = "pnx-i2c.0"	},
+	{ .clk = &i2c1_ck,	.dev_id = "pnx-i2c.1"	},
+	{ .clk = &i2c2_ck,	.dev_id = "pnx-i2c.2"	},
 	{ .clk = &spi0_ck,	.con_id = "spi0_ck"	},
 	{ .clk = &spi1_ck,	.con_id = "spi1_ck"	},
 	{ .clk = &uart3_ck,	.con_id = "uart3_ck"	},
diff --git a/arch/arm/mach-pnx4008/i2c.c b/arch/arm/mach-pnx4008/i2c.c
index f3fea29..c986b3a 100644
--- a/arch/arm/mach-pnx4008/i2c.c
+++ b/arch/arm/mach-pnx4008/i2c.c
@@ -21,11 +21,9 @@
 static int set_clock_run(struct platform_device *pdev)
 {
 	struct clk *clk;
-	char name[10];
 	int retval = 0;
 
-	snprintf(name, 10, "i2c%d_ck", pdev->id);
-	clk = clk_get(&pdev->dev, name);
+	clk = clk_get(&pdev->dev, NULL);
 	if (!IS_ERR(clk)) {
 		clk_set_rate(clk, 1);
 		clk_put(clk);
@@ -38,11 +36,9 @@ static int set_clock_run(struct platform_device *pdev)
 static int set_clock_stop(struct platform_device *pdev)
 {
 	struct clk *clk;
-	char name[10];
 	int retval = 0;
 
-	snprintf(name, 10, "i2c%d_ck", pdev->id);
-	clk = clk_get(&pdev->dev, name);
+	clk = clk_get(&pdev->dev, NULL);
 	if (!IS_ERR(clk)) {
 		clk_set_rate(clk, 0);
 		clk_put(clk);
-- 
1.6.2.5
