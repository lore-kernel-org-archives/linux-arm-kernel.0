From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Jan 2016 14:28:50 +0000
Subject: [PATCH 2/3] clk: WARN_ON about to disable a critical clock
In-Reply-To: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1453127331-20616-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/clk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 835cb85..178b364 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -575,6 +575,9 @@ static void clk_core_unprepare(struct clk_core *core)
 	if (WARN_ON(core->prepare_count == 0))
 		return;
 
+	if (WARN_ON(core->prepare_count == 1 && core->flags & CLK_IS_CRITICAL))
+		return;
+
 	if (--core->prepare_count > 0)
 		return;
 
@@ -680,6 +683,9 @@ static void clk_core_disable(struct clk_core *core)
 	if (WARN_ON(core->enable_count == 0))
 		return;
 
+	if (WARN_ON(core->enable_count == 1 && core->flags & CLK_IS_CRITICAL))
+		return;
+
 	if (--core->enable_count > 0)
 		return;
 
-- 
1.9.1
