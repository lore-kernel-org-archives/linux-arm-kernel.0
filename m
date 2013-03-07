From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Mar 2013 03:50:24 +0000
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130306214036.62fc93b9@skate>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306202447.GA4916@obsidianresearch.com> <20130306214036.62fc93b9@skate>
Message-ID: <201303070350.25083.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 March 2013, Thomas Petazzoni wrote:
> I don't follow you. For the moment we have to say in the DT, I have a
> NOR of 16 MB, and it's mapped at 0xCD000000. This 0xCD000000 is
> completely useless: the NOR driver or whatever driver sets up the NOR
> can do an allocate_resource(), which returns an available fragment of
> the physical address space, and create the address decoding window at
> this address.
> 
> The base address of address decoding windows is not a description of
> the hardware. Those base addresses can be dynamically allocated during
> the probing of devices.

I think you just described precisely why the binding that Jason has suggested
is able to describe what the hardware does, while the binding you proposed
cannot do that.

If we want to dynamically assign the address of the NOR flash, we need a
way to describe the hardware address that we want to remap to a CPU
visible logical address using MBUS.

When each device behind MBUS has its own bus space in hardware, a ranges
property is exactly what we should use to describe how that bus space
is mapped into the parent bus that is visible to the CPU. The ranges
property that is passed by the boot loader can describe how the address
is currently configured at boot time, or how you would like the kernel
to configure it to get a sensible system view. But if you want to
dynamically remap it in MBUS, that should /not/ require changing the
"reg" property of the device, because the device itself does not change,
only the mapping changes.

There is a little deficiency here in the way that Linux probes the
platform devices: We allocate a "struct resource" at the time the
platform_device is created, and that resource will be incorrect if
we remap the window. However, I think it's easy enough to work around
that by using 'of_iomap' in drivers that are children of the MBUS and
can get remapped, rather than using 'devm_ioremap_resource'. Platform
devices are Linux specific implementation detail that should not
impact the DT binding in this case.

	Arnd
