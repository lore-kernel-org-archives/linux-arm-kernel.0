From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 15:21:53 +0530
Subject: [PATCH V3 6/8] SPEAr: clk: Add General Purpose Timer Synthesizer
 clock
In-Reply-To: <91fe5296600bd8ca55f9b7e0a1fd32e1a072f817.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <91fe5296600bd8ca55f9b7e0a1fd32e1a072f817.1335249846.git.viresh.kumar@st.com>
Message-ID: <4FA25539.9080109@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 12:20 PM, Viresh KUMAR wrote:
> All SPEAr SoC's contain GPT Synthesizers. Their Fout is derived from
> following equations:
> 
> Fout= Fin/((2 ^ (N+1)) * (M+1))
> 
> This patch adds in support for this type of clock.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Sorry for another fixup. Required due to Saravana's patch:

---
 drivers/clk/spear/clk-gpt-synth.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spear/clk-gpt-synth.c b/drivers/clk/spear/clk-gpt-synth.c
index 688cbf4..b471c97 100644
--- a/drivers/clk/spear/clk-gpt-synth.c
+++ b/drivers/clk/spear/clk-gpt-synth.c
@@ -115,6 +115,7 @@ struct clk *clk_register_gpt(const char *name, const char *parent_name, unsigned
                long flags, void __iomem *reg, struct gpt_rate_tbl *rtbl, u8
                rtbl_cnt, spinlock_t *lock)
 {
+       struct clk_init_data init;
        struct clk_gpt *gpt;
        struct clk *clk;
 
@@ -134,9 +135,15 @@ struct clk *clk_register_gpt(const char *name, const char *parent_name, unsigned
        gpt->rtbl = rtbl;
        gpt->rtbl_cnt = rtbl_cnt;
        gpt->lock = lock;
+       gpt->hw.init = &init;
 
-       clk = clk_register(NULL, name, &clk_gpt_ops, &gpt->hw, &parent_name, 1,
-                       flags);
+       init.name = name;
+       init.ops = &clk_gpt_ops;
+       init.flags = flags;
+       init.parent_names = &parent_name;
+       init.num_parents = 1;
+
+       clk = clk_register(NULL, &gpt->hw);
        if (!IS_ERR_OR_NULL(clk))
                return clk;

-- 
viresh
