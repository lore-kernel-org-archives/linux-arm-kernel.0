From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 4 Dec 2012 14:41:59 +0200
Subject: [PATCH 5/5] ARM: tegra20: cpuidle: apply coupled cpuidle for
 powered-down mode
In-Reply-To: <50BCF4F8.60606@wwwdotorg.org>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-6-git-send-email-josephl@nvidia.com>
 <50BCF4F8.60606@wwwdotorg.org>
Message-ID: <20121204124159.GO19258@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> > @@ -258,6 +256,9 @@ int __init tegra20_cpuidle_init(void)
> 
> > +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> > +		dev->coupled_cpus = *cpu_online_mask;
> > +#endif
> 
> What if that changes; I assume couple cpuidle handles that by
> registering a notifier?
> 

Yes. see drivers/cpuidle/coupled.c:651

> Is there any way that the kernel can boot with only CPU 0 "plugged in",
> but later have the other CPU hotplugged in? In other words, should that
> hard-code a mask (3?) that describes the HW, rather than relying on the
> runtime hotplug status? (think about what happens when this idle code is
> moved into drivers/cpuidle/ and built as a module, and hence could be
> initialized with only 1 CPU hotplugged in).

Using the cpu_possible_mask might be a better idea. The only other user
of coupled cpuidle (OMAP4) also uses cpu_online_mask however.

Cheers,

Peter.
