From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 11 Apr 2012 13:17:11 +0530
Subject: [PATCH] clk: Don't set clk->new_rate twice
Message-ID: <b1645e8d85b8857b4b153f1a3d7e9929f0ad4a74.1334130399.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if (!clk->ops->round_rate && (clk->flags & CLK_SET_RATE_PARENT)) is true, then
we don't need to set clk->new_rate here, as we will call clk_calc_subtree()
afterwards and it also sets clk->new_rate.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 56e32a1..9d11c19 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -775,7 +775,7 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
 
 	if (!clk->ops->round_rate && (clk->flags & CLK_SET_RATE_PARENT)) {
 		top = clk_calc_new_rates(clk->parent, rate);
-		new_rate = clk->new_rate = clk->parent->new_rate;
+		new_rate = clk->parent->new_rate;
 
 		goto out;
 	}
-- 
1.7.9
