From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Jun 2015 12:25:53 +0200
Subject: dma_sync_single_for_cpu takes a really long time
In-Reply-To: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
References: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
Message-ID: <2697205.Fh05irTfqN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 June 2015 22:40:03 Sylvain Munaut wrote:
> Hi,
> 
> 
> I'm working on a DMA driver that uses the the streaming DMA API to
> synchronize the access between host and device. The data flow is
> exclusively from the device to the host (video grabber).
> 
> As such, I call dma_sync_single_for_cpu when the hardware is done
> writing a frame to make sure that the cpu gets up to date data when
> accessing the zone.
> 
> However this call takes a _long_ time to complete. For a 6 Megabytes
> buffer, it takes about 13 ms which is just crazy ... at that rate it'd
> be faster to just read random data from a random buffer to trash the
> measly 512k of cache ...
> 
> Is there any alternative that's faster when dealing with large buffers ?
> 
> (The platform is a Zynq 7000 - Dual Cortex A9).

?f the frame grabber is implemented in the FPGA, try using the
coherency port instead of the noncoherent port to memory and mark
the device as "dma-coherent", to avoid the explicit flushes.

Another alternative would be to use uncached memory for the buffer
and then read it using an optimized loop from the CPU, but that may
not fit your usage pattern.

	Arnd
