From: andreiw@motorola.com (Andrei Warkentin)
Date: Fri, 17 Dec 2010 14:52:29 -0600
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <20101216232849.GY9937@n2100.arm.linux.org.uk>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
	<20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
	<20101216232849.GY9937@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimxY0ufwR-nUT_Hx=NkG=9vcuGFrKOBgYpGtvoi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 5:28 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 16, 2010 at 05:09:48PM -0600, Andrei Warkentin wrote:
>> On Thu, Dec 16, 2010 at 5:34 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> >
>> > On Wed, Dec 15, 2010 at 05:45:13PM -0600, Andrei Warkentin wrote:
>> > > This is my first time on linux-arm-kernel, and while I've read the
>> > > FAQ, hopefully I don't screw up too badly :).
>> > >
>> > > Anyway, we're on a dual-core ARMv7 running 2.6.36, and during
>> > > stability stress testing saw the following:
>> > > 1) After a number hotplug iterations, CPU1 fails to set its online bit
>> > > quickly enough and __cpu_up() times-out.
>> > > 2) CPU1 eventually completes its startup and sets the bit, however,
>> > > since _cpu_up() failed, CPU1's active bit is never set.
>> >
>> > Why is your CPU taking soo long to come up? ?We wait one second in the
>> > generic code, which is the time taken from the platform code being happy
>> > that it has successfully started the CPU. ?Normally, platforms wait an
>> > additional second to detect the CPU entering the kernel.
>>
>> It seems twd_calibrate_rate is the culprit (although in our case,
>> since the clock is the same to both CPUs, there is no point in
>> calibrating).
>
> twd_calibrate_rate() should only run once at boot. ?Once it's run,
> taking CPUs offline and back online should not cause the rate to be
> recalibrated.

Let's me just see if I understand things correctly for the hotplug case.

1) cpu_down calls take_down_cpu
2) Idle thread on secondary notices cpu_is_offline, and calls cpu_die()
3) cpu_die calls platform_cpu_die, at which point the cpu is dead. If
it ever wakes up (because of a cpu_up), it will continue to run in
cpu_die.
4) cpu_die jump to secondary_start_kernel.
5) secondary_start_kernel calls percpu_timer_setup
6)  percpu_timer_setup calls platform local_timer_setup
7) local_timer_setup calls twd_timer_setup_scalable

...which calls __twd_timer_setup, which does twd_calibrate_rate among
other things.
It also does clockevents_register_device.

I didn't try, but looking at kernel/time/clockevents.c,
clockevents_exchange_device is called from tick_shutdown in the
CPU_DEAD notify path, so as is, twd_timer_setup does need to be called
in UP path, even on hotplug.

>
>> See, the SMP logic is sensitive to system load at the moment.
>
> I don't think it is - it sounds like you're explicitly causing the twd
> rate to be recalculated every time you're bringing a CPU online, which
> is not supposed to happen.
>
>> Since boot_secondary is supposed to return failure on failing
>> to up the secondary, maybe there is no point doing a timed wait for
>> the online bit, since you are guaranteed to get there.
>
> If you're starving the secondary CPU of soo much bus bandwidth that it's
> taking more than one second for it to be marked online, the delay loop
> calibration is going to fail too. ?If you can starve it of bus bandwidth
> from the primary CPU, then you have badly designed hardware too - you'll
> gain very little benefit from a SMP system if you can't sensibly run both
> CPUs at the same time without starving one or other.

I can't argue with you there :). But I didn't design the hardware, and
I'm not the only poor sod dealing with it ;). I wish I had another
MPCore Cortex A9 platform nearby so I could replicate the test
results. Unfortunately I don't. This particular issue only happens
about once every four hours while running stress tests that
effectively wedge the entire system, starving it both computationally
and memory/IO-wise.

Anyway, the point I want to make, is that whatever happens in
__cpu_up, it shouldn't ever cause the system to be put into an
inconsistent state, where subsequent oopses will result from from the
secondary having booted up after __cpu_up timed out. At the very
least, it makes looking for these strange up issues (whether they are
caused by HW issues or bad programming) non-trivial.

>
> What I'm saying is that if it's taking more than one second to setup
> the local timer (which should be a few register writes) and calibrate
> the delay loop, you're going to have bigger problems and your system is
> already in an unstable situation.
>
> Please post your SMP support code so it can be reviewed, which'll help
> eliminate it from being the cause.
>

Sure. It's mach-tegra/platsmp.c.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: platsmp.c
Type: text/x-csrc
Size: 6189 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101217/b85cf3d2/attachment.bin>
