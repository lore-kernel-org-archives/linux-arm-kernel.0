From: drjones@redhat.com (Andrew Jones)
Date: Fri, 29 Jun 2018 17:46:08 +0200
Subject: [PATCH] arm64: acpi: reenumerate topology ids
In-Reply-To: <20180629132934.GA16282@e107155-lin>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
Message-ID: <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 02:29:34PM +0100, Sudeep Holla wrote:
> If it matters a lot, vendors must use UID for consistency. Since OS doesn't
> use those IDs for any particular reason, OS must not care.

That depends. If you look at how topology_logical_package_id() is used in
x86 code you'll see it gets used as an index to an array in a couple
places. If we don't remap arbitrary IDs to counters than we may miss out
on some opportunities to avoid lists.

Also, we're talking about what's visible to users. I think it's much more
likely to break a user app by exposing topology IDs that have values
greater than the linear CPU numbers (even though properly written apps
shouldn't expect them to be strictly <=), than the opposite.

> 
> > > 
> > > > >
> > > > > So I would like to keep it simple and just have this counters for
> > > > > package ids as demonstrated in Shunyong's patch.
> > > > >
> > > >
> > > > If we don't also handle cores when there are threads, then the cores
> > > > will also end up having weird IDs.
> > > >
> > > 
> > > Yes, but if PPTT says it has valid ID, I would prefer that over DT like
> > > generated.
> > 
> > Valid *ACPI* ID, which just means it's a guaranteed unique ACPI UID,
> > which isn't likely going to be anything useful to a user.
> > 
> 
> How is that different from OS generated one from user's perspective ?
> Vendors might assign sockets UID and he may help them to replace one.
> Having some generated counter based id is not helpful.

I agree with this. It's a good argument for maintaining a mapping of
package-id to id-physically-printed-on-a-package somewhere. To avoid
maintaining a mapping it could just be stored directly in
cpu_topology[cpu].package_id, but then how can we tell the difference
between a valid printed-on-package-id and an ACPI offset? We'd still
have to maintain additional state to determine if it's valid or not,
so we could just maintain a mapping instead.

Thanks,
drew
