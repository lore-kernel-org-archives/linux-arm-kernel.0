From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jun 2010 08:38:28 +0100
Subject: Request review of device tree documentation
In-Reply-To: <AANLkTinwL0XtMNG13inr_1UliOlqZkyr4dlvG-ZGL9JT@mail.gmail.com>
References: <AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<1276408773.1962.574.camel@pasglop>
	<AANLkTinwL0XtMNG13inr_1UliOlqZkyr4dlvG-ZGL9JT@mail.gmail.com>
Message-ID: <20100614073828.GA6095@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 13, 2010 at 11:23:45PM -0600, Grant Likely wrote:
> >> Or perhaps the MMU and caches can be turned off for the duration of the
> >> callback.
> >> I don't have the details of ARM MMUs and caches reloaded into my head
> >> yet. ?Maybe next week...

We've had these kinds of questions in the past.  Doing what you're asking
above is not really an option - it requires:

1. disable all IRQs
2. setup 1:1 MMU mappings for code to turn off MMU
   (requires new page table)
3. disable imprecise exceptions
4. flush caches and TLBS
5. jump to 1:1 mapping area for code to disable MMU
6. disable caches and mmu
7. call function
8. flush caches and TLBs
9. re-enable caches and mmu
10. re-enable imprecise exceptions
11. switch back to original MMU mappings
12. re-enable all IRQs

This is fine if you don't care at all about interrupt latency.
Unfortunately, most people do care about interrupt latency because
that directly affects interactivity and system performance.  The
called function could not enable interrupts or exceptions - as the
CPU vectors are in virtual space, disabling the MMU effectively
makes them disappear.

Moreover, with the MMU and caches disabled, the CPU performance is
extremely poor, so the called function will run slowly.

So, disabling the MMU isn't really viable.

Now, if the external code was fully PIC, we could then run it with
the MMU enabled.  However, this wouldn't really help - the external
code could not access any devices without knowledge of how the kernel
setup the V:P translations.

So you'd need to pass some kind of data structure giving locations of
devices to the called code - but then what if the kernel doesn't have
the device mapped?
