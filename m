From: drjones@redhat.com (Andrew Jones)
Date: Fri, 29 Jun 2018 20:03:08 +0200
Subject: [PATCH] arm64: acpi: reenumerate topology ids
In-Reply-To: <20180629172252.GA6906@e107155-lin>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
 <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
 <30d56d70-6043-0ad7-4530-208fab18c8d4@arm.com>
 <20180629170334.3ab7ngru3abxcobf@kamzik.brq.redhat.com>
 <20180629172252.GA6906@e107155-lin>
Message-ID: <20180629180308.zdl4taihzv2zwarc@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 06:23:15PM +0100, Sudeep Holla wrote:
> On Fri, Jun 29, 2018 at 07:03:34PM +0200, Andrew Jones wrote:
> > On Fri, Jun 29, 2018 at 11:48:15AM -0500, Jeremy Linton wrote:
> [..]
> 
> > >
> > > If you want a human readable socket identifier that matches something
> > > stamped above the socket, that is what SMBIOS is for. Queue discussion about
> > > that tables reliability for functional ids. Either way, as the spec is
> > > written today (or any ECRs I've seen), your definitely not going to get both
> > > nice socket1, socket2, and cpu1, cpu2 out of the same PPTT/ACPIid name-space
> > > since the numerical id's conflict.
> > >
> >
> > If we don't expect the ACPI processor ID to be something useful to users,
> > then I'll revert back to lobbying for counters, as those arbitrary numbers
> > can't be less useful than arbitrary offsets and ACPI IDs, and, IMO, are
> > more likely to make users/user apps happy.
> >
> 
> I agree that ACPI processor ID may not be useful to the users, but providing
> some counter based ID which is highly dependent on the ordering the firmware
> table which can change between boots is highly inconsistent and unreliable
> and in some sense break user ABI. So I still NACK the counter based ID.
>

If the firmware tables change order between boots, then so will ACPI table
offsets - unless you mean only the leaf nodes may change order. Leaf nodes
would indeed keep the same ID (by using ACPI processor IDs), but when the
leaves are threads, those IDs aren't visible to the user anyway, as
thread-id is not in sysfs.

Anyway, what would be the harm if PE_x (PE not a thread) was identified by
the pair (1,1) on one boot and (1,2) on the second boot? It's still
clearly in the same package, and I don't believe there's any need nor
desire to allow a user to tell the difference between two peer PEs. Users
should never know that the core-id of a specific physical core changed,
nor should they care.

I'm racking my brain trying to think of scenario, maybe something with
elaborate cpu pinning, that could be affected, but can't see how. Please
provide an example. If you can, then we obviously need to modify how
the DT cpu-map is parsed, as DT boots would be vulnerable to the same
issue.

Thanks,
drew
