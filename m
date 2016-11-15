From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Nov 2016 12:40:20 +0000
Subject: [PATCH] ARM: dma-mapping: preallocate DMA-debug hash tables in
 pure_initcall
In-Reply-To: <1479204295-29773-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161115100459eucas1p152b644d5d329192a0902c836b13f35ba@eucas1p1.samsung.com>
 <1479204295-29773-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20161115124020.GU1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 11:04:55AM +0100, Marek Szyprowski wrote:
> fs_initcall is definitely too late to initialize DMA-debug hash tables,
> because some drivers might get probed and use DMA mapping framework
> already in core_initcall. Late initialization of DMA-debug results in
> false warning about accessing memory, that was not allocated, like this
> one:

I think using pure_initcall() is not justified here - and if you read
the comments in include/linux/init.h, you're going against its
documented purpose - it says that it exists only to allow variables
that could not be statically initialised to be so.

It's also wrong, because debugfs gets initialised at core_initcall()
time, which happens after pure_initcall(), and dma_debug_init() calls
debugfs functions.

So, I really don't like this patch - it's subsituting one initcall
ordering issue for a different ordering issue.

Core code (which includes arch/arm/mm/) gets linked before drivers, so
moving this to be a core_initcall() would result in it being initialised
before drivers - and it actually makes total sense that this is a core
initcall.

It looks like this is safe from the debugfs perspective as well -
debugfs also gets initialised at core_initcall(), and that is earlier
than arch code in the link order, so debugfs should get initialised
first and then the DMA debug.

So, I'll accept a patch to change this from fs_initcall() to
core_initcall().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
