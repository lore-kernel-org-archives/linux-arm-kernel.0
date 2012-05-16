From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 May 2012 12:04:51 +0100
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
Message-ID: <20120516110451.GA9571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series removes the dependence on the dma_slave_config direction
argument for the PL08x DMA engine driver, and in doing so, we end up
with less code in the driver.

We now compute the cctl values for both directions, and continue to
select the appropriate one at prepare time.  If this is found to be
invalid, the prepare function will return NULL.

However, we still use the direction argument in the slave configuration
call to determine whether we should report and fail an invalid
configuration.  Eventually this will be removed.

* This has only been compile tested.  Test feedback welcomed. *

 drivers/dma/amba-pl08x.c   |  196 +++++++++++++++++++++++++++++---------------
 include/linux/amba/pl08x.h |   84 +------------------
 2 files changed, 134 insertions(+), 146 deletions(-)
