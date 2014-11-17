From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Nov 2014 09:45:39 +0100
Subject: [RFC PATCHv2] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <1415327626-16079-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <20141106201603.GF4974@lunn.ch>
 <1415327626-16079-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <20141117094539.4abc53e5@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chris Packham,

On Fri,  7 Nov 2014 15:33:46 +1300, Chris Packham wrote:

> +static bool __init armada_smp_init(void)
> +{
> +	struct device_node *cpu, *cpus;
> +	int len;
> +	bool found_method = false;

I don't think this boolean variable is needed.

> +
> +	cpus = of_find_node_by_path("/cpus");
> +	if (!cpus)
> +		return false;
> +
> +	for_each_child_of_node(cpus, cpu) {
> +		if (of_node_cmp(cpu->type, "cpu"))
> +			continue;
> +		if (of_find_property(cpu, "enable-method", &len))
> +			found_method = true;

Replace with:
		if (of_find_property(cpu, "enable-method", &len)) {
			of_node_put(cpus);
			return true;
		}

> +	}
> +
> +	/* Fallback to an enable-method in the cpus node */
> +	if (!found_method)
> +		if (of_find_property(cpus, "enable-method", &len))
> +			found_method = true;

Replace with:

	if (of_find_property(cpus, "enable-method", &len)) {
		of_node_put(cpus);
		return true;
	}

	of_node_put(cpus);
	return false;

Also, please add a comment above the function to clarify what it is
doing and why we're doing it. The commit log should also probably
mention why we're keeping the .smp = smp_ops(...) field (i.e, backward
compatibility with old DT).

>  static const char * const armada_370_xp_dt_compat[] = {
>  	"marvell,armada-370-xp",
>  	NULL,
> @@ -206,6 +231,7 @@ static const char * const armada_370_xp_dt_compat[] = {
>  DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
>  	.l2c_aux_val	= 0,
>  	.l2c_aux_mask	= ~0,
> +	.smp_init	= armada_smp_init,
>  	.smp		= smp_ops(armada_xp_smp_ops),
>  	.init_machine	= mvebu_dt_init,
>  	.init_irq       = mvebu_init_irq,

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
