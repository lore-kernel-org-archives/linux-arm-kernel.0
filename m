From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 30 Jun 2014 11:25:12 +0100
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <20140627232757.GB26184@ulmo>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53ADAA1C.70407@ti.com> <20140627232757.GB26184@ulmo>
Message-ID: <20140630102512.GE28951@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 12:27:58AM +0100, Thierry Reding wrote:
> On Fri, Jun 27, 2014 at 01:30:04PM -0400, Santosh Shilimkar wrote:
> > On Friday 27 June 2014 12:58 PM, Thierry Reding wrote:
> > >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra114.c (100%)
> > >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra20.c (100%)
> > >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra30.c (100%)
> > >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.c (100%)
> > >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.h (91%)
> > This should go into drivers/idle/*. if you have dependencies, please sort
> > them out.
> 
> What exactly is the difference between drivers/idle and drivers/cpuidle?
> There's an intel_idle driver in drivers/idle that includes cpuidle.h and
> registers with that subsystem. But there's also an i7300_idle driver
> that doesn't.
> 
> drivers/cpuidle seems like a better fit. I'll look into moving the code
> there.

Actually, please look at Lorenzo's generic cpuidle series. Basically
most cpuidle drivers simply define some C states and call the
corresponding platform back-end. On arm64, we aim to separate the
back-end in the cpu_operations structure and just have a generic cpuidle
driver with states defined in the DT (and passed to the back-end).

As for the back-end, what about using PSCI?

> > >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset-handler.S (100%)
> > >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.c (100%)
> > >  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.h (97%)
> > subsystem: drivers/power/reset/
> 
> drivers/power/reset seems to be for drivers that register functions to
> reset a board. The above code for Tegra doesn't do that. Rather it sets
> up the reset handlers for secondary CPUs and for suspend/resume.

PSCI again?

-- 
Catalin
