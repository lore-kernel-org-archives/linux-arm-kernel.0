From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Jan 2011 23:15:28 +0000
Subject: [PATCH 1/2] ARM: calculate VMALLOC_END by probing in
	mdesc->map_io()
In-Reply-To: <1295737001-19578-1-git-send-email-eric.y.miao@gmail.com>
References: <1295737001-19578-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <20110122231528.GD11960@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 23, 2011 at 06:56:40AM +0800, Eric Miao wrote:
> From: Eric Miao <eric.miao@linaro.org>
> 
> Provided that the only place initializing the fixed IO mapping is
> in mdesc->map_io(), the VMALLOC_END can actually be calculated by
> first invoking the function without actually doing the map.

We really can't do this.  You're assuming that platforms only do IO
mapping in their map_io callback - that's way far from the truth.

Samsung platforms for instance register clocks and other stuff.

OMAP platforms issue cache flushes which won't work on CPUs requiring
a mapping to be setup for this to work.  They also check CPU revisions
(requiring mappings in place for that), probe the size of sram, etc.
None of this will work without mappings setup.

And there's a catch-you in OMAP there - it needs accessible mappings
to work out what other mappings (eg, sram size) to setup.  It can't map
a larger area than is actually present because that's known to cause
problems.

So, without a lot of effort to clean up platform code first, it's
really unsafe to do this double-call of map_io().  Given that it
takes some platform support _years_ to change, I really don't see
that this is a practical approach.

I'd instead suggest adding vmalloc_end to the machine description
record.
