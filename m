From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 8 Dec 2016 12:45:49 +0200
Subject: [PATCH 3/3] clk: keystone: Add sci-clk driver support
In-Reply-To: <20161208001348.GC5423@codeaurora.org>
References: <1477053961-27128-1-git-send-email-t-kristo@ti.com>
 <1477053961-27128-4-git-send-email-t-kristo@ti.com>
 <20161208001348.GC5423@codeaurora.org>
Message-ID: <cb608729-b617-0eab-5ddf-d78ff47b237e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/16 02:13, Stephen Boyd wrote:
> On 10/21, Tero Kristo wrote:
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 6a8ac04..dce08a7 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -169,6 +169,15 @@ config COMMON_CLK_NXP
>>  	---help---
>>  	  Support for clock providers on NXP platforms.
>>
>> +config TI_SCI_CLK
>> +	tristate "TI System Control Interface clock drivers"
>> +	depends on (TI_SCI_PROTOCOL && COMMON_CLK_KEYSTONE) || COMPILE_TEST
>
> Given that we depend on COMMON_CLK_KEYSTONE (just for the
> Makefile dependency?) this should be moved to right below the
> COMMON_CLK_KEYSTONE config. And we should consider making a
> Kconfig file in drivers/clk/keystone/ to hold both those configs
> instead of having them at the toplevel.

Its a makefile dependency only right now. I'll have a look at how to 
handle this properly.

>
>> +	default TI_SCI_PROTOCOL
>> +	---help---
>> +	  This adds the clock driver support over TI System Control Interface.
>> +	  If you wish to use clock resources from the PMMC firmware, say Y.
>> +	  Otherwise, say N.
>> +
>>  config COMMON_CLK_PALMAS
>>  	tristate "Clock driver for TI Palmas devices"
>>  	depends on MFD_PALMAS
>> diff --git a/drivers/clk/keystone/Makefile b/drivers/clk/keystone/Makefile
>> index 0477cf6..0e7993d 100644
>> --- a/drivers/clk/keystone/Makefile
>> +++ b/drivers/clk/keystone/Makefile
>> @@ -1 +1,2 @@
>>  obj-y			+= pll.o gate.o
>> +obj-$(CONFIG_TI_SCI_CLK)	+= sci-clk.o
>> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
>> new file mode 100644
>> index 0000000..f6af5bd
>> --- /dev/null
>> +++ b/drivers/clk/keystone/sci-clk.c
>> @@ -0,0 +1,589 @@
> [...]
>> +
>> +/**
>> + * sci_clk_recalc_rate - Get clock rate for a TI SCI clock
>> + * @hw: clock to get rate for
>> + * @parent_rate: parent rate provided by common clock framework, not used
>> + *
>> + * Gets the current clock rate of a TI SCI clock. Returns the current
>> + * clock rate, or zero in failure.
>> + */
>> +static unsigned long sci_clk_recalc_rate(struct clk_hw *hw,
>> +					 unsigned long parent_rate)
>> +{
>> +	struct sci_clk *clk = to_sci_clk(hw);
>> +	u64 freq;
>> +	int ret;
>> +
>> +	ret = clk->provider->ops->get_freq(clk->provider->sci, clk->dev_id,
>> +					   clk->clk_id, &freq);
>> +	if (ret) {
>> +		dev_err(clk->provider->dev,
>> +			"recalc-rate failed for dev=%d, clk=%d, ret=%d\n",
>> +			clk->dev_id, clk->clk_id, ret);
>> +		return 0;
>> +	}
>> +
>> +	return (u32)freq;
>
> Do we need the cast? sizeof(u32) doesn't always equal
> sizeof(unsigned long).

Hmm, not sure where that came from. But yea, can be dropped.


>
>> +
>> +/**
>> + * _sci_clk_get - Gets a handle for an SCI clock
>> + * @provider: Handle to SCI clock provider
>> + * @dev_id: device ID for the clock to register
>> + * @clk_id: clock ID for the clock to register
>> + *
>> + * Gets a handle to an existing TI SCI hw clock, or builds a new clock
>> + * entry and registers it with the common clock framework. Called from
>> + * the common clock framework, when a corresponding of_clk_get call is
>> + * executed, or recursively from itself when parsing parent clocks.
>> + * Returns a pointer to the hw clock struct, or ERR_PTR value in failure.
>> + */
>> +static struct clk_hw *_sci_clk_build(struct sci_clk_provider *provider,
>> +				     u16 dev_id, u8 clk_id)
>> +{
>> +	struct clk_init_data init = { NULL };
>> +	struct sci_clk *sci_clk = NULL;
>> +	char *name = NULL;
>> +	char **parent_names = NULL;
>> +	int i;
>> +	int ret;
>> +
>> +	sci_clk = devm_kzalloc(provider->dev, sizeof(*sci_clk), GFP_KERNEL);
>> +	if (!sci_clk)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	sci_clk->dev_id = dev_id;
>> +	sci_clk->clk_id = clk_id;
>> +	sci_clk->provider = provider;
>> +
>> +	ret = provider->ops->get_num_parents(provider->sci, dev_id,
>> +					     clk_id,
>> +					     &init.num_parents);
>> +	if (ret)
>> +		goto err;
>> +
>> +	name = kasprintf(GFP_KERNEL, "%s:%d:%d", dev_name(provider->dev),
>> +			 sci_clk->dev_id, sci_clk->clk_id);
>> +
>> +	init.name = name;
>> +
>> +	if (init.num_parents < 2)
>> +		init.num_parents = 0;
>
> This deserves a comment. Why is num_parents == 1 the same as
> num_parents == 0?

I'll add a comment on this. Basically some clocks can be root clocks 
which don't have parents, and we only want to have parent control for 
clocks that can switch their parent. This is kind of a quirk of the 
firmware.

>
>> +
>> +	if (init.num_parents) {
>> +		parent_names = devm_kcalloc(provider->dev, init.num_parents,
>> +					    sizeof(char *), GFP_KERNEL);
>> +
>> +		if (!parent_names) {
>> +			ret = -ENOMEM;
>> +			goto err;
>> +		}
>> +
>> +		for (i = 0; i < init.num_parents; i++) {
>> +			char *parent_name;
>> +
>> +			parent_name = kasprintf(GFP_KERNEL, "%s:%d:%d",
>> +						dev_name(provider->dev),
>> +						sci_clk->dev_id,
>> +						sci_clk->clk_id + 1 + i);
>> +			if (!parent_name) {
>> +				ret = -ENOMEM;
>> +				goto err;
>> +			}
>> +			parent_names[i] = parent_name;
>> +		}
>> +		init.parent_names = (const char * const *)parent_names;
>
> Does that really need a cast?

Doesn't seem like so... I think without this it was generating some 
checkpatch issue sometime back, but doesn't seem to be the case anymore.

>
>> +	}
>> +
>> +	init.ops = &sci_clk_ops;
>> +	sci_clk->hw.init = &init;
>> +
>> +	ret = devm_clk_hw_register(provider->dev, &sci_clk->hw);
>> +	if (ret) {
>> +		dev_err(provider->dev, "failed clk register with %d\n", ret);
>> +		goto err;
>> +	}
>> +	kfree(name);
>> +
>> +	return &sci_clk->hw;
>> +
>> +err:
>> +	if (parent_names) {
>> +		for (i = 0; i < init.num_parents; i++)
>> +			devm_kfree(provider->dev, parent_names[i]);
>> +
>> +		devm_kfree(provider->dev, parent_names);
>
> Shouldn't we be freeing the parent names all the time? It should
> be deep copied in the framework.

I'll check this.

>
>> +	}
>> +
>> +	devm_kfree(provider->dev, sci_clk);
>> +
>> +	kfree(name);
>> +
>> +	return ERR_PTR(ret);
>> +}
> [..]
>> +
>> +static int ti_sci_init_clocks(struct sci_clk_provider *p)
>> +{
>> +	struct sci_clk_data *data = p->clocks;
>> +	struct clk_hw *hw;
>> +	int i;
>> +
>> +	while (data->num_clks) {
>> +		data->clocks = devm_kcalloc(p->dev, data->num_clks,
>> +					    sizeof(struct sci_clk),
>> +					    GFP_KERNEL);
>> +		if (!data->clocks)
>> +			return -ENOMEM;
>> +
>> +		for (i = 0; i < data->num_clks; i++) {
>> +			hw = _sci_clk_build(p, data->dev, i);
>> +			if (!IS_ERR(hw)) {
>> +				data->clocks[i] = hw;
>> +				continue;
>> +			}
>> +
>> +			/* Skip any holes in the clock lists */
>> +			if (PTR_ERR(hw) == -ENODEV)
>
> Does this happen? I don't see where _sci_clk_build() returns
> -ENODEV.

Yes, it can and will happen. get_num_parents() called by sci_clk_build 
will return ENODEV for device/clock pairs that don't exist.

>
>> +				continue;
>> +
>> +			return PTR_ERR(hw);
>> +		}
>> +		data++;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>
>> +
>> +/**
>> + * ti_sci_clk_probe - Probe function for the TI SCI clock driver
>> + * @pdev: platform device pointer to be probed
>> + *
>> + * Probes the TI SCI clock device. Allocates a new clock provider
>> + * and registers this to the common clock framework. Also applies
>> + * any required flags to the identified clocks via clock lists
>> + * supplied from DT. Returns 0 for success, negative error value
>> + * for failure.
>> + */
>> +static int ti_sci_clk_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct sci_clk_provider *provider;
>> +	const struct ti_sci_handle *handle;
>> +	struct sci_clk_data *data;
>> +	int ret;
>> +
>> +	data = (struct sci_clk_data *)
>> +		of_match_node(ti_sci_clk_of_match, np)->data;
>
> Just use of_device_get_match_data() instead.

All righty.

>
>> +
>> +	handle = devm_ti_sci_get_handle(dev);
>> +	if (IS_ERR(handle))
>> +		return PTR_ERR(handle);
>> +
>> +	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
>> +	if (!provider)
>> +		return -ENOMEM;
>> +
>> +	provider->clocks = data;
>> +
>> +	provider->sci = handle;
>> +	provider->ops = &handle->ops.clk_ops;
>> +	provider->dev = dev;
>> +
>> +	ti_sci_init_clocks(provider);
>
> And if this fails?

Yea this is kind of controversial. ti_sci_init_clocks() can fail if any 
of the clocks registered will fail. I decided to have it this way so 
that at least some clocks might work in failure cause, and you might 
have a booting device instead of total lock-up.

Obviously it could be done so that if any clock fails, we would 
de-register all clocks at that point, but personally I think this is a 
worse option.

ti_sci_init_clocks could probably be modified to continue registering 
clocks when a single clock fails though. Currently it aborts at first 
failure.

Thoughts on that?

>
>> +
>> +	ret = of_clk_add_hw_provider(np, sci_clk_get, provider);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>
> Just "return of_clk_add_hw_provider()" please.

True that, will fix.

-Tero
