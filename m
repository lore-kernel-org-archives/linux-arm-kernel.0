From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Apr 2017 15:37:26 +0100
Subject: [PATCH 2/3] bus: fsl-mc: dpio: enable qbman CENA portal memory
 access
In-Reply-To: <1492716858-24509-3-git-send-email-Haiying.Wang@nxp.com>
References: <1492716858-24509-1-git-send-email-Haiying.Wang@nxp.com>
 <1492716858-24509-3-git-send-email-Haiying.Wang@nxp.com>
Message-ID: <20170421143725.GC5312@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 03:34:17PM -0400, Haiying Wang wrote:
> Once we enable the cacheable portal memory, we need to do
> cache flush for enqueue, vdq, buffer release, and management
> commands, as well as invalidate and prefetch for the valid bit
> of management command response and next index of dqrr.
> 
> Signed-off-by: Haiying Wang <Haiying.Wang@nxp.com>

For the record, NAK on the whole series. It may appear to improve the
performance a bit but this is not architecturally compliant and relies
heavily on specific CPU and SoC implementation details which may
fail in very subtle way.

> --- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
> +++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
> @@ -99,6 +99,14 @@ enum qbman_sdqcr_fc {
>  	qbman_sdqcr_fc_up_to_3 = 1
>  };
>  
> +#define dccvac(p) { asm volatile("dc cvac, %0;" : : "r" (p) : "memory"); }
> +#define dcivac(p) { asm volatile("dc ivac, %0" : : "r"(p) : "memory"); }
> +static inline void qbman_inval_prefetch(struct qbman_swp *p, uint32_t offset)
> +{
> +	dcivac(p->addr_cena + offset);
> +	prefetch(p->addr_cena + offset);
> +}
[...]
> @@ -435,6 +445,7 @@ int qbman_swp_enqueue(struct qbman_swp *s, const struct qbman_eq_desc *d,
>  	/* Set the verb byte, have to substitute in the valid-bit */
>  	dma_wmb();
>  	p->verb = d->verb | EQAR_VB(eqar);
> +	dccvac(p);

The command buffer is on a device and currently mapped as write-combined
memory (that is Normal Non-cacheable on ARM). To enqueue a command, the
current code populates the struct qbman_eq_desc fields, followed by a
dma_wmb() (that is a DSB SY on ARM) and the subsequent update of the
"verb" byte to mark the descriptor as valid. These are all pretty much
*slave* (vs master) accesses since the device does not read such memory
through the system's point of serialisation. The DSB may happen ensure
the ordering of the verb update on your specific SoC, though
architecturally this is not guaranteed.

With your cacheable mapping patch, things get worse. The above dma_wmb()
does not have any effect at all with respect to the QBMan device since
all the code does is populate qbman_eq_desc *within* the CPU's L1 cache
which the device does *not* see. Once you call the dccvac() macro, you
would find that the "verb" is evicted first (since it's the beginning of
the qbman_eq_desc structure which is not what you want). The
interconnect may also split the cache eviction into multiple
transactions, so what the device would see is not guaranteed to be
atomic.

Similarly for the dequeue ring, the CPU is allowed to generate
transactions to fill its cache lines in any order (usually it can start
on any of the 4 quad words of the cache line), so it could as well
preload stale descriptors but with a valid verb.

-- 
Catalin
