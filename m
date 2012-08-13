From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Aug 2012 17:00:08 +0100
Subject: Discontiguous memory and cacheflush
In-Reply-To: <5029126C.5000202@arm.com>
References: <1613427331.1190769.1344577949008.JavaMail.root@mozilla.com>
 <5029126C.5000202@arm.com>
Message-ID: <20120813160008.GA30302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 03:42:52PM +0100, Jonathan Austin wrote:
> On my system the cacheflush(2) documentation suggests it is MIPS only:
> "This  Linux-specific  system call is only available on MIPS based
> systems.  It should not be used in programs intended to be portable."

It's been part of the ARM kernel API for a very long time.

> As you've established by looking at the code, on ARM we intentionally
> attempt to flush only the part of the given range that occurs inside the
> vma containing 'start'.

It's intention is to support self-modifying userspace code only and also
intended to be used over a _short_ range of addresses only - it works by
flushing each _individual_ cache line over the range of addreses
requested.

If it's going to be used for significantly larger areas, then we need to
think about imposing a limit, upon which we just flush the entire cache
and be done with it.
