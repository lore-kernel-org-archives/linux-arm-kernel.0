From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 18 Apr 2012 14:02:40 -0700
Subject: [PATCH 05/13] clk: clk-gate: Create clk_gate_endisable()
In-Reply-To: <5c01b4d3c28b8c34d88be3b3db0c9959c41f4bfe.1334660431.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <5c01b4d3c28b8c34d88be3b3db0c9959c41f4bfe.1334660431.git.viresh.kumar@st.com>
Message-ID: <CAJOA=zO+aNE8mn=1oBDPG5eTnyQnzeTp23ofwZMz67NFK3O_Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 4:15 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> This patch tries to remove duplicate code for clk_gate clocks. This creates
> another routine clk_gate_endisable() which will take care of enable/disable
> clock with knowledge of CLK_GATE_SET_TO_DISABLE flag.
>
> It works on following logic:
>
> For enabling clock, enable = 1
> ? ? ? ?set2dis = 1 ? ? -> clear bit ? ?-> set = 0
> ? ? ? ?set2dis = 0 ? ? -> set bit ? ? ?-> set = 1
>
> For disabling clock, enable = 0
> ? ? ? ?set2dis = 1 ? ? -> set bit ? ? ?-> set = 1
> ? ? ? ?set2dis = 0 ? ? -> clear bit ? ?-> set = 0
>
> So, result is always: enable xor set2dis.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Hi Viresh,

Looks good to me.  I'll take into my -next branch.

Thanks,
Mike

> ---
> ?drivers/clk/clk-gate.c | ? 54 ++++++++++++++++++++++-------------------------
> ?1 files changed, 25 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> index 288fb5e..f8d70b5 100644
> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -28,32 +28,38 @@
>
> ?#define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
>
> -static void clk_gate_set_bit(struct clk_gate *gate)
> +/*
> + * It works on following logic:
> + *
> + * For enabling clock, enable = 1
> + * ? ? set2dis = 1 ? ? -> clear bit ? ?-> set = 0
> + * ? ? set2dis = 0 ? ? -> set bit ? ? ?-> set = 1
> + *
> + * For disabling clock, enable = 0
> + * ? ? set2dis = 1 ? ? -> set bit ? ? ?-> set = 1
> + * ? ? set2dis = 0 ? ? -> clear bit ? ?-> set = 0
> + *
> + * So, result is always: enable xor set2dis.
> + */
> +static void clk_gate_endisable(struct clk_hw *hw, int enable)
> ?{
> - ? ? ? u32 reg;
> + ? ? ? struct clk_gate *gate = to_clk_gate(hw);
> + ? ? ? int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
> ? ? ? ?unsigned long flags = 0;
> + ? ? ? u32 reg;
> +
> + ? ? ? set ^= enable;
>
> ? ? ? ?if (gate->lock)
> ? ? ? ? ? ? ? ?spin_lock_irqsave(gate->lock, flags);
>
> ? ? ? ?reg = readl(gate->reg);
> - ? ? ? reg |= BIT(gate->bit_idx);
> - ? ? ? writel(reg, gate->reg);
> -
> - ? ? ? if (gate->lock)
> - ? ? ? ? ? ? ? spin_unlock_irqrestore(gate->lock, flags);
> -}
> -
> -static void clk_gate_clear_bit(struct clk_gate *gate)
> -{
> - ? ? ? u32 reg;
> - ? ? ? unsigned long flags = 0;
>
> - ? ? ? if (gate->lock)
> - ? ? ? ? ? ? ? spin_lock_irqsave(gate->lock, flags);
> + ? ? ? if (set)
> + ? ? ? ? ? ? ? reg |= BIT(gate->bit_idx);
> + ? ? ? else
> + ? ? ? ? ? ? ? reg &= ~BIT(gate->bit_idx);
>
> - ? ? ? reg = readl(gate->reg);
> - ? ? ? reg &= ~BIT(gate->bit_idx);
> ? ? ? ?writel(reg, gate->reg);
>
> ? ? ? ?if (gate->lock)
> @@ -62,24 +68,14 @@ static void clk_gate_clear_bit(struct clk_gate *gate)
>
> ?static int clk_gate_enable(struct clk_hw *hw)
> ?{
> - ? ? ? struct clk_gate *gate = to_clk_gate(hw);
> -
> - ? ? ? if (gate->flags & CLK_GATE_SET_TO_DISABLE)
> - ? ? ? ? ? ? ? clk_gate_clear_bit(gate);
> - ? ? ? else
> - ? ? ? ? ? ? ? clk_gate_set_bit(gate);
> + ? ? ? clk_gate_endisable(hw, 1);
>
> ? ? ? ?return 0;
> ?}
>
> ?static void clk_gate_disable(struct clk_hw *hw)
> ?{
> - ? ? ? struct clk_gate *gate = to_clk_gate(hw);
> -
> - ? ? ? if (gate->flags & CLK_GATE_SET_TO_DISABLE)
> - ? ? ? ? ? ? ? clk_gate_set_bit(gate);
> - ? ? ? else
> - ? ? ? ? ? ? ? clk_gate_clear_bit(gate);
> + ? ? ? clk_gate_endisable(hw, 0);
> ?}
>
> ?static int clk_gate_is_enabled(struct clk_hw *hw)
> --
> 1.7.9
>
