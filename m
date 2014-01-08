From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  8 Jan 2014 16:06:28 +0100
Subject: [PATCH v5 3/4] i2c: mv64xxx: Fix bus hang on A0 version of the Armada
 XP SoCs
In-Reply-To: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1389193589-18485-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first variants of Armada XP SoCs (A0 stepping) have issues related
to the i2c controller which prevent to use the offload mechanism and
lead to a kernel hang during boot.

The commit introduces a new the compatible string
marvell,mv78230-a0-i2c for the i2c controller. When this compatible
string is used the driver disables the offload mechanism and the
kernel no more hangs on these SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reported-by: Andrew Lunn <andrew@lunn.ch>
Cc: stable at vger.kernel.org
---
 drivers/i2c/busses/i2c-mv64xxx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8be7e42aa4de..f424c0f89946 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -692,6 +692,10 @@ static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
 	{ .compatible = "allwinner,sun4i-i2c", .data = &mv64xxx_i2c_regs_sun4i},
 	{ .compatible = "marvell,mv64xxx-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
 	{ .compatible = "marvell,mv78230-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
+	{
+		.compatible = "marvell,mv78230-a0-i2c",
+		.data = &mv64xxx_i2c_regs_mv64xxx
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
@@ -783,6 +787,10 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		drv_data->errata_delay = true;
 	}
 
+	if (of_device_is_compatible(np, "marvell,mv78230-a0-i2c")) {
+		drv_data->offload_enabled = false;
+		drv_data->errata_delay = true;
+	}
 out:
 	return rc;
 #endif
-- 
1.8.1.2
