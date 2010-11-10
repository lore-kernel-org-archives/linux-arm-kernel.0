From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 10 Nov 2010 21:13:21 +0530
Subject: [PATCH] ARM: Temporary fix for broken arch reboot
In-Reply-To: <1289397874.4513.54.camel@e102109-lin.cambridge.arm.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FAB9E@dbde02.ent.ti.com>
	<20101109131838.GF2869@n2100.arm.linux.org.uk>
	<1289320692.11461.21.camel@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D4FAE5C@dbde02.ent.ti.com>
	<20101110100617.GA23244@n2100.arm.linux.org.uk>
	<1289397874.4513.54.camel@e102109-lin.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D58A400@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Wednesday, November 10, 2010 7:35 PM
> To: Russell King - ARM Linux
> Cc: Shilimkar, Santosh; linux-arm-kernel at lists.infradead.org; Gadiyar,
> Anand
> Subject: Re: [PATCH] ARM: Temporary fix for broken arch reboot
> 
> On Wed, 2010-11-10 at 10:06 +0000, Russell King - ARM Linux wrote:
> > On Wed, Nov 10, 2010 at 11:25:21AM +0530, Shilimkar, Santosh wrote:
> > > > -----Original Message-----
> > > > From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> > > > Sent: Tuesday, November 09, 2010 10:08 PM
> > > > To: Russell King - ARM Linux
> > > > Cc: Shilimkar, Santosh; linux-arm-kernel at lists.infradead.org;
> Gadiyar,
> > > > Anand
> > > > Subject: Re: [PATCH] ARM: Temporary fix for broken arch reboot
> > > >
> > > > On Tue, 2010-11-09 at 13:18 +0000, Russell King - ARM Linux wrote:
> > > > > On Tue, Nov 09, 2010 at 06:40:39PM +0530, Shilimkar, Santosh
> wrote:
> > > > > > With commit 3d3f78d752bf, reboot seems to broken on ARM
> > > > > > machines. CPU dies while doing flush_pmd_entry() as part of
> > > > > > setup_mm_for_reboot()
> > > >
> > > > What do you mean by 'dies'? Can you still connect with a debugger or
> it
> > > > got to some weird state?
> > > >
> > > It goes to some weird state. Basically the emulation connection dies,
> > > and debugger gets disconnected.
> > >
> > > > > > I know this is not the fix but intention is to report the
> > > > > > issue and also provide temporary fix till it get fixed correctly
> > > > >
> > > > > So you're now rebooting with the secondary CPUs still running.  I
> guess
> > > > > that the secondary CPUs end up crashing and don't restart.
> > > > >
> > > > > I think more the question is why the CP15 cache clean/flush is
> hanging
> > > > > with the other CPUs taken down.  All the other CPUs will be doing
> is
> > > > > sitting in a loop doing nothing.
> > > >
> > > > I can't think of anything. Did the other CPUs print 'stopping'?
> > > No it doesn't not print anything.
> >
> > The processing of the IPI is asynchronous to the CPU which is rebooting
> > continuing - which means that if there is some kind of bus lockup, you
> > won't get anything from any of the CPUs.
> 
> The printing only happens for SYSTEM_BOOTING or SYSTEM_RUNNING. I
> suspect in this case we have SYSTEM_RESTARTING and the condition in
> ipi_cpu_stop() is false, therefore no printing. It may be worth putting
> some printks outside the 'if' to see whether the secondary CPUs get
> there.
> 
While doing some experiments on this issue, one interesting
observation I made. Looks like there is race between two
Cores which makes system behave badly in reboot path.

Just adding a delay in the ipi_cpu_stop() makes the reboot work
as well

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8c19595..f7dadbf 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -526,6 +526,8 @@ static void ipi_cpu_stop(unsigned int cpu)
                spin_unlock(&stop_lock);
        }

+       udelay(500);
+
        set_cpu_online(cpu, false);

        local_fiq_disable();

Regards,
Santosh
