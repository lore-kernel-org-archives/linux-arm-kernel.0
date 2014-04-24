From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 12:15:47 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <20140424104737.GE8521@arm.com>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <20140423171727.GK5649@arm.com>
 <20140423183742.GK24070@n2100.arm.linux.org.uk> <6414220.SShvCHLvZQ@wuerfel>
 <20140423190448.GB26756@n2100.arm.linux.org.uk>
 <20140424104737.GE8521@arm.com>
Message-ID: <20140424111547.GP26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 11:47:37AM +0100, Catalin Marinas wrote:
> On Wed, Apr 23, 2014 at 08:04:48PM +0100, Russell King - ARM Linux wrote:
> > What is done on down-stream buses is of no concern to the behaviour of
> > the CPU, which is what's being discussed here (in terms of barriers.)
> > and the correct CPU ordering of various read/writes to memory and
> > devices vs the streaming cache operations.
> 
> It is still of concern because for cases like NAPI an rmb() on the CPU
> side is no longer enough. If you use a common network driver, written
> correctly with rmb(), but you have some weird interconnect which doesn't
> ensure ordering, you have to add interconnect specific barrier to the
> rmb() (or hack the dma ops like mvebu). I consider such hardware broken.

Yes, the hardware /is/ broken, but if you want to get it working in a
way that's acceptable in upstream kernels, adding that barrier to rmb()
is probably the only acceptable solution - especially if you have other
stuff going in between the rmb() and the DMA unmap.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
