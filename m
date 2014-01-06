From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  6 Jan 2014 11:40:20 +0100
Subject: [PATCH v3 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the Armada
 XP SoCs
In-Reply-To: <1389004820-30230-1-git-send-email-gregory.clement@free-electrons.com>
References: <1389004820-30230-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1389004820-30230-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first variants of Armada XP SoCs (A0 stepping) have issues related
to the i2c controller which prevent to use the offload mechanism and
lead to a kernel hang during boot.

The driver now check the revision of the SoC. If the revision is not
more recent than the A0 or if the driver can't get the SoC revision
then it disables the offload mechanism.

Cc: stable at vger.kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8be7e42aa4de..b1c6bc4c5e81 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/mvebu-soc-id.h>
 
 #define MV64XXX_I2C_ADDR_ADDR(val)			((val & 0x7f) << 1)
 #define MV64XXX_I2C_BAUD_DIV_N(val)			(val & 0x7)
@@ -779,8 +780,16 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	 * Transaction Generator support and the errata fix.
 	 */
 	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) {
-		drv_data->offload_enabled = true;
+		u32 dev, rev;
+
 		drv_data->errata_delay = true;
+		/*
+		 * Only revisons more recent than A0 support the
+		 * offload mechanism. In case we can't get the SoC
+		 * revision we play safe and we don't enable it
+		 */
+		if (mvebu_get_soc_id(&rev, &dev) == 0 && dev > MV78XX0_A0_REV)
+			drv_data->offload_enabled = true;
 	}
 
 out:
-- 
1.8.1.2
