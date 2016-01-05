From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jan 2016 12:51:42 +0000
Subject: [PATCH v3 2/2] ARM64: kernel: PSCI: move PSCI idle management
 code to drivers/firmware
In-Reply-To: <20160105123134.GA1821@red-moon>
References: <1445011379-8787-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1445011379-8787-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20160105105900.GT19062@n2100.arm.linux.org.uk>
 <20160105123134.GA1821@red-moon>
Message-ID: <20160105125142.GV19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 12:31:34PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Jan 05, 2016 at 10:59:01AM +0000, Russell King - ARM Linux wrote:
> > On Fri, Oct 16, 2015 at 05:02:59PM +0100, Lorenzo Pieralisi wrote:
> > > ARM64 PSCI kernel interfaces that initialize idle states and implement
> > > the suspend API to enter them are generic and can be shared with the
> > > ARM architecture.
> > > 
> > > To achieve that goal, this patch moves ARM64 PSCI idle management
> > > code to drivers/firmware, so that the interface to initialize and
> > > enter idle states can actually be shared by ARM and ARM64 arches
> > > back-ends.
> > > 
> > > The ARM generic CPUidle implementation also requires the definition of
> > > a cpuidle_ops section entry for the kernel to initialize the CPUidle
> > > operations at boot based on the enable-method (ie ARM64 has the
> > > statically initialized cpu_ops counterparts for that purpose); therefore
> > > this patch also adds the required section entry on CONFIG_ARM for PSCI so
> > > that the kernel can initialize the PSCI CPUidle back-end when PSCI is
> > > the probed enable-method.
> > > 
> > > On ARM64 this patch provides no functional change.
> > 
> > On ARM64, it causes build breakage though:
> > 
> > drivers/built-in.o: In function `psci_suspend_finisher':
> > arm_pmu.c:(.text+0xc6494): undefined reference to `cpu_resume'
> > arm_pmu.c:(.text+0xc6498): undefined reference to `cpu_resume'
> > drivers/built-in.o: In function `psci_cpu_suspend_enter':
> > arm_pmu.c:(.text+0xc66c0): undefined reference to `cpu_suspend'
> > 
> > The code which has been moved looks similar.  However, when it lived
> > in arch/arm64/kernel/psci.c, it was protected by
> > #ifdef CONFIG_HOTPLUG_CPU.  In its new location, there are no ifdefs
> > around it, and so if it gets built without CONFIG_ARM_CPU_SUSPEND on
> > ARM, or CONFIG_CPU_PM for ARM64, it will error out like the above.
> > 
> > As this is causing a regression, and I've now closed my tree, I will
> > be doing what I said yesterday: I'll be dropping this patch for this
> > merge window in order to stabilise my tree.  Sorry.
> 
> My bad, I apologise, I will likely have to add a config option to
> make sure cpu_{suspend/resume} code is compiled in (on both ARM/ARM64),
> thanks for spotting it.

On ARM, that option is CONFIG_ARM_CPU_SUSPEND - that option solely
controls whether cpu_suspend/resume are present.  ARM64 just needs
to adopt this, and use that to control the code which is built in
drivers/firmware/psci.c.

However, I don't think it's as simple as just adding that to ARM64,
as you need to be careful of the Kconfig dependencies.  For ARM,
this is:

Generic code:
- SUSPEND defaults to y, depends on ARCH_SUSPEND_POSSIBLE (which is set for
   any cpu_suspend enabled CPU.)
- PM_SLEEP if SUSPEND || HIBERNATE_CALLBACKS
ARM sets:
- CPU_PM if SUSPEND || CPU_IDLE.
- ARM_CPU_SUSPEND if PM_SLEEP || BL_SWITCHER || (ARCH_PXA && PM)

What this means is that CPU_PM is entirely independent of
ARM_CPU_SUSPEND.  One does not imply the other, so I think you need
to consider carefully what ifdef you need in drivers/firmware/psci.c.

This is why I think fixing this is not simple as it first looks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
