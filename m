From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 10:07:13 +0200
Subject: [PATCHv4 4/9] i2c: mv64xxx: Add Allwinner sun4i compatible
In-Reply-To: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1371024438-16631-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the compatible string for the Allwinner A10 i2c controller and the
associated register layout.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/i2c/busses/Kconfig       |  3 ++-
 drivers/i2c/busses/i2c-mv64xxx.c |  1 +
 include/linux/mv643xx_i2c.h      | 10 ++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 631736e..5dc4148 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -507,10 +507,11 @@ config I2C_MPC
 
 config I2C_MV64XXX
 	tristate "Marvell mv64xxx I2C Controller"
-	depends on (MV64X60 || PLAT_ORION)
+	depends on (MV64X60 || PLAT_ORION || ARCH_SUNXI)
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Marvell 64xxx line of host bridges.
+	  This driver is also used for Allwinner SoCs I2C controllers.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mv64xxx.
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index f9e076e..febf5ba 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -490,6 +490,7 @@ static const struct i2c_algorithm mv64xxx_i2c_algo = {
  */
 #ifdef CONFIG_OF
 static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
+	{ .compatible = "allwinner,sun4i-i2c", .data = &mv64xxx_i2c_regs_sun4i},
 	{ .compatible = "marvell,mv64xxx-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
 	{}
 };
diff --git a/include/linux/mv643xx_i2c.h b/include/linux/mv643xx_i2c.h
index 9304c94..737108e 100644
--- a/include/linux/mv643xx_i2c.h
+++ b/include/linux/mv643xx_i2c.h
@@ -32,6 +32,16 @@ struct mv64xxx_i2c_regs mv64xxx_i2c_regs_mv64xxx = {
 	.soft_reset	= 0x1c,
 };
 
+struct mv64xxx_i2c_regs mv64xxx_i2c_regs_sun4i = {
+	.addr		= 0x00,
+	.ext_addr	= 0x04,
+	.data		= 0x08,
+	.control	= 0x0c,
+	.status		= 0x10,
+	.clock		= 0x14,
+	.soft_reset	= 0x18,
+};
+
 /* i2c Platform Device, Driver Data */
 struct mv64xxx_i2c_pdata {
 	u32			freq_m;
-- 
1.8.3
