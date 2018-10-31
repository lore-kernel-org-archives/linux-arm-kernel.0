From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Wed, 31 Oct 2018 15:48:47 +0200
Subject: [PATCH 1/8] clk: clkdev/of_clk - add managed lookup and provider
 registrations
In-Reply-To: <b3954431df109827c71d25d390adf22f6991a6df.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
 <b3954431df109827c71d25d390adf22f6991a6df.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <20181031134847.GA29664@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 10:30:34AM +0200, Matti Vaittinen wrote:
> With MFD devices the clk properties may be contained in MFD (parent) DT
> node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
> subdevice not to MFD device (parent). Add
> devm_of_clk_add_hw_provider_parent to tackle this issue.
> 
> Also clkdev registration lacks of managed registration functions and it
> seems few drivers do not drop clkdev lookups at exit. Add
> devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
> releasing at exit.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

//snip

> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 60c51871b04b..94c7bf471c31 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -916,6 +916,10 @@ int devm_of_clk_add_hw_provider(struct device *dev,
>  			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
>  						 void *data),
>  			   void *data);
> +int devm_of_clk_add_parent_hw_provider(struct device *dev,
> +			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> +						 void *data),
> +			   void *data);
>  void of_clk_del_provider(struct device_node *np);
>  void devm_of_clk_del_provider(struct device *dev);
>  struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,

Right. Didn't spot the 
#ifdef CONFIG_OF
in clk-provider.h. So patch lacks of stub functions for non OF
architectures. The 0-Day test system spot this. Tomorrow I'll send v2
where the inlined stub functions for non OF architectures are added.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
