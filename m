From: johan@kernel.org (Johan Hovold)
Date: Fri, 21 Nov 2014 12:00:16 +0100
Subject: [PATCH] Revert "mfd: tps65910: Convert ti,
 system-power-controller DT property to poweroff-source"
In-Reply-To: <20141121105951.GA20679@localhost>
References: <20141121105951.GA20679@localhost>
Message-ID: <1416567616-10582-1-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 25f833c1171d ("mfd: tps65910: Convert
ti,system-power-controller DT property to poweroff-source"), which
switched to a new device-tree property name for configuring the device
as a power-off controller, but failed to update the affected device-tree
sources and neither provided backward compatibility with the old
property name.

This fixes broken power-off functionality for all boards relying on
tps65910 to power off the system.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mfd/tps65910.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index b8dca8a0db41..7612d89850dd 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -423,7 +423,8 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 
 	board_info->irq = client->irq;
 	board_info->irq_base = -1;
-	board_info->pm_off = of_system_has_poweroff_source(np);
+	board_info->pm_off = of_property_read_bool(np,
+			"ti,system-power-controller");
 
 	return board_info;
 }
-- 
2.0.4
