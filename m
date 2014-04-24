From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Apr 2014 12:21:53 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <20140424111547.GP26756@n2100.arm.linux.org.uk>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <20140423171727.GK5649@arm.com>
 <20140423183742.GK24070@n2100.arm.linux.org.uk>
 <6414220.SShvCHLvZQ@wuerfel>
 <20140423190448.GB26756@n2100.arm.linux.org.uk>
 <20140424104737.GE8521@arm.com>
 <20140424111547.GP26756@n2100.arm.linux.org.uk>
Message-ID: <20140424112152.GF19564@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 12:15:47PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 24, 2014 at 11:47:37AM +0100, Catalin Marinas wrote:
> > On Wed, Apr 23, 2014 at 08:04:48PM +0100, Russell King - ARM Linux wrote:
> > > What is done on down-stream buses is of no concern to the behaviour of
> > > the CPU, which is what's being discussed here (in terms of barriers.)
> > > and the correct CPU ordering of various read/writes to memory and
> > > devices vs the streaming cache operations.
> > 
> > It is still of concern because for cases like NAPI an rmb() on the CPU
> > side is no longer enough. If you use a common network driver, written
> > correctly with rmb(), but you have some weird interconnect which doesn't
> > ensure ordering, you have to add interconnect specific barrier to the
> > rmb() (or hack the dma ops like mvebu). I consider such hardware broken.
> 
> Yes, the hardware /is/ broken, but if you want to get it working in a
> way that's acceptable in upstream kernels, adding that barrier to rmb()
> is probably the only acceptable solution - especially if you have other
> stuff going in between the rmb() and the DMA unmap.

The problem then is that the additional barrier may well require
bus-specific knowledge and access to parts of bus driver code which we can't
use inside the rmb() macro. To solve this properly, the bus topology topic
once again rears its ugly head, as I think you'd need a callback from the
device driver to the bus on which it resides in order to provide the
appropriate barrier (which isn't something that can be done sanely for
the platform_bus).

Will
