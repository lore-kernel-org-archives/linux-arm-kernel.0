From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 19 Dec 2012 11:47:36 +0800
Subject: [PATCH V3 1/5] ARM: tegra: add pending SGI checking API
In-Reply-To: <1355879172.4449.10.camel@jlo-ubuntu-64.nvidia.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <1355797861-12759-2-git-send-email-josephl@nvidia.com>
 <CAMbhsRSorDf-BebFn+t39zOK4VX4N0Fu0iPrM7XpKZcssTgX9A@mail.gmail.com>
 <20121218101548.GO19258@tbergstrom-lnx.Nvidia.com>
 <CAMbhsRSDwSoHoEs93NZhDchCS28-vQCuW2p+kqfNKeqLygL2sQ@mail.gmail.com>
 <1355879172.4449.10.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <1355888856.11949.19.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-12-19 at 09:06 +0800, Joseph Lo wrote:
> On Wed, 2012-12-19 at 03:36 +0800, Colin Cross wrote:
> > On Tue, Dec 18, 2012 at 2:15 AM, Peter De Schrijver
> > <pdeschrijver@nvidia.com> wrote:
> > > On Tue, Dec 18, 2012 at 03:42:24AM +0100, Colin Cross wrote:
> > >> On Mon, Dec 17, 2012 at 6:30 PM, Joseph Lo <josephl@nvidia.com> wrote:
> > >> > The "powered-down" CPU idle mode of Tegra cut off the vdd_cpu rail, it
> > >> > include the power of GIC. That caused the SGI (Software Generated
> > >> > Interrupt) been lost. Because the SGI can't wake up the CPU that in
> > >> > the "powered-down" CPU idle mode. We need to check if there is any
> > >> > pending SGI when go into "powered-down" CPU idle mode. This is important
> > >> > especially when applying the coupled cpuidle framework into "power-down"
> > >> > cpuidle dirver. Because the coupled cpuidle framework may have the
> > >> > chance that misses IPI_SINGLE_FUNC handling sometimes.
> > >>
> > >> This problem exists for any GIC-based SoC, and needs to be fixed in
> > >> gic_cpu_save or gic_dist_save, whichever one loses the interrupt.
> > >
> > > Not necessarily. It depends on the SoC design. On Tegra20, the entire CPU
> > > cluster is railgated, including the GIC. This causes a pending IPI to be lost.
> > > But for example on OMAP4, only the actual CPU cores are powergated. The GIC
> > > stays alive until also the core domain hits idle. By that time a potential
> > > pending IPI has long woken up the target CPU again, so no additional
> > > checks are needed for functional correct behavior.
> > 
> > I'm not sure that is correct for OMAP4.  C2 and C3 will put the power
> > rail for the GIC in retention, and I don't think an IPI will wake it
> > up.  I believe the same problem also exists for Exynos5.  In any case,
> > checking for an IPI early during idle and aborting won't hurt those
> > platforms, so I still think it should be in the GIC driver and not by
> > mapping the GIC registers into a separate driver.
> 
> If I move this code into common GIC driver, should I just take care
> pending SGI also?
> 
> I will try to create a RFC patch for this.
> 
Hi Colin,

I just checked the scenario to abort cpu_pm_enter when there is any
pending SGI. This may break the current CPU idle driver that already
using cpu_pm_enter. If these drivers didn't handle the error return of
"cpu_pm_enter", the error will cause the CPU_PM_ENTER_FAILED be
triggered. Then the idle code will fail.

The other solution may just like this patch did. Adding an API
"gic_pending_sgi" to check if there is a pending SGI before putting the
CPU into low power mode. But I still don't think this is a common code
to be put there. It's still SoC specific code. So I still prefer the
current solution in this patch for Tegra.

Thanks,
Joseph
