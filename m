From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 8 Jan 2014 18:23:31 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <1389201013-23794-2-git-send-email-broonie@kernel.org>
References: <1389201013-23794-1-git-send-email-broonie@kernel.org>
 <1389201013-23794-2-git-send-email-broonie@kernel.org>
Message-ID: <20140108182331.GB9724@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 05:10:11PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Add support for parsing the explicit topology bindings to discover the
> topology of the system.
> 
> Since it is not currently clear how to map multi-level clusters for the
> scheduler all leaf clusters are presented to the scheduler at the same
> level. This should be enough to provide good support for current systems.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
> 
> This doesn't actually ignore CPUs in the root cpu-map, merely warns
> about them.  After looking at ignoring them it seemed like a more
> sensible thing to just shove them in a separate cluster for now -
> giving the scheduler information about only some of the cores seemed
> like it was asking for trouble and trying to do anything more active
> seems like a lot of work to unsupport broken systems (if you see what
> I mean).  I would expect that the end result of putting them in a
> cluster is going to be about the same as not providing information
> anyway.
> 
> It seems like if this isn't enough then either disabling the affected
> CPUs entirely or making the warnings louder is the way forwards.

Well, there are so many corner cases (eg duplicated CPUs might be
another one - should we track that ? It is probably something worth
warning on, you check before initializing a cpu struct if it has already
been initialized) that they are hard to track. What you did makes sense
to me at first glance.

>  arch/arm64/kernel/topology.c | 149 +++++++++++++++++++++++++++++++++++++++++++
> +static void __init parse_cluster(struct device_node *cluster, int depth)

Is it really worth adding a depth parameter just for cpu-map ? Can't we check
the node name ? Either way is fine by me, just flagging this up.

> +{
> +	char name[10];
> +	bool leaf = true;
> +	bool has_cores = false;
> +	struct device_node *c;
> +	int core_id = 0;
> +	int i;
> +
> +	/*
> +	 * First check for child clusters; we currently ignore any
> +	 * information about the nesting of clusters and present the
> +	 * scheduler with a flat list of them.
> +	 */
> +	i = 0;
> +	do {
> +		snprintf(name, sizeof(name), "cluster%d", i);
> +		c = of_get_child_by_name(cluster, name);
> +		if (c) {
> +			parse_cluster(c, depth + 1);
> +			leaf = false;
> +		}
> +		i++;
> +	} while (c);
> +
> +	/* Now check for cores */
> +	i = 0;
> +	do {
> +		snprintf(name, sizeof(name), "core%d", i);
> +		c = of_get_child_by_name(cluster, name);
> +		if (c) {
> +			has_cores = true;
> +
> +			if (depth == 0)
> +				pr_err("%s: cpu-map children should be clusters\n",
> +				       c->full_name);
> +
> +			if (leaf)
> +				parse_core(c, core_id++);
> +			else
> +				pr_err("%s: Non-leaf cluster with core %s\n",
> +				       cluster->full_name, name);
> +		}
> +		i++;
> +	} while (c);
> +
> +	if (leaf && !has_cores)
> +		pr_warn("%s: empty cluster\n", cluster->full_name);
> +
> +	if (leaf)
> +		cluster_id++;

We increment cluster_id even for leaf clusters with no cores, it is
probably safe to do it given that cluster id are completely arbitrary
numbers, just wanted to mention that.

> +}
> +
> +static void __init parse_dt_topology(void)
> +{
> +	struct device_node *cn;
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
> +	parse_cluster(cn, 0);

You could loop through cluster children here, but I understand you
want to avoid copying the sprintf variables and code here too just to
check for cluster children, so it is fine to leave code as it is
(probably we can remove the depth parameter too).

Lorenzo
