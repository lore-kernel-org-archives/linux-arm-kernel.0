From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 15:20:31 +0530
Subject: [PATCH V3 4/8] SPEAr: clk: Add Auxiliary Synthesizer clock
In-Reply-To: <73afd5e86c8311a04c5d2d21419e3eaa45eafec4.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <73afd5e86c8311a04c5d2d21419e3eaa45eafec4.1335249846.git.viresh.kumar@st.com>
Message-ID: <4FA254E7.2050806@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 12:20 PM, Viresh KUMAR wrote:
> All SPEAr SoC's contain Auxiliary Synthesizers. Their Fout is derived based on
> values of eq, x and y.
> 
> Fout from synthesizer can be given from two equations:
> Fout1 = (Fin * X/Y)/2		EQ1
> Fout2 = Fin * X/Y		EQ2
> 
> This patch adds in support for this type of clock.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Sorry for another fixup. Required due to Saravana's patch:

---
 drivers/clk/spear/clk-aux-synth.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spear/clk-aux-synth.c b/drivers/clk/spear/clk-aux-synth.c
index abb1747..af34074 100644
--- a/drivers/clk/spear/clk-aux-synth.c
+++ b/drivers/clk/spear/clk-aux-synth.c
@@ -140,6 +140,7 @@ struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
                u8 rtbl_cnt, spinlock_t *lock, struct clk **gate_clk)
 {
        struct clk_aux *aux;
+       struct clk_init_data init;
        struct clk *clk;
 
        if (!aux_name || !parent_name || !reg || !rtbl || !rtbl_cnt) {
@@ -163,9 +164,15 @@ struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
        aux->rtbl = rtbl;
        aux->rtbl_cnt = rtbl_cnt;
        aux->lock = lock;
+       aux->hw.init = &init;
 
-       clk = clk_register(NULL, aux_name, &clk_aux_ops, &aux->hw, &parent_name,
-                       1, flags);
+       init.name = aux_name;
+       init.ops = &clk_aux_ops;
+       init.flags = flags;
+       init.parent_names = &parent_name;
+       init.num_parents = 1;
+
+       clk = clk_register(NULL, &aux->hw);
        if (IS_ERR_OR_NULL(clk))
                goto free_aux;
 
-- 
viresh
