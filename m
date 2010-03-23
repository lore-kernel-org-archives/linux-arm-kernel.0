From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Mar 2010 21:27:36 +0000
Subject: [PATCH v5 4/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100319143317.11748.81936.stgit@e102109-lin.cambridge.arm.com>
References: <20100319143047.11748.9186.stgit@e102109-lin.cambridge.arm.com>
	<20100319143317.11748.81936.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100323212736.GG19572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 02:33:17PM +0000, Catalin Marinas wrote:
> The mandatory barriers (mb, rmb, wmb) are used even on uniprocessor
> systems for things like ordering Normal Non-cacheable memory accesses
> with DMA transfer (via Device memory writes). The current implementation
> uses dmb() for mb() and friends but this is not sufficient. The DMB only
> ensures the relative ordering of the observability of accesses by other
> processors or devices acting as masters. In case of DMA transfers
> started by writes to device memory, the relative ordering is not ensured
> because accesses to slave ports of a device are not considered
> observable by the DMB definition.
> 
> A DSB is required for the data to reach the main memory (even if mapped
> as Normal Non-cacheable) before the device receives the notification to
> begin the transfer. Furthermore, some L2 cache controllers (like L2x0 or
> PL310) buffer stores to Normal Non-cacheable memory and this would need
> to be drained with the outer_sync() function call.
> 
> The patch also allows platforms to define their own mandatory barriers
> implementation by selecting CONFIG_ARCH_HAS_BARRIERS and providing a
> mach/barriers.h file.
> 
> Note that the SMP barriers are unchanged (being DMBs as before) since
> they are only guaranteed to work with Normal Cacheable memory.

Ok.
