From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Nov 2018 14:02:36 -0800
Subject: [PATCH 1/2] bus: ti-sysc: Fix getting optional clocks in clock_roles
In-Reply-To: <20181115220237.32129-1-tony@atomide.com>
References: <20181115220237.32129-1-tony@atomide.com>
Message-ID: <20181115220237.32129-2-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can have holes in clock_roles with interface clock missing for
example. Currently getting an optional clock will fail if there are
only a functional clock and an optional clock.

Fixes: 09dfe5810762 ("bus: ti-sysc: Add handling for clkctrl opt clocks")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -214,8 +214,13 @@ static int sysc_get_clocks(struct sysc *ddata)
 	if (!ddata->clocks)
 		return -ENOMEM;
 
-	for (i = 0; i < ddata->nr_clocks; i++) {
-		error = sysc_get_one_clock(ddata, ddata->clock_roles[i]);
+	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
+		const char *name = ddata->clock_roles[i];
+
+		if (!name)
+			continue;
+
+		error = sysc_get_one_clock(ddata, name);
 		if (error && error != -ENOENT)
 			return error;
 	}
-- 
2.19.1
