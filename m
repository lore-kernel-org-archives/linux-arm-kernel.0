From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 21 Apr 2015 16:56:46 +0200
Subject: [PATCH v4 1/4] ARM: UniPhier: add basic support for UniPhier
 architecture
In-Reply-To: <1429600890-26713-2-git-send-email-yamada.masahiro@socionext.com>
References: <1429600890-26713-1-git-send-email-yamada.masahiro@socionext.com>
 <1429600890-26713-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <4816076.vmWnA5VvTb@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. April 2015, 16:21:27 schrieb Masahiro Yamada:
> Initial commit for a new SoC family, UniPhier, developed by
> Socionext Inc. (formerly, System LSI Business Division of
> Panasonic Corporation).
> 
> This commit includes a minimal set of components for booting the
> kernel, including SMP support.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

[...]

> +static int uniphier_boot_secondary(unsigned int cpu,
> +				   struct task_struct *idle)
> +{
> +	struct regmap *sbcm_regmap;
> +	int ret;
> +
> +	sbcm_regmap = syscon_regmap_lookup_by_compatible(
> +			"socionext,uniphier-system-bus-controller-misc");
> +	if (IS_ERR(sbcm_regmap)) {
> +		pr_err("failed to regmap system-bus-controller-misc\n");
> +		return PTR_ERR(sbcm_regmap);
> +	}
> +
> +	ret = regmap_write(sbcm_regmap, 0x1208,
> +			   virt_to_phys(uniphier_secondary_startup));
> +	if (!ret)
> +		asm("sev"); /* wake up secondary CPU */
> +
> +	return ret;
> +}
> +
> +struct smp_operations uniphier_smp_ops __initdata = {
> +	.smp_prepare_cpus	= uniphier_smp_prepare_cpus,
> +	.smp_boot_secondary	= uniphier_boot_secondary,
> +};

this is more of a drive-by comment, but you're doing the syscon lookup on 
every boot of a core, which includes walking big parts of the devicetree every 
time.

Is there anything speaking against doing this once in a .smp_prepare_cpus 
callback?


Heiko
