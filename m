From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 22 Jan 2011 13:14:21 +0530
Subject: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK
	tospeed-up boot
In-Reply-To: <20110121171555.GB30823@n2100.arm.linux.org.uk>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com><4D385155.4050301@gmail.com><43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com><4D38641E.2000301@gmail.com><c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com><4D399F74.9050302@gmail.com>
	<20110121171555.GB30823@n2100.arm.linux.org.uk>
Message-ID: <bccc6a7edf66bedd311bc869bfa89ae8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell King -
> ARM Linux
> Sent: Friday, January 21, 2011 10:46 PM
> To: Rob Herring
> Cc: linux-omap at vger.kernel.org; Santosh Shilimkar; Linus Walleij;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK
> tospeed-up boot
>
[...]

>
> That means cpufreq scaling on SMP is broken then...  Why isn't
> cpufreq
> marked with a !SMP dependence or something similar (eg, depends on
> !SMP || CPU_INDEPENDENT_UDELAY)...  Maybe it should be.
>
Actually it's not broken but documented to use arch specific
per-cpu lpj with cpufreq scaling. And that update cab be
managed by arch specific cpufreq code based on the way
CPUs scale. That's how other arch including x86 doing it.
And global lpj can be update as well there which is not
done at this moment.

> > And delay.S uses the global loops_per_jiffy, not the per cpu
> value. The
> > only place I see the per cpu value get used is /proc/cpuinfo.
> >
> > Consider the following sequence:
> >
> > - scale down the cpu freq
> > - hot unplug a core
> > - hot plug a core
> >   - calls calibrate_delay and update the global loops_per_jiffy
> > - scale up the cpu freq
> > - udelay time is now much too short!!!
> >
> > So for that reason, I would just remove calibrate_delay
> unconditionally.
> > Better to have the 1% inaccuracy and longer delays at low
> frequency than
> > to have too short of a delay at high freq.
>
> As you've shown above, it makes not a blind bit of difference
> whether
> calibrate_delay() is called... on SMP the loops_per_jiffy will be
> wrong
> as soon as you start scaling no matter what.
>
Surely whichever way we should remove the recalibration otherwise
every time secondary cpus spend ~ 200 ms there.

Russell,
How do you like to address this?

Regards,
Santosh
