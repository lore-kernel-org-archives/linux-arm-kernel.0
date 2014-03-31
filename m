From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 31 Mar 2014 18:47:27 +0100
Subject: [PATCH] clk: shmobile: fix setting paretn clock rate
Message-ID: <1396288047-6647-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the driver needs to change a clock rate, then it must be propogated
through the MSTP clock to the parent clock (such as shdi0 -> sd0). Without
this we cannot up-rate default clocks which are really slow (such as the
mmcif1 which defaults to 12MHz where it could be running at 97MHz)

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/clk/shmobile/clk-mstp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 7bfdcfc..9fc754b 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -139,7 +139,7 @@ cpg_mstp_clock_register(const char *name, const char *parent_name,
 
 	init.name = name;
 	init.ops = &cpg_mstp_clock_ops;
-	init.flags = CLK_IS_BASIC;
+	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-- 
1.9.0
