From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 12 Nov 2010 16:01:25 +0530
Subject: [PATCH] ARM: Temporary fix for broken arch reboot
In-Reply-To: <20101110154604.GA27571@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FAB9E@dbde02.ent.ti.com>
	<20101109131838.GF2869@n2100.arm.linux.org.uk>
	<1289320692.11461.21.camel@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D4FAE5C@dbde02.ent.ti.com>
	<20101110100617.GA23244@n2100.arm.linux.org.uk>
	<1289397874.4513.54.camel@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D58A400@dbde02.ent.ti.com>
	<20101110154604.GA27571@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D58B003@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Wednesday, November 10, 2010 9:16 PM
> To: Shilimkar, Santosh
> Cc: Catalin Marinas; linux-arm-kernel at lists.infradead.org; Gadiyar, Anand
> Subject: Re: [PATCH] ARM: Temporary fix for broken arch reboot
> 
> On Wed, Nov 10, 2010 at 09:13:21PM +0530, Shilimkar, Santosh wrote:
> >
> >
> > > -----Original Message-----
> > > From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> > > Sent: Wednesday, November 10, 2010 7:35 PM
> > > To: Russell King - ARM Linux
> > > Cc: Shilimkar, Santosh; linux-arm-kernel at lists.infradead.org; Gadiyar,
> > > Anand
> > > Subject: Re: [PATCH] ARM: Temporary fix for broken arch reboot
> > >
> > > The printing only happens for SYSTEM_BOOTING or SYSTEM_RUNNING. I
> > > suspect in this case we have SYSTEM_RESTARTING and the condition in
> > > ipi_cpu_stop() is false, therefore no printing. It may be worth
> putting
> > > some printks outside the 'if' to see whether the secondary CPUs get
> > > there.
> > >
> > While doing some experiments on this issue, one interesting
> > observation I made. Looks like there is race between two
> > Cores which makes system behave badly in reboot path.
> >
> > Just adding a delay in the ipi_cpu_stop() makes the reboot work
> > as well
> 
> That could just be that it's taking longer than 500us for the reboot CPU
> to get through setup_mm_for_reboot().

It not seems to be the case otherwise below patch should have worked.
Right ? Did I miss your point ?

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index e76fcaa..c3ae1d6 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -103,6 +103,8 @@ void arm_machine_restart(char mode, const char *cmd)
         * soft boot works.
         */
        setup_mm_for_reboot(mode);
+
+       machine_shutdown();

        /* Clean and invalidate caches */
        flush_cache_all();
@@ -247,7 +249,6 @@ void machine_power_off(void)

 void machine_restart(char *cmd)
 {
-       machine_shutdown();
        arm_pm_restart(reboot_mode, cmd);
 }
