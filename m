From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 28 Jun 2014 01:27:58 +0200
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <53ADAA1C.70407@ti.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53ADAA1C.70407@ti.com>
Message-ID: <20140627232757.GB26184@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 01:30:04PM -0400, Santosh Shilimkar wrote:
> +Arnd, Greg, Catalin and Kumar,
> 
> On Friday 27 June 2014 12:58 PM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > These drivers are closely coupled and need to be moved as a whole. One
> > reason for moving them out of arch/arm/mach-tegra is to allow them to be
> > shared with 64-bit ARM.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  arch/arm/mach-tegra/Makefile                       | 32 --------
> >  arch/arm/mach-tegra/common.h                       |  4 -
> >  arch/arm/mach-tegra/io.c                           | 27 +++++-
> >  arch/arm/mach-tegra/pmc.h                          | 62 --------------
> >  arch/arm/mach-tegra/tegra.c                        |  9 --
> >  drivers/soc/Makefile                               |  1 +
> >  drivers/soc/tegra/Makefile                         | 34 ++++++++
> >  .../soc/tegra}/cpuidle-tegra114.c                  |  0
> >  .../soc/tegra}/cpuidle-tegra20.c                   |  6 +-
> >  .../soc/tegra}/cpuidle-tegra30.c                   |  0
> >  .../arm/mach-tegra => drivers/soc/tegra}/cpuidle.c |  0
> >  .../arm/mach-tegra => drivers/soc/tegra}/cpuidle.h |  3 -
> >  .../mach-tegra => drivers/soc/tegra}/flowctrl.c    |  0
> >  .../mach-tegra => drivers/soc/tegra}/flowctrl.h    |  2 -
> >  .../arm/mach-tegra => drivers/soc/tegra}/headsmp.S |  0
> >  .../arm/mach-tegra => drivers/soc/tegra}/hotplug.c |  0
> >  {arch/arm/mach-tegra => drivers/soc/tegra}/iomap.h |  0
> >  .../arm/mach-tegra => drivers/soc/tegra}/irammap.h |  0
> >  {arch/arm/mach-tegra => drivers/soc/tegra}/irq.c   |  1 -
> >  {arch/arm/mach-tegra => drivers/soc/tegra}/irq.h   |  6 --
> >  .../arm/mach-tegra => drivers/soc/tegra}/platsmp.c |  5 --
> >  .../mach-tegra => drivers/soc/tegra}/pm-tegra20.c  |  0
> >  .../mach-tegra => drivers/soc/tegra}/pm-tegra30.c  |  0
> >  {arch/arm/mach-tegra => drivers/soc/tegra}/pm.c    |  0
> >  {arch/arm/mach-tegra => drivers/soc/tegra}/pm.h    |  4 +-
> >  {arch/arm/mach-tegra => drivers/soc/tegra}/pmc.c   |  0
> >  drivers/soc/tegra/pmc.h                            | 35 ++++++++
> >  .../mach-tegra => drivers/soc/tegra}/powergate.c   |  0
> >  .../soc/tegra}/reset-handler.S                     |  0
> >  {arch/arm/mach-tegra => drivers/soc/tegra}/reset.c |  0
> >  {arch/arm/mach-tegra => drivers/soc/tegra}/reset.h |  2 -
> >  .../soc/tegra}/sleep-tegra20.S                     |  0
> >  .../soc/tegra}/sleep-tegra30.S                     |  0
> >  {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.S |  0
> >  {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.h |  2 -
> >  include/linux/tegra-soc.h                          | 95 ++++++++++++++++++++++
> >  36 files changed, 195 insertions(+), 135 deletions(-)
> >  delete mode 100644 arch/arm/mach-tegra/common.h
> >  delete mode 100644 arch/arm/mach-tegra/pmc.h
> >  create mode 100644 drivers/soc/tegra/Makefile
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra114.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra20.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra30.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.h (91%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/flowctrl.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/flowctrl.h (98%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/headsmp.S (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/hotplug.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/iomap.h (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/irammap.h (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/irq.c (99%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/irq.h (83%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/platsmp.c (98%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm-tegra20.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm-tegra30.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm.h (94%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/pmc.c (100%)
> >  create mode 100644 drivers/soc/tegra/pmc.h
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/powergate.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset-handler.S (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.h (97%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep-tegra20.S (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep-tegra30.S (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.S (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.h (98%)
> > 
> NAK for this patch.
> 
> You are using drivers/soc/* as a dump yard for your SOC code which
> is not the intention we created drivers/soc/.

That was not my intention. What remains in arch/arm/mach-tegra at this
point doesn't actually have a corresponding subsystem (well, except
maybe the cpuidle code).

> Its really for subsystem drivers which doesn't have appropriate
> home in Linux kernel today. From your above patch ...
> 
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra114.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra20.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra30.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.h (91%)
> This should go into drivers/idle/*. if you have dependencies, please sort
> them out.

What exactly is the difference between drivers/idle and drivers/cpuidle?
There's an intel_idle driver in drivers/idle that includes cpuidle.h and
registers with that subsystem. But there's also an i7300_idle driver
that doesn't.

drivers/cpuidle seems like a better fit. I'll look into moving the code
there.

> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset-handler.S (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.c (100%)
> >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.h (97%)
> subsystem: drivers/power/reset/

drivers/power/reset seems to be for drivers that register functions to
reset a board. The above code for Tegra doesn't do that. Rather it sets
up the reset handlers for secondary CPUs and for suspend/resume.

> For tegra/*pm*/, you can use drivers/power or drivers/base/power/

drivers/power seems to be exclusively battery charger drivers. The pm.c,
pm-*.c and sleep-*.S set up suspend/resume. That doesn't seem to belong
in drivers/base/power either.

pmc.c implements various routines to access the power management
controller, some of which is needed by suspend/resume, some of it is
needed by SMP. powergate.c implements a subset of the PMC that needs to
be exported to drivers to enable power partitions on the SoC. I'm not
aware of subsystems that deal with this kind of driver.

> For SMP boot, ARMv8 expecting to have either PSCI based implementation or
> device tree based boot scheme. you can move towards that model if possible.

But we also have the code for SMP on 32-bit ARM. Should that remain in
arch/arm/mach-tegra or can it move to drivers/soc/tegra?

So the only thing in the above that I think could be moved somewhere
else is the cpuidle drivers. Or do you have any other suggestions for
the remaining code?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140628/e7cc45f2/attachment.sig>
