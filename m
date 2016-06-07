From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue,  7 Jun 2016 09:47:38 -0700
Subject: [RESEND/PATCHv4 v4 0/3] request_firmware() into pre-allocated buffers
Message-ID: <20160607164741.31849-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some systems are memory constrained but they need to load very
large firmwares. The firmware subsystem allows drivers to request
this firmware be loaded from the filesystem, but this requires
that the entire firmware be loaded into kernel memory first
before it's provided to the driver. This can lead to a situation
where we map the firmware twice, once to load the firmware into
kernel memory and once to copy the firmware into the final
resting place.

This design creates needless memory pressure and delays loading
because we have to copy from kernel memory to somewhere else.
This patch sets adds support to the request firmware API to load the
firmware directly into a pre-allocated buffer, skipping the intermediate
copying step and alleviating memory pressure during firmware loading.
The drawback is that we can't use the firmware caching feature because
the memory for the firmware cache is not managed by the firmware
layer.

Patches based on v4.7-rc1.

Changes since v3:
 * Rebased onto v4.7-rc1
 * Renamed enum per Mimi's comment

Changes since v2:
 * Dropped DMA API changes and moved to dma coherent APIs per Catalin's
   suggestions
 * Reworked to request firmware directly into any pre-allocated buffer
 * Split off cleanup patch into patch #1 to ease review
 * Added file reading enum for reading firmware directly into buffer

Changes since v1:
 * Rebased onto v4.6-rc1 (large conflicts due to movement of code from Mimi)
 * Added some CONFIG_HAS_DMA ifdefs around code that's using DMA ops

Stephen Boyd (2):
  firmware: Consolidate kmap/read/write logic
  firmware: Support loading into a pre-allocated buffer

Vikram Mulukutla (1):
  firmware: Provide infrastructure to make fw caching optional

 drivers/base/firmware_class.c | 183 +++++++++++++++++++++++++++++-------------
 fs/exec.c                     |   9 ++-
 include/linux/firmware.h      |   8 ++
 include/linux/fs.h            |   1 +
 4 files changed, 142 insertions(+), 59 deletions(-)

-- 
2.9.0-rc1
