From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 17:23:17 +0100
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <58279306-048d-4d63-896b-f002567b5478@VA3EHSMHS004.ehs.local>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706230945.GA8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107062246130.14596@xanadu.home>
	<201107071817.11842.arnd@arndb.de>
	<20110708085954.GA2414@n2100.arm.linux.org.uk>
	<58279306-048d-4d63-896b-f002567b5478@VA3EHSMHS004.ehs.local>
Message-ID: <20110708162317.GH4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 07:58:03AM -0600, John Linn wrote:
> It's only at addresses 0 - 512K that's not DMA-able.  I am using a DMA
> zone (with a hole at the front) to avoid this problem right now but
> maybe I'm not really understanding it and it's not working correctly.
> Testing looks good with the DMA zone.

That's more or less what we do with Integrator platforms.  It's very
unlikely that a kernel will ever be smaller than 512K, so if you place
it at 32K as normal, avoid freeing the .init text/data, and keep the
first 32K reserved (the second 16K will be reserved for the swapper
page table in any case) then you'll keep that memory away from anything
that might hand it out for DMA purposes.

See free_initmem() for the integrator stuff avoiding .init freeing, and
integrator_reserve() to keep the first 16K reserved.
