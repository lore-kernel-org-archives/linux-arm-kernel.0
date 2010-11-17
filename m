From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Nov 2010 17:23:58 +0000
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <20101117161130.GC5757@angua.secretlab.ca>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
	<AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
	<4CE31F0E.7050103@ti.com>
	<20101117161130.GC5757@angua.secretlab.ca>
Message-ID: <20101117172357.GC19488@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 09:11:30AM -0700, Grant Likely wrote:

> To start, I'm not a fan of matching by name.  It's fragile because it
> makes assumptions about how devices will be names when they actually
> appear (ie. Sometimes .id is dynamically assigned).  Ideally I'd
> prefer to have direct references (ie. pointers) to the devices that
> need to be registered, which *shouldn't* be difficult to handle.  That

Pointers are a complete pain for buses where things are dynamically
instantiated, the things you have to point at in machine data aren't the
things that end up appearing during device registration when the struct
device gets dynamically allocated so you need some way of translating
them.  This is why everyone ends up using dev_name for this sort of
thing ATM, it's easy to put into the code and match against the actual
struct device at runtime without needing to know about bus types.

> guarantees that the correct device is always referenced.  (aside: the
> device-tree use case provides this information by having direct
> 'phandle' references between dependencies.)

Device tree makes this a lot easier.

> Option 1: Add a list of prerequisite devices to struct device and
> modify driver core so that it defers binding to a driver until all the
> prerequisites are already bound.  This can probably be implemented
> in a way that works for all bus types transparently.  Before binding
> a driver, the driver core would increase the ref count on each of the
> prereq devices, and decrease it again when the driver is removed.

> Option 2: On a per-bus_type basis have a separate registration and the
> bus type code would hold the device unregistered in a pending list.
> This option would also add a prerequisites list to struct device.

Per bus type sounds like a lot of hassle going through all the bus types
but we may need to do that to handle autoprobable buses like USB.  I do
like the idea that the core would know what's going on so that things do
become visible for the debuggabilty reasons you mention, though helpers
could also provide similar infrastructure.

> Option 3: Don't try to handle it in the bus_type or driver core code
> at all, but rather provide board support code with helpers to make
> waiting for other devices easy.  Even in this case I think it is
> probably still a good idea for the dependant devices to increment
> the refcount of the prereq devices.

Agreed on the refcounting.
