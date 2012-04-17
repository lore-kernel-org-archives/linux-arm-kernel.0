From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 16:45:38 +0530
Subject: [PATCH 06/13] clk: Don't set clk->new_rate twice
In-Reply-To: <cover.1334660431.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
Message-ID: <fedbd601aa943e249bfa220faa8ec48949bb4eb2.1334660431.git.viresh.kumar@st.com>
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
index af2bf12..865d0dd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -789,7 +789,7 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
 
 	if (!clk->ops->round_rate) {
 		top = clk_calc_new_rates(clk->parent, rate);
-		new_rate = clk->new_rate = clk->parent->new_rate;
+		new_rate = clk->parent->new_rate;
 
 		goto out;
 	}
-- 
1.7.9
