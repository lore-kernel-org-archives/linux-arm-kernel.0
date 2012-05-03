From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 11:02:41 +0530
Subject: [PATCH V3 2/8] clk: add a fixed factor clock
In-Reply-To: <20120502224108.GC18402@gmail.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <a8f9558e0709b63673e88912d25f2173b6b410e5.1335249846.git.viresh.kumar@st.com>
 <20120502094807.GE20478@pengutronix.de> <4FA120E8.5030707@st.com>
 <20120502224108.GC18402@gmail.com>
Message-ID: <4FA21879.9060508@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/3/2012 4:11 AM, Mike Turquette wrote:
> I will take this patch in before sending my request to Arnd.  In your
> patch 0/8 you ask me to take in the series, but it looks like not all of
> the patches are going through me.  For instance patch 2/8 certainly
> looks destined for Russell.

I think you only need to take this patch, i.e. 2/8.
Others will go through Arnd directly, keeping your branch as an dependency
branch for it.

> After fixing up this patch can you resend a clean series which is only
> headed for clk-next?

So, i would be sending this patch only after applying the last fixup
(hopefully :) ).

@Sascha: Please see if this patch is sufficient.

---
 drivers/clk/clk-fixed-factor.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 9afbdc4..8d25c2e 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -37,16 +37,15 @@ static long clk_factor_round_rate(struct clk_hw *hw, unsigned long rate,
 {
        struct clk_fixed_factor *fix = to_clk_fixed_factor(hw);
 
-       if (prate) {
+       if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
                unsigned long best_parent;
+
                best_parent = (rate / fix->mult) * fix->div;
                *prate = __clk_round_rate(__clk_get_parent(hw->clk),
                                best_parent);
-               return (*prate / fix->div) * fix->mult;
-       } else {
-               return (__clk_get_rate(__clk_get_parent(hw->clk)) / fix->div) *
-                       fix->mult;
        }
+
+       return (*prate / fix->div) * fix->mult;
 }
 
 static int clk_factor_set_rate(struct clk_hw *hw, unsigned long rate,



-- 
viresh
