From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 May 2017 11:09:23 +0800
Subject: [PATCH v2 2/8] clk: Provide option to query hardware for clk phase
In-Reply-To: <20170503030929.28763-1-wens@csie.org>
References: <20170503030929.28763-1-wens@csie.org>
Message-ID: <20170503030929.28763-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some hardware, the clk phase is tied to the parent clk's
rate and some clk delay programmed into the hardware. As the
parent clk rate changes, so does the clk phase.

Add a clk flag specifying not to use the cached clk phase,
but always query the hardware for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/clk.c            | 6 +++++-
 include/linux/clk-provider.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 67201f67a14a..05e2481c1340 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1929,7 +1929,11 @@ static int clk_core_get_phase(struct clk_core *core)
 	int ret;
 
 	clk_prepare_lock();
-	ret = core->phase;
+	if (core && (core->flags & CLK_GET_PHASE_NOCACHE) &&
+	    core->ops->get_phase)
+		ret = core->ops->get_phase(core->hw);
+	else
+		ret = core->phase;
 	clk_prepare_unlock();
 
 	return ret;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index a428aec36ace..e2e856b1a81f 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -35,6 +35,7 @@
 #define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
 /* parents need enable during gate/ungate, set rate and re-parent */
 #define CLK_OPS_PARENT_ENABLE	BIT(12)
+#define CLK_GET_PHASE_NOCACHE	BIT(13) /* do not use the cached clk phase */
 
 struct clk;
 struct clk_hw;
-- 
2.11.0
