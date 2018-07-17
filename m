From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 17 Jul 2018 14:58:14 +0200
Subject: [PATCH v3 5/7] arm64: smp: remove cpu and numa topology
 information when hotplugging out CPU
In-Reply-To: <1530874968-5960-6-git-send-email-sudeep.holla@arm.com>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
 <1530874968-5960-6-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAMuHMdXw9My+P1UCJ19Qdjq4O9gY_0QVFZaw6C5Ytmpyac59Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Fri, Jul 6, 2018 at 1:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> We already repopulate the information on CPU hotplug-in, so we can safely
> remove the CPU topology and NUMA cpumap information during CPU hotplug
> out operation. This will help to provide the correct cpumask for
> scheduler domains.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

This is now commit 7f9545aa1a91a9a4 ("arm64: smp: remove cpu and numa
topology information when hotplugging out CPU") in arm64/for-next/core, to
which I bisected a PSCI checker regression on systems with two CPU clusters.

Dmesg on R-Car H3 (4xCA57+4xCA53) before/after:

     psci_checker: PSCI checker started using 8 CPUs

8 CPU cores detected.

     psci_checker: Starting hotplug tests
     psci_checker: Trying to turn off and on again all CPUs
     CPU1: shutdown
     psci: CPU1 killed.
     CPU2: shutdown
     psci: CPU2 killed.
    -NOHZ: local_softirq_pending 55
     CPU3: shutdown
     psci: CPU3 killed.
    -NOHZ: local_softirq_pending 51
     CPU4: shutdown
     psci: CPU4 killed.
     NOHZ: local_softirq_pending 55
     CPU5: shutdown
     psci: CPU5 killed.
     NOHZ: local_softirq_pending 55
     CPU6: shutdown
     psci: CPU6 killed.
     NOHZ: local_softirq_pending 55
     CPU7: shutdown
     psci: CPU7 killed.
     Detected PIPT I-cache on CPU1
     CPU1: Booted secondary processor 0x0000000001 [0x411fd073]
     Detected PIPT I-cache on CPU2
     CPU2: Booted secondary processor 0x0000000002 [0x411fd073]
     Detected PIPT I-cache on CPU3
     CPU3: Booted secondary processor 0x0000000003 [0x411fd073]
     Detected VIPT I-cache on CPU4
     CPU4: Booted secondary processor 0x0000000100 [0x410fd034]
     cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 1198080 KHz
     cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed
to: 1200000 KHz
     Detected VIPT I-cache on CPU5
     CPU5: Booted secondary processor 0x0000000101 [0x410fd034]
     Detected VIPT I-cache on CPU6
     CPU6: Booted secondary processor 0x0000000102 [0x410fd034]
     Detected VIPT I-cache on CPU7
     CPU7: Booted secondary processor 0x0000000103 [0x410fd034]

All but CPU0 tested, as expected.

    psci_checker: Trying to turn off and on again group 0 (CPUs 0-3)

4 big CPU cores detected.

     CPU1: shutdown
     psci: CPU1 killed.
    -NOHZ: local_softirq_pending 55
    +NOHZ: local_softirq_pending 51
     CPU2: shutdown
     psci: CPU2 killed.
     NOHZ: local_softirq_pending 51
     CPU3: shutdown
     psci: CPU3 killed.
     Detected PIPT I-cache on CPU1
     CPU1: Booted secondary processor 0x0000000001 [0x411fd073]
     Detected PIPT I-cache on CPU2
     CPU2: Booted secondary processor 0x0000000002 [0x411fd073]
     Detected PIPT I-cache on CPU3
     CPU3: Booted secondary processor 0x0000000003 [0x411fd073]

All but CPU0 tested, as expected.

    psci_checker: Trying to turn off and on again group 1 (CPUs 4-7)

4 LITTLE CPU cores detected.

     CPU4: shutdown
     psci: CPU4 killed.
     NOHZ: local_softirq_pending 55
    -CPU5: shutdown
    -psci: CPU5 killed.
    -NOHZ: local_softirq_pending 55
    -CPU6: shutdown
    -psci: CPU6 killed.
    -NOHZ: local_softirq_pending 55
    -CPU7: shutdown
    -psci: CPU7 killed.
     Detected VIPT I-cache on CPU4
     CPU4: Booted secondary processor 0x0000000100 [0x410fd034]
    -cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 1198080 KHz
    -cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed
to: 1200000 KHz
    -Detected VIPT I-cache on CPU5
    -CPU5: Booted secondary processor 0x0000000101 [0x410fd034]
    -Detected VIPT I-cache on CPU6
    -CPU6: Booted secondary processor 0x0000000102 [0x410fd034]
    -Detected VIPT I-cache on CPU7
    -CPU7: Booted secondary processor 0x0000000103 [0x410fd034]

Woops, CPU5-7 are not tested.

    psci_checker: Hotplug tests passed OK


> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -279,6 +279,9 @@ int __cpu_disable(void)
>         if (ret)
>                 return ret;
>
> +       remove_cpu_topology(cpu);
> +       numa_remove_cpu(cpu);
> +
>         /*
>          * Take this CPU offline.  Once we clear this, we can't return,
>          * and we must not schedule until we're ready to give up the cpu.

A simple revert is not sufficient, as that causes

    watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [cpuhp/2:21]

Do you have an idea how to fix this?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
