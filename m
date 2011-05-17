From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 May 2011 23:41:34 +0100
Subject: device_tree binding for "amba bus"
In-Reply-To: <f9ae780a-2747-427f-826a-e0b510ca8afb@VA3EHSMHS001.ehs.local>
References: <f9ae780a-2747-427f-826a-e0b510ca8afb@VA3EHSMHS001.ehs.local>
Message-ID: <20110517224134.GC2266@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2011 at 01:28:33PM -0700, Stephen Neuendorffer wrote:
> None of this seems terribly interesting enough to justify a bus that has
> a small number of users:

However, without this infrastructure, drivers have to start doing those
three points you bring up themselves, manually, with additional code,
which makes for additional bugs.  No thanks.  Let's keep the bus
abstraction there as it serves to ensure that the right things happen
at the right time.

> And at the very least the hardcoded nature of the names seems, well...
> hardcoded.

What hardcoded names?  Driver names no matter what bus are part of the
_userspace_ API - remember that almost everything in the device model
is exported to userspace and is therefore part of the kernel's userspace
API.  So logically the driver names do want to be stable.

> Any thoughts about how to abstract this in a device tree?
> (My thoughts: devices need to reference a clock, devices need to
> reference a regulator,
> and it seems to me that the register check could be pulled out into a
> single call that the
> devices that care about it can do themselves during probe() )

And another during their remove callback - and where do they store the
data associated with that?  Will the drivers need to have a certain
base driver_data structure?

This all sounds like getting rather icky and prone to bugs.
