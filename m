From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 17:40:20 +0000
Subject: [PATCH] arm: kernel/perf_event_cpu.c: fix error null pointer
 dereference check
In-Reply-To: <20130114173826.GA917@gmail.com>
References: <1358183933-29160-1-git-send-email-dinggnu@gmail.com>
 <20130114172346.GK23505@n2100.arm.linux.org.uk>
 <20130114173826.GA917@gmail.com>
Message-ID: <20130114174020.GH31341@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 05:38:26PM +0000, Cong Ding wrote:
> On Mon, Jan 14, 2013 at 05:23:46PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 14, 2013 at 05:18:53PM +0000, Cong Ding wrote:
> > > the pointer cpu_pmu is used without null pointer dereference check, and is
> > > checked after the using of it, so we move the null pointer check to before the
> > > first use.
> > 
> > The NULL pointer check is not necessary.  cpu_pmu_init() is called
> > after cpu_pmu has already been dereferenced by its caller:
> > 
> >         cpu_pmu = pmu;
> >         cpu_pmu->plat_device = pdev;
> >         cpu_pmu_init(cpu_pmu);
> > 
> > So...
> > 
> > > -	/* Ensure the PMU has sane values out of reset. */
> > > -	if (cpu_pmu && cpu_pmu->reset)
> > 
> > Just replace this with:
> > 	if (cpu_pmu->reset)
> Thanks Russell, I will send version 2.

No need, I've taken this into my perf/updates branch.

Thanks,

Will
