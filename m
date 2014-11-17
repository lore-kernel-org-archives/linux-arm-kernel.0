From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Nov 2014 11:48:33 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141116163355.GK4042@n2100.arm.linux.org.uk>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
Message-ID: <20141117114832.GB29595@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 04:33:56PM +0000, Russell King - ARM Linux wrote:
> On Sun, Nov 16, 2014 at 12:56:56AM -0500, Rich Felker wrote:
> > Aside from that, the only case among the above that's "right" already
> > is v7+. Hard-coding the mcr-based barrier on v6 is wrong because it's
> 
> I don't think it's wrong at all.  The instruction isn't going away from
> ARMv7, because ARMv7 deprecates it, but it _still_ has to be implemented
> by a CPU conforming to ARMv7.  As ARMv7 is going to be the last 32-bit
> ARM architecture, we aren't going to see the MCR instruction disappearing
> on 32-bit CPUs.

You are wrong here. ARMv8-A supports 32-bit at all levels. ARMv8-R is
32-bit only (and it even has an MMU at EL1). And there is a slight
chance that we may even see 32-bit only ARMv8-A implementations (I'm not
really giving a hint and I'm not aware of any but I don't see anything
preventing this, it's all marketing driven).

http://www.arm.com/products/processors/instruction-set-architectures/armv8-r-architecture.php

> On ARMv8, it may have been removed, but we have already decided that the
> kernel _must_ provide emulation for this op-code, because otherwise we
> are breaking existing userspace, which is just not permissible.  However,
> you are absolutely right that running on ARMv8 should use the new
> instruction where possible.

Even on ARMv8 we could enable CP15 barriers in hardware, they are just
deprecated but haven't been removed (yet). What I'm pushing for, though
it's not easy, is that the hardware just deprecates such instructions
for performance rather than removing them entirely. This would make them
faster than emulation but I fully agree with you that the new
instructions should be used where possible.

-- 
Catalin
