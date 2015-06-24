From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Jun 2015 00:13:42 +0100
Subject: L2 Cache enable on i.MX5
In-Reply-To: <DBXPR06MB58911B5FD193722EC5BD34185AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
References: <DBXPR06MB5891810D431F1AE9AEB1CE985AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
 <20150624172900.GN7557@n2100.arm.linux.org.uk>
 <DBXPR06MB58911B5FD193722EC5BD34185AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
Message-ID: <20150624231342.GQ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 10:53:01PM +0000, Robert Daniels wrote:
> 
> >> I recently discovered an issue with an i.MX53 based product where we had
> >> an older version of Das U-Boot which disabled the L2 cache on startup but
> >> in a later version would re-enable it once the L2 cache was configured.
> 
> > The kernel is supposed to be booted with caches disabled, and in particular,
> > the L2 cache disabled during the decompressor run.
> 
> > If the L2 cache is configured, it will enable it during it's boot sequence.
> 
> I see - so the boot loader is not supposed to enable the L2 cache and it
> should not be enabled until after the decompressor runs.
> 
> In that case, where should the kernel be enabling the L2 cache? I'm using
> the 3.14 kernel for this i.MX53 product and the L2 cache is definitely not
> enabled.

I don't know, I don't have any knowledge of iMX35 - all I can do is say
what the generic requirements are of the kernel.

The problem with having the L2 cache enabled when calling into the kernel
is that the decompressor knows nothing of the L2 cache, and doesn't
have the capability to do any cache maintanence there, which it would
need to do.  That adds a _lot_ of extra complexity.

> I see that there is a imx_init_l2cache defined which is being called by
> the imx6 and imx35 platform code but it is not being called for the
> i.mx5... should it?

Searching google, I see there was some discussion on this topic back in
2011, which concluded that the kernel should enable the cache.  However,
as it's now four years later, and you've found that the kernel still
does not enable the cache, the conclusion is that the code has never
been submitted.

The kernel also needs to know not only how to enable the L2 cache, but
how to perform cache maintanence on that cache, so things like DMA will
work (it's no good trying to DMA data to a device when it's sitting in
a CPU cache.)

As the information for the iMX5 doesn't seem to be public (or not in
google's index), I'm not sure who could help you.

If you have some ideas about how to deal with this, the place to go
looking for L2 cache support stuff is arch/arm/mm.  If the cache is
significantly different from the others there, it'd be better to
start a new file rather than trying to merge it into cache-l2x0.c.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
