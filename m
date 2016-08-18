From: romain.perier@free-electrons.com (Romain Perier)
Date: Thu, 18 Aug 2016 14:12:12 +0200
Subject: [PATCH 0/2] Improve DMA chaining for ahash requests
Message-ID: <1471522334-24839-1-git-send-email-romain.perier@free-electrons.com>
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

Before		373 Mbits/s		530 Mbits/s
After		413 Mbits/s		578 Mbits/s
Improvement	+11%			+9%


Romain Perier (2):
  crypto: marvell - Use an unique pool to copy results of requests
  crypto: marvell - Don't break chain for computable last ahash requests

 drivers/crypto/marvell/cesa.c   |  4 +--
 drivers/crypto/marvell/cesa.h   |  6 ++--
 drivers/crypto/marvell/cipher.c |  2 +-
 drivers/crypto/marvell/hash.c   | 69 ++++++++++++++++++++++++++++++++---------
 drivers/crypto/marvell/tdma.c   | 16 +++++-----
 5 files changed, 68 insertions(+), 29 deletions(-)

-- 
2.8.1
