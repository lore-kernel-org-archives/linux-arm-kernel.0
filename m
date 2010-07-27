From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jul 2010 15:21:13 +0100
Subject: Issue with file transfers to a mass storage device on SMP system
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF90B@dbde02.ent.ti.com>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com>
	<20100727100121.GB7846@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF75B@dbde02.ent.ti.com>
	<20100727104133.GA10665@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF83C@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF8F3@dbde02.ent.ti.com>
	<20100727135939.GD11468@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF90B@dbde02.ent.ti.com>
Message-ID: <20100727142113.GE11468@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 27, 2010 at 07:44:20PM +0530, Shilimkar, Santosh wrote:
> OMAP doesn't override because the default definition is good enough now.

Ah, good to know.

> Shouldn't below work ?
> #elif __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
> #define mb()            do { dsb(); outer_sync(); } while (0)
> #define rmb()           dmb()
> #define wmb()           mb()

Yes, that should get it out of the CPU and caches, and onto the bus.
However, I need to check up exactly what a write to the L2x0 SYNC
register gives us...

> > As the OMAP mandatory barrier implementation isn't in mainline, I can't
> > comment on that.  However, I feel certain that this is where the problem
> > is.
> 
> Do you think with above setting it should be still a problem ? I mean
> with " CONFIG_ARCH_HAS_BARRIERS" not enabled

Well, the question is whether getting it out of the outer cache (and
performing an effective memory barrier to the outer cache) is sufficient
for the DMA agent to see the data.

Could the data be sitting somewhere in the interconnect between the
CPU pushing it out of the outer cache and the DMA agent trying to read
from memory?
