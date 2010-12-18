From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Dec 2010 12:19:02 +0000
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <AANLkTimLkiRkvJAYaJr0=g3zE1goXTekxFG_gj4Zza8z@mail.gmail.com>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
	<20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
	<20101218095820.GI9937@n2100.arm.linux.org.uk>
	<AANLkTimLkiRkvJAYaJr0=g3zE1goXTekxFG_gj4Zza8z@mail.gmail.com>
Message-ID: <20101218121902.GJ9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 18, 2010 at 05:54:25AM -0600, Andrei Warkentin wrote:
> That's a good question. I think the best answer I can come up right
> now is to find another dual-core ARM platform and run our stress tests
> to get it to fail in the same fashion. The issue you pointed out -
> namely, the byzantine design of the hotplug code, does not affect the
> up path. Proof: boot_secondary always succeeds.

Send me your test case, and provided it can work in a limited filesystem
I can test it on the 4-core Versatile Express system, and an OMAP4
platform.

> I am not convinced with your writel argument either. Proof:
> boot_secondary always succeeded,

Your boot_secondary() _always_ succeeds.  It can never fail!  I think
that in itself makes some of your anaysis invalid (as I suspect you're
basing the fact that the secondary CPU is within kernel code to be upon
the reset vector being modified.)

> plus the writel expands to a write followed by a dsb and
> outer cache sync.

Covering what I said in the other email, it is the other way around.
It's a dsb+outer sync followed by the write.

> And the writel location looked polled at
> boot_secondary is in memory. Doesn't the dsb drain the write buffer?
> In all the failure cases the secondary was inside kernel code by the
> time __cpu_up started waiting on the online bit to appear. That means
> that whatever was taking it's sweet time - it was taking it from the
> moment secondary_start_kernel entered to the moment the online bit was
> set. I have printk logs showing that.

Show me the logs then!

> So the question we want to collectively answer is really - should the
> stuffing in secondary_start_kernel really be taking so long, assuming
> an unrealistic load? I don't have a good answer for that, yet. I'm
> going to get some timings for that code.

The answer to that is no.  There's very little which goes on in there.
Between the point where platform_secondary_startup() is called, and
the CPU is set online, we:

1. notify that the CPU is starting.  This calls the CPU notifier list,
   of which (until I added VFP) there are no consumers of this on ARM.
2. enable IRQs.  The secondary core should not be receiving any
   interrupts from peripherals at this time.
3. setup the per-CPU timer, which assuming twd_calibrate_rate() doesn't
   re-run, is just a case of re-registering the clock event driver.
4. calibrate the bogomips - this may take a short time, but certainly
   less than a second.
5. store the CPU specific information into the structure - a couple of
   writes at the most.

The biggest thing in there is (4), which should take less than 64
jiffy-update ticks to complete.

> Btw, I would guess that one of the reasons the hotplug logic is done
> the way it was is because secondary_startup is garbage after init,
> having been freed along with the rest of init memory. Is anybody
> addressing that atm?

No.  The reason its done the way it is is because hotplug CPU was
initially created on an ARM926 SMP platform, where it was not possible
to do anything with the secondary cores but to place them in WFI mode.
The same method applies to Realview and Versatile Express - you can
only place the cores into WFI mode, you can't stop them any other way.

The original hotplug CPU code which I received from ARM used to just
return straight back to the idle loop without re-initializing the CPU.
I fixed that to re-run as much of the initialization from as early on
as I possibly could (which was basically jumping back to
secondary_startup).  In order to take it back any further requires
jumping through large hoops to take the MMU down.

As such, the initial SMP assembly bring up code never got tested for
hotplug-safeness, and so the problem wasn't noticed until recently -
and that's now been fixed.

However, other people copied the Realview code without really thinking,
(maybe because of the buggy ASM code) but that's all been fixed and
everyone can now sort out their implementations.
