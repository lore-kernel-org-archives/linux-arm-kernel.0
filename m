From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Nov 2010 17:45:22 +0100
Subject: [PATCH] ARM: Gemini: Add support for PCI BUS
In-Reply-To: <4CF3CF33.20407@gmail.com>
References: <1290860675-15453-1-git-send-email-ulli.kroll@googlemail.com>
	<201011282056.17389.arnd@arndb.de> <4CF3CF33.20407@gmail.com>
Message-ID: <201011291745.22566.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 November 2010, Paulius Zaleckas wrote:
> > The I/O ordering is probably not what you think it is.
> > There is no ordering guarantee between __raw_writel and
> > spin_lock/spin_unlock, so you really should be using
> > readl/writel.
> 
> No he really should NOT use readl/writel. The ONLY difference
> between readl/writel and __raw_readl/__raw_writel is endianess
> conversion. __raw_*l is not doing it. Which to use depend only
> on HW.

There are many differences between readl and __raw_readl, including

* __raw_readl does not have barriers and does not serialize with
  spinlocks, so it breaks on out-of-order CPUs.
* __raw_readl does not have a specific endianess, while readl is
  fixed little-endian, just as the hardware is in this case.
  The endian-conversion is a NOP on little-endian ARM, but required
  if you actually run on a big-endian ARM (you don't).
* __raw_readl may not be atomic, gcc is free to split the access
  into byte wise reads (it normally does not, unless you mark
  the pointer __attribute__((packed))).

In essence, it is almost never a good idea to use __raw_readl, and
the double underscores should tell you so.

	Arnd
