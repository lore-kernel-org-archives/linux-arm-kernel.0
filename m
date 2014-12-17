From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 17 Dec 2014 14:04:04 +0000
Subject: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <549181F0.3010408@linaro.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <2519415.GklIQeMgWR@wuerfel> <54903DC6.8010308@linaro.org>
 <2663853.2Q3kHisMT7@wuerfel> <549181F0.3010408@linaro.org>
Message-ID: <20141217140404.GB11998@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 01:15:28PM +0000, Daniel Lezcano wrote:

[...]

> > I would assume that the same can be done for most other platforms.
> >
> > There are probably cases where the same piece of hardware is responsible
> > for both cpuidle and cpufreq, but what that means is really that you
> > should have a single driver for it that does both things. Same for
> > SMP support: if you have one register block that does both the SMP
> > bringup and the cpuidle stuff, then have *one* driver for this block
> > that does it all. There are currently a few dependencies that require
> > doing SMP bringup early during boot, but we decided years ago that those
> > are all artificial dependencies and we should be able to boot secondary
> > CPUs much later than we currently do.
> 
> I agree with this point and given the number of drivers, the easiest way 
> to do that is to create cpu pm ops as I gave in the previous email and 
> reuse them for cpu hotplug/bringup. And I believe that is possible if we 
> continue our approach by splitting the low level pm code from the 
> cpuidle driver.
> 
> What about doing something simple ? Like creating a struct 
> arm_cpu_pm_ops variable visible from everywhere and filled by the 
> different platform ?

I agree with this approach, which by the way consists in defining
cpu operations as ARM64 does and use those from cpuidle, suspend and
hotplug code. The MCPM interface does that already, probably we should
enhance/rename it since people think it must be used for multicluster
power management whereas it is a pretty generic [drivers -> mach] code
interface (I am talking about the API, not the synchronization scheme),
and can certainly be extended/refactored according to new platforms need.

Thanks,
Lorenzo
