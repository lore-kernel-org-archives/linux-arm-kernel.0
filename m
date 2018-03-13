From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Tue, 13 Mar 2018 17:34:19 +0100
Subject: [PATCH 2/2] reset: simple: Enable stm32mp1 reset driver
In-Reply-To: <1520958859-27911-1-git-send-email-gabriel.fernandez@st.com>
References: <1520958859-27911-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1520958859-27911-3-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

The stm32mp1 reset driver is quite similar to simple reset driver.
The difference is that stm32mp1 has a reset SET register and
a reset CLEAR register.

Writing '0' on reset SET register has no effect
Writing '1' on reset SET register
	activates the reset of the corresponding peripheral

Writing '0' on reset CLEAR register	has no effect
Writing '1' on reset CLEAR register
	releases the reset of the corresponding peripheral

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/reset/reset-simple.c | 27 +++++++++++++++++++++------
 drivers/reset/reset-simple.h |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index f7ce891..57ecb49 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -41,15 +41,23 @@ static int reset_simple_update(struct reset_controller_dev *rcdev,
 	int offset = id % (reg_width * BITS_PER_BYTE);
 	unsigned long flags;
 	u32 reg;
+	void __iomem *addr;
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + (bank * reg_width));
-	if (assert ^ data->active_low)
-		reg |= BIT(offset);
-	else
-		reg &= ~BIT(offset);
-	writel(reg, data->membase + (bank * reg_width));
+	addr = data->membase + (bank * reg_width);
+	if (data->clr_offset) {
+		reg = BIT(offset);
+		if (!assert)
+			addr += data->clr_offset;
+	} else {
+		reg = readl(addr);
+		if (assert ^ data->active_low)
+			reg |= BIT(offset);
+		else
+			reg &= ~BIT(offset);
+	}
+	writel(reg, addr);
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
@@ -103,6 +111,7 @@ struct reset_simple_devdata {
 	u32 nr_resets;
 	bool active_low;
 	bool status_active_low;
+	u32 clr_offset;
 };
 
 #define SOCFPGA_NR_BANKS	8
@@ -118,9 +127,14 @@ struct reset_simple_devdata {
 	.status_active_low = true,
 };
 
+struct reset_simple_devdata reset_stm32mp1 = {
+	.clr_offset = 0x4,
+};
+
 static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "altr,rst-mgr", .data = &reset_simple_socfpga },
 	{ .compatible = "st,stm32-rcc", },
+	{ .compatible = "st,stm32mp1-rcc", .data = &reset_stm32mp1},
 	{ .compatible = "allwinner,sun6i-a31-clock-reset",
 		.data = &reset_simple_active_low },
 	{ .compatible = "zte,zx296718-reset",
@@ -163,6 +177,7 @@ static int reset_simple_probe(struct platform_device *pdev)
 			data->rcdev.nr_resets = devdata->nr_resets;
 		data->active_low = devdata->active_low;
 		data->status_active_low = devdata->status_active_low;
+		data->clr_offset = devdata->clr_offset;
 	}
 
 	if (of_device_is_compatible(dev->of_node, "altr,rst-mgr") &&
diff --git a/drivers/reset/reset-simple.h b/drivers/reset/reset-simple.h
index 8a49602..0bbdd34 100644
--- a/drivers/reset/reset-simple.h
+++ b/drivers/reset/reset-simple.h
@@ -38,6 +38,7 @@ struct reset_simple_data {
 	struct reset_controller_dev	rcdev;
 	bool				active_low;
 	bool				status_active_low;
+	u32				clr_offset;
 };
 
 extern const struct reset_control_ops reset_simple_ops;
-- 
1.9.1
