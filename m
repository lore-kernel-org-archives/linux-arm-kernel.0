From: andreiw@motorola.com (Andrei Warkentin)
Date: Tue, 21 Dec 2010 15:53:46 -0600
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <20101218200443.GM9937@n2100.arm.linux.org.uk>
References: <20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
	<20101216232849.GY9937@n2100.arm.linux.org.uk>
	<AANLkTimxY0ufwR-nUT_Hx=NkG=9vcuGFrKOBgYpGtvoi@mail.gmail.com>
	<20101217231449.GF9937@n2100.arm.linux.org.uk>
	<AANLkTi=-foyb9c5F4tFpGK6KzQnP9htJW8GwYoUHVK0r@mail.gmail.com>
	<20101218000828.GG9937@n2100.arm.linux.org.uk>
	<AANLkTinSg+iCGM64iQqLn32Wjpta_87=HWuG==KJ9-eW@mail.gmail.com>
	<20101218120154.GA4803@n2100.arm.linux.org.uk>
	<AANLkTimG8yuCMOJPz9-ANi_2hf7E2HPYPy9sWaxVPXmE@mail.gmail.com>
	<20101218200443.GM9937@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikHGX6OQWfGoNiQj-UX81=8_HwP3W+DXwZASatN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russel,

Thank you! The culprit looks as it seems to be the writel without
__iowmb, as you pointed out. At the very least I've yet to hit the
problem again this way.

I still want to add code inside the platform SMP support as a safety
net. Maybe I am being too pedantic, but  In the near future (with
those 40 patches), secondaries are going to boot directly via
secondary_startup as well, so the first time platform-specific code
gets invoked is platform_secondary_init. I want to ensure that when
boot_secondary returns, the CPU is either guaranteed to be running or
for-sure dead. The problem is that platform_secondary_init is already
too late - if the CPU gets killed due to timeout anytime between the
entry to secondary_start_kernel and  platform_secondary_init, it could
have already increased the refcount on init_mm or disabled preemption.

I propose a platform_secondary_preinit, which would be invoked right
before the "Booted secondary processor" printk. This will give a
chance to synchronize with the platform boot_secondary and would be
the point, for example, where the reset vector is written with the
smpid of the booted processor, so that boot_secondary knows it came
up.

What do you think?
A

On Sat, Dec 18, 2010 at 2:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Dec 18, 2010 at 06:10:49AM -0600, Andrei Warkentin wrote:
>> Definitely. This would be exactly the right place to place any holding
>> logic...
>
> FYI, I've managed to get some timing figures out of my Versatile
> Express platform. ?It takes about 100us for a CPU to come online via
> hotplug, and a further 222ms to run the calibration before marking the
> CPU online.
>
> That leaves a margin of about 750ms before the timeout in the generic code
> fires.
>
> CPU requesting hotplug, times in ns:
> SMP: Start: 0
> SMP: Booting: 750
> SMP: Cross call: 3500
> SMP: Pen released: 41167
> SMP: Unlock: 42417
> SMP: Boot returned: 43250
>
> CPU being brought online, referenced to "SMP: Start" above, times in ns.
> SMP: Sec: restart: 3834
> SMP: Sec: up: 5334
> SMP: Sec: enter: 30667
> SMP: Sec: pen write: 38917
> SMP: Sec: pen done: 41417
> SMP: Sec: exit: 42750
> SMP: Sec: calibrate: 91834
> SMP: Sec: online: 222054375
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-SMP-Do-early-platform-init-on-entering-secondary.patch
Type: text/x-patch
Size: 1507 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101221/31913d2c/attachment-0001.bin>
