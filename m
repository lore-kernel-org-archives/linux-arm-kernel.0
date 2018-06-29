From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 29 Jun 2018 14:38:49 +0100
Subject: [PATCH] arm64: acpi: reenumerate topology ids
In-Reply-To: <20180629114227.4noje2kx3lcjbcpd@kamzik.brq.redhat.com>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <d797ebc5-bd7b-4f72-d4fc-840ba7345a15@arm.com>
 <20180629105334.GB18043@e107155-lin>
 <20180629114227.4noje2kx3lcjbcpd@kamzik.brq.redhat.com>
Message-ID: <20180629133849.GB16282@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 01:42:27PM +0200, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 11:53:34AM +0100, Sudeep Holla wrote:
> > On Thu, Jun 28, 2018 at 12:12:00PM -0500, Jeremy Linton wrote:
> > > Hi,
> > > 
> > > On 06/28/2018 11:30 AM, Sudeep Holla wrote:
> > 
> > [...]
> > 
> > > >I am not sure if we can ever guarantee that DT and ACPI will get the
> > > >same ids whatever counter we use as it depends on the order presented in
> > > >the firmware(DT or ACPI). So I am not for generating ids for core and
> > > >threads in that way.
> > > >
> > > >So I would like to keep it simple and just have this counters for
> > > >package ids as demonstrated in Shunyong's patch.
> > >
> > > So, currently on a non threaded system, the core id's look nice because they
> > > are just the ACPI ids. Its the package id's that look strange, we could just
> > > fix the package ids, but on threaded machines the threads have the nice acpi
> > > ids, and the core ids are then funny numbers. So, I suspect that is driving
> > > this as much as the strange package ids.
> > >
> > 
> > Yes, I know that and that's what made be look at topology_get_acpi_cpu_tag
> > For me, if the PPTT has valid ID, we should use that. Just becuase DT lacks
> > it and uses counter doesn't mean ACPI also needs to follow that.
> 
> AFAIK, a valid ACPI UID doesn't need to be something derivable directly
> from the hardware, so it's just as arbitrary as the CPU phandle that is
> in the DT cpu-map, i.e. DT *does* have an analogous leaf node integer.
>

Its platform specific, left to vendors to identify that. Are you referring
to reg property in DT for leaf nodes ? If so, that's MPIDR and is present
in ACPI MADT.

> >
> > I am sure some vendor will put valid UID and expect that to be in the
> > sysfs.
>
> I can't think of any reason that would be useful, especially when the
> UID is for a thread, which isn't even displayed by sysfs.
>

You are mixing MPIDR and UID here.

> > 
> > > (and as a side, I actually like the PE has a acpi id behavior, but for
> > > threads its being lost with this patch...)
> > > 
> > > Given i've seen odd package/core ids on x86s a few years ago, it never
> 
> So this inspired me to grep some x86 topology code. I found
> arch/x86/kernel/smpboot.c:topology_update_package_map(), which uses
> a counter to set the logical package id and Documentation/x86/topology.txt
> states
> 
> """
>   - cpuinfo_x86.logical_id:
> 
>     The logical ID of the package. As we do not trust BIOSes to enumerate the
>     packages in a consistent way, we introduced the concept of logical package
>     ID so we can sanely calculate the number of maximum possible packages in
>     the system and have the packages enumerated linearly.
> """
> 
> Which I see as x86 precedent for the consistency argument I made in my
> other reply.
> 

There are lots of things arm64 doesn't replicate x86. So I don't take that
as valid argument. It's a new feature, we can use APCI PPTT UID feature to
be consistent. I don't see counter being in anyway consistent.

Even PPTT could be generated in the firmware and the order is not consistent.
In which case the counter values in Linux might get things wrong while using
UID from the firmware can keep it consistent(e.g. sockets removed,..etc)

--
Regards,
Sudeep
