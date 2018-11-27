From: joe@perches.com (Joe Perches)
Date: Tue, 27 Nov 2018 10:35:15 -0800
Subject: [PATCH v10 1/7] interconnect: Add generic on-chip interconnect API
In-Reply-To: <20181127180349.29997-2-georgi.djakov@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-2-georgi.djakov@linaro.org>
Message-ID: <5d16a4a57ed5529299d7b73e13a249add00b1afe.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-11-27 at 20:03 +0200, Georgi Djakov wrote:
> This patch introduces a new API to get requirements and configure the
> interconnect buses across the entire chipset to fit with the current
> demand.

trivial notes:

> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
[]
> +static int apply_constraints(struct icc_path *path)
> +{
> +	struct icc_node *next, *prev = NULL;
> +	int ret = -EINVAL;
> +	int i;
> +
> +	for (i = 0; i < path->num_nodes; i++, prev = next) {
> +		struct icc_provider *p;
> +
> +		next = path->reqs[i].node;
> +		/*
> +		 * Both endpoints should be valid master-slave pairs of the
> +		 * same interconnect provider that will be configured.
> +		 */
> +		if (!prev || next->provider != prev->provider)
> +			continue;
> +
> +		p = next->provider;
> +
> +		/* set the constraints */
> +		ret = p->set(prev, next);
> +		if (ret)
> +			goto out;
> +	}
> +out:
> +	return ret;
> +}

The use of ", prev = next" appears somewhat tricky code.
Perhaps move the assignment of prev to the bottom of the loop.
Perhaps the temporary p assignment isn't useful either.

> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
> +{
[]
> +	ret = apply_constraints(path);
> +	if (ret)
> +		pr_debug("interconnect: error applying constraints (%d)", ret);

Ideally all pr_<foo> formats should end in '\n'

> +static struct icc_node *icc_node_create_nolock(int id)
> +{
> +	struct icc_node *node;
> +
> +	/* check if node already exists */
> +	node = node_find(id);
> +	if (node)
> +		goto out;
> +
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node) {
> +		node = ERR_PTR(-ENOMEM);
> +		goto out;

Generally, this code appears to overly rely on goto when
direct returns could be more readable.

> +	}
> +
> +	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> +	if (WARN(id < 0, "couldn't get idr")) {

This seems to unnecessarily hide the id < 0 test in a WARN

Why is this a WARN and not a simpler
	if (id < 0) {
		[ pr_err(...); or WARN(1, ...); ]

> +		kfree(node);
> +		node = ERR_PTR(id);
> +		goto out;
> +	}
> +
> +	node->id = id;
> +
> +out:
> +	return node;
> +}
[]
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
[]
> +/* macros for converting to icc units */
> +#define bps_to_icc(x)	(1)
> +#define kBps_to_icc(x)	(x)
[]
> +#define MBps_to_icc(x)	(x * 1000)
> +#define GBps_to_icc(x)	(x * 1000 * 1000)
> +#define kbps_to_icc(x)	(x / 8 + ((x) % 8 ? 1 : 0))
> +#define Mbps_to_icc(x)	(x * 1000 / 8 )
> +#define Gbps_to_icc(x)	(x * 1000 * 1000 / 8)

The last 5 macros should parenthesize x
