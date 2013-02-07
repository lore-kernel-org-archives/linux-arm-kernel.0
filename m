From: robherring2@gmail.com (Rob Herring)
Date: Thu,  7 Feb 2013 13:09:01 -0600
Subject: [PATCH 1/4] clocksource: pass DT node pointer to init functions
In-Reply-To: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
Message-ID: <1360264144-20714-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In cases where we have multiple nodes of the same type, we may need the
node pointer to know which node was matched. Passing the node pointer
also keeps the init function from having to match the node a 2nd time.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: John Stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/clksrc-of.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/clksrc-of.c b/drivers/clocksource/clksrc-of.c
index bdabdaa..3ef11fb 100644
--- a/drivers/clocksource/clksrc-of.c
+++ b/drivers/clocksource/clksrc-of.c
@@ -26,10 +26,10 @@ void __init clocksource_of_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
-	void (*init_func)(void);
+	void (*init_func)(struct device_node *);
 
 	for_each_matching_node_and_match(np, __clksrc_of_table, &match) {
 		init_func = match->data;
-		init_func();
+		init_func(np);
 	}
 }
-- 
1.7.10.4
