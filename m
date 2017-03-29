From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 29 Mar 2017 10:55:35 -0600
Subject: [PATCH v5 6/9] coresight: add support for CPU debug module
In-Reply-To: <20170329015423.GA5035@leoy-linaro>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-7-git-send-email-leo.yan@linaro.org>
 <20170328165010.GA21937@linaro.org>
 <20170329015423.GA5035@leoy-linaro>
Message-ID: <20170329165535.GB24889@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 09:54:23AM +0800, Leo Yan wrote:
> Hi Mathieu,
> 
> On Tue, Mar 28, 2017 at 10:50:10AM -0600, Mathieu Poirier wrote:
> > On Sun, Mar 26, 2017 at 02:23:14AM +0800, Leo Yan wrote:
> 
> [...]
> 
> > > +static void debug_force_cpu_powered_up(struct debug_drvdata *drvdata)
> > > +{
> > > +	int timeout = DEBUG_WAIT_TIMEOUT;
> > > +
> > > +	drvdata->edprsr = readl_relaxed(drvdata->base + EDPRSR);
> > > +
> > > +	CS_UNLOCK(drvdata->base);
> > > +
> > > +	/* Bail out if CPU is powered up yet */
> > > +	if (drvdata->edprsr & EDPRSR_PU)
> > > +		goto out_powered_up;
> > > +
> > > +	/*
> > > +	 * Send request to power management controller and assert
> > > +	 * DBGPWRUPREQ signal; if power management controller has
> > > +	 * sane implementation, it should enable CPU power domain
> > > +	 * in case CPU is in low power state.
> > > +	 */
> > > +	drvdata->edprsr = readl(drvdata->base + EDPRCR);
> > > +	drvdata->edprsr |= EDPRCR_COREPURQ;
> > > +	writel(drvdata->edprsr, drvdata->base + EDPRCR);
> > 
> > Here ->edprsr is used but EDPRCR is accessed.  Is this intentional or a
> > copy/paste error?  The same is true for accesses in the out_powered_up section.
> 
> Thanks for pointing out. This is a typo error and will fix.
> 
> > > +
> > > +	/* Wait for CPU to be powered up (timeout~=32ms) */
> > > +	while (timeout--) {
> > > +		drvdata->edprsr = readl_relaxed(drvdata->base + EDPRSR);
> > > +		if (drvdata->edprsr & EDPRSR_PU)
> > > +			break;
> > > +
> > > +		usleep_range(1000, 2000);
> > > +	}
> > 
> > See if function readx_poll_timeout() can be used.
> 
> Will use it.
> 
> > > +
> > > +	/*
> > > +	 * Unfortunately the CPU cannot be powered up, so return
> > > +	 * back and later has no permission to access other
> > > +	 * registers. For this case, should set 'idle_constraint'
> > > +	 * to ensure CPU power domain is enabled!
> > > +	 */
> > > +	if (!(drvdata->edprsr & EDPRSR_PU)) {
> > > +		pr_err("%s: power up request for CPU%d failed\n",
> > > +			__func__, drvdata->cpu);
> > > +		goto out;
> > > +	}
> > > +
> > > +out_powered_up:
> > > +	debug_os_unlock(drvdata);
> > > +
> > > +	/*
> > > +	 * At this point the CPU is powered up, so set the no powerdown
> > > +	 * request bit so we don't lose power and emulate power down.
> > > +	 */
> > > +	drvdata->edprsr = readl(drvdata->base + EDPRCR);
> > > +	drvdata->edprsr |= EDPRCR_COREPURQ | EDPRCR_CORENPDRQ;
> > 
> > If we are here the core is already up.  Shouldn't we need to set
> > EDPRCR_CORENPDRQ only?
> 
> Yeah. Will fix.
> 
> > > +	writel(drvdata->edprsr, drvdata->base + EDPRCR);
> > 
> > This section is a little racy - between the time the PU bit has been
> > checked and the time COREPDRQ has been flipped, the state of PU may have
> > changed.  You can probably get around this by checking edprsr.PU rigth here.  If
> > it is not set you go through the process again.  Note that doing this will
> > probably force a refactoring of the whole function.  
> 
> Agree. Will handle this.
> 
> [...]
> 
> > > +static ssize_t debug_func_knob_write(struct file *f,
> > > +		const char __user *buf, size_t count, loff_t *ppos)
> > > +{
> > > e	u8 on;
> > > +	int ret;
> > > +
> > > +	ret = kstrtou8_from_user(buf, count, 2, &on);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	mutex_lock(&debug_lock);
> > > +
> > > +	if (!on ^ debug_enable)
> > > +		goto out;
> > 
> > I had to read this condition too many times - please refactor.
> 
> Will do it.
> 
> > > +
> > > +	if (on) {
> > > +		ret = debug_enable_func();
> > > +		if (ret) {
> > > +			pr_err("%s: unable to disable debug function: %d\n",
> > > +			       __func__, ret);
> > 
> > Based on the semantic this is the wrong error message.
> 
> Yeah. Will fix.
> 
> > > +			goto err;
> > > +		}
> > > +	} else
> > > +		debug_disable_func();
> > 
> > Did checkpatch.pl complain about extra curly braces?  If not please add them.
> 
> checkpatch.pl doesn't report for this. Will add.
> 
> > > +
> > > +	debug_enable = on;
> > 
> > Here we can't set debug_enable if we just called debug_disable_func().  Maybe
> > I'm missing something.  If that's the case a comment in the code would be worth
> > it.
> 
> After called debug_disable_func(), debug_enable is set to 0 (on = 0).
> 
> > > +
> > > +out:
> > > +	ret = count;
> > > +err:
> > > +	mutex_unlock(&debug_lock);
> > > +	return ret;
> > > +}
> > > +
> > > +static ssize_t debug_func_knob_read(struct file *f,
> > > +		char __user *ubuf, size_t count, loff_t *ppos)
> > > +{
> > > +	char val[] = { '0' + debug_enable, '\n' };
> > > +
> > > +	return simple_read_from_buffer(ubuf, count, ppos, val, sizeof(val));
> > 
> > Use the debug_lock to avoid race conditions.
> 
> Will do it.
> 
> > > +}
> > > +
> > > +static ssize_t debug_idle_constraint_write(struct file *f,
> > > +		const char __user *buf, size_t count, loff_t *ppos)
> > > +{
> > > +	int val;
> > > +	ssize_t ret;
> > > +
> > > +	ret = kstrtoint_from_user(buf, count, 10, &val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	mutex_lock(&debug_lock);
> > > +	idle_constraint = val;
> > > +
> > > +	if (debug_enable)
> > > +		pm_qos_update_request(&debug_qos_req, idle_constraint);
> > > +
> > > +	mutex_unlock(&debug_lock);
> > > +	return count;
> > > +}
> > > +
> > > +static ssize_t debug_idle_constraint_read(struct file *f,
> > > +		char __user *ubuf, size_t count, loff_t *ppos)
> > > +{
> > > +	char buf[32];
> > > +	int len;
> > > +
> > > +	if (*ppos)
> > > +		return 0;
> > > +
> > > +	len = sprintf(buf, "%d\n", idle_constraint);
> > > +	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
> > 
> > Use the debug_lock to avoid race conditions.
> 
> Will do it.
> 
> > > +}
> > > +
> > > +static const struct file_operations debug_func_knob_fops = {
> > > +	.open	= simple_open,
> > > +	.read	= debug_func_knob_read,
> > > +	.write	= debug_func_knob_write,
> > > +};
> > > +
> > > +static const struct file_operations debug_idle_constraint_fops = {
> > > +	.open	= simple_open,
> > > +	.read	= debug_idle_constraint_read,
> > > +	.write	= debug_idle_constraint_write,
> > > +};
> > > +
> > > +static int debug_func_init(void)
> > > +{
> > > +	struct dentry *file;
> > > +	int ret;
> > > +
> > > +	/* Create debugfs node */
> > > +	debug_debugfs_dir = debugfs_create_dir("coresight_cpu_debug", NULL);
> > > +	if (!debug_debugfs_dir) {
> > > +		pr_err("%s: unable to create debugfs directory\n", __func__);
> > > +		return -ENOMEM;
> > 
> > return PTR_ERR(debug_debugfs_dir);
> 
> Here cannot use PTR_ERR(debug_debugfs_dir). If create debugfs failed
> the pointer is NULL value, so finally we will return zero value for
> PTR_ERR(debug_debugfs_dir).
> 
> [...]
> 
> > > +	}
> > > +
> > > +	file = debugfs_create_file("enable", S_IRUGO | S_IWUSR,
> > > +			debug_debugfs_dir, NULL, &debug_func_knob_fops);
> > > +	if (!file) {
> > > +		pr_err("%s: unable to create enable knob file\n", __func__);
> > > +		ret = -ENOMEM;
> > 
> > Same as above.
> > 
> > > +		goto err;
> > > +	}
> > > +
> > > +	file = debugfs_create_file("idle_constraint", S_IRUGO | S_IWUSR,
> > > +			debug_debugfs_dir, NULL, &debug_idle_constraint_fops);
> > > +	if (!file) {
> > > +		pr_err("%s: unable to create idle constraint file\n", __func__);
> > > +		ret = -ENOMEM;
> > 
> > Same as above.
> > 
> > > +		goto err;
> > > +	}
> > > +
> > > +	/* Use sysfs node to enable functionality */
> > > +	if (!debug_enable)
> > > +		return 0;
> > > +
> > > +	/* Enable debug module at boot time */
> > > +	ret = debug_enable_func();
> > > +	if (ret) {
> > > +		pr_err("%s: unable to disable debug function: %d\n",
> > > +		       __func__, ret);
> > > +		goto err;
> > > +	}
> > 
> > Use the debug_lock to avoid race conditions.
> 
> I'm struggling to understand what's race condition at here? The
> function pairs debug_func_init()/debug_func_exit() are used for
> module's probing and removing, so naturally module's probing and
> removing are sequential, right?

You are correct - void that comment.

> 
> > > +
> > > +	return 0;
> > > +
> > > +err:
> > > +	debugfs_remove_recursive(debug_debugfs_dir);
> > > +	return ret;
> > > +}
> > > +
> > > +static void debug_func_exit(void)
> > > +{
> > > +	debugfs_remove_recursive(debug_debugfs_dir);
> > > +
> > > +	/* Disable functionality if has enabled */
> > > +	if (debug_enable)
> > > +		debug_disable_func();
> > > +}
> > > +
> > > +static int debug_probe(struct amba_device *adev, const struct amba_id *id)
> > > +{
> > > +	void __iomem *base;
> > > +	struct device *dev = &adev->dev;
> > > +	struct debug_drvdata *drvdata;
> > > +	struct resource *res = &adev->res;
> > > +	struct device_node *np = adev->dev.of_node;
> > > +	int ret;
> > > +
> > > +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > > +	if (!drvdata)
> > > +		return -ENOMEM;
> > > +
> > > +	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
> > > +	if (per_cpu(debug_drvdata, drvdata->cpu)) {
> > > +		dev_err(dev, "CPU's drvdata has been initialized\n");
> > 
> > Might be worth adding the CPU number in the error message.
> 
> Yeah, will add it.
> 
> [...]
> 
> > This driver doesn't call the pm_runtime_put/get() operations needed to handle the
> > debug power domain.  See the other CoreSight drivers for details. 
> 
> Sure, will do it.
> 
> > Also, from the conversation that followed the previous post we agreed that we wouldn't
> > deal with CPUidle issues in this driver.  We deal with the CPU power domain
> > using the EDPRCR register (like you did) and that's it.  System that don't honor that register
> > can use other (external) means to solve this.  As such please remove the
> > pm_qos_xyz() functions. 
> 
> From previous discussion, Mike reminds the CPU power domain design is
> quite SoC specific and usually the SoC has many different low power
> states, e.g. except CPU level and cluster level low power states, they
> also can define SoC level low power states. Any SoC with any power
> state is possible finally impact CPU power domain, so this is why I add
> this interface to let user can have the final decision based on their
> working platform.

Mike is correct but there are other ways to deal with these cases, i.e cpuidle
interface from cmd line.  

> 
> We can rely on "nohlt" and "cpuidle.off=1" in kernel command line to
> disable whole SoC low power states at boot time; or we can use sysfs
> node "echo 1 > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disble" to
> disable CPU low power states at runtime. But that means we need use
> different interfaces to control CPU power domain for booting and
> runtime, it's not nice for usage.

That is a different topic altogether.

> 
> So this is why add "idle_constraint" as a central place to control
> power domain for CPU debug purpose and I also think this is more
> friendly for hardware design, e.g. some platforms can enable partial
> low power states to save power and avoid overheat after using this
> driver.
> 
> How about you think for this?

Like Sudeep pointed out we should concentrate on doing the right thing, that is
work with EDPRSR.PU, EDPRCR.COREPURQ and EDPRCR.CORENPDRQ.  Anything
outside of that becomes platform specific and can't be handled in
this driver.

> 
> Thanks,
> Leo Yan
