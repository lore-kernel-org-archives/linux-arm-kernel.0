From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 17:15:55 +0000
Subject: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
	speed-up boot
In-Reply-To: <4D399F74.9050302@gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
	<4D385155.4050301@gmail.com>
	<43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
	<4D38641E.2000301@gmail.com>
	<c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
	<4D399F74.9050302@gmail.com>
Message-ID: <20110121171555.GB30823@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 09:00:04AM -0600, Rob Herring wrote:
> Why? If preset_lpj is non-zero, calibrate_delay will effectively be  
> skipped which is the same thing your patch does.

Theoretically...

You boot.  lpj= sets preset_lpj.  calibrate_delay() sets loops_per_jiffy
based on preset_lpj which happens to match the boot CPU speed correctly.

cpufreq initializes, changes the CPU frequency.  loops_per_jiffy is
scaled for the new CPU clock rate.

You hot-unplug a CPU, and then hot-plug it back in.  calibrate_delay()
gets called again, and it again notices preset_lpj is set.  It copies
this value into loops_per_jiffy, overwriting it with what is now a
value which is completely wrong for the current CPU run rate.

> This is the cpfreq loops_per_jiffy adjustment function for SMP:
>
> static inline void adjust_jiffies(unsigned long val, struct  
> cpufreq_freqs *ci)
> {
> 	return;
> }

That means cpufreq scaling on SMP is broken then...  Why isn't cpufreq
marked with a !SMP dependence or something similar (eg, depends on
!SMP || CPU_INDEPENDENT_UDELAY)...  Maybe it should be.

> And delay.S uses the global loops_per_jiffy, not the per cpu value. The  
> only place I see the per cpu value get used is /proc/cpuinfo.
>
> Consider the following sequence:
>
> - scale down the cpu freq
> - hot unplug a core
> - hot plug a core
>   - calls calibrate_delay and update the global loops_per_jiffy
> - scale up the cpu freq
> - udelay time is now much too short!!!
>
> So for that reason, I would just remove calibrate_delay unconditionally.  
> Better to have the 1% inaccuracy and longer delays at low frequency than  
> to have too short of a delay at high freq.

As you've shown above, it makes not a blind bit of difference whether
calibrate_delay() is called... on SMP the loops_per_jiffy will be wrong
as soon as you start scaling no matter what.
