From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jan 2014 18:32:18 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140108182331.GB9724@e102568-lin.cambridge.arm.com>
References: <1389201013-23794-1-git-send-email-broonie@kernel.org>
 <1389201013-23794-2-git-send-email-broonie@kernel.org>
 <20140108182331.GB9724@e102568-lin.cambridge.arm.com>
Message-ID: <20140108183218.GV31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 06:23:31PM +0000, Lorenzo Pieralisi wrote:

> > This doesn't actually ignore CPUs in the root cpu-map, merely warns
> > about them.  After looking at ignoring them it seemed like a more
> > sensible thing to just shove them in a separate cluster for now -
> > giving the scheduler information about only some of the cores seemed
> > like it was asking for trouble and trying to do anything more active
> > seems like a lot of work to unsupport broken systems (if you see what
> > I mean).  I would expect that the end result of putting them in a
> > cluster is going to be about the same as not providing information
> > anyway.

> > It seems like if this isn't enough then either disabling the affected
> > CPUs entirely or making the warnings louder is the way forwards.

> Well, there are so many corner cases (eg duplicated CPUs might be
> another one - should we track that ? It is probably something worth
> warning on, you check before initializing a cpu struct if it has already
> been initialized) that they are hard to track. What you did makes sense
> to me at first glance.

Yes, there's definitely scope for improving the robustness.  On the
other hand I'm sure all device tree authors are dilligent and careful so
there's no need for us to worry! :P

> >  arch/arm64/kernel/topology.c | 149 +++++++++++++++++++++++++++++++++++++++++++
> > +static void __init parse_cluster(struct device_node *cluster, int depth)

> Is it really worth adding a depth parameter just for cpu-map ? Can't we check
> the node name ? Either way is fine by me, just flagging this up.

It seemed more idiomatic and I suspect we may want the depth in future
if we try to tell the scheduler about clusters of clusters.  It's
certainly easier to leave the code as is now I've written it this way if
nothing else.

> > +	if (leaf)
> > +		cluster_id++;

> We increment cluster_id even for leaf clusters with no cores, it is
> probably safe to do it given that cluster id are completely arbitrary
> numbers, just wanted to mention that.

Right, my thoughts exactly - this is the simplest thing I thought of.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/4ab73550/attachment.sig>
