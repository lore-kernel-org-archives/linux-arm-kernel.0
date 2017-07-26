From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Jul 2017 12:37:28 +0100
Subject: [PATCH] ASoC: fix balance of of_node_get()/of_node_put()
In-Reply-To: <20170725214952.6491-1-borneo.antonio@gmail.com>
References: <20170725214952.6491-1-borneo.antonio@gmail.com>
Message-ID: <20170726113728.fpj3kboxib5tnmzv@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 11:49:52PM +0200, Antonio Borneo wrote:

> Fixed by:
> - removing of_node_put() in the body of of_for_each_phandle(){},
>   since already provided at each iteration. Add it in case the
>   loop is break out;
> - adding of_node_get() before calling of_graph_get_port_parent()
>   or asoc_graph_card_dai_link_of().

>  sound/soc/generic/audio-graph-card.c  | 14 +++++++++-----
>  sound/soc/generic/simple-card-utils.c |  5 +++++
>  sound/soc/soc-core.c                  |  5 +++++
>  3 files changed, 19 insertions(+), 5 deletions(-)

This is a series of different changes to fix different (although
related) problems which should be being submitted individually.  Sending
multiple changes in one patch makes it harder to review things and for
fixes like this makes it harder to backport the fixes where not all the
code being fixed was introduced in a single kernel version.

>  	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
> +		/*
> +		 * asoc_graph_card_dai_link_of() will call
> +		 * of_node_put(). So, call of_node_get() here
> +		 */
> +		of_node_get(it.node);
>  		ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);

Why is this the most sensible fix?  It is really not at all obvious why
asoc_graph_card_dai_link_of() would drop a reference, or in what
situations callers might have a reference they're OK with dropping.

> +	/*
> +	 * of_graph_get_port_parent() will call
> +	 * of_node_put(). So, call of_node_get() here
> +	 */
> +	of_node_get(ep);
>  	node = of_graph_get_port_parent(ep);

Same here, why does this make sense?  It is not in the least bit obvious
to me why looking up the parent of a node would cause us to drop the
reference to the current node, this seems like an error prone and
confusing API which would be better fixed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170726/8cd234f7/attachment.sig>
