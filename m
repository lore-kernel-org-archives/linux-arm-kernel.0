From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 03 Mar 2014 14:03:53 +0100
Subject: Generic PM domains - too noisy?
In-Reply-To: <20140303121204.GH21483@n2100.arm.linux.org.uk>
References: <20140303121204.GH21483@n2100.arm.linux.org.uk>
Message-ID: <3624925.bB4hsTNXCK@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 03, 2014 12:12:04 PM Russell King - ARM Linux wrote:
> Rafael,

Hi,

> I've been trying out the generic PM domains support with a small driver
> on Marvell Dove.  At the moment, I have just one domain with one device
> in it, and it's quite basic in that all it does is provide a power_on
> and power_off hook.
> 
> Both of these hooks read/write three registers in sequence under a spin
> lock, so nothing too heavy.  The lock is only taken by this code, so at
> the moment there's no contention on that lock.
> 
> However, what I find is that it's very noisy in the kernel log, printing
> much of this at warning level:
> 
> ap510-vmeta ap510-vmeta.0: start latency exceeded, new value 2352 ns
> ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 3594 ns
> ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 2784 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3234 ns
> vpu: Power-off latency exceeded, new value 12025 ns
> vpu: Power-on latency exceeded, new value 12156 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3342 ns
> ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 3840 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3564 ns
> vpu: Power-off latency exceeded, new value 104996 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3570 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3612 ns
> ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 2790 ns
> ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 2808 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3636 ns
> ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 3924 ns
> vpu: Power-on latency exceeded, new value 21000 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3732 ns
> vpu: Power-on latency exceeded, new value 5066544 ns
> ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 3942 ns
> ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 27006 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 27072 ns
> ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 130850 ns
> ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 59821 ns
> ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 181628 ns
> vpu: Power-off latency exceeded, new value 215840 ns
> ap510-vmeta ap510-vmeta.0: start latency exceeded, new value 73057 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 86659 ns
> ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 155288 ns
> ap510-vmeta ap510-vmeta.0: start latency exceeded, new value 143629 ns
> ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 156973 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 135715 ns
> ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 364768 ns
> ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 484019 ns
> ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 355288 ns
> ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 1981264 ns
> ap510-vmeta ap510-vmeta.0: start latency exceeded, new value 521765 ns
> ap510-vmeta ap510-vmeta.0: start latency exceeded, new value 616560 ns
> vpu: Power-off latency exceeded, new value 495882 ns
> vpu: Power-off latency exceeded, new value 501834 ns
> ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 436259 ns
> 
> Rerally, the power on/power off latency should be small - which it would
> be if only this code was being run and measured.
> 
> However, when you factor in interrupts, context switches due to preemption,
> etc, it quickly becomes apparent that measuring the absolute time that it
> takes for a handler to complete is nonsense - not only are you measuring
> the latency of that handler to complete, but if the kernel ends up by way
> of preemption switching to another thread, your latency includes the time
> it takes for the system to return back to running the handler.  The more
> the system is loaded, the longer these latency measurements will be.
> 
> So, here's the question: what use is this information which can be wrong
> by a factor of 300x or more, and why does it need to be printed at
> warning level?

There's a patch already in my tree changing the level to "debug":

https://patchwork.kernel.org/patch/3735101/

Thanks,
Rafael
