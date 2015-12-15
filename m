From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Dec 2015 15:08:13 +0000
Subject: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
In-Reply-To: <20151215140135.GI31299@leverpostej>
References: <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
 <20151210153004.GA26758@sirena.org.uk>
 <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
Message-ID: <20151215150813.GZ5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 02:01:36PM +0000, Mark Rutland wrote:

> I really don't want to see a table of magic numbers in the kernel.

Right, there's pitfalls there too although not being part of an ABI
does make them more manageable.  

One thing it's probably helpful to establish here is how much the
specific numbers are going to matter in the grand scheme of things.  If
the specific numbers *are* super important then nobody is going to want
to touch them as they'll be prone to getting tweaked.  If instead the
numbers just need to be ballpark accurate so the scheduler starts off in
roughly the right place and the specific numbers don't matter it's a lot
easier and having a table in the kernel until we think of something
better (if that ever happens) gets a lot easier.

My expectation is that we just need good enough, not perfect, and that
seems to match what Juri is saying about the expectation that most of
the fine tuning is done via other knobs.

> The relative performance and efficiency of cores will vary depending on
> uArch-specific configuration (e.g. sizing of L1/L2 caches) in addition
> to general uArch differences, and integration too (e.g. if the memory
> system gives priority to one cluster over another for whatever reason).
> I've heard of pseudo-heterogeneous platforms with different
> configuration of the same uArch across clusters.

> We also don't necessarily have the CPU clock frequencies, or the ability
> to scale them. Maybe we simply give up in that case, though.

These variables all sound like the sort of thing we can get people to
put in the DT where they matter, and the more we talk about multiple
subtle variables feeding into a single number the more this starts to
sound like tuning (with all the problems that brings, especially when
you're into things like the behaviour with the clusters competing for
resources).  Who knows, at some point the scheduler may even want to
directly act on some of these parameters?

> If we cannot rely on external information, and want this information to
> be derived by the kernel, then we need to perform some dynamic
> benchmark. That would work for future CPUs the kernel knows nothing
> about yet, and would cater for the pseudo-heterogeneous cases too.

Runtime benchmarking (or gradual tuning based on observed performance of
the scheduler) would work as well of course.  I'd expect something like
that to be part of any end point we get to here, the more the system is
able to self tune the better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151215/24a3ffc1/attachment.sig>
