From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2012 09:51:06 +0000
Subject: [PATCH] ARM: setup_mm_for_reboot(): use flush_cache_louis()
In-Reply-To: <20121106220458.GP28327@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1211061610070.21033@xanadu.home>
 <20121106220458.GP28327@n2100.arm.linux.org.uk>
Message-ID: <20121107095106.GA23305@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 10:04:58PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 06, 2012 at 04:12:27PM -0500, Nicolas Pitre wrote:
> > 
> > ... instead of flush_cache_all().  The later unconditionally flushes
> > the L2 cache on ARMv7 architectures such as Cortex A15 and A7 which
> > is costly and unnecessary in some scenarios where setup_mm_for_reboot()
> > is used.  If L2 has to be flushed as well, it should already be done
> > separately on other architectures anyway.
> 
> Why does the cost at reboot count?  It's a relatively slow operation as
> it is anyway, because you have to wait for the system to shut down, call
> the boot loader, etc.
> 
> However, the opposite argument is that the state of the L2 _shouldn't_
> matter - except for one small little detail.  Dirty data, which could
> get evicted and overwrite something that matters.  Generally there won't
> be any dirty data in the L2 cache on normal boot, so this is a situation
> which boot loaders probably don't expect.

Wouldn't the L2 flush in this case be included with the code that turns off
caching? For reboot, that's currently done in __sort_restart -- the cache
flush in setup_mm_for_reboot is just to ensure that the idmap tables are
visible to the hardware walker iirc.

Will
