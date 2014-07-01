From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 1 Jul 2014 16:02:16 -0400 (EDT)
Subject: [PATCH v2] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <20140701135037.GB7023@e102568-lin.cambridge.arm.com>
References: <1403780312-22885-1-git-send-email-a.kesavan@samsung.com>
 <1404152927-11168-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1407010012150.16842@knanqh.ubzr>
 <CAM4voama9omO4=x2+GaQesLQOh+5U2q8FQSe4+VwA0_4pOukkg@mail.gmail.com>
 <20140701135037.GB7023@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1407011556530.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Jul 2014, Lorenzo Pieralisi wrote:

> On Tue, Jul 01, 2014 at 02:14:49PM +0100, Abhilash Kesavan wrote:
> > Hi Nicolas,
> > 
> > On Tue, Jul 1, 2014 at 9:49 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > On Mon, 30 Jun 2014, Abhilash Kesavan wrote:
> > >
> > >> Use the MCPM layer to handle core suspend/resume on Exynos5420.
> > >> Also, restore the entry address setup code post-resume.
> > >>
> > >> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > >> ---
> > > [...]
> > >
> > > Could you tell me more about this?
> > >
> > >> @@ -150,7 +153,13 @@ static void exynos_power_down(void)
> > >>       BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
> > >>       cpu_use_count[cpu][cluster]--;
> > >>       if (cpu_use_count[cpu][cluster] == 0) {
> > >> -             exynos_cpu_power_down(cpunr);
> > >> +             /*
> > >> +              * Bypass power down for CPU0 during suspend. This is being
> > >> +              * taken care by the SYS_PWR_CFG bit in CORE0_SYS_PWR_REG.
> > >> +              */
> > >> +             if ((cpunr != 0) ||
> > >> +             (__raw_readl(pmu_base_addr + S5P_INFORM1) != S5P_CHECK_SLEEP))
> > >> +                     exynos_cpu_power_down(cpunr);
> > >
> > > What happens if CPU0 is the first in the cluster to be idled?  Will it
> > > remain powered up until all the others have gone idle too?
> > This check is only for handling the S2R CPU0 case. In case of
> > idle/switching the S5P_CHECK_SLEEP flag would not be set and hence
> > there would be no change in behavior for them.
> > During suspend, we enable the ARM_USE_STANDBY_WFI0 bit which tells the
> > PMU when the CPU0 is ready to be suspended. This in conjunction with
> > the sleep state core configuration (setting SYS_PWR_REG low) causes
> > the CPU0 to go down. We should not write to the CPU0 power
> > configuration register (exynos_cpu_power_down) along with this during
> > suspend.
> 
> I think this should be part of a refactoring that includes the exynos MCPM
> suspend call parameters. In particular, at the moment there is no code in
> the back-end to detect if the last man should request core gating or cluster
> gating (ie last man _always_ request cluster gating, that might not be what
> we want), there is the residency value that can be also be used to imply a
> S2R request (eg residency = ~0 ?).
> 
> The command sent must be implied by the state that is entered, not by
> peeking at registers that should contain magic values, and that's true
> not only for exynos but for all ARM platforms out there.
> 
> What I mean is: we can pass the requested state as a suspend parameter
> and the power_down state machine will send the required command
> accordingly.
> 
> It can be done using the residency value or by passing the power state "index"
> as suspend parameter, the power down MCPM code will do a look-up and send
> the respective command.
> 
> Thoughts appreciated.

I agree.  Having the MCPM abstraction having to rely on some magic value 
to be set in a register beforehand for things to work properly is not 
nice.


Nicolas
