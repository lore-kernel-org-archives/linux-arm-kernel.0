From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:33:06 +0000
Subject: [PATCH 09/48] ARM: PL08x: add comment explaining the flow control
	methods
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZsxe-0001OS-7R@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explain the two flow control methods which the PL08x implements, along
with the problem which peripheral flow control presents.  This helps
people understand why we are unable to use these DMA controllers with
(eg) the MMCI.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 74fa5a0..4b63fc3 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -53,7 +53,23 @@
  *
  * ASSUMES default (little) endianness for DMA transfers
  *
- * Only DMAC flow control is implemented
+ * The PL08x has two flow control settings:
+ *  - DMAC flow control: the transfer size defines the number of transfers
+ *    which occur for the current LLI entry, and the DMAC raises TC at the
+ *    end of every LLI entry.  Observed behaviour shows the DMAC listening
+ *    to both the BREQ and SREQ signals (contrary to documented),
+ *    transferring data if either is active.  The LBREQ and LSREQ signals
+ *    are ignored.
+ *
+ *  - Peripheral flow control: the transfer size is ignored (and should be
+ *    zero).  The data is transferred from the current LLI entry, until
+ *    after the final transfer signalled by LBREQ or LSREQ.  The DMAC
+ *    will then move to the next LLI entry.
+ *
+ * Only the former works sanely with scatter lists, so we only implement
+ * the DMAC flow control method.  However, peripherals which use the LBREQ
+ * and LSREQ signals (eg, MMCI) are unable to use this mode, which through
+ * these hardware restrictions prevents them from using scatter DMA.
  *
  * Global TODO:
  * - Break out common code from arch/arm/mach-s3c64xx and share
-- 
1.6.2.5
