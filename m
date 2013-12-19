From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 16:57:29 -0700
Subject: [PATCH 3/6] clk: tegra: add library for the DFLL clocksource
 (open-loop mode)
In-Reply-To: <20131219123701.3226.91986.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
 <20131219123701.3226.91986.stgit@tamien>
Message-ID: <52B387E9.6080009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 05:37 AM, Paul Walmsley wrote:
> Add shared code to support the Tegra DFLL clocksource in open-loop
> mode.  This root clocksource is present on the Tegra114 and Tegra124

"root clocksource" implies no parents, yet the clock object this driver
registers lists "dfll_soc" as its parent.

> SoCs.  It's used to generate a clock for the fast CPU cluster.  Future
> patches will add support for closed-loop mode.
> 
> This code was originally created by Aleksandr Frid <afrid@nvidia.com>.
> It's been converted to use DT and integrated into the common clock
> framework, and a few minor functional changes have been implemented.
> 
> Subsequent patches will add drivers for the Tegra114 and Tegra124 fast
> CPU cluster DFLL devices, which rely on this code.

> diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig

> +config CLK_TEGRA_DFLL
> +	tristate
> +	depends on COMMON_CLK

Is there a need to make this optional? There's nothing configurable in
the rest of the Tegra clock driver, and it'd be nicer if the rest of the
kernel (e.g. Tegra cpufreq driver?) could simply always assume that DFLL
were available.

> +

Blank line at EOF. Same in Makefile.

> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile

> +# XXX -Wno-sign-compare is only needed due to problems with
> +# some non-clock-related Linux header files, and can be removed
> +# once those headers are fixed
> +CFLAGS_clk-dfll.o			+= -Wall -Wextra -Wno-unused-parameter \
> +					   -Wno-sign-compare

Aside from the no-sign-compare issue (which I assume is being fixed in
parallel before this is applied?) is there really a need to second-guess
the kernel's -W flags?

> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> +/*
> + * clk-dfll.c - Tegra DFLL clock source common code

It'd be best not to put filenames in comments; it's just one more thing
to update if the file gets renamed.

> +struct tegra_dfll {
...
> +	u8				speedo_id;
> +	u8				process_id;

I don't think you need a copy of these; just read the globals directly?

> +static bool dfll_is_running(struct platform_device *pdev)
> +{
> +	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
> +
> +	return (td->mode == DFLL_DISABLED ||
> +		td->mode == DFLL_UNINITIALIZED) ? false : true;

Why not:

	return td->mode == DFLL_OPEN_LOOP;

or at least:

	return td->mode != DFLL_DISABLED &&
		td->mode != DFLL_UNINITIALIZED;

> +static void dfll_set_tune_range(struct platform_device *pdev,
> +				enum dfll_tune_range range)
> +{
> +	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
> +
> +	td->tune_range = range;

Do we really need a (private, single-use) function just to write a field
in a structure?

> +static u64  __attribute__((pure)) dfll_calc_monitored_rate(u32 monitor_data,

Does the compiler really need to be told about pure? It seems pretty
obvious from the code, and I imagine the compiler is smart enough to
tell. It looks like __pure would be preferred:

include/linux/compiler-gcc.h:94:#define __pure __attribute__((pure))

> +static u64 dfll_read_monitor_rate(struct platform_device *pdev)
...
> +	if (td->mode == DFLL_DISABLED || td->mode == DFLL_UNINITIALIZED)
> +		return 0;

if (!dfll_is_running(td))
	return 0;

> +static int dfll_init(struct platform_device *pdev)

> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +
> +	td->ref_rate = clk_get_rate(td->ref_clk);

Doesn't clk_get_rate() work before clk_enable() (which happens in
pm_runtime_get_sync()), so you could simplify the error-handling here by
checking the rate a little earlier, outside the pm_runtime_get/put?

> +	if (td->ref_rate == 0) {
> +		dev_err(&pdev->dev, "ref_clk rate cannot be 0\n");
> +		ret = -EINVAL;
> +		goto di_err3;
> +	}
> +

> +	pm_runtime_put_sync(&pdev->dev);

Would plain pm_runtime_put() work just as well, and avoid the put if
something else enables the driver/dfll clock very soon after?

> +static const char *dfll_clk_parents[] = { "dfll_soc" };
> +
> +static struct clk_init_data dfll_clk_init_data = {
> +	.ops		= &dfll_clk_ops,
> +	.parent_names	= dfll_clk_parents,
> +	.num_parents	= ARRAY_SIZE(dfll_clk_parents),
> +};

Does a root clock actually have any parents?

> +static void dfll_unregister_clk(struct platform_device *pdev)
> +{
> +	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
> +
> +	/* XXX Why doesn't clk_unregister_clkdev() exist? */

Hmm. Seems like we need a patch to the clkdev core before this series?

> +static int dfll_enable_get(void *data, u64 *val)
> +{
> +	struct platform_device *pdev = data;
> +	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
> +
> +	*val = (td->mode == DFLL_OPEN_LOOP);

Use dfll_is_running()? Given td->mode embodies both enable/disable and
the current mode, would it make more sense to have a debugfs file that
exposed the raw enum, so you could both tell is-enabled and the current
mode?

> +
> +	return 0;
> +}
> +static int dfll_enable_set(void *data, u64 val)

Missing blank line.

> +{
> +	struct platform_device *pdev = data;
> +	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
> +
> +	if (val && !dfll_is_running(pdev))
> +		clk_prepare_enable(td->dfll_clk);
> +	else if (!val && dfll_is_running(pdev))
> +		clk_disable_unprepare(td->dfll_clk);

This is going to allow unbalanced prepare_enable/disable_unprepare calls
simply by writing stuff to the debugfs file. Do we want to make debugfs
more friendly than that? If so, perhaps keep some state around to
indicate the last requested state from debugfs, and only make the clock
calls if the new requested state is different from the previous
debugfs-requested state, rather than different to the current-actual state?

> +static int dfll_register_show(struct seq_file *s, void *data)

regmap will give you this function for free. Perhaps its considered too
much overhead though?

> +static ssize_t dfll_register_write(struct file *file,
> +				   const char __user *userbuf, size_t count,
> +				   loff_t *ppos)
> +{
> +	struct platform_device *pdev = file->f_path.dentry->d_inode->i_private;
> +	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
> +	char buf[80];
> +	u32 offs, val;
> +
> +	if (sizeof(buf) <= count)
> +		return -EINVAL;

Don't you need to check whether ppos==0, to detect continuation rather
than initial writes?

For register twiddling, why not just use a user-space app that mmap()s
/dev/mem and blasts in the values? That would remove the need to put
this into the kernel. This also feels like a function that should be
implemented as a common utility, not open-coded into every driver. regmap?

> +static int dfll_debug_init(struct platform_device *pdev)
> +{
> +	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
> +	int ret;
> +
> +	if (!td || (td->mode == DFLL_UNINITIALIZED))
> +		return 0;

Isn't td->mode always == DFLL_UNINITIALIZED when this function is
called, since the mode is only set when dfll_enable() is called, which
is only called when dfll_clk_enable() is called, and the clock isn't
enabled when this function is called?

> +int tegra_dfll_register(struct platform_device *pdev,
> +			struct tegra_dfll_soc_data *soc)

> +	td = kzalloc(sizeof(*td), GFP_KERNEL);

devm_kzalloc would simplify error-handling.

> +	td->soc = kmemdup(soc, sizeof(struct tegra_dfll_soc_data), GFP_KERNEL);

Why not just store the pointer?

> +	td->base = ioremap(mem->start, resource_size(mem));

devm_ioremap()

> +	clk_put(td->i2c_clk);

I evidently should have mentioned devm_clk_get() somewhere too.

> +int tegra_dfll_unregister(struct platform_device *pdev)

> +	pm_runtime_put_sync(&pdev->dev);

What is that matching? dfll_init() does a matched get/put, as do
dfll_enable/disable, which in turn should be called in a matched fashion
from any client's clk_enable/disable.

> diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h

> + * clk-dfll.h - prototypes and macros for the Tegra DFLL clocksource driver

Remove filename?
