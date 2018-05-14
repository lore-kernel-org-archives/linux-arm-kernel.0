From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 14 May 2018 08:50:48 +0000
Subject: clk: stm32mp1: Fix a memory leak in
 'clk_stm32_register_gate_ops()'
In-Reply-To: <20180513111704.31842-1-christophe.jaillet@wanadoo.fr>
References: <20180513111704.31842-1-christophe.jaillet@wanadoo.fr>
Message-ID: <3d149e1f-3290-8b6f-9b5b-1a1133461ed0@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christophe,

Many thanks !

Acked-by: Gabriel Fernandez <gabriel.fernandez@st.com>


On 05/13/2018 01:17 PM, Christophe Jaillet wrote:
> We allocate some memory which is neither used, nor referenced by anything.
> So axe it.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch as not been compile-tested, I don't have the corresponding arch
> and have not taken time to cross-compile it.
> ---
>   drivers/clk/clk-stm32mp1.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
> index edd3cf451401..dfb9cb5bd0c4 100644
> --- a/drivers/clk/clk-stm32mp1.c
> +++ b/drivers/clk/clk-stm32mp1.c
> @@ -579,14 +579,9 @@ clk_stm32_register_gate_ops(struct device *dev,
>   			    spinlock_t *lock)
>   {
>   	struct clk_init_data init = { NULL };
> -	struct clk_gate *gate;
>   	struct clk_hw *hw;
>   	int ret;
>   
> -	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> -	if (!gate)
> -		return ERR_PTR(-ENOMEM);
> -
>   	init.name = name;
>   	init.parent_names = &parent_name;
>   	init.num_parents = 1;
> @@ -604,10 +599,8 @@ clk_stm32_register_gate_ops(struct device *dev,
>   	hw->init = &init;
>   
>   	ret = clk_hw_register(dev, hw);
> -	if (ret) {
> -		kfree(gate);
> +	if (ret)
>   		hw = ERR_PTR(ret);
> -	}
>   
>   	return hw;
>   }
