From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Aug 2010 10:18:04 +0100
Subject: Driver supported smp linux kernel need use smp_wmb/smp_rmb,
	nor wmb/rmb?
In-Reply-To: <AANLkTimOaRrEGCYH6k_3wfDixnk1RkJ5JCSi_hv8PQsC@mail.gmail.com>
References: <AANLkTimOaRrEGCYH6k_3wfDixnk1RkJ5JCSi_hv8PQsC@mail.gmail.com>
Message-ID: <20100826091804.GA8212@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 26, 2010 at 03:43:29PM +0800, David Yang wrote:
> Start with linux 2.6.33,  the DMA coherent buffers are mapped as Normal
> Non-cacheable, so our drivers using dma_alloc_coherent() add the
> barriers (e.g. wmb/rmb) to ensure that read/wirte coherence with
> devices.
> 
> Now our drivers are stable at the non-smp linux 2.6.33,  if our driver
> need support the smp linux 2.6.33, we need replace wmb()/rmb() to
> smp_wmb()/smp_rmb()?

No.  smp_* barriers are compiler barriers on uniprocessor, and mandatory
barriers on SMP systems.

If you definitely need a barrier for UP, then use the non-smp_ versions.
