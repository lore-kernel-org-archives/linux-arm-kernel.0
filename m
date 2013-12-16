From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 15:22:35 +0000
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <52AF11FE.70000@linaro.org>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <52AF11FE.70000@linaro.org>
Message-ID: <20131216152235.GI3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 10:45:18PM +0800, Alex Shi wrote:
> On 12/11/2013 09:13 PM, Mark Brown wrote:

> > +struct cputopo_arm {
> > +	int thread_id;
> > +	int core_id;
> > +	int socket_id;

> Forgive me if I am stupid. :)

> why we don't need a cluster_id? and does one cpu socket include few
> clusters?

The ARMv7 code calls a cluster a socket I think because it's trying to
maintain similarity with other architectures and the ARMv8 code follows
ARMv7 in this regard.  At the minute we're using this ID for whatever
the lowest level of grouping is above a core and presenting the
scheduler with a flat topology there - the topology binding and MPIDR
both allow multiple layers of cluster so you could definitely have
multiple clusters in a supercluster.

Without practical examples of such systems or more architecture
documentation than I've been able to find it's not clear how to
represent them to the scheduler, it will depend on how closely
associated the clusters are and what the scheduler's features are,
perhaps we should describe such a system as NUMA but it's not clear to
me that this would produce the desired results.  I wonder if we may end
up figuring this out from other data such as descriptions of caches and
interconnects rather than purely from the topology information.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/b1c8dde4/attachment.sig>
