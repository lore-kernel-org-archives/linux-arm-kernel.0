From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 16:45:39 +0530
Subject: [PATCH 07/13] clk: clk_set_rate() must fail if CLK_SET_RATE_GATE is
 set and clk is enabled
In-Reply-To: <cover.1334660431.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
Message-ID: <f34c1238e2b5d8469e172b2d850e2e161cc26486.1334660432.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is well documented but isn't implemented. clk_set_rate() must check if
flags have CLK_SET_RATE_GATE bit set and is enabled too.

Untested patch.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clk.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 865d0dd..2bcce5a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -898,6 +898,11 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (rate == clk->rate)
 		goto out;
 
+	if ((clk->flags & CLK_SET_RATE_GATE) && __clk_is_enabled(clk)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* calculate new rates and get the topmost changed clock */
 	top = clk_calc_new_rates(clk, rate);
 	if (!top) {
-- 
1.7.9
