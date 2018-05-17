From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 May 2018 15:14:40 -0700
Subject: [PATCH] bus: ti-sysc: Fix optional clocks array access
Message-ID: <20180517221440.91897-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should be checking ddata->clocks[i] instead of clock_names[i]
for the optional clocks. Currently this just happens to work for
the typical case of one fck and one optional clock.

Fixes: 09dfe5810762 ("bus: ti-sysc: Add handling for clkctrl opt clocks")
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -128,7 +128,7 @@ static int sysc_get_one_clock(struct sysc *ddata, const char *name)
 
 	if (index < 0) {
 		for (i = SYSC_OPTFCK0; i < SYSC_MAX_CLOCKS; i++) {
-			if (!clock_names[i]) {
+			if (!ddata->clocks[i]) {
 				index = i;
 				break;
 			}
-- 
2.17.0
