From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 21 Jun 2010 18:19:17 +0800
Subject: [PATCH 1/2] [ARM] Introduce 'struct machine_class' for SoC level
	abstraction
In-Reply-To: <20100621090245.GA7702@n2100.arm.linux.org.uk>
References: <1277042450-30382-1-git-send-email-eric.miao@canonical.com>
	<201006211527.49786.jeremy.kerr@canonical.com>
	<AANLkTilUddhIW0C5LN4b7igh6vEDvelhnT8a3or677Zk@mail.gmail.com>
	<20100621090245.GA7702@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimHuNuaVrRqPMiLpItBNgBeW3Cdqg6hBYT1DEpl@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 5:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 21, 2010 at 04:23:22PM +0800, Eric Miao wrote:
>> So that from derivative POV, it can be expressed as:
>>
>> ? ? ? if (mdesc->class && mdesc->class->map_io)
>> ? ? ? ? ? ? ? mdesc->class->map_io();
>> ? ? ? if (mdesc->map_io())
>> ? ? ? ? ? ? ? mdesc->map_io();
>>
>> But this seems to make things a bit over complicated, so for such cases
>> I'd prefer:
>>
>> 1. have a separate machine_class for mainstone
>> 2. or move the board specific map_io() separatedly
>
> How about making the presence of mdesc->map_io override the class
> version?
>
> So if mainstone provides its own map_io() function, it is still
> responsible (as is today) for calling the PXA specific map_io().
> The same behaviour seems sensible to apply to the other class
> functions as well - allow platforms to override the class
> version, and leave the replacement platform function responsible
> for calling the class if that's what it needs to do.
>

Yep, that's a good idea, and actually was as my first version. Yet my
concern is this doesn't easily fit for the class data, i.e., allow the
machine specific data to override the class data like below:

	if (valid_value(mdesc->phys_io))
		use(mdesc->phys_io);
	else
		use(mdesc->class->phys_io);

but since phys_io could be valid for value zero (as if not explicitly
initialized), so we may end up defining like below to allow use of the
default class values:

MACHINE_START(....)
	.phys_io	= INVALID_ADDRESS,
	.io_pg_offst	= INVALID_ADDRESS,
	....
MACHINE_END

This, however, creates some incompatiblity in semantics from the functions.
That's why I chose a much simpler scheme: use the class version if class
is there, otherwise use the machine specific one.
