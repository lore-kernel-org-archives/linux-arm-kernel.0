From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 24 Mar 2014 16:02:36 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140324154550.GL2269@sirena.org.uk>
References: <1395422881-10029-1-git-send-email-broonie@kernel.org>
 <1395422881-10029-2-git-send-email-broonie@kernel.org>
 <20140324153611.GA16245@red-moon>
 <20140324154550.GL2269@sirena.org.uk>
Message-ID: <20140324160236.GB16245@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 03:45:50PM +0000, Mark Brown wrote:
> On Mon, Mar 24, 2014 at 03:36:11PM +0000, Lorenzo Pieralisi wrote:
> 
> > -	for_each_possible_cpu(cpu) {
> > -		if (of_get_cpu_node(cpu, NULL) == cpu_node)
> > +	for_each_possible_cpu(cpu)
> > +		if (of_get_cpu_node(cpu, NULL) == cpu_node) {
> > +			of_node_put(cpu_node);
> >  			return cpu;
> > -	}
> > +		}
> 
> of_get_cpu_node() doesn't visibly take a reference and isn't documented
> as doing such?

of_parse_phandle() does, am I right ?

> >  	pr_crit("Unable to find CPU node for %s\n", cpu_node->full_name);
> > +
> > +	of_node_put(cpu_node);
> 
> I don't understand this one - the caller passed in cpu_node, we didn't
> acquire a reference here so I'd expect the caller to be doing any frees
> that are needed.

cpu_node has to be put, since it is obtained through of_parse_phandle().

> > @@ -55,6 +58,7 @@ static int __init parse_core(struct device_node *core, int cluster_id,
> >  		if (t) {
> >  			leaf = false;
> >  			cpu = get_cpu_for_node(t);
> > +			of_node_put(t);
> >  			if (cpu >= 0) {
> >  				cpu_topology[cpu].cluster_id = cluster_id;
> >  				cpu_topology[cpu].core_id = core_id;
> > @@ -64,7 +68,6 @@ static int __init parse_core(struct device_node *core, int cluster_id,
> >  				       t->full_name);
> >  				return -EINVAL;
> >  			}
> > -			of_node_put(t);
> 
> This causes us to reference the just released t when displaying the
> error message in the error case (t->full_name in the quoted context).
> You're right that the reference is leaked in the error path but the free
> needs to be inside the error handling case.

Gah, right. I will let you fix it please as you deem fit.

> Of course all this refcounting does absolutely nothing for FDT but hey
> ho.

We comply with the interface, so that at least from an API standpoint
code is complete. I understand your point.

> > @@ -107,11 +110,11 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
> >  		snprintf(name, sizeof(name), "cluster%d", i);
> >  		c = of_get_child_by_name(cluster, name);
> >  		if (c) {
> > +			leaf = false;
> >  			ret = parse_cluster(c, depth + 1);
> > +			of_node_put(c);
> >  			if (ret != 0)
> >  				return ret;
> > -			leaf = false;
> > -			of_node_put(c);
> 
> I don't understand why you moved the assignment of leaf?

It makes it tidier, but that's just cosmetic and my opinion (but thanks
for having a look since it is not a significant change). Again, squash it
in as you deem fit.

Thanks !
Lorenzo
