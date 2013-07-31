From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 31 Jul 2013 11:30:25 +0100
Subject: [PATCH 11/13] ARM: bL_switcher: veto CPU hotplug requests when
 the switcher is active
In-Reply-To: <1374550289-25305-12-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-12-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130731103025.GC6583@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 04:31:27AM +0100, Nicolas Pitre wrote:
> Trying to support both the switcher and CPU hotplug at the same time
> is quickly becoming very complex due to ambiguous semantics.  So let's
> simply veto any hotplug requests when the switcher is active for now.
> 
> This restriction might be loosened eventually.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/common/bL_switcher.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> index 704c4b4ef3..2fe3911601 100644
> --- a/arch/arm/common/bL_switcher.c
> +++ b/arch/arm/common/bL_switcher.c
> @@ -528,6 +528,25 @@ static int __init bL_switcher_sysfs_init(void)
>  
>  #endif  /* CONFIG_SYSFS */
>  
> +/*
> + * Veto any CPU hotplug operation while the switcher is active.
> + * We're just not ready to deal with that given the trickery involved.
> + */
> +static int bL_switcher_hotplug_callback(struct notifier_block *nfb,
> +					unsigned long action, void *hcpu)
> +{
> +	switch (action) {
> +	case CPU_UP_PREPARE:
> +	case CPU_DOWN_PREPARE:
> +		if (bL_switcher_active)
> +			return NOTIFY_BAD;

This is a bit of a sledgehammer. It implies that S2R can't be implemented when
the switcher is active. Are we really sure that hotplug, given MCPM HW
CPUs awareness, is incompatible with the switcher as it stands ?

What are the main issues that have to be tackled ?

Thanks,
Lorenzo

> +	}
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block bL_switcher_hotplug_notifier =
> +	{ &bL_switcher_hotplug_callback, NULL, 0 };
> +
>  static bool no_bL_switcher;
>  core_param(no_bL_switcher, no_bL_switcher, bool, 0644);
>  
> @@ -540,6 +559,8 @@ static int __init bL_switcher_init(void)
>  		return -EINVAL;
>  	}
>  
> +	register_cpu_notifier(&bL_switcher_hotplug_notifier);
> +
>  	if (!no_bL_switcher) {
>  		ret = bL_switcher_enable();
>  		if (ret)
> -- 
> 1.8.1.2
> 
> 
> 
