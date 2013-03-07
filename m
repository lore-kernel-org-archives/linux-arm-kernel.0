From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 7 Mar 2013 19:20:05 -0300
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130306230412.GA5870@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
Message-ID: <20130307222004.GA2450@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Wed, Mar 06, 2013 at 04:04:12PM -0700, Jason Gunthorpe wrote:
> 
>        nor at 0 {
>           compatible = 'linux mtd nor driver';
>           regs = <MAPDEF(1, 0xab, MAPDEF_NOMASK) 0x10000>;
>       }
> 
> We can now tell directly that 'linux mtd nor driver' is behind MBUS
> target 0xab, and the OF code already knows the base for this MBUS
> target from the ranges property, as modified by the MBUS driver. The
> MBUS driver also knows which targets to configure windows for
> immediately at boot without having to consult internal tables. Plus we
> don't need to modify the NOR driver to call out to MBUS window
> functions to fetch an address.
> 
> There are a few other variants on how to do this in DT, but they all
> come down to modeling the MBUS target using a ranges property and
> having the mbus driver adjust the range mapping at runtime.
> 

At least in the flash (NOR and friends) case, this is not necessarily true.

Now that the Device Bus driver is posted I think we have a nice example
on how address decoding windows would be allocated through the mbus
driver, *without* touching the child driver (i.e. NOR driver).

The windows are allocated as part of the "preparing" tasks the Device
Bus does as the parent device and it seems like a very clean solution.
The windows are specifically related to him, so I think this driver is
the most appropriate to perform the window management.

In a certain way, this is similar to other memory-controller devices
(e.g. OMAP's GPMC) that need to request a chip select before the child
device can be accessed.

Moreover -as I already stated in the patchset- I believe we can make the
Device Bus implement dynamic window allocation, if he can't find a 'ranges'
property for a given child.

In conclusion: there is absolutely no need to change the NOR driver,
and there is no need to explictly add an explicit description of the
NOR window in the device tree.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
