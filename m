From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 17 Jul 2018 17:06:53 +0200
Subject: [PATCH v3 5/7] arm64: smp: remove cpu and numa topology
 information when hotplugging out CPU
In-Reply-To: <20180717140536.GA27323@e107155-lin>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
 <1530874968-5960-6-git-send-email-sudeep.holla@arm.com>
 <CAMuHMdXw9My+P1UCJ19Qdjq4O9gY_0QVFZaw6C5Ytmpyac59Vw@mail.gmail.com>
 <20180717140536.GA27323@e107155-lin>
Message-ID: <CAMuHMdUnL=XyoSfRU+ebVUjsiP89V4vcoN=O4xc0VwHmLP72HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Tue, Jul 17, 2018 at 4:05 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Tue, Jul 17, 2018 at 02:58:14PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Jul 6, 2018 at 1:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > We already repopulate the information on CPU hotplug-in, so we can safely
> > > remove the CPU topology and NUMA cpumap information during CPU hotplug
> > > out operation. This will help to provide the correct cpumask for
> > > scheduler domains.
> > >
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > > Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > This is now commit 7f9545aa1a91a9a4 ("arm64: smp: remove cpu and numa
> > topology information when hotplugging out CPU") in arm64/for-next/core, to
> > which I bisected a PSCI checker regression on systems with two CPU clusters.
> >
> > Dmesg on R-Car H3 (4xCA57+4xCA53) before/after:
> >
> >      psci_checker: PSCI checker started using 8 CPUs
> >
> > 8 CPU cores detected.
> >
> >      psci_checker: Starting hotplug tests
> >      psci_checker: Trying to turn off and on again all CPUs
> >      CPU1: shutdown
> >      psci: CPU1 killed.
> >      CPU2: shutdown
> >      psci: CPU2 killed.
> >     -NOHZ: local_softirq_pending 55
> >      CPU3: shutdown
> >      psci: CPU3 killed.
> >     -NOHZ: local_softirq_pending 51
> >      CPU4: shutdown
> >      psci: CPU4 killed.
> >      NOHZ: local_softirq_pending 55
> >      CPU5: shutdown
> >      psci: CPU5 killed.
> >      NOHZ: local_softirq_pending 55
> >      CPU6: shutdown
> >      psci: CPU6 killed.
> >      NOHZ: local_softirq_pending 55
> >      CPU7: shutdown
> >      psci: CPU7 killed.
> >      Detected PIPT I-cache on CPU1
> >      CPU1: Booted secondary processor 0x0000000001 [0x411fd073]
> >      Detected PIPT I-cache on CPU2
> >      CPU2: Booted secondary processor 0x0000000002 [0x411fd073]
> >      Detected PIPT I-cache on CPU3
> >      CPU3: Booted secondary processor 0x0000000003 [0x411fd073]
> >      Detected VIPT I-cache on CPU4
> >      CPU4: Booted secondary processor 0x0000000100 [0x410fd034]
> >      cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 1198080 KHz
> >      cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed to: 1200000 KHz
> >      Detected VIPT I-cache on CPU5
> >      CPU5: Booted secondary processor 0x0000000101 [0x410fd034]
> >      Detected VIPT I-cache on CPU6
> >      CPU6: Booted secondary processor 0x0000000102 [0x410fd034]
> >      Detected VIPT I-cache on CPU7
> >      CPU7: Booted secondary processor 0x0000000103 [0x410fd034]
> >
> > All but CPU0 tested, as expected.
>
> OK, does the firmware on this system not allow CPU0 to be hotplugged out ?

Correct. But that's not the issue.

> >     psci_checker: Trying to turn off and on again group 0 (CPUs 0-3)
> >
> > 4 big CPU cores detected.
> >
> >      CPU1: shutdown
> >      psci: CPU1 killed.
> >     -NOHZ: local_softirq_pending 55
> >     +NOHZ: local_softirq_pending 51
> >      CPU2: shutdown
> >      psci: CPU2 killed.
> >      NOHZ: local_softirq_pending 51
> >      CPU3: shutdown
> >      psci: CPU3 killed.
> >      Detected PIPT I-cache on CPU1
> >      CPU1: Booted secondary processor 0x0000000001 [0x411fd073]
> >      Detected PIPT I-cache on CPU2
> >      CPU2: Booted secondary processor 0x0000000002 [0x411fd073]
> >      Detected PIPT I-cache on CPU3
> >      CPU3: Booted secondary processor 0x0000000003 [0x411fd073]
> >
> > All but CPU0 tested, as expected.
> >
> >     psci_checker: Trying to turn off and on again group 1 (CPUs 4-7)
> >
> > 4 LITTLE CPU cores detected.
> >
> >      CPU4: shutdown
> >      psci: CPU4 killed.
> >      NOHZ: local_softirq_pending 55
> >     -CPU5: shutdown
> >     -psci: CPU5 killed.
> >     -NOHZ: local_softirq_pending 55
> >     -CPU6: shutdown
> >     -psci: CPU6 killed.
> >     -NOHZ: local_softirq_pending 55
> >     -CPU7: shutdown
> >     -psci: CPU7 killed.
> >      Detected VIPT I-cache on CPU4
> >      CPU4: Booted secondary processor 0x0000000100 [0x410fd034]
> >     -cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 1198080 KHz
> >     -cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed to: 1200000 KHz
> >     -Detected VIPT I-cache on CPU5
> >     -CPU5: Booted secondary processor 0x0000000101 [0x410fd034]
> >     -Detected VIPT I-cache on CPU6
> >     -CPU6: Booted secondary processor 0x0000000102 [0x410fd034]
> >     -Detected VIPT I-cache on CPU7
> >     -CPU7: Booted secondary processor 0x0000000103 [0x410fd034]
> >
> > Woops, CPU5-7 are not tested.
>
> I don't understand what you mean by that. From the logs, it looks fine.
> What do you mean by "CPU5-7 are not tested" ?
> Sorry, but I am finding it hard to understand the issue from the log.

The above is not the log, but the diff between the log before and after the bad
commit. So lines prefixed with "-" are no longer printed.
Before, CPU4-7 were tested for hotplug in group 1.
After, only CPU4 is tested for hotplug in group 1.

> Also, it would be good to know your config. Is it defconfig - NUMA as before ?

arm64 defconfig + CONFIG_ARM_PSCI_CHECKER=y should do.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
