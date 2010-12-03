From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 3 Dec 2010 16:28:27 +0000
Subject: RFC: Dynamic hwcaps
Message-ID: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'd be interested in people's views on the following idea-- feel free
to ignore if it doesn't interest you.


For power-management purposes, it's useful to be able to turn off
functional blocks on the SoC.

For on-SoC peripherals, this can be managed through the driver
framework in the kernel, but for functional blocks of the CPU itself
which are used by instruction set extensions, such as NEON or other
media accelerators, it would be interesting if processes could adapt
to these units appearing and disappearing at runtime.  This would mean
that user processes would need to select dynamically between different
implementations of accelerated functionality at runtime.

This allows for more active power management of such functional
blocks: if the CPU is not fully loaded, you can turn them off -- the
kernel can spot when there is significant idle time and do this.  If
the CPU becomes fully loaded, applications which have soft-realtime
constraints can notice this and switch to their accelerated code
(which will cause the kernel to switch the functional unit(s) on).
Or, the kernel can react to increasing CPU load by speculatively turn
it on instead.  This is analogous to the behaviour of other power
governors in the system.  Non-aware applications will still work
seamlessly -- these may simply run accelerated code if the hardware
supports it, causing the kernel to turn the affected functional
block(s) on.

In order for this to work, some dynamic status information would need
to be visible to each user process, and polled each time a function
with a dynamically switchable choice of implementations gets called.
You probably don't need to worry about race conditions either-- if the
process accidentally tries to use a turned-off feature, you will take
a fault which gives the kernel the chance to turn the feature back on.
 Generally, this should be a rare occurrence.


The dynamic feature status information should ideally be per-CPU
global, though we could have a separate copy per thread, at the cost
of more memory.  It can't be system-global, since different CPUs may
have a different set of functional blocks active at any one time --
for this reason, the information can't be stored in an existing
mapping such as the vectors page.  Conversely, existing mechanisms
such sysfs probably involve too much overhead to be polled every time
you call copy_pixmap() or whatever.

Alternatively, each thread could register a userspace buffer (a single
word is probably adequate) into which the CPU pokes the hardware
status flags each time it returns to userspace, if the hardware status
has changed or if the thread has been migrated.

Either of the above approaches could be prototyped as an mmap'able
driver, though this may not be the best approach in the long run.


Does anyone have a view on whether this is a worthwhile idea, or what
the best approach would be?

Cheers
---Dave
