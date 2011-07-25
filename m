From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Jul 2011 11:42:38 +0300
Subject: [PATCH 2/2 V2] OMAP3+: PM: SR: add suspend/resume handlers
In-Reply-To: <1311526357-7578-1-git-send-email-nm@ti.com>
References: <1311526357-7578-1-git-send-email-nm@ti.com>
Message-ID: <20110725084238.GC18062@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 24, 2011 at 11:52:37AM -0500, Nishanth Menon wrote:
> SmartReflex should be disabled while entering low power mode due to
> the following reasons:
> a) SmartReflex values are not defined for retention voltage.
> b) With SmartReflex enabled, if the CPU enters low power state, FSM
>    will try to bump the voltage to current OPP's voltage for which
>    it has entered low power state, causing power loss and potential
>    unknown states for the SoC.
> Since we are sure to attempt entering the lowest possible power state
> during suspend operation, SmartReflex needs to be disabled for the
> voltage domains in suspend path before achieving auto retention voltage
> on the device.
> 
> Traditionally, this has been done with interrupts disabled as part of
> the common code which handles the idle sequence. Instead, by using the
> fact that we have to disable SmartReflex for sure during suspend
> operations, we can opportunistically disable SmartReflex in device
> standard pm ops, instead of disabling it as part of the code which
> executes with interrupts disabled and slave CPU{s} shutdown. This
> allows the system to do other parallel activities(such as suspending
> other devices in the system using slave CPU{s}) and save the time
> required to achieve suspend and resume from suspended state as a
> sequential activity.
> 
> However, by being opportunistic as described above, we also increase
> the likelihood of SmartReflex library access functions being invoked in
> parallel contexts *after* SmartReflex driver's suspend handler (during
> suspend operation) or *before* resume handler (during resume operation)
> have been invoked (Example: DVFS for dependent devices, cpufreq for
> MPU etc.). We prevent this by using a flag to reject the callers in
> the duration where SmartReflex has been disabled.

while at that, SR's IRQ is never freed on exit path, could fix it while
you're already there ?

> @@ -998,10 +1020,75 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int omap_sr_suspend(struct device *dev)
> +{
> +	struct omap_sr_data *pdata;
> +	struct omap_sr *sr_info;
> +
> +	pdata = dev_get_platdata(dev);

I'm not sure you need to use platform data here...

> +	if (!pdata) {
> +		dev_err(dev, "%s: platform data missing\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	sr_info = _sr_lookup(pdata->voltdm);

this field is held on struct omap_sr. Can't you:

	struct omap_sr	*info = dev_get_drvdata(dev);

?? I see that a platform_set_drvdata() is missing from the driver, but
maybe you should add that instead of accessing platform_data.

>  static struct platform_driver smartreflex_driver = {
>  	.remove         = omap_sr_remove,
>  	.driver		= {
>  		.name	= "smartreflex",
> +		.pm	= &omap_sr_dev_pm_ops,

this should not be valid in case CONFIG_PM isn't enabled.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110725/599d66a8/attachment.sig>
