From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 12 Jul 2011 09:29:04 -0700
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <1310476090-9807-2-git-send-email-lee.jones@linaro.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<1310476090-9807-2-git-send-email-lee.jones@linaro.org>
Message-ID: <4E1C7650.6010700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2011 06:08 AM, Lee Jones wrote:
> Signed-off-by: Lee Jones<lee.jones@linaro.org>
> ---
>   arch/arm/mach-ux500/Kconfig |    1 +
>   arch/arm/mach-ux500/id.c    |  115 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 116 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> index 4210cb4..4d2f2c2 100644

<snip>

> +
> +struct soc_callback_functions soc_callbacks = {
> +	.get_machine_fn  = ux500_get_machine,
> +	.get_family_fn   = ux500_get_family,
> +	.get_soc_id_fn   = ux500_get_soc_id,
> +	.get_revision_fn = ux500_get_revision,
> +};
> +
> +struct device_attribute ux500_soc_attrs[] = {
> +	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL),
> +	__ATTR_NULL,
> +};
> +
> +static int __init ux500_soc_sysfs_init(void)
> +{
> +	int ret;
> +	int i = 0;
> +	ret = soc_device_register(&soc_parent,
> +				&soc_callbacks);
> +	if (ret>= 0) {
> +		while (ux500_soc_attrs[i].attr.name != NULL) {
> +			ret = device_create_file(&soc_parent,
> +						&ux500_soc_attrs[i++]);
> +			if (ret)
> +				goto out;
> +		}
> +	}

Can you please make this code as part of soc_device_register? Otherwise, 
every SoC that wants to add its own set of attributes will have to 
repeat this code.

> + out:
> +	return ret;
> +}
> +module_init(ux500_soc_sysfs_init);
> +
> +static void __exit ux500_soc_sysfs_exit(void)
> +{
> +	int i = 0;
> +
> +	while (ux500_soc_attrs[i].attr.name != NULL)
> +		device_remove_file(&soc_parent,&ux500_soc_attrs[i++]);

That would also pull this in and make sure the ordering is always correct.

> +
> +	soc_device_unregister(&soc_parent);
> +}
> +module_exit(ux500_soc_sysfs_exit);
> +
> +#endif

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
