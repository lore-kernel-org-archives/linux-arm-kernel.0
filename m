From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 13:51:20 -0600
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <1373973447.8538.80.camel@jlo-ubuntu-64.nvidia.com>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
 <51E439BC.9030608@wwwdotorg.org>
 <1373973447.8538.80.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51E5A438.10004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 05:17 AM, Joseph Lo wrote:
> On Tue, 2013-07-16 at 02:04 +0800, Stephen Warren wrote:
>> On 06/25/2013 03:23 AM, Joseph Lo wrote:
>>> Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
>>> to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
>>> this state.
>>
>> I tried applying this patch, your series "[PATCH V3 0/3] ARM: tegra114:
>> cpuidle: add power down state", and your series "[PATCH V2 00/11] ARM:
>> tegra114: add support for system suspend", all on top of v3.11-rc1.
>>
>> On Dalmore, the new cpuidle mode /appears/ to work (I see increasing
>> values in the sysfs cpuidle "usage" file for all defined cpuidle
>> states), but I don't see the "CPU VDD off" LED light up; I'm not
>> convinced that the CPU is actually being powered off in the idle mode.
>
> The LED of the CPU Vdd indicates the power of CPU cluster. But the
> series of CPU idle power down mode support for Tegra114 only supports
> per core power down.

OK, that's fine then.

>> With these patches applies, Harmony acts very strangely. After
>> hot-unplug and re-plug of CPU1, the system is hung or almost hung. The
>> patches appear to reduce the amount of time CPU VDD is off judging by
>> the LEDs. The patches might cause issues with system suspend too, but
>> I'm not 100% sure.
>
> Actually I didn't add anything about hotplug

Well, the patches do touch the CPU reset vector and related code. That's
shared with hotplug, right? But anyway, it turns out the CPU hotplug is
not related to the issue; the system acts strangely even without/before
performing any hotplug. I just hadn't noticed that before.

> or something can increase
> the loading or make regressions. But I think you are testing with USB
> device attached, right? That might cause some extra loading. You can
> give it a try after just removing USB device. And I double confirm that
> on Seaboard. Except that, the test result looks OK for me.

Yes, having a USB device plugged in does affect the issue. In summary:

next-20130716, with or without USB devices plugged in: Works fine.

next-20130716 with your patches, without USB device plugged in:
Occasional short problems (detailed below).

next-20130716 with your patches, with USB device plugged in: Continual
long problems (detailed below).

The testing I did was to log in over the serial console, hit <enter>
around five times, and watch the shell prompt echo back, then type
"ls<enter" and watch the (directory listing appear (I have about 20
files in my directory, with long-ish names), then repeat. With plain
next-20130716, this is nice and fast and there are no pauses. With your
patches applied, there are occasional or continual pauses, which last
for either a short time (tenths of a second), or even a second or two,
both depending on whether a USB device is plugged in or not.

I believe this is the same issue I saw when I applied your patches to
the Tegra tree on top of v3.11-rc1.

So, either your patch causes a bug, or exposes some pre-existing bug.
Either way, I can't apply them because they cause a regression.

I wonder if this is@all related to NVIDIA bug 1286857 "Upstreaming
task: Enabling LP2 causes slow serial console"? I tried the WAR there:

echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/state1/disable
echo 1 > /sys/devices/system/cpu/cpu1/cpuidle/state1/disable

... and the system locked up solid very soon after; I had just enough
time to type "ls<enter>", then it locked up. Again, performing those
same echos on next-20130716 without your patches works fine.
