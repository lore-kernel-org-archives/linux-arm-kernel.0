From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Aug 2013 11:06:13 +0100
Subject: Another possible race in deferred probing...
Message-ID: <20130812100613.GC23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no better way to provoke bugs than to show a device to someone
who has never seen it before.  Obviously, I didn't get much chance to
investigate what happened, so all I have are the kernel messages:

kirkwood-spdif-audio kirkwood-spdif-audio.1: ASoC: CPU DAI mvebu-audio.1 not registered
kirkwood-spdif-audio kirkwood-spdif-audio.1: failed to register card
platform kirkwood-spdif-audio.1: Driver kirkwood-spdif-audio requests probe deferral
mvebu-audio mvebu-audio.1: found external clock
kirkwood-spdif-audio kirkwood-spdif-audio.1: ASoC: CODEC spdif-dit not registered
kirkwood-spdif-audio kirkwood-spdif-audio.1: failed to register card
platform kirkwood-spdif-audio.1: Driver kirkwood-spdif-audio requests probe deferral
kirkwood-spdif-audio kirkwood-spdif-audio.1: ASoC: CODEC spdif-dit not registered
kirkwood-spdif-audio kirkwood-spdif-audio.1: failed to register card
platform kirkwood-spdif-audio.1: Driver kirkwood-spdif-audio requests probe deferral

and then when manually removing the kirkwood-spdif module and re-inserting
it:

kirkwood-spdif-audio kirkwood-spdif-audio.1:  dit-hifi <-> mvebu-audio.1 mapping ok

First, remember that Ubuntu loads kernel modules from separate threads,
so module loading here is multithreaded.

What I suspect happened was the spdif-dit module was inserted and
initialized between kirkwood-spdif starting to be re-probed, and
returning from its probe function with -EPROBE_DEFER, and I suspect
that spdif-dit was the last module.

As there was no further module loading or driver activity, there was
no attempt to re-probe the kirkwood-spdif module.

This seems to be a very rare event (it's the first time I've seen it
since the last fix to the deferred probing, and that's many hundreds
of reboots.)

Nevertheless, the fact that it has happened indicates that deferred
probing still has holes that can leave modular drivers unbound after
boot.

Let's consider this scenario, which from a quick scan of the code looks
like it's possible to happen:

Thread 0			Thread 1
deferred probe triggered
driver A's probe function called
 (kirkwood_spdif_probe in my case)
takes lock L to lookup resource A
checks for resource A
 (the spdif_dit codec)
releases lock L
resource A is not found
		----- context switch ------
				module init function called
				 (to register spdif_dit_driver)
				driver B's probe function called
				 (to register the spdif_dit codec
				 via snd_soc_register_codec)
				takes lock L for adding resource A
				registers resource A
				releases lock L
				driver B's probe function completes
				deferred probe triggered,
				 deferred probe list empty
				module init completes
		----- context switch ------
probe returns -EPROBE_DEFER
deferred probe mutex taken
added to deferred probe list
deferred probe mutex released

This can happen because there's no locking between looking up the
resource and having the driver added to the list of devices waiting
to be probed.

Given that deferred probing is becoming the "normal" thing for device
drivers, these races are only going to get worse.  Consider that as we're
working on ARM towards having a single zImage bootable on many boards,
most drivers will be modules, and if they're inserted into the kernel in
a multi-threaded way, the above race is going to continually come back
and bite us.

I don't see an easy solution to this; we can't serialise device probes,
because we have some places where device driver probe functions register
devices themselves, which then go on to have their drivers probed
(nested probes).

Maybe this reflects back into Greg's whole argument against platform
devices: maybe we need a struct device which lists _all_ the resources
which a device requires, have the bus layer safely check for the
presence of all those resources before calling the probe function, and
move the deferred probe out of the core into the bus layer(s).

Another solution would be to have a way to attach to the device a list
of resources which failed, and have the driver core scan that list after
the probe returns rechecking to see if all the resources are now present.
That to me sounds particularly horrid, invasive and quite disgusting to
implement safely.
