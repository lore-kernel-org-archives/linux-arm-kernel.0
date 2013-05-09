From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed,  8 May 2013 22:18:45 -0700
Subject: [PATCH 2/3] clk: Disable unused clocks after deferred probing is done
In-Reply-To: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
Message-ID: <1368076726-11492-3-git-send-email-skannan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With deferred probing, late_initcall() is too soon to declare a clock as
unused. Wait for deferred probing to finish before declaring a clock as
unused.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 drivers/clk/clk.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fe4055f..35de83b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -516,6 +516,8 @@ static int clk_disable_unused(void)
 		return 0;
 	}
 
+	wait_for_init_deferred_probe_done();
+
 	clk_prepare_lock();
 
 	hlist_for_each_entry(clk, &clk_root_list, child_node)
@@ -534,7 +536,7 @@ static int clk_disable_unused(void)
 
 	return 0;
 }
-late_initcall(clk_disable_unused);
+late_initcall_sync(clk_disable_unused);
 
 /***    helper functions   ***/
 
-- 
1.7.8.3

The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
