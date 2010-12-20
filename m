From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 20 Dec 2010 09:16:15 +0100
Subject: [RFC] Fixing CPU Hotplug for RealView Platforms
Message-ID: <AANLkTinMobeQBz_ruGAeOSoTWP_9-0Aw4-=8Sk3JxEjX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm also interested in hotplug latency measurement and have done some
on my CA9 platform u8500. I have the same kind of result for plugging
a secondary cpu:
  total duration = 295ms
  166 us for the low level cpu wake up
  228ms between the return from platform_cpu_die and the cpu becomes online

I have added some trace events for doing these measurements and I'd
like to add some generic traces point in the cpu hotplug code like we
already have in power management code (cpuidle, suspend, cpufreq ...)
These traces could be used with power events for studying the impact
of cpu hotplug in the complete power management scheme.



> Message: 4
> Date: Sat, 18 Dec 2010 19:22:13 +0000
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> To: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC] Fixing CPU Hotplug for RealView Platforms
> Message-ID: <20101218192213.GL9937@n2100.arm.linux.org.uk>
> Content-Type: text/plain; charset=us-ascii
>
> On Sat, Dec 18, 2010 at 05:44:47PM +0000, Will Deacon wrote:
>> > Hotplug bringup:
>> >
>> > Booting: 1000 ? ? ? ? ? ? ? ? ? -> 0ns ? ? ? ? ?0ns ? ? ? ? ? ? (1us per print)
>> > Restarting: 3976375 ? ? ? ? ? ? -> ? ? ? ? ? ? ?3.976375ms
>> > cross call: 3976625 ? ? ? ? ? ? -> 3.976625ms
>> > Up: 4003125 ? ? ? ? ? ? ? ? ? ? -> ? ? ? ? ? ? ?4.003125ms
>> > CPU1: Booted secondary processor
>> > secondary_init: 4022583 ? ? ? ? -> ? ? ? ? ? ? ?4.022583ms
>> > writing release: 4040750 ? ? ? ?-> ? ? ? ? ? ? ?4.04075ms
>> > release done: 4051083 ? ? ? ? ? -> ? ? ? ? ? ? ?4.051083ms
>> > released: 46509000 ? ? ? ? ? ? ?-> 4.6509ms
>> > Boot returned: 51745708 ? ? ? ? -> 5.1745708ms
>> > sync'd: 51745875 ? ? ? ? ? ? ? ?-> ? ? ? ? ? ? ?5.1745875ms
>> > CPU1: Unknown IPI message 0x1
>> > Switched to NOHz mode on CPU #1
>> > Online: 281251041 ? ? ? ? ? ? ? -> ? ? ? ? ? ? ?281.251041ms
>> >
>> > So, it appears to take 4ms to get from just before the call to
>> > boot_secondary() in __cpu_up() to writing pen_release.
>> >
>> > The secondary CPU appears to run from being woken up to writing the
>> > pen release in about 40us - and then spends about 1ms spinning on
>> > its lock waiting for the requesting CPU to catch up.
>> >
>> > This can be repeated every time without exception when you bring a
>> > CPU back online.
>> >
>> Hmm, this sounds needlessly expensive.
>
> Actually, I'm starting to get concerned about doing timing measurements
> on Versatile Express - I'm seeing some unexplainable issues with the
> Versatile Express platform.
>
> I occasionally see the kernel get stuck when initializing the CLCD - and
> I think this is a hardware lockup - pressing the red 'reset/power on'
> button is ignored, and the only way to recover it is to press the
> black 'power off' button first.
>
> Also I keep running into some weird stuff which causes the MMC to
> underflow, serial output to be corrupted, and rootfs not to be mounted
> which is 100% reliable with some kernels (iow, the built kernel just
> will not boot no matter how many times you attempt to do so.) ?I've
> sent Catalin & Philippe a copy of one such kernel which exhibits this
> behaviour a few days ago (but I think they're on holiday.)
>
> Anyway, I decided to implement a slightly different method to measuring
> the time taken, and the apparant long delays have gone - I suspect that
> was something to do with printk. ?I'm not logging the times into an
> array, and later printing out the values.
>
> So, CPU1 boot:
>
> SMP: Start: 0
> SMP: Booting: 916
> SMP: Cross call: 3083
> SMP: Pen released: 278416
> SMP: Unlock: 279583
> SMP: Boot returned: 280333
>
> SMP: Sec: up: 238666
> SMP: Sec: enter: 264333
> SMP: Sec: pen write: 267083
> SMP: Sec: pen done: 268916
> SMP: Sec: exit: 279916
> SMP: Sec: calibrate: 328416
> SMP: Sec: online: 218380875
>
> CPU1 hotplug:
> SMP: Start: 0
> SMP: Booting: 833
> SMP: Cross call: 4250
> SMP: Pen released: 51500
> SMP: Unlock: 52667
> SMP: Boot returned: 53500
>
> SMP: Sec: restart: 4667
> SMP: Sec: up: 7167
> SMP: Sec: enter: 31000
> SMP: Sec: pen write: 39667
> SMP: Sec: pen done: 42167
> SMP: Sec: exit: 53000
> SMP: Sec: calibrate: 104583
> SMP: Sec: online: 221423333
>
> This looks far saner.
>
> Anyway, with the delay loop calibration, we're looking at a boot time of
> about 110us to the delay loop calibration, and 221ms for a secondary CPU
> using the existing code. ?I don't think that will go up significantly if
> we re-vector offlined CPUs back through the reset vector.
>
>
>
> ------------------------------
