From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 12 Mar 2015 17:17:59 +0100
Subject: [PATCH 2/2] i2c: busses with dynamic ids should start after fixed ids
 for DT
In-Reply-To: <1426177093-26820-1-git-send-email-wsa@the-dreams.de>
References: <1426177093-26820-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1426177093-26820-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure dynamic ids do not interfere with fixed ones and let them
start after the highest fixed id. This patch might cause different
bus-numbers for dynamic ids, however it fixes a bug. Assume:

- fixed id0 defers probe
- fixed id1 succeeds and registers a muxed bus with dynamic id
- muxed bus gets id0
- fixed id0 wants to probe again, but its fixed id is gone now
- fixed id0 probe fails

With this patch, the fixed ids are always reserved in the DT case.
For legacy board init, we already have a mechanism like this in
i2c_register_board_info().

Reported-by: Bob Feretich <bob.feretich@rafresearch.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 210cf4874cb7ea..4dda9a529f4464 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1878,6 +1878,14 @@ static int __init i2c_init(void)
 {
 	int retval;
 
+	retval = of_alias_get_highest_id("i2c");
+
+	down_write(&__i2c_board_lock);
+	if (retval >= __i2c_first_dynamic_bus_num) {
+		__i2c_first_dynamic_bus_num = retval + 1;
+	}
+	up_write(&__i2c_board_lock);
+
 	retval = bus_register(&i2c_bus_type);
 	if (retval)
 		return retval;
-- 
2.1.4
