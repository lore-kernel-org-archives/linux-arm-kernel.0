From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 19:19:05 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20131217174037.GC9831@e102568-lin.cambridge.arm.com>
References: <1387212565-12668-1-git-send-email-broonie@kernel.org>
 <1387212565-12668-2-git-send-email-broonie@kernel.org>
 <20131217174037.GC9831@e102568-lin.cambridge.arm.com>
Message-ID: <20131217191905.GC28455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 05:40:37PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Dec 16, 2013 at 04:49:23PM +0000, Mark Brown wrote:

> > +	i = 0;
> > +	do {
> > +		snprintf(name, sizeof(name), "thread%d", i);
> > +		t = of_get_child_by_name(core, name);
> > +		if (t) {
> > +			leaf = false;
> > +			cpu = get_cpu_for_node(t);
> > +			if (cpu) {

> I think that's wrong. If cpu == -1 that should be skipped.

Yup, good spot.

> > +	do {
> > +		snprintf(name, sizeof(name), "cluster%d", i);
> > +		c = of_get_child_by_name(cluster, name);
> > +		if (c) {
> > +			parse_cluster(c);
> > +			leaf = false;
> > +		}
> > +		i++;
> > +	} while (c);
> > +

> A cpu-map can only contain cluster nodes, this is not verified here, but
> it has to be. Put it differently, a core node cannot be a cpu-map direct
> child, a long winded way to say cpu-map cannot be parsed by this function
> as it is.

Well, it can be parsed totally happily but we're not as strict with the
validation as we might want be - we'll parse valid bindings successfully
but also accept out of spec bindings (but then they're using undefined
behaviour so anything could happen including the kernel trying to do
something sensible with what it was handed).

It might just make sense to change the binding here, saying the cpu_map
is a root cluster seems reasonable to me, it doesn't hurt to have the
extra level but it doesn't seem to buy us anything either.  But we could
also add a validation check for unwanted properties, I'm not that fussed
between any of these options.

> Apart from these minor remarks, I think we should aim for consolidating
> these parsing functions, after all they are all pretty similar bar minor
> corner cases, or at least factor out the parsing/enumeration loops.

> What do you think ?

I thought about that and did poke at it but it didn't seem worth the
effort for the very small number of uses - adding a callback for the
action didn't seem to be doing anything for the readability and starting
to define macros didn't fill me with great joy.  I didn't want to put
anything in of.h as bindings that can use the existing iterators are
generally more idiomatic.

It may be there's some nice way of writing the factoring out but I
didn't think of it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/a5c74b41/attachment.sig>
