From: geoff@infradead.org (Geoff Levand)
Date: Tue, 13 May 2014 15:27:23 -0700
Subject: [PATCH 6/8] arm64/kexec: kexec needs cpu_die
In-Reply-To: <20140509082439.GC4757@e106331-lin.cambridge.arm.com>
References: <cover.1399594544.git.geoff@infradead.org>
 <4408c92fbc8f2f2a81054b9f2ac38331562e658a.1399594544.git.geoff@infradead.org>
 <20140509082439.GC4757@e106331-lin.cambridge.arm.com>
Message-ID: <1400020043.11178.72.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 2014-05-09 at 09:24 +0100, Mark Rutland wrote:
> Hi Geoff,
> 
> On Fri, May 09, 2014 at 01:48:17AM +0100, Geoff Levand wrote:
> > Kexec uses the cpu_die method of struct cpu_operations, so add
> > defined(CONFIG_KEXEC) to the preprocessor conditional that enables cpu_die.
> 
> Why not make kexec depend on !CONFIG_SMP || CONFIG_HOTPLUG_CPU instead?
> 
> From the POV of the PSCI code in the kernel, it's hotplugging a CPU. Why
> it's performing the hotplug operation shouldn't matter.

Sure.

> > @@ -284,7 +284,7 @@ const struct cpu_operations cpu_psci_ops = {
> >  	.cpu_init	= cpu_psci_cpu_init,
> >  	.cpu_prepare	= cpu_psci_cpu_prepare,
> >  	.cpu_boot	= cpu_psci_cpu_boot,
> > -#ifdef CONFIG_HOTPLUG_CPU
> > +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
> >  	.cpu_disable	= cpu_psci_cpu_disable,
> >  	.cpu_die	= cpu_psci_cpu_die,
> >  #endif
> 
> Doesn't his cause the build to fail when KEXEC && !HOTPLUG_CPU? I didn't
> see cpu_ops.h updated similarly.

Sorry, that part got lost when rebasing patches.  I added back in on my
for-arm-kexec-2 and master branches.

-Geoff
