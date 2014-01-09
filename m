From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 9 Jan 2014 17:44:58 +0000
Subject: [PATCH v10 2/4] arm64: topology: Add support for topology DT
 bindings
In-Reply-To: <1389287106-29979-3-git-send-email-broonie@kernel.org>
References: <1389287106-29979-1-git-send-email-broonie@kernel.org>
 <1389287106-29979-3-git-send-email-broonie@kernel.org>
Message-ID: <20140109174458.GA13541@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 05:05:04PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> +#include <linux/slab.h>

Move it to patch 3 please where kcalloc is actually used.

[...]

> +static void __init parse_dt_topology(void)
> +{
> +	struct device_node *cn;
> +	int cluster_id = 0;
> +
> +	cn = of_find_node_by_path("/cpus");
> +	if (!cn) {
> +		pr_err("No CPU information found in DT\n");
> +		return;
> +	}
> +
> +	/*
> +	 * If topology is provided as a cpu-map it is essentially a
> +	 * root cluster.
> +	 */
> +	cn = of_find_node_by_name(cn, "cpu-map");
> +	if (!cn)
> +		return;
> +	parse_cluster(cn, 0, &cluster_id);

You do not need to pass a pointer, sorry I wanted to comment but I did
not manage to do it in time. Define cluster_id it as static __initdata in
parse_cluster and pass it by value to parse_core, that's it no need for
a pointer unless I am missing something. This way cluster_id is defined
where it is used and still does what you expect from it. I just did not
like the fact that was defined outside function scope to pass state
across functions, it is just a matter of taste really.

Apart from that I will re-review the entire series and add proper tags
accordingly.

Lorenzo
