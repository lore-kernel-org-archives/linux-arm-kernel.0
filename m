From: per.forlin@linaro.org (Per Forlin)
Date: Sun, 19 Jun 2011 23:17:26 +0200
Subject: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize latency
Message-ID: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

How significant is the cache maintenance over head?
It depends, the eMMC are much faster now
compared to a few years ago and cache maintenance cost more due to
multiple cache levels and speculative cache pre-fetch. In relation the
cost for handling the caches have increased and is now a bottle neck
dealing with fast eMMC together with DMA.

The intention for introducing non-blocking mmc requests is to minimize the
time between a mmc request ends and another mmc request starts. In the
current implementation the MMC controller is idle when dma_map_sg and
dma_unmap_sg is processing. Introducing non-blocking mmc request makes it
possible to prepare the caches for next job in parallel to an active
mmc request.

This is done by making the issue_rw_rq() non-blocking.
The increase in throughput is proportional to the time it takes to
prepare (major part of preparations is dma_map_sg and dma_unmap_sg)
a request and how fast the memory is. The faster the MMC/SD is
the more significant the prepare request time becomes. Measurements on U5500
and Panda on eMMC and SD shows significant performance gain for large
reads when running DMA mode. In the PIO case the performance is unchanged.

There are two optional hooks pre_req() and post_req() that the host driver
may implement in order to move work to before and after the actual mmc_request
function is called. In the DMA case pre_req() may do dma_map_sg() and prepare
the dma descriptor and post_req runs the dma_unmap_sg.

Details on measurements from IOZone and mmc_test:
https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfMMC-async-req

Changes since v5:
 * Fix spelling mistakes, replace "none blocking" with non-blocking.
 * excluded patch "omap_hsmmc: use original sg_len..." since it is
   being merged separately.

Per Forlin (11):
  mmc: add non-blocking mmc request function
  omap_hsmmc: add support for pre_req and post_req
  mmci: implement pre_req() and post_req()
  mmc: mmc_test: add debugfs file to list all tests
  mmc: mmc_test: add test for non-blocking transfers
  mmc: add member in mmc queue struct to hold request data
  mmc: add a block request prepare function
  mmc: move error code in mmc_block_issue_rw_rq to a separate function.
  mmc: add a second mmc queue request member
  mmc: test: add random fault injection in core.c
  mmc: add handling for two parallel block requests in issue_rw_rq

 drivers/mmc/card/block.c      |  534 ++++++++++++++++++++++++-----------------
 drivers/mmc/card/mmc_test.c   |  361 +++++++++++++++++++++++++++-
 drivers/mmc/card/queue.c      |  184 +++++++++-----
 drivers/mmc/card/queue.h      |   33 ++-
 drivers/mmc/core/core.c       |  165 ++++++++++++-
 drivers/mmc/core/debugfs.c    |    5 +
 drivers/mmc/host/mmci.c       |  146 ++++++++++-
 drivers/mmc/host/mmci.h       |    8 +
 drivers/mmc/host/omap_hsmmc.c |   87 +++++++-
 include/linux/mmc/core.h      |    6 +-
 include/linux/mmc/host.h      |   24 ++
 lib/Kconfig.debug             |   11 +
 12 files changed, 1235 insertions(+), 329 deletions(-)

-- 
1.7.4.1
