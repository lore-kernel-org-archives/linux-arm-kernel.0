From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 28 Nov 2010 12:08:57 +0000
Subject: memory allocation errors on Marvell Kirkwood
In-Reply-To: <BLU0-SMTP90312A69589CE7FD162BA4CF230@phx.gbl>
References: <BLU0-SMTP90312A69589CE7FD162BA4CF230@phx.gbl>
Message-ID: <20101128120857.GB23772@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 28, 2010 at 12:44:56PM +0100, Frank wrote:
> [323570.011580] swapper: page allocation failure. order:3, mode:0x4020

Order 3.  That's wanting 4K << 3, or 32K.

> [323570.289988] Normal: 1057*4kB 3870*8kB 99*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 36772kB

And from this line, we see that we have no pages larger than 16K available
in the system, despite having 36MB of free memory.  IOW, your memory has
become extremely fragmented.

We don't guaranttee that this doesn't happen - in fact, we explicitly tell
people that memory fragmentation _does_ happen and we do _not_ guarantee
that allocations > order-0 will succeed.
