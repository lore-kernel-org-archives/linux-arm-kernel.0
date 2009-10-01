From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu,  1 Oct 2009 09:13:31 +0800
Subject: [PATCH 2/4] i2c: imx: only imx1 needs disable delay
In-Reply-To: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
Message-ID: <1254359613-21210-2-git-send-email-linuxzsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

check cpu_is_mx1() when set disable_delay.

Signed-off-by: Richard Zhao <linuxzsc@gmail.com>

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 156cc95..c1e541c 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -254,14 +254,16 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
 	/* Write divider value to register */
 	writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
 
-	/*
-	 * There dummy delay is calculated.
-	 * It should be about one I2C clock period long.
-	 * This delay is used in I2C bus disable function
-	 * to fix chip hardware bug.
-	 */
-	i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
-		+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
+	if (cpu_is_mx1()) {
+		/*
+		 * There dummy delay is calculated.
+		 * It should be about one I2C clock period long.
+		 * This delay is used in I2C bus disable function
+		 * to fix chip hardware bug.
+		 */
+		i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
+			+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
+	}
 
 	/* dev_dbg() can't be used, because adapter is not yet registered */
 #ifdef CONFIG_I2C_DEBUG_BUS
-- 
1.6.0.4
