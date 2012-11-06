From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2012 22:04:58 +0000
Subject: [PATCH] ARM: setup_mm_for_reboot(): use flush_cache_louis()
In-Reply-To: <alpine.LFD.2.02.1211061610070.21033@xanadu.home>
References: <alpine.LFD.2.02.1211061610070.21033@xanadu.home>
Message-ID: <20121106220458.GP28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 04:12:27PM -0500, Nicolas Pitre wrote:
> 
> ... instead of flush_cache_all().  The later unconditionally flushes
> the L2 cache on ARMv7 architectures such as Cortex A15 and A7 which
> is costly and unnecessary in some scenarios where setup_mm_for_reboot()
> is used.  If L2 has to be flushed as well, it should already be done
> separately on other architectures anyway.

Why does the cost at reboot count?  It's a relatively slow operation as
it is anyway, because you have to wait for the system to shut down, call
the boot loader, etc.

However, the opposite argument is that the state of the L2 _shouldn't_
matter - except for one small little detail.  Dirty data, which could
get evicted and overwrite something that matters.  Generally there won't
be any dirty data in the L2 cache on normal boot, so this is a situation
which boot loaders probably don't expect.

So all in all, I'm not sure of the wiseness of your change.  It's likely
to cause regressions.
