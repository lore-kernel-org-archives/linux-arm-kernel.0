From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 18 Jul 2017 22:53:31 +0300
Subject: [PATCH v6 2/3] clk: gate: expose clk_gate_ops::is_enabled
In-Reply-To: <1500364414-10021-3-git-send-email-gabriel.fernandez@st.com>
References: <1500364414-10021-1-git-send-email-gabriel.fernandez@st.com>
 <1500364414-10021-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <55bc0f3f-67ed-a15f-5b71-d87044fd5237@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2017 10:53 AM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch exposes clk_gate_ops::is_enabled as functions
> that can be directly called and assigned in places like this so
> we don't need wrapper functions that do nothing besides forward
> the call.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Sugested by Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/clk-gate.c       | 3 ++-
>  include/linux/clk-provider.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> index 4e0c054a..dd82485 100644
> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -86,7 +86,7 @@ static void clk_gate_disable(struct clk_hw *hw)
>  	clk_gate_endisable(hw, 0);
>  }
>  
> -static int clk_gate_is_enabled(struct clk_hw *hw)
> +int clk_gate_is_enabled(struct clk_hw *hw)
>  {
>  	u32 reg;
>  	struct clk_gate *gate = to_clk_gate(hw);
> @@ -101,6 +101,7 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
>  
>  	return reg ? 1 : 0;
>  }
> +EXPORT_SYMBOL_GPL(clk_gate_is_enabled);
>  
>  const struct clk_ops clk_gate_ops = {
>  	.enable = clk_gate_enable,
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index c59c625..e9587ab 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -343,6 +343,7 @@ struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
>  		u8 clk_gate_flags, spinlock_t *lock);
>  void clk_unregister_gate(struct clk *clk);
>  void clk_hw_unregister_gate(struct clk_hw *hw);
> +int clk_gate_is_enabled(struct clk_hw *hw);

Here the prefix does not reflect the type of its argument, it might be
acceptable for a veiled function, but it is not wanted for the exported
function. Something like clk_hw_gate_is_enabled() is expected here, but
again, let's firstly come to an agreement, that the export is needed.

>  
>  struct clk_div_table {
>  	unsigned int	val;
> 

--
With best wishes,
Vladimir
