From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jun 2015 18:40:09 +0100
Subject: [PATCH 08/13] gpio: sysfs: implement class.get_dependencies()
In-Reply-To: <1434548543-22949-9-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-9-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150617174009.GZ14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 03:42:18PM +0200, Tomeu Vizoso wrote:

> +static bool strends(const char *str, const char *postfix)
> +{
> +	if (strlen(str) < strlen(postfix))
> +		return false;
> +
> +	return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
> +}

This is named like (and looks like) a generic fuction, shouldn't it be
in string.h or something?

> +static void add_dependency(struct fwnode_handle *fwnode,
> +			   struct list_head *list)
> +{
> +	struct fwnode_dependency *dep;
> +
> +	dep = kzalloc(sizeof(*dep), GFP_KERNEL);
> +	if (!dep)
> +		return;
> +
> +	INIT_LIST_HEAD(&dep->dependency);
> +	dep->fwnode = fwnode;
> +
> +	list_add_tail(&dep->dependency, list);
> +}

Might be worth putting this in generic code, it looks pretty generic?  I
have to say I'm unclear what frees the returned list.

> +	if (!is_of_node(fwnode))
> +		return NULL;
> +
> +	np = of_node(fwnode);
> +	if (!np)
> +		return NULL;

Presumably the first check could be dropped?

> +	list = kzalloc(sizeof(*list), GFP_KERNEL);
> +	if (!list)
> +		return NULL;

Might it make sense for the core to allocate the head of the list and
just ask the classes to add to the list?  We're going to want to merge
the dependencies from multiple subsystems and that saves allocating
heads that may never get anything added to them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150617/9551bc96/attachment.sig>
