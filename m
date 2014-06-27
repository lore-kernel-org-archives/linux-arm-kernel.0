From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 15:03:08 -0600
Subject: [RFC 3/4] soc/tegra: Initialize interrupt controller from DT
In-Reply-To: <1403888329-24755-3-git-send-email-thierry.reding@gmail.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <1403888329-24755-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <53ADDC0C.4060401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 10:58 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Obtains the register ranges for the legacy interrupt controller from DT
> and provide hard-coded values as fallback.

> diff --git a/drivers/soc/tegra/irq.c b/drivers/soc/tegra/irq.c

>  void __init tegra_init_irq(void)

> -	distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
> +	np = of_find_matching_node(NULL, ictlr_matches);
> +	if (np) {
> +		for (i = 0; i < ARRAY_SIZE(ictlr_regs); i++)
> +			if (of_address_to_resource(np, i, &res) == 0)
> +				ictlr_regs[i] = res;

It'd be nice to check that loop ran exactly the number of times expected
based on the compatible value (i.e. SoC) if the legacy interrupt
controller node.

What about erroring out if entries are missing or can't be parsed.

>  	if (num_ictlrs > ARRAY_SIZE(ictlr_reg_base)) {
> -		WARN(1, "Too many (%d) interrupt controllers found. Maximum is %d.",
> +		WARN(1, "Too many (%d) interrupt controllers found. Maximum is %zu.",
>  			num_ictlrs, ARRAY_SIZE(ictlr_reg_base));

While we're changing this, maybe we should change that test to
"num_ictlrs != the expected value", so too few is found as well.
