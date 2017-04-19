From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 19 Apr 2017 14:23:04 +0100
Subject: [PATCH v6 6/8] coresight: add support for CPU debug module
In-Reply-To: <1491485461-22800-7-git-send-email-leo.yan@linaro.org>
References: <1491485461-22800-1-git-send-email-leo.yan@linaro.org>
 <1491485461-22800-7-git-send-email-leo.yan@linaro.org>
Message-ID: <5c5cb6f8-1dcb-8a9d-1605-c006656005eb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/17 14:30, Leo Yan wrote:
> Coresight includes debug module and usually the module connects with CPU
> debug logic. ARMv8 architecture reference manual (ARM DDI 0487A.k) has
> description for related info in "Part H: External Debug".
>
> Chapter H7 "The Sample-based Profiling Extension" introduces several
> sampling registers, e.g. we can check program counter value with
> combined CPU exception level, secure state, etc. So this is helpful for
> analysis CPU lockup scenarios, e.g. if one CPU has run into infinite
> loop with IRQ disabled. In this case the CPU cannot switch context and
> handle any interrupt (including IPIs), as the result it cannot handle
> SMP call for stack dump.
>
> This patch is to enable coresight debug module, so firstly this driver
> is to bind apb clock for debug module and this is to ensure the debug
> module can be accessed from program or external debugger. And the driver
> uses sample-based registers for debug purpose, e.g. when system triggers
> panic, the driver will dump program counter and combined context
> registers (EDCIDSR, EDVIDSR); by parsing context registers so can
> quickly get to know CPU secure state, exception level, etc.
>
> Some of the debug module registers are located in CPU power domain, so
> this requires the CPU power domain stays on when access related debug
> registers, but the power management for CPU power domain is quite
> dependent on SoC integration for power management. For the platforms
> which with sane power controller implementations, this driver follows
> the method to set EDPRCR to try to pull the CPU out of low power state
> and then set 'no power down request' bit so the CPU has no chance to
> lose power.
>
> If the SoC has not followed up this design well for power management
> controller, the user should use the command line parameter or sysfs
> to constrain all or partial idle states to ensure the CPU power
> domain is enabled and access coresight CPU debug component safely.

Hi Leo,

This version looks good to me. I have two minor comments below.


> +
> +static struct notifier_block debug_notifier = {
> +	.notifier_call = debug_notifier_call,
> +};
> +
> +static int debug_enable_func(void)
> +{
> +	struct debug_drvdata *drvdata;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		drvdata = per_cpu(debug_drvdata, cpu);
> +		if (!drvdata)
> +			continue;
> +
> +		pm_runtime_get_sync(drvdata->dev);
> +	}
> +
> +	return atomic_notifier_chain_register(&panic_notifier_list,
> +					      &debug_notifier);
> +}
> +
> +static int debug_disable_func(void)
> +{
> +	struct debug_drvdata *drvdata;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		drvdata = per_cpu(debug_drvdata, cpu);
> +		if (!drvdata)
> +			continue;
> +
> +		pm_runtime_put(drvdata->dev);
> +	}
> +
> +	return atomic_notifier_chain_unregister(&panic_notifier_list,
> +						&debug_notifier);
> +}

I believe you should, reverse the order of these operations in debug_disable_func()
to prevent getting a panic notifier after we have released the power domain for the
debug.
i.e, :
	atomic_notifier_chain_unregister(...);
	
	for_each_possible_cpu(cpu) {}



> +
> +static ssize_t debug_func_knob_write(struct file *f,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	u8 val;
> +	int ret;
> +
> +	ret = kstrtou8_from_user(buf, count, 2, &val);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&debug_lock);
> +
> +	if (val == debug_enable)
> +		goto out;
> +
> +	if (val)
> +		ret = debug_enable_func();
> +	else
> +		ret = debug_disable_func();
> +
> +	if (ret) {
> +		pr_err("%s: unable to %s debug function: %d\n",
> +		       __func__, val ? "enable" : "disable", ret);
> +		goto err;
> +	}
> +
> +	debug_enable = val;
> +out:
> +	ret = count;
> +err:
> +	mutex_unlock(&debug_lock);
> +	return ret;
> +}
> +
> +static ssize_t debug_func_knob_read(struct file *f,
> +		char __user *ubuf, size_t count, loff_t *ppos)
> +{
> +	ssize_t ret;
> +	char buf[2];
> +
> +	mutex_lock(&debug_lock);
> +
> +	buf[0] = '0' + debug_enable;
> +	buf[1] = '\n';
> +	ret = simple_read_from_buffer(ubuf, count, ppos, buf, sizeof(buf));
> +
> +	mutex_unlock(&debug_lock);
> +	return ret;
> +}
> +
> +static const struct file_operations debug_func_knob_fops = {
> +	.open	= simple_open,
> +	.read	= debug_func_knob_read,
> +	.write	= debug_func_knob_write,
> +};
> +
> +static int debug_func_init(void)
> +{
> +	struct dentry *file;
> +	int ret;
> +
> +	/* Create debugfs node */
> +	debug_debugfs_dir = debugfs_create_dir("coresight_cpu_debug", NULL);
> +	if (!debug_debugfs_dir) {
> +		pr_err("%s: unable to create debugfs directory\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	file = debugfs_create_file("enable", S_IRUGO | S_IWUSR,
> +			debug_debugfs_dir, NULL, &debug_func_knob_fops);
> +	if (!file) {
> +		pr_err("%s: unable to create enable knob file\n", __func__);
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	/* Use sysfs node to enable functionality */
> +	if (!debug_enable)
> +		return 0;
> +
> +	/* Register function to be called for panic */
> +	ret = atomic_notifier_chain_register(&panic_notifier_list,
> +					     &debug_notifier);
> +	if (ret) {
> +		pr_err("%s: unable to register notifier: %d\n",
> +		       __func__, ret);
> +		goto err;
> +	}
> +

Since we depend on the value of debug_enable above, below in debug_probe()
and in debug_remove(), we should protect these paths using the debug_lock mutex,
like we do above, to make sure we don't create a race.

> +	return 0;
> +
> +err:
> +	debugfs_remove_recursive(debug_debugfs_dir);
> +	return ret;
> +}
> +
> +static void debug_func_exit(void)
> +{
> +	debugfs_remove_recursive(debug_debugfs_dir);
> +
> +	/* Unregister panic notifier callback */
> +	if (debug_enable)
> +		atomic_notifier_chain_unregister(&panic_notifier_list,
> +						 &debug_notifier);
> +}
> +
> +static int debug_probe(struct amba_device *adev, const struct amba_id *id)
> +{
> +	void __iomem *base;
> +	struct device *dev = &adev->dev;
> +	struct debug_drvdata *drvdata;
> +	struct resource *res = &adev->res;
> +	struct device_node *np = adev->dev.of_node;
> +	int ret;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
> +	if (per_cpu(debug_drvdata, drvdata->cpu)) {
> +		dev_err(dev, "CPU%d drvdata has been initialized\n",
> +			drvdata->cpu);

May be we could warn about a possible issue in the DT ?


Cheers
Suzuki
