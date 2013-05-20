From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 20 May 2013 13:11:21 +0100
Subject: [RFC PATCH v3] drivers: bus: add ARM CCI support
In-Reply-To: <1368095640-3675-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368095640-3675-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368095640-3675-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1369051881.3511.4.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-05-09 at 11:34 +0100, Lorenzo Pieralisi wrote:
[...]
> +static int __init cci_probe(void)
> +{
> +	struct cci_nb_ports const *cci_config;
> +	int ret, i, nb_ace = 0, nb_ace_lite = 0;
> +	struct device_node *np, *cp;
> +	const char *match_str;
> +	bool is_ace;
> +
> +	np = of_find_matching_node(NULL, arm_cci_matches);
> +	if (!np)
> +		return -ENODEV;
> +
> +	cci_config = of_match_node(arm_cci_matches, np)->data;
> +	if (!cci_config)
> +		return -ENODEV;
> +
> +	nb_cci_ports = cci_config->nb_ace + cci_config->nb_ace_lite;
> +
> +	ports = kcalloc(sizeof(*ports), nb_cci_ports, GFP_KERNEL);
> +	if (!ports)
> +		return -ENOMEM;
> +
> +	cci_ctrl_base = of_iomap(np, 0);
> +
> +	if (!cci_ctrl_base) {
> +		WARN(1, "unable to ioremap CCI ctrl\n");
> +		ret = -ENXIO;
> +		goto memalloc_err;
> +	}
> +
> +	for_each_child_of_node(np, cp) {
> +		i = nb_ace + nb_ace_lite;
> +
> +		if (i >= nb_cci_ports)
> +			break;

I know this is a bit late, but...

Would it not be best to check here that the node type is in fact
"slave-if", that way if we add support in later versions for other node
types (e.g. for the PMU) then we don't cause backward compatibility
issues. I'm thinking here of the same concerns that Rob raised with
"ARM: kernel: fix arm_dt_init_cpu_maps() to skip non-cpu nodes"


> +		if (of_property_read_string(cp, "interface-type",
> +					&match_str)) {
> +			WARN(1, "node %s missing interface-type property\n",
> +				  cp->full_name);
> +			continue;
> +		}
> +
[..]

-- 
Tixy
