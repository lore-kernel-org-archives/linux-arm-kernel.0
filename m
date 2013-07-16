From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 16 Jul 2013 19:17:27 +0800
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <51E439BC.9030608@wwwdotorg.org>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
 <51E439BC.9030608@wwwdotorg.org>
Message-ID: <1373973447.8538.80.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-16 at 02:04 +0800, Stephen Warren wrote:
> On 06/25/2013 03:23 AM, Joseph Lo wrote:
> > Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
> > to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
> > this state.
> 
> I tried applying this patch, your series "[PATCH V3 0/3] ARM: tegra114:
> cpuidle: add power down state", and your series "[PATCH V2 00/11] ARM:
> tegra114: add support for system suspend", all on top of v3.11-rc1.
> 
> On Dalmore, the new cpuidle mode /appears/ to work (I see increasing
> values in the sysfs cpuidle "usage" file for all defined cpuidle
> states), but I don't see the "CPU VDD off" LED light up; I'm not
> convinced that the CPU is actually being powered off in the idle mode.
> 
The LED of the CPU Vdd indicates the power of CPU cluster. But the
series of CPU idle power down mode support for Tegra114 only supports
per core power down. It did not support cluster power down yet in idle
mode. That needs some extra work to support cluster power down in idle
mode.
There are some items that I plat to do:
1. integrate the MCPM (multi cluster power management) code into Tegra
CPU PM code
2. integrate coupled CPUidle framework into Tegra CPU idle driver
3. normalize the Tegra CPU idle driver to single one

> With these patches applies, Harmony acts very strangely. After
> hot-unplug and re-plug of CPU1, the system is hung or almost hung. The
> patches appear to reduce the amount of time CPU VDD is off judging by
> the LEDs. The patches might cause issues with system suspend too, but
> I'm not 100% sure.
> 
Actually I didn't add anything about hotplug or something can increase
the loading or make regressions. But I think you are testing with USB
device attached, right? That might cause some extra loading. You can
give it a try after just removing USB device. And I double confirm that
on Seaboard. Except that, the test result looks OK for me.

> As such, I haven't applied any of these. Can you please test boards for
> all of Tegra20/30/114, and validate that on Dalmore the CPU power is
> actually being turned off, and report back? Thanks.

I have tested all these patches based on next-20130716. And verified the
functions on Seaboard, Cardhu and Dalmore. Looks good for me. And the
per core power down in idle is OK too. The cluster power down only
support when the system goes into suspend mode right now for Tegra114.

Thanks,
Joseph
