From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 May 2010 12:53:42 +0100
Subject: PIPT cache handling on s5pv210 chip
In-Reply-To: <00ca01caf359$643defa0$2cb9cee0$%kim@samsung.com>
References: <AANLkTilN-B_hvIPWFC8Q02wIcO7nJLmodSj0RyBYZKuk@mail.gmail.com>
	<00bc01caf351$5daf71c0$190e5540$%kim@samsung.com>
	<20100514104843.GG10339@n2100.arm.linux.org.uk>
	<00ca01caf359$643defa0$2cb9cee0$%kim@samsung.com>
Message-ID: <20100514115342.GA15405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 08:34:14PM +0900, Kukjin Kim wrote:
> In case a driver starts the Memory_To_Peripheral DMA operation with the
> memory area allotted by __vmalloc(,,no-cacheable), the driver can face some
> problems caused by cache victims.

That's its own lookout - all the time that there's the kernel mapping
present, the cache can be loaded with data via that mapping - and being
PIPT, that means the data _could_ be hit by accesses via the __vmalloc
mapping.

As I've already explained, __vmalloc() with differing memory types on
ARMv6 and above is unpredictable, period.  The same is true for different
sharability settings for the same physical memory.  No amount of
discussing will change this; it's a fact of the hardware.  If you
create them, your system will have unpredictable behaviour.

With different cache attributes, it's unpredictable to the word of the
architecture spec, and eventually it will become unpredictable according
to the hardware as well.

So the message is: using __vmalloc() with _any_ differing attributes
from the main memory mapping is unpredictable and must not be used on
ARM.
