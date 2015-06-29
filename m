From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Jun 2015 10:09:14 +0100
Subject: dma_sync_single_for_cpu takes a really long time
In-Reply-To: <20150628223039.GV7557@n2100.arm.linux.org.uk>
References: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
 <20150628223039.GV7557@n2100.arm.linux.org.uk>
Message-ID: <20150629090914.GA29907@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 28, 2015 at 11:30:40PM +0100, Russell King - ARM Linux wrote:
> On Sun, Jun 28, 2015 at 10:40:03PM +0200, Sylvain Munaut wrote:
> > I'm working on a DMA driver that uses the the streaming DMA API to
> > synchronize the access between host and device. The data flow is
> > exclusively from the device to the host (video grabber).
> > 
> > As such, I call dma_sync_single_for_cpu when the hardware is done
> > writing a frame to make sure that the cpu gets up to date data when
> > accessing the zone.
> > 
> > However this call takes a _long_ time to complete. For a 6 Megabytes
> > buffer, it takes about 13 ms which is just crazy ... at that rate it'd
> > be faster to just read random data from a random buffer to trash the
> > measly 512k of cache ...
> 
> Flushing a large chunk of memory one cache line at a time takes a long
> time, there's really nothing "new" about that.
> 
> It's the expense that has to be paid for using cacheable mappings on a
> CPU which is not DMA coherent - something which I've brought up over
> the years with ARM, but it's not something that ARM believe is wanted
> by their silicon partners.

You are slightly mistaken here. Over the years ARM introduced ACP, AMBA4
ACE, AMBA5 CHI. See Mike's reply in this thread about the presence of
the ACP on this system and some of its drawbacks. But even if there are
options to make a device coherent, vendors may decide not to for various
reasons (cache look-up latency, increased power, cache thrashing; the
latter was actually a case for introducing bit 22 in PL310 aux ctrl).
But it's definitely worth testing.

> What we _could_ do is decide that if the buffer is larger than some
> factor of the cache size, to just flush the entire cache.

This is not a safe operation for the inner cache in an SMP system unless
you disable the MMUs (some kind of stop_machine call with temporary loss
of coherency). The set/way ops are not broadcast to the other CPUs.

> However, if you're going to read the entire frame through a cacheable
> mapping, you're probably going to end up flushing your cache several
> times over through doing that - but that's probably something you're
> doing in userspace, and so the kernel doesn't have the knowledge to know
> that's what userspace will be doing (nor should it.)

Alternatively, create a non-cacheable mapping for this buffer.

-- 
Catalin
