From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 17 Jan 2013 10:35:21 +0800
Subject: [PATCH V4 5/5] ARM: tegra20: cpuidle: apply coupled cpuidle
 for powered-down mode
In-Reply-To: <CAMbhsRQpEE_bkLTZCKno_kDAHh5ggXm6qBSJ91K+ezqwoCsY5A@mail.gmail.com>
References: <1358323873-30525-1-git-send-email-josephl@nvidia.com>
 <CAMbhsRTmGVrjnKa_z+zonGypU+U4r2iE=D-Zfvyoq8chY68QKQ@mail.gmail.com>
 <1358388332.1667.7.camel@jlo-ubuntu-64.nvidia.com>
 <CAMbhsRQpEE_bkLTZCKno_kDAHh5ggXm6qBSJ91K+ezqwoCsY5A@mail.gmail.com>
Message-ID: <1358390121.1667.33.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-01-17 at 10:32 +0800, Colin Cross wrote:
> On Wed, Jan 16, 2013 at 6:05 PM, Joseph Lo <josephl@nvidia.com> wrote:
> > On Thu, 2013-01-17 at 02:55 +0800, Colin Cross wrote:
> >> On Wed, Jan 16, 2013 at 12:11 AM, Joseph Lo <josephl@nvidia.com> wrote:
> >> > The "powered-down" cpuidle mode of Tegra20 needs the CPU0 be the last one
> >> > core to go into this mode before other core. The coupled cpuidle framework
> >> > can help to sync the MPCore to coupled state then go into "powered-down"
> >> > idle mode together. The driver can just assume the MPCore come into
> >> > "powered-down" mode at the same time. No need to take care if the CPU_0
> >> > goes into this mode along and only can put it into safe idle mode (WFI).
> >> >
> >> > The powered-down state of Tegra20 requires power gating both CPU cores.
> >> > When the secondary CPU requests to enter powered-down state, it saves
> >> > its own contexts and then enters WFI for waiting CPU0 in the same state.
> >> > When the CPU0 requests powered-down state, it attempts to put the secondary
> >> > CPU into reset to prevent it from waking up. Then power down both CPUs
> >> > together and power off the cpu rail.
> >> >
> >> > Be aware of that, you may see the legacy power state "LP2" in the code
> >> > which is exactly the same meaning of "CPU power down".
> >> >
> >> > Based on the work by:
> >> > Colin Cross <ccross@android.com>
> >> > Gary King <gking@nvidia.com>
> >> >
> >> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> >> > ---
> >> > V4:
> >> > * rename the function to "tegra20_wake_cpu1_from_reset"
> >> > * make the coupled cpuidle can be disabled if SMP is disabled
> >> > V3:
> >> > * sqash last two patch in previous version to support coupled cpuidle
> >> >   directly
> >> > V2:
> >> > * refine the cpu control function that dedicate for CPU_1
> >> > * rename "tegra_cpu_pllp" to "tegra_switch_cpu_to_pllp"
> >> > ---
> >>
> >> <snip>
> >>
> >> > diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
> >> > index 50f984d..63ab9c2 100644
> >> > --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
> >> > +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
> >>
> >> <snip>
> >>
> >> > @@ -87,20 +176,31 @@ static inline bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
> >> >  }
> >> >  #endif
> >> >
> >> > -static int tegra20_idle_lp2(struct cpuidle_device *dev,
> >> > -                           struct cpuidle_driver *drv,
> >> > -                           int index)
> >> > +static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
> >> > +                                   struct cpuidle_driver *drv,
> >> > +                                   int index)
> >> >  {
> >> >         u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
> >> >         bool entered_lp2 = false;
> >> >
> >> > +       if (tegra_pending_sgi())
> >> > +               atomic_inc(&abort_flag);
> >> Minor nit, this doesn't need to be atomic.  You could just use
> >> abort_flag = true, or ACCESS_ONCE(abort_flag) = true.  Each cpu will
> >> either not touch this variable or write 1 to it, so there is no
> >> read/modify/write race.
> >>
> > Thanks for your remind. There is a reason I don't use a boolean flag
> > here. The SGI register was per CPU register. Different CPU may get
> > different content of the register depend on there is a SGI pending or
> > not. That's why I don't use a boolean flag that may be overwritten by
> > the other CPU here.
> >
> > So I think I can just modify as follows and remove atomic operation.
> >
> >         if (tegra_pending_sgi())
> >                 abort_flag++;
> >
> >         if (abort_flag > 0)
> >                 abort coupled cpuidle;
> 
> abort_flag++ is a bad idea, it will do a read-modify-write on the
> variable, and two concurrent read-modify-writes will not result in the
> correct value.
> 
> In this case you don't care about counting how many cpus have sgis,
> you just care if any cpu does.  ACCESS_ONCE(abort_flag) = true will
> work fine, because cpus that do not have a pending sgi will not set
> the variable to false.

Ah, yes. You are right.

Thanks,
Joseph
