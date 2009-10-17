From: linuxzsc@gmail.com (Richard Zhao)
Date: Sat, 17 Oct 2009 17:46:23 +0800
Subject: [PATCH V1 2/3] i2c: imx: only imx1 needs disable delay
In-Reply-To: <1255772784-11387-1-git-send-email-linuxzsc@gmail.com>
References: <1255772784-11387-1-git-send-email-linuxzsc@gmail.com>
Message-ID: <1255772784-11387-2-git-send-email-linuxzsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

check cpu_is_mx1() when disable delay.

Signed-off-by: Richard Zhao <linuxzsc@gmail.com>

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 6055e92..671d37c 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -225,11 +225,13 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 		writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
 		i2c_imx->stopped = 1;
 	}
-	/*
-	 * This delay caused by an i.MXL hardware bug.
-	 * If no (or too short) delay, no "STOP" bit will be generated.
-	 */
-	udelay(i2c_imx->disable_delay);
+	if (cpu_is_mx1()) {
+		/*
+		 * This delay caused by an i.MXL hardware bug.
+		 * If no (or too short) delay, no "STOP" bit will be generated.
+		 */
+		udelay(i2c_imx->disable_delay);
+	}
 
 	if (!i2c_imx->stopped)
 		i2c_imx_bus_busy(i2c_imx, 0);
-- 
1.6.0.4
