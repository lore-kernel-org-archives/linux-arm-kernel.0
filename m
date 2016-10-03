From: romain.perier@free-electrons.com (Romain Perier)
Date: Mon, 3 Oct 2016 17:48:56 +0200
Subject: [PATCH v2 0/2] Improve DMA chaining for ahash requests
In-Reply-To: <20161003151739.11615-1-romain.perier@free-electrons.com>
References: <20161003151739.11615-1-romain.perier@free-electrons.com>
Message-ID: <57F27DE8.1050703@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 03/10/2016 17:17, Romain Perier a ?crit :
> This series contain performance improvement regarding ahash requests.
> So far, ahash requests were systematically not chained at the DMA level.
> However, in some case, like this is the case by using IPSec, some ahash
> requests can be processed directly by the engine, and don't have
> intermediaire partial update states.
>
> This series firstly re-work the way outer IVs are copied from the SRAM
> into the dma pool. To do so, we introduce a common dma pool for all type
> of requests that contains outer results (like IV or digest). Then, for
> ahash requests that can be processed directly by the engine, outer
> results are copied from the SRAM into the common dma pool. These requests
> are then allowed to be chained at the DMA level.
>
>
> Benchmarking results with iperf throught IPSec
> ==============================================
> 		ESP			AH
>
> Before		343 Mbits/s		492 Mbits/s
> After		392 Mbits/s		557 Mbits/s
> Improvement	+14%			+13%
>
> Romain Perier (2):
>    crypto: marvell - Use an unique pool to copy results of requests
>    crypto: marvell - Don't break chain for computable last ahash requests
>
>   drivers/crypto/marvell/cesa.c   |  4 ---
>   drivers/crypto/marvell/cesa.h   |  5 ++-
>   drivers/crypto/marvell/cipher.c |  6 ++--
>   drivers/crypto/marvell/hash.c   | 79 +++++++++++++++++++++++++++++++++--------
>   drivers/crypto/marvell/tdma.c   | 17 +++++----
>   5 files changed, 78 insertions(+), 33 deletions(-)
>

After an internal discussion, we can handle things differently. Instead 
of allocating a new mv_cesa_op_ctx in the op_pool, we can just allocate 
a new descriptor which points to the first op ctx of the chain, and then 
copy outer data.

Please ignore this series.

Regards,

-- 
Romain Perier, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
