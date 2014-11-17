From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Nov 2014 13:03:06 +0000
Subject: some question about TCR setting
In-Reply-To: <20141117120952.GA23769@leverpostej>
References: <CAOVJa8HBYkTMCJFKC=+UwjgPp4odm5UV-oUQXu17ctv2+HkpRg@mail.gmail.com>
 <20141114104246.GA25828@leverpostej>
 <CAOVJa8Fx4yiSU0O7HTaYEKOrRdtWve4JGeN0cWRXDsBMyV_8Mg@mail.gmail.com>
 <20141114135531.GA27768@leverpostej>
 <CAOVJa8GB=pk4SFEArcEGWF8g12105F_9YUL0hH5k+WW6=WWOBg@mail.gmail.com>
 <20141116165211.GL4042@n2100.arm.linux.org.uk>
 <20141117120952.GA23769@leverpostej>
Message-ID: <20141117130306.GP4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 12:09:52PM +0000, Mark Rutland wrote:
> On Sun, Nov 16, 2014 at 04:52:11PM +0000, Russell King - ARM Linux wrote:
> > The access type is included on the bus along with the address and other
> > attributes.  This includes whether it's sharable, and the cache attributes.
> > A MMU page walker may be implemented such that it is capable of accessing
> > L2 cache.
> 
> Or L1, depending on the implementation of the memory system. The logic
> which walks the page tables is essentially another coherent observer, so
> it doesn't necessarily matter precisely where it is attached.
...
> To further this point, provided the TCR is programmed with the same
> attributes the kernel uses to access the page tables, no cache
> maintenance is necessary, as the CPU(s) and page table walker(s) are
> coherent.

That depends on the implementation - whether the MMU page table walker
can read from the L1 cache.  If you were correct in all cases, we could
get rid of:

        ALT_UP (mcr     p15, 0, r0, c7, c10, 1)         @ flush_pte

in proc-v7-2level.S - but obviously we think that ARMv7 is unable to read
from L1 when walking the page tables.

> This is what we do for ARMv7 and arm64.

>From the code, it looks like we don't for ARMv7.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
