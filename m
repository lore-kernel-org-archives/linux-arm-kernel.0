From: drjones@redhat.com (Andrew Jones)
Date: Fri, 29 Jun 2018 18:03:06 +0200
Subject: [PATCH] arm64: acpi: reenumerate topology ids
In-Reply-To: <20180629133849.GB16282@e107155-lin>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <d797ebc5-bd7b-4f72-d4fc-840ba7345a15@arm.com>
 <20180629105334.GB18043@e107155-lin>
 <20180629114227.4noje2kx3lcjbcpd@kamzik.brq.redhat.com>
 <20180629133849.GB16282@e107155-lin>
Message-ID: <20180629160306.zdticyqs4rqvzw2g@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 02:38:49PM +0100, Sudeep Holla wrote:
> On Fri, Jun 29, 2018 at 01:42:27PM +0200, Andrew Jones wrote:
> > On Fri, Jun 29, 2018 at 11:53:34AM +0100, Sudeep Holla wrote:
> > > On Thu, Jun 28, 2018 at 12:12:00PM -0500, Jeremy Linton wrote:
> > > > Hi,
> > > > 
> > > > On 06/28/2018 11:30 AM, Sudeep Holla wrote:
> > > 
> > > [...]
> > > 
> > > > >I am not sure if we can ever guarantee that DT and ACPI will get the
> > > > >same ids whatever counter we use as it depends on the order presented in
> > > > >the firmware(DT or ACPI). So I am not for generating ids for core and
> > > > >threads in that way.
> > > > >
> > > > >So I would like to keep it simple and just have this counters for
> > > > >package ids as demonstrated in Shunyong's patch.
> > > >
> > > > So, currently on a non threaded system, the core id's look nice because they
> > > > are just the ACPI ids. Its the package id's that look strange, we could just
> > > > fix the package ids, but on threaded machines the threads have the nice acpi
> > > > ids, and the core ids are then funny numbers. So, I suspect that is driving
> > > > this as much as the strange package ids.
> > > >
> > > 
> > > Yes, I know that and that's what made be look at topology_get_acpi_cpu_tag
> > > For me, if the PPTT has valid ID, we should use that. Just becuase DT lacks
> > > it and uses counter doesn't mean ACPI also needs to follow that.
> > 
> > AFAIK, a valid ACPI UID doesn't need to be something derivable directly
> > from the hardware, so it's just as arbitrary as the CPU phandle that is
> > in the DT cpu-map, i.e. DT *does* have an analogous leaf node integer.
> >
> 
> Its platform specific, left to vendors to identify that. Are you referring
> to reg property in DT for leaf nodes ? If so, that's MPIDR and is present
> in ACPI MADT.

No, I'm referring to the 'cpu' node in the cpu-map, which is a phandle
pointing to a cpu node. The cpu node contains the reg with the MPIDR.
A phandle links one DT node to another, thus it's analogous to an ACPI
ID linkage.

However, after reading your last mail that indicates these "ACPI processor
IDs" may actually be derived from hardware - I guess by implementing the
_UID method and having that method extract it in some vendor-specific way,
then the analogy breaks down. A phandle is just a DT construct, while an
ID from an ACPI method may actually be a useful hardware locator address.

> 
> > >
> > > I am sure some vendor will put valid UID and expect that to be in the
> > > sysfs.
> >
> > I can't think of any reason that would be useful, especially when the
> > UID is for a thread, which isn't even displayed by sysfs.
> >
> 
> You are mixing MPIDR and UID here.

I wasn't talking about MPIDR at all. As I said above, I was was under the
impression the UID was not derived from hardware, i.e. only an ACPI
construct. If that's not the case, then it has more value than what I was
giving it before, but only when the valid flag is set.

And, since we have a [good?] chance that the valid flag won't be set,
then I still think we're better off with counters to keep the user API
consistent and unambiguous across systems. We should also keep a mapping
to these UIDs, though, when we have something valid to map to.

Thanks,
drew
