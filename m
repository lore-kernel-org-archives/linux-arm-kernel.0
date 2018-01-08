From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 8 Jan 2018 17:22:26 +0000
Subject: [PATCH v6 11/16] firmware: arm_sdei: Add support for CPU and
 system power states
In-Reply-To: <20180108153818.22743-12-james.morse@arm.com>
References: <20180108153818.22743-1-james.morse@arm.com>
 <20180108153818.22743-12-james.morse@arm.com>
Message-ID: <20180108172226.GC2530@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 03:38:13PM +0000, James Morse wrote:

[...]

> +/* When entering idle, mask/unmask events for this cpu */

Just mentioning (since I know you know), this notifier is called also
through syscore_ops so it is not just idle (CPUidle or Suspend-to-idle).

> +static int sdei_pm_notifier(struct notifier_block *nb, unsigned long action,
> +			    void *data)
> +{
> +	int rv;
> +
> +	switch (action) {
> +	case CPU_PM_ENTER:
> +		rv = sdei_mask_local_cpu();
> +		break;
> +	case CPU_PM_EXIT:

You should handle CPU_PM_ENTER_FAILED here for correctness,
in case the notifier chain fails.

Other than that:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> +		rv = sdei_unmask_local_cpu();
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	if (rv)
> +		return notifier_from_errno(rv);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block sdei_pm_nb = {
> +	.notifier_call = sdei_pm_notifier,
> +};
> +
> +static int sdei_device_suspend(struct device *dev)
> +{
> +	on_each_cpu(_ipi_mask_cpu, NULL, true);
> +
> +	return 0;
> +}
> +
> +static int sdei_device_resume(struct device *dev)
> +{
> +	on_each_cpu(_ipi_unmask_cpu, NULL, true);
> +
> +	return 0;
> +}
> +
> +/*
> + * We need all events to be reregistered when we resume from hibernate.
> + *
> + * The sequence is freeze->thaw. Reboot. freeze->restore. We unregister
> + * events during freeze, then re-register and re-enable them during thaw
> + * and restore.
> + */
> +static int sdei_device_freeze(struct device *dev)
> +{
> +	int err;
> +
> +	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
> +
> +	err = sdei_unregister_shared();
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int sdei_device_thaw(struct device *dev)
> +{
> +	int err;
> +
> +	/* re-register shared events */
> +	err = sdei_reregister_shared();
> +	if (err) {
> +		pr_warn("Failed to re-register shared events...\n");
> +		sdei_mark_interface_broken();
> +		return err;
> +	}
> +
> +	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
> +				&sdei_cpuhp_up, &sdei_cpuhp_down);
> +	if (err)
> +		pr_warn("Failed to re-register CPU hotplug notifier...\n");
> +
> +	return err;
> +}
> +
> +static int sdei_device_restore(struct device *dev)
> +{
> +	int err;
> +
> +	err = sdei_platform_reset();
> +	if (err)
> +		return err;
> +
> +	return sdei_device_thaw(dev);
> +}
> +
> +static const struct dev_pm_ops sdei_pm_ops = {
> +	.suspend = sdei_device_suspend,
> +	.resume = sdei_device_resume,
> +	.freeze = sdei_device_freeze,
> +	.thaw = sdei_device_thaw,
> +	.restore = sdei_device_restore,
> +};
> +
> +/*
> + * Mask all CPUs and unregister all events on panic, reboot or kexec.
> + */
> +static int sdei_reboot_notifier(struct notifier_block *nb, unsigned long action,
> +				void *data)
> +{
> +	/*
> +	 * We are going to reset the interface, after this there is no point
> +	 * doing work when we take CPUs offline.
> +	 */
> +	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
> +
> +	sdei_platform_reset();
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block sdei_reboot_nb = {
> +	.notifier_call = sdei_reboot_notifier,
> +};
> +
>  static void sdei_smccc_smc(unsigned long function_id,
>  			   unsigned long arg0, unsigned long arg1,
>  			   unsigned long arg2, unsigned long arg3,
> @@ -547,9 +772,36 @@ static int sdei_probe(struct platform_device *pdev)
>  		return 0;
>  	}
>  
> -	on_each_cpu(&_ipi_unmask_cpu, NULL, false);
> +	err = cpu_pm_register_notifier(&sdei_pm_nb);
> +	if (err) {
> +		pr_warn("Failed to register CPU PM notifier...\n");
> +		goto error;
> +	}
> +
> +	err = register_reboot_notifier(&sdei_reboot_nb);
> +	if (err) {
> +		pr_warn("Failed to register reboot notifier...\n");
> +		goto remove_cpupm;
> +	}
> +
> +	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
> +				&sdei_cpuhp_up, &sdei_cpuhp_down);
> +	if (err) {
> +		pr_warn("Failed to register CPU hotplug notifier...\n");
> +		goto remove_reboot;
> +	}
>  
>  	return 0;
> +
> +remove_reboot:
> +	unregister_reboot_notifier(&sdei_reboot_nb);
> +
> +remove_cpupm:
> +	cpu_pm_unregister_notifier(&sdei_pm_nb);
> +
> +error:
> +	sdei_mark_interface_broken();
> +	return err;
>  }
>  
>  static const struct of_device_id sdei_of_match[] = {
> @@ -560,6 +812,7 @@ static const struct of_device_id sdei_of_match[] = {
>  static struct platform_driver sdei_driver = {
>  	.driver		= {
>  		.name			= "sdei",
> +		.pm			= &sdei_pm_ops,
>  		.of_match_table		= sdei_of_match,
>  	},
>  	.probe		= sdei_probe,
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 201ab7267986..87b505a48a94 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -109,6 +109,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_XTENSA_STARTING,
>  	CPUHP_AP_PERF_METAG_STARTING,
>  	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
> +	CPUHP_AP_ARM_SDEI_STARTING,
>  	CPUHP_AP_ARM_VFP_STARTING,
>  	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
>  	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
> -- 
> 2.15.0
> 
