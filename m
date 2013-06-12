From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 18:53:30 +0200
Subject: [PATCHv5 1/8] i2c: mv64xxx: Add macros to access parts of registers
In-Reply-To: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1371056017-8166-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These macros make it more comprehensive to access to useful masked and
shifted area of the various registers used.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 6356439..d70a2fda 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -33,6 +33,10 @@
 #define	MV64XXX_I2C_REG_EXT_SLAVE_ADDR			0x10
 #define	MV64XXX_I2C_REG_SOFT_RESET			0x1c
 
+#define MV64XXX_I2C_ADDR_ADDR(val)			((val & 0x7f) << 1)
+#define MV64XXX_I2C_BAUD_DIV_N(val)			(val & 0x7)
+#define MV64XXX_I2C_BAUD_DIV_M(val)			((val & 0xf) << 3)
+
 #define	MV64XXX_I2C_REG_CONTROL_ACK			0x00000004
 #define	MV64XXX_I2C_REG_CONTROL_IFLG			0x00000008
 #define	MV64XXX_I2C_REG_CONTROL_STOP			0x00000010
@@ -133,7 +137,7 @@ mv64xxx_i2c_prepare_for_io(struct mv64xxx_i2c_data *drv_data,
 		drv_data->addr1 = 0xf0 | (((u32)msg->addr & 0x300) >> 7) | dir;
 		drv_data->addr2 = (u32)msg->addr & 0xff;
 	} else {
-		drv_data->addr1 = ((u32)msg->addr & 0x7f) << 1 | dir;
+		drv_data->addr1 = MV64XXX_I2C_ADDR_ADDR((u32)msg->addr) | dir;
 		drv_data->addr2 = 0;
 	}
 }
@@ -151,7 +155,7 @@ static void
 mv64xxx_i2c_hw_init(struct mv64xxx_i2c_data *drv_data)
 {
 	writel(0, drv_data->reg_base + MV64XXX_I2C_REG_SOFT_RESET);
-	writel((((drv_data->freq_m & 0xf) << 3) | (drv_data->freq_n & 0x7)),
+	writel(MV64XXX_I2C_BAUD_DIV_M(drv_data->freq_m) | MV64XXX_I2C_BAUD_DIV_N(drv_data->freq_n),
 		drv_data->reg_base + MV64XXX_I2C_REG_BAUD);
 	writel(0, drv_data->reg_base + MV64XXX_I2C_REG_SLAVE_ADDR);
 	writel(0, drv_data->reg_base + MV64XXX_I2C_REG_EXT_SLAVE_ADDR);
-- 
1.8.3
