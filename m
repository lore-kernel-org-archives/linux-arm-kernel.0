From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jun 2015 19:13:59 +0100
Subject: [PATCH 13/13] driver-core: probe dependencies before probing
In-Reply-To: <1434548543-22949-14-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-14-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150617181359.GA14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 03:42:23PM +0200, Tomeu Vizoso wrote:
> Before actually probing a device, find out what dependencies it has and
> do our best to ensure that they are available at this point.

> This is accomplished by finding out what platform devices need to be
> probed so the dependencies are available.

...and then trying to probe them first.

> If any dependencies are still unavailable after that (most probably a
> missing driver or an error in the HW description from the firmware), we
> print a nice error message so that people don't have to add a zillion of
> printks to find out why a device asked for its probe to be deferred.

So, I think I like this approach though I've not done a full pass
through and I'm not sure how expensive it gets (there's definitely room
for optimisation as the patch notes).  I'm not 100% sure I see what
prints this error message you're referring to (I'm just seeing debug
prints).

> +static struct fwnode_handle *get_enclosing_platform_dev(
> +						struct fwnode_handle *fwnode)

Only platform devices?

> +static void check_dependencies_per_class(struct class *class, void *data)
> +{
> +	struct fwnode_handle *fwnode = data;
> +	struct list_head *deps;
> +	struct fwnode_dependency *dep, *tmp;
> +
> +	if (!class->get_dependencies)
> +		return;
> +
> +	deps = class->get_dependencies(fwnode);
> +	if (!deps)
> +		return;
> +
> +	list_for_each_entry_safe(dep, tmp, deps, dependency) {
> +		if (!check_dependency(dep->fwnode))
> +			pr_debug("Dependency '%s' not available\n",
> +				 fwnode_get_name(dep->fwnode));
> +
> +		list_del(&dep->dependency);
> +		kfree(dep);
> +	}
> +
> +	kfree(deps);

OK, so the caller is responsible for freeing everything and the class
must allocate - this definitely suggests that 

I'm not sure there's any benefit in having deps be dynamically allocated
here, just put it on the stack and iterate through the list - the
iteration is going to be cheap if we get nothing back (probably the
common case) and probably cheaper than the alloc/free.

One thing here is that I was under the impression classes were supposed
to be going away...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150617/2865540c/attachment.sig>
