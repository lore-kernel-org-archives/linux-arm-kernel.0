From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed,  5 Oct 2016 09:56:31 +0200
Subject: [PATCH v4 0/2] Improve DMA chaining for ahash requests
Message-ID: <20161005075633.12711-1-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contain performance improvement regarding ahash requests.
So far, ahash requests were systematically not chained at the DMA level.
However, in some case, like this is the case by using IPSec, some ahash
requests can be processed directly by the engine, and don't have
intermediaire partial update states.

This series firstly re-work the way outer IVs are copied from the SRAM
into the dma pool. To do so, we introduce a common dma pool for all type
of requests that contains outer results (like IV or digest). Then, for
ahash requests that can be processed directly by the engine, outer
results are copied from the SRAM into the common dma pool. These requests
are then allowed to be chained at the DMA level.


Benchmarking results with iperf throught IPSec
==============================================
		ESP			AH

Before		343 Mbits/s		492 Mbits/s
After		422 Mbits/s		577 Mbits/s
Improvement	+23%			+17%

Romain Perier (2):
  crypto: marvell - Use an unique pool to copy results of requests
  crypto: marvell - Don't break chain for computable last ahash requests

 drivers/crypto/marvell/cesa.c   |  4 ---
 drivers/crypto/marvell/cesa.h   |  5 ++--
 drivers/crypto/marvell/cipher.c |  8 +++--
 drivers/crypto/marvell/hash.c   | 65 +++++++++++++++++++++++++++++++----------
 drivers/crypto/marvell/tdma.c   | 28 +++++++++---------
 5 files changed, 70 insertions(+), 40 deletions(-)

-- 
2.9.3
