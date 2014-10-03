From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Oct 2014 17:57:16 +0100
Subject: [PATCH v2 2/2] xen/arm: introduce GNTTABOP_cache_flush
In-Reply-To: <542EBB2A.6030104@citrix.com>
References: <alpine.DEB.2.02.1410031549150.17038@kaball.uk.xensource.com>
 <1412348006-27884-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <542EBB2A.6030104@citrix.com>
Message-ID: <20141003165716.GW5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 04:05:14PM +0100, David Vrabel wrote:
> Are all these cache operations needed?  You do a clean on map regardless
> of the direction and INVAL on map seems unnecessary.
> 
> I would have thought it would be:
> 
> map && (TO_DEVICE || BOTH)
>    op = CLEAN
> 
> unmap && (FROM_DEVICE || BOTH)
>    op = INVAL

This is wrong.  You've failed to consider the case where you have dirty
cache lines in the cache before the DMA operation, and the DMA operation
is going to write to memory.  So, let's take this case, and work it
through.

At the map point, we do nothing.  This leaves dirty cache lines in the
cache.

DMA commences, and starts writing data into the memory.  Meanwhile, the
CPU goes off and does something else.

The cache then wants to evict a line, and picks one of the dirty lines
associated with this region.  The dirty data is written back to memory,
overwriting the newly DMA'd data.

Meanwhile, the CPU may speculatively load cache lines corresponding with
this memory, possibly from the part which has not yet been updated by the
DMA activity.

At the end of the DMA, we unmap, and at this point we invalidate the cache,
getting rid of any remaining dirty lines, and the speculatively loaded
lines.

We now have corrupted data in the memory region.  So, maybe you'll be
saying bye bye to your filesystem at this point...

You could always clean at map time, but in the case of DMA from the device,
this is a waste of bus cycles since you don't need the dirty lines in the
cache written back to memory.  If you can invalidate, you might as well do
that for this case and save writing back data to memory which you're about
to overwrite with DMA.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
