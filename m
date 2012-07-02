From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon,  2 Jul 2012 09:41:42 +0200
Subject: [PATCH v2] clk: __clk_set_parent: set uninitialized variable
Message-ID: <1341214902-15667-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following warning:

    drivers/clk/clk.c: In function '__clk_set_parent':
    drivers/clk/clk.c:1083:5: warning: 'i' may be used uninitialized in this function [-Wuninitialized]

which has been introduced with commit:

    commit 7975059db572eb47f0fb272a62afeae272a4b209
    Author: Rajendra Nayak <rnayak@ti.com>
    Date:   Wed Jun 6 14:41:31 2012 +0530

        clk: Allow late cache allocation for clk->parents

This patch applies to linux-3.5-rc5

Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

here an updated version. Changes since v1:
- Set i to clk->num_parents as Uwe pointed out.

regards, Marc

 drivers/clk/clk.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index dcbe056..9a75635 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1068,13 +1068,15 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	old_parent = clk->parent;
 
 	/* find index of new parent clock using cached parent ptrs */
-	if (clk->parents)
+	if (clk->parents) {
 		for (i = 0; i < clk->num_parents; i++)
 			if (clk->parents[i] == parent)
 				break;
-	else
+	} else {
+		i = clk->num_parents
 		clk->parents = kzalloc((sizeof(struct clk*) * clk->num_parents),
 								GFP_KERNEL);
+	}
 
 	/*
 	 * find index of new parent clock using string name comparison
-- 
1.7.10
