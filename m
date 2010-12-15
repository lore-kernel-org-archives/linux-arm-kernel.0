From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Dec 2010 17:27:54 +0000
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <201012151817.33671.arnd@arndb.de>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<201012151758.42896.arnd@arndb.de>
	<20101215170636.GJ28971@pengutronix.de>
	<201012151817.33671.arnd@arndb.de>
Message-ID: <20101215172754.GI9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 06:17:33PM +0100, Arnd Bergmann wrote:
> The problem is that __raw_* is defined as a pointer reference on
> all architectures, nothing more. Depending on the architecture and
> compiler, sometimes even on the I/O subsystem, it may or may not
> do any of the following:
> 
> * work on mapped PCI addresses
> * work on mapped non-PCI addresses
> * work on addresses returned from ioport_map
> * be synchronized with spinlocks

Err.  Even readl/writel are not synchronized with spinlocks.  See
Documentation/memory-barriers.txt:

| Under certain circumstances (especially involving NUMA), I/O accesses within
| two spinlocked sections on two different CPUs may be seen as interleaved by the
| PCI bridge, because the PCI bridge does not necessarily participate in the
| cache-coherence protocol, and is therefore incapable of issuing the required
| read memory barriers.
|
| For example:
|
|       CPU 1                           CPU 2
|       =============================== ===============================
|       spin_lock(Q)
|       writel(0, ADDR)
|       writel(1, DATA);
|       spin_unlock(Q);
|                                       spin_lock(Q);
|                                       writel(4, ADDR);
|                                       writel(5, DATA);
|                                       spin_unlock(Q);
|
| may be seen by the PCI bridge as follows:
|
|       STORE *ADDR = 0, STORE *ADDR = 4, STORE *DATA = 1, STORE *DATA = 5
|
| which would probably cause the hardware to malfunction.
